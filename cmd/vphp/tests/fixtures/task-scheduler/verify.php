<?php
declare(strict_types=1);

use function VPHP\TaskProbe\awaitStream;
use function VPHP\TaskProbe\streamGenerator;
use function VPHP\TaskProbe\waitPair;
use function VPHP\TaskProbe\waitWithArgs;
use function VPHP\TaskProbe\sleep as sleepTask;
use VSlim\Task;
use VSlim\TaskChannelStatus as ChannelStatus;

if (($argv[1] ?? '') === '--cleanup-exit') {
    VPHP\TaskProbe\runCleanup(
        static fn () => throw new RuntimeException('pending exception'),
        static function (): void { exit(43); },
    );
    throw new LogicException('Cleanup did not exit');
}

// A parked send adds a VM call frame to the cycle. Check separately from
// a cycle contained entirely in a channel's queue.
function parkTask(VSlim\TaskHandle $task): void
{
    $peer = Task::spawn(static fn () => true, []);
    if (Task::waitAny([$task, $peer]) !== $peer) {
        throw new RuntimeException('The task never parked');
    }
}

function parkedChannelCycle(bool $queueSameMessage, bool $cancel): array
{
    $channel = Task::channel(1);
    $message = (object) ['channel' => $channel];
    $channel->send($queueSameMessage ? $message : 'queued');
    $writer = Task::spawn(static fn () => $channel->send($message), []);
    $message->writer = $writer;
    parkTask($writer);
    if ($cancel) {
        $reason = new DomainException('Release a parked channel writer');
        if (!$writer->cancel($reason)) {
            throw new RuntimeException('The parked channel writer could not be cancelled');
        }
        try {
            $writer->wait();
            throw new RuntimeException('The cancelled writer returned normally');
        } catch (DomainException $caught) {
            if ($caught !== $reason) {
                throw $caught;
            }
        }
    }
    return array_map(WeakReference::create(...), [$channel, $message, $writer]);
}

$gate = tempnam(sys_get_temp_dir(), 'vphp-task-');
unlink($gate);
try {
    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    $first = VSlim\Task::spawn(static fn () => $native->wait(), []);
    $second = VSlim\Task::spawn(static fn () => $native->wait(), []);
    $unblock = VSlim\Task::spawn(static function () use ($gate): bool {
        VSlim\Task::sleep(0);
        return touch($gate);
    }, []);
    $expected = ['native', 'done'];
    if (VSlim\Task::waitAll([$first, $second, $unblock, $native, $native])
        !== [$expected, $expected, true, $expected, $expected]) {
        throw new RuntimeException('Native task waits blocked PHP peers or joined the same thread twice');
    }
    unlink($gate);
    unlink($gate . '.done');

    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    $waiting = VSlim\Task::spawn(static fn () => $native->wait(), []);
    $reason = new DomainException('Stop waiting for the native task');
    $cancel = VSlim\Task::spawn(static function () use ($gate, $waiting, $reason): bool {
        VSlim\Task::sleep(0);
        return $waiting->cancel($reason) && touch($gate);
    }, []);
    try {
        VSlim\Task::waitAll([$waiting, $cancel]);
        throw new LogicException('Cancellation was lost during a native task wait');
    } catch (DomainException $error) {
        if ($error !== $reason || $cancel->wait() !== true || $native->wait() !== $expected) {
            throw $error;
        }
    }
    unlink($gate);
    unlink($gate . '.done');

    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    unset($native);
    touch($gate);
    $deadline = hrtime(true) + 2_000_000_000;
    while (!is_file($gate . '.done') && hrtime(true) < $deadline) {
        clearstatcache(true, $gate . '.done');
        usleep(1000);
    }
    if (!is_file($gate . '.done')) {
        throw new RuntimeException('Releasing an unawaited task blocked its PHP caller');
    }
} finally {
    @unlink($gate);
    @unlink($gate . '.done');
}

$channel = Task::channel(capacity: 1);
$message = new stdClass();
if (!(new ReflectionClass($channel))->getConstructor()->isPrivate()) {
    throw new RuntimeException('TaskChannel can be constructed without its queue');
}
if ($channel->send(timeoutMs: 0, value: null) !== ChannelStatus::Ready
    || $channel->send($message, 0) !== ChannelStatus::TimedOut
    || $channel->receive(timeoutMs: 0) !== ['status' => ChannelStatus::Ready, 'value' => null]
    || $channel->receive(0) !== ['status' => ChannelStatus::TimedOut]
    || $channel->send($message) !== ChannelStatus::Ready
    || !$channel->close() || $channel->close()
    || $channel->send('late') !== ChannelStatus::Closed
    || $channel->receive() !== ['status' => ChannelStatus::Ready, 'value' => $message]
    || $channel->receive() !== ['status' => ChannelStatus::Closed]) {
    throw new RuntimeException('Channel lost its capacity, closure, or message identity');
}
try {
    Task::channel(capacity: 0);
    throw new RuntimeException('Channel accepted an invalid capacity');
} catch (ValueError) {
}

$aggregate = new class ($message) implements IteratorAggregate {
    public int $calls = 0;

    public function __construct(public object $message) {}

    public function getIterator(): Traversable
    {
        ++$this->calls;
        return new ArrayIterator(['item' => $this->message]);
    }
};
$iterator = VPHP\TaskProbe\aggregateIterator(value: $aggregate);
$signature = new ReflectionFunction('VPHP\\TaskProbe\\aggregateIterator');
if ((string) $signature->getParameters()[0]->getType() !== 'IteratorAggregate'
    || (string) $signature->getReturnType() !== 'Traversable'
    || $aggregate->calls !== 1 || !$iterator instanceof ArrayIterator
    || iterator_to_array($iterator) !== ['item' => $message]) {
    throw new RuntimeException('The IteratorAggregate bridge lost its types or the original PHP iterator');
}
$identity = VPHP\TaskProbe\aggregateIdentity();
$signature = new ReflectionFunction($identity);
if ((string) $signature->getParameters()[0]->getType() !== 'IteratorAggregate'
    || (string) $signature->getReturnType() !== 'IteratorAggregate'
    || $identity($aggregate) !== $aggregate) {
    throw new RuntimeException('A generated closure lost its IteratorAggregate signature or object identity');
}
foreach ([[], new ArrayIterator()] as $invalidAggregate) {
    try {
        VPHP\TaskProbe\aggregateIterator($invalidAggregate);
        throw new RuntimeException('IteratorAggregate accepted a value outside its PHP interface');
    } catch (TypeError) {
    }
}
$error = new DomainException('Broken iterator factory');
$broken = new class ($error) implements IteratorAggregate {
    public function __construct(private Throwable $error) {}

    public function getIterator(): Traversable
    {
        throw $this->error;
    }
};
try {
    VPHP\TaskProbe\aggregateIterator($broken);
    throw new RuntimeException('IteratorAggregate swallowed an exception');
} catch (DomainException $caught) {
    if ($caught !== $error) {
        throw $caught;
    }
}

$channel = Task::channel(2);
$iterator = $channel->getIterator();
$signature = new ReflectionMethod($channel, 'getIterator');
if (!$channel instanceof IteratorAggregate || !$iterator instanceof Generator
    || (string) $signature->getReturnType() !== 'Traversable'
    || $channel->send(null) !== ChannelStatus::Ready || $channel->send($message) !== ChannelStatus::Ready) {
    throw new RuntimeException('Channel iterator creation consumed a message or lost the interface');
}
$channel->close();
foreach ($channel as $key => $value) {
    if ($key !== 0 || $value !== null) {
        throw new RuntimeException('Channel iteration lost its first null message');
    }
    break;
}
if (iterator_to_array($iterator) !== [$message] || iterator_to_array($channel) !== []) {
    throw new RuntimeException('Breaking channel iteration consumed its remaining messages');
}

$channel = Task::channel(1);
$reader = Task::spawn(static fn () => iterator_to_array($channel), []);
$writer = Task::spawn(static function () use ($channel, $message): array {
    try {
        return [$channel->send(null), $channel->send($message), $channel->send('last')];
    } finally {
        $channel->close();
    }
}, []);
if (Task::waitAll([$reader, $writer]) !== [[null, $message, 'last'], array_fill(0, 3, ChannelStatus::Ready)]) {
    throw new RuntimeException('Channel iteration lost messages while yielding to a scheduled writer');
}

$channel = Task::channel(1);
$order = [];
$producer = Task::spawn(static function () use ($channel, $message, &$order): array {
    $sent = [];
    foreach ([null, $message, 'last'] as $index => $value) {
        $sent[] = $channel->send($value);
        $order[] = "sent:$index";
    }
    $channel->close();
    return $sent;
}, []);
$consumer = Task::spawn(static function () use ($channel, &$order): array {
    $messages = [];
    while (($result = $channel->receive())['status'] === ChannelStatus::Ready) {
        $order[] = 'received:' . count($messages);
        $messages[] = $result['value'];
    }
    if ($result !== ['status' => ChannelStatus::Closed]) {
        throw new RuntimeException('Draining a channel did not observe closure');
    }
    return $messages;
}, []);
if (Task::waitAll([$producer, $consumer]) !== [array_fill(0, 3, ChannelStatus::Ready), [null, $message, 'last']]
    || array_search('sent:1', $order, true) <= array_search('received:0', $order, true)) {
    throw new RuntimeException('Channel did not apply backpressure or deliver messages in order');
}

$channel = Task::channel(1);
$reader = Task::spawn(static fn () => $channel->receive(), []);
$closer = Task::spawn(static function () use ($channel): bool {
    Task::sleep(0);
    return $channel->close();
}, []);
if (Task::waitAll([$reader, $closer]) !== [['status' => ChannelStatus::Closed], true]) {
    throw new RuntimeException('Closing a channel did not wake its suspended reader');
}

$channel = Task::channel(1);
$channel->send('keep');
$cancelledWriter = Task::spawn(static fn () => $channel->send('discard'), []);
$reason = new DomainException('Cancel a blocked channel send');
$canceller = Task::spawn(static function () use ($cancelledWriter, $reason): bool {
    Task::sleep(0);
    return $cancelledWriter->cancel($reason);
}, []);
try {
    Task::waitAll([$cancelledWriter, $canceller]);
    throw new LogicException('Channel did not propagate cancellation');
} catch (DomainException $error) {
    if ($error !== $reason || $canceller->wait() !== true
        || $channel->receive() !== ['status' => ChannelStatus::Ready, 'value' => 'keep']
        || $channel->receive(0) !== ['status' => ChannelStatus::TimedOut]) {
        throw new RuntimeException('A cancelled writer modified the channel', previous: $error);
    }
}

$channel = Task::channel(1);
$timed = Task::spawn(static fn () => $channel->receive(timeoutMs: 20), []);
$started = hrtime(true);
if ($timed->wait() !== ['status' => ChannelStatus::TimedOut] || hrtime(true) - $started < 15_000_000) {
    throw new RuntimeException('A blocked channel read ignored its deadline');
}
$channel->send('buffered');
$timedWriter = Task::spawn(static fn () => $channel->send(value: 'late', timeoutMs: 20), []);
if ($timedWriter->wait() !== ChannelStatus::TimedOut
    || $channel->receive() !== ['status' => ChannelStatus::Ready, 'value' => 'buffered']) {
    throw new RuntimeException('A timed-out writer modified the channel');
}
$waiting = Task::spawn(static fn () => $channel->receive(), []);
if (Task::waitAny([$waiting], 20) !== null || $channel->send('resume') !== ChannelStatus::Ready
    || $waiting->wait() !== ['status' => ChannelStatus::Ready, 'value' => 'resume']) {
    throw new RuntimeException('A batch deadline lost a suspended channel read');
}
$deadlocked = Task::spawn(static function () use ($channel): string {
    try {
        $channel->receive();
    } catch (LogicException $error) {
        return $error->getMessage();
    }
    return 'unexpected completion';
}, []);
if ($deadlocked->wait() !== 'Task channel cannot make progress') {
    throw new RuntimeException('An isolated channel wait did not report the deadlock inside its Fiber');
}

$channel = Task::channel(1);
$cycle = (object) ['channel' => $channel];
$cycleReference = WeakReference::create($cycle);
$channel->send($cycle);
unset($channel, $cycle);
gc_collect_cycles();
if ($cycleReference->get() !== null) {
    throw new RuntimeException('An unreachable channel retained its queued objects');
}
foreach ([false, true] as $queueSameMessage) {
    foreach ([false, true] as $cancel) {
        $refs = parkedChannelCycle($queueSameMessage, $cancel);
        gc_collect_cycles();
        if (array_filter($refs, static fn (WeakReference $ref): bool => $ref->get() !== null)) {
            throw new RuntimeException(sprintf(
                '%s writer retained a cycle with a %s message',
                $cancel ? 'A cancelled' : 'An abandoned',
                $queueSameMessage ? 'queued and pending' : 'pending',
            ));
        }
    }
}

[$writer, $channelRef, $messageRef] = (static function (): array {
    $channel = Task::channel(1);
    $message = (object) ['channel' => $channel];
    $channel->send($message);
    $writer = Task::spawn(static fn () => $channel->send($message), []);
    $message->writer = $writer;
    parkTask($writer);
    return [$writer, WeakReference::create($channel), WeakReference::create($message)];
})();
gc_collect_cycles();
$channel = $channelRef->get();
$message = $messageRef->get();
if ($channel === null || $message === null
    || $channel->receive() !== ['status' => ChannelStatus::Ready, 'value' => $message]
    || $writer->wait() !== ChannelStatus::Ready
    || $channel->receive() !== ['status' => ChannelStatus::Ready, 'value' => $message]) {
    throw new RuntimeException('GC discarded or changed the state of a reachable parked writer');
}
unset($writer, $channel, $message);
gc_collect_cycles();
if ($channelRef->get() !== null || $messageRef->get() !== null) {
    throw new RuntimeException('A resumed writer retained its native GC pins');
}

foreach (['waitAll', 'waitAllSettled', 'waitAny'] as $operation) {
    $refs = (static function () use ($operation): array {
        $parent = null;
        $child = Task::spawn(static function () use (&$parent) {
            Task::sleep(3000);
            return $parent;
        }, []);
        $parent = Task::spawn(static fn () => Task::$operation([$child]), []);
        parkTask($parent);
        return [WeakReference::create($parent), WeakReference::create($child)];
    })();
    gc_collect_cycles();
    if ($refs[0]->get() !== null || $refs[1]->get() !== null) {
        throw new RuntimeException("An abandoned Task::$operation retained its parent and child");
    }
}

$refs = (static function (): array {
    $value = new stdClass();
    $task = Task::spawn(static fn () => VPHP\TaskProbe\sleepWithValue($value), []);
    $value->task = $task;
    parkTask($task);
    return [WeakReference::create($task), WeakReference::create($value)];
})();
gc_collect_cycles();
if ($refs[0]->get() !== null || $refs[1]->get() !== null) {
    throw new RuntimeException('An abandoned call to an exported function retained its PHP argument');
}

$domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
$emptyStreams = ['readable' => [], 'writable' => []];
$streamWaitSignature = new ReflectionMethod(VSlim\Task::class, 'waitStreams');
if (array_map(static fn (ReflectionParameter $p) => $p->getDefaultValue(), $streamWaitSignature->getParameters())
    !== [[], [], -1] || (string) $streamWaitSignature->getReturnType() !== 'array'
    || VSlim\Task::waitStreams() !== $emptyStreams) {
    throw new RuntimeException('The stream wait lost its default arguments or empty result');
}
[$selectFirst, $feedFirst] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
[$selectSecond, $feedSecond] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
foreach ([$selectFirst, $feedFirst, $selectSecond, $feedSecond] as $socket) {
    stream_set_blocking($socket, false);
}
try {
    fwrite($feedFirst, "r\0");
    if (VSlim\Task::waitStreams(read: [-4 => $selectFirst, "k\0y" => $selectFirst, 'idle' => $selectSecond],
        write: ['03' => $selectFirst], timeoutMs: 0) !== [
        'readable' => [-4 => $selectFirst, "k\0y" => $selectFirst],
        'writable' => ['03' => $selectFirst],
    ]) {
        throw new RuntimeException('The stream wait lost mixed interests, duplicate watches or original keys');
    }
    if (fread($selectFirst, 1) !== 'r' || VSlim\Task::waitStreams(read: [$selectFirst], timeoutMs: 0)
        !== ['readable' => [$selectFirst], 'writable' => []] || fread($selectFirst, 1) !== "\0") {
        throw new RuntimeException('The stream wait lost buffered read data');
    }
    $started = hrtime(true);
    if (VSlim\Task::waitStreams(read: [$selectFirst, $selectSecond], timeoutMs: 20) !== $emptyStreams
        || hrtime(true) - $started < 15_000_000) {
        throw new RuntimeException('The stream wait did not honor its main-stack timeout');
    }
    $drainFirst = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($selectFirst, 1), []);
    $select = VSlim\Task::spawn(static fn () => VSlim\Task::waitStreams(
        read: ['first' => $selectFirst, 'second' => $selectSecond], timeoutMs: 1000), []);
    $feed = VSlim\Task::spawn(static function () use ($feedFirst, $feedSecond, $drainFirst): int {
        sleepTask(0);
        fwrite($feedFirst, 'a');
        $drainFirst->wait();
        return fwrite($feedSecond, 'b');
    }, []);
    if (VSlim\Task::waitAll([$drainFirst, $select, $feed])
        !== ['a', ['readable' => ['second' => $selectSecond], 'writable' => []], 1]
        || fread($selectSecond, 1) !== 'b') {
        throw new RuntimeException('A competing Fiber left stale readiness in the selected set');
    }

    $slot = $selectFirst;
    $select = VSlim\Task::spawn(static function () use (&$slot): array {
        return VSlim\Task::waitStreams(read: ['watch' => &$slot], timeoutMs: 1000);
    }, []);
    $replace = VSlim\Task::spawn(static function () use (&$slot, $selectSecond, $feedFirst): int {
        sleepTask(0);
        $slot = $selectSecond;
        return fwrite($feedFirst, 'c');
    }, []);
    if (VSlim\Task::waitAll([$select, $replace])
        !== [['readable' => ['watch' => $selectFirst], 'writable' => []], 1]
        || fread($selectFirst, 1) !== 'c') {
        throw new RuntimeException('Replacing an input reference changed the registered stream');
    }

    $cancelReason = new DomainException('Cancel a multi-stream wait');
    $select = VSlim\Task::spawn(static fn () => VSlim\Task::waitStreams(read: [$selectFirst, $selectSecond]), []);
    $cancel = VSlim\Task::spawn(static function () use ($select, $cancelReason): bool {
        sleepTask(0);
        return $select->cancel($cancelReason);
    }, []);
    try {
        VSlim\Task::waitAll([$select, $cancel]);
        throw new RuntimeException('The stream set ignored cancellation');
    } catch (DomainException $error) {
        if ($error !== $cancelReason || !$cancel->wait()) {
            throw $error;
        }
    }
    try {
        waitPair(
            static fn () => VSlim\Task::waitStreams(read: [$selectFirst, $selectSecond]),
            static function () use ($selectFirst): void {
                sleepTask(0);
                fclose($selectFirst);
            },
        );
        throw new RuntimeException('Closing a watched stream did not wake a stream set');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'closed or became unpollable')) {
            throw $error;
        }
    }
    fwrite($feedSecond, 'd');
    if (VSlim\Task::waitStreams(read: [$selectSecond], timeoutMs: 0)
        !== ['readable' => [$selectSecond], 'writable' => []] || fread($selectSecond, 1) !== 'd') {
        throw new RuntimeException('A cancelled or closed set damaged another stream');
    }
} finally {
    foreach ([$selectFirst, $feedFirst, $selectSecond, $feedSecond] as $socket) {
        if (is_resource($socket)) {
            fclose($socket);
        }
    }
}

$fast = VSlim\Task::spawn(static fn () => 'ready', []);
$probeStarts = 0;
$probeOnly = VSlim\Task::spawn(static function () use (&$probeStarts): int {
    return ++$probeStarts;
}, []);
if (VSlim\Task::waitAny([$probeOnly], timeoutMs: 0) !== null || $probeStarts !== 0) {
    throw new RuntimeException('A zero timeout started a queued task');
}
if (VSlim\Task::waitAll(tasks: [$probeOnly], timeoutMs: 0) !== null || $probeStarts !== 0
    || VSlim\Task::waitAll([], 0) !== []) {
    throw new RuntimeException('A zero batch timeout changed the queued or empty batch');
}
try {
    VSlim\Task::waitAny([$probeOnly], -2);
    throw new RuntimeException('waitAny accepted an invalid timeout');
} catch (LogicException $error) {
    if (!str_contains($error->getMessage(), 'task wait timeout') || $probeStarts !== 0) {
        throw $error;
    }
}
if ($probeOnly->wait() !== 1 || VSlim\Task::waitAny([$probeOnly], 0) !== $probeOnly) {
    throw new RuntimeException('A zero timeout lost a settled task');
}
if (VSlim\Task::waitAll([$probeOnly, $probeOnly], 0) !== [1, 1]) {
    throw new RuntimeException('An immediate batch check lost a settled result or duplicate');
}
$signature = new ReflectionMethod(VSlim\Task::class, 'waitAny');
$timeoutParam = $signature->getParameters()[1];
if (!$signature->getReturnType()->allowsNull() || (string) $signature->getReturnType() !== '?VSlim\\TaskHandle'
    || $timeoutParam->getName() !== 'timeoutMs' || $timeoutParam->getDefaultValue() !== -1) {
    throw new RuntimeException('waitAny lost its nullable return or timeout metadata');
}
$batchSignature = new ReflectionMethod(VSlim\Task::class, 'waitAll');
$batchTimeout = $batchSignature->getParameters()[1];
if ((string) $batchSignature->getReturnType() !== '?array'
    || $batchTimeout->getName() !== 'timeoutMs' || $batchTimeout->getDefaultValue() !== -1) {
    throw new RuntimeException('waitAll lost its nullable return or timeout metadata');
}
$handleSignature = new ReflectionMethod(VSlim\TaskHandle::class, 'wait');
$handleTimeout = $handleSignature->getParameters()[0];
if ((string) $handleSignature->getReturnType() !== 'mixed'
    || $handleTimeout->getName() !== 'timeoutMs' || $handleTimeout->getDefaultValue() !== -1
    || !is_subclass_of(VSlim\TaskTimeoutException::class, RuntimeException::class)) {
    throw new RuntimeException('TaskHandle::wait lost its timeout metadata');
}
$statusSignature = new ReflectionMethod(VSlim\TaskHandle::class, 'status');
$outcomeSignature = new ReflectionMethod(VSlim\TaskHandle::class, 'outcome');
$statusEnum = new ReflectionEnum(VSlim\TaskStatus::class);
if ((string) $statusSignature->getReturnType() !== 'VSlim\\TaskStatus'
    || (string) $outcomeSignature->getReturnType() !== '?array'
    || $statusEnum->isBacked() || VSlim\TaskStatus::cases() !== [
        VSlim\TaskStatus::Pending, VSlim\TaskStatus::Fulfilled, VSlim\TaskStatus::Rejected,
    ]) {
    throw new RuntimeException('TaskHandle status or outcome metadata did not match its PHP contract');
}
try {
    VSlim\Task::waitAll([$probeOnly], -2);
    throw new RuntimeException('waitAll accepted an invalid timeout');
} catch (LogicException $error) {
    if (!str_contains($error->getMessage(), 'task wait timeout')) {
        throw $error;
    }
}
[$timeoutReader, $timeoutWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($timeoutReader, false);
$readStarts = 0;
$timedRead = VSlim\Task::spawn(static function () use ($timeoutReader, &$readStarts): string {
    ++$readStarts;
    return VSlim\Task::readExactly($timeoutReader, 1);
}, []);
try {
    $started = hrtime(true);
    if (VSlim\Task::waitAny([$timedRead], 20) !== null
        || hrtime(true) - $started < 15_000_000 || $readStarts !== 1) {
        throw new RuntimeException('A standalone waitAny did not honor the deadline');
    }
    fwrite($timeoutWriter, 't');
    if (VSlim\Task::waitAny([$timedRead], 1000) !== $timedRead
        || $timedRead->wait() !== 't' || $readStarts !== 1) {
        throw new RuntimeException('A timed-out wait did not preserve its candidate');
    }
    $failure = new DomainException('batch exception');
    $failedTask = VSlim\Task::spawn(static fn () => throw $failure, []);
    $timedRead = VSlim\Task::spawn(static function () use ($timeoutReader, &$readStarts): string {
        ++$readStarts;
        return VSlim\Task::readExactly($timeoutReader, 1);
    }, []);
    $started = hrtime(true);
    if (VSlim\Task::waitAll([$failedTask, $timedRead], 20) !== null
        || hrtime(true) - $started < 15_000_000 || $readStarts !== 2) {
        throw new RuntimeException('A batch did not honor its deadline after a task failed');
    }
    fwrite($timeoutWriter, 'b');
    try {
        VSlim\Task::waitAll([$failedTask, $timedRead], 1000);
        throw new RuntimeException('A later batch wait lost its original exception');
    } catch (DomainException $error) {
        if ($error !== $failure || $timedRead->wait() !== 'b' || $readStarts !== 2) {
            throw $error;
        }
    }

    $lead = VSlim\Task::spawn(static function (): string {
        sleepTask(65);
        return 'first';
    }, []);
    $tail = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($timeoutReader, 1), []);
    $batch = VSlim\Task::spawn(static fn () => VSlim\Task::waitAll([$lead, $tail], 120), []);
    $feed = VSlim\Task::spawn(static function () use ($timeoutWriter): int {
        sleepTask(155);
        return fwrite($timeoutWriter, 'c');
    }, []);
    if (VSlim\Task::waitAll([$batch, $feed]) !== [null, 1]
        || VSlim\Task::waitAll([$lead, $tail], 1000) !== ['first', 'c']) {
        throw new RuntimeException('A nested batch restarted its deadline or lost a task');
    }

    $nullStarts = 0;
    $nullTask = VSlim\Task::spawn(static function () use ($timeoutReader, &$nullStarts): mixed {
        ++$nullStarts;
        VSlim\Task::readExactly($timeoutReader, 1);
        return null;
    }, []);
    if ($nullTask->status() !== VSlim\TaskStatus::Pending || $nullTask->outcome() !== null
        || $nullStarts !== 0) {
        throw new RuntimeException('Inspecting a queued task started its callback');
    }
    try {
        $nullTask->wait(timeoutMs: 0);
        throw new RuntimeException('An unfinished handle was reported as settled');
    } catch (VSlim\TaskTimeoutException $error) {
        if ($nullStarts !== 0) {
            throw $error;
        }
    }
    $started = hrtime(true);
    try {
        $nullTask->wait(20);
        throw new RuntimeException('A single handle ignored its deadline');
    } catch (VSlim\TaskTimeoutException $error) {
        if (hrtime(true) - $started < 15_000_000 || $nullStarts !== 1) {
            throw $error;
        }
    }
    if ($nullTask->status() !== VSlim\TaskStatus::Pending || $nullTask->outcome() !== null) {
        throw new RuntimeException('A timed-out handle wait reported the task as settled');
    }
    fwrite($timeoutWriter, 'n');
    if ($nullTask->wait(timeoutMs: 1000) !== null || $nullTask->wait(0) !== null || $nullStarts !== 1) {
        throw new RuntimeException('A successful null result was lost after a handle timeout');
    }
    if ($nullTask->status() !== VSlim\TaskStatus::Fulfilled
        || $nullTask->outcome() !== ['status' => 'fulfilled', 'value' => null]) {
        throw new RuntimeException('A settled null result was reported as pending');
    }
} finally {
    fclose($timeoutReader);
    fclose($timeoutWriter);
}
$timedParent = null;
$timedChild = VSlim\Task::spawn(static function () use (&$timedParent): string {
    return $timedParent->wait() . ' child';
}, []);
$timedParent = VSlim\Task::spawn(static function () use ($timedChild): string {
    $started = hrtime(true);
    if (VSlim\Task::waitAny([$timedChild], timeoutMs: 20) !== null
        || hrtime(true) - $started < 15_000_000) {
        throw new RuntimeException('A finite wait did not let a dependency cycle expire');
    }
    return 'parent';
}, []);
if ($timedParent->wait() !== 'parent' || $timedChild->wait() !== 'parent child') {
    throw new RuntimeException('A timed nested wait lost the dependent task');
}

$handleParent = null;
$handleChild = VSlim\Task::spawn(static function () use (&$handleParent): string {
    return $handleParent->wait() . ' child';
}, []);
$handleParent = VSlim\Task::spawn(static function () use ($handleChild): string {
    try {
        $handleChild->wait(20);
        throw new RuntimeException('A nested handle wait ignored its deadline');
    } catch (VSlim\TaskTimeoutException) {
        return 'parent';
    }
}, []);
if ($handleParent->wait() !== 'parent' || $handleChild->wait(1000) !== 'parent child') {
    throw new RuntimeException('The nested handle timeout lost the dependent task');
}

$neverStarted = VSlim\Task::spawn(static fn () => throw new RuntimeException('Started a losing task'), []);
if (VSlim\Task::waitAny(tasks: [$fast, $neverStarted]) !== $fast
    || VSlim\Task::waitAny([$neverStarted, $fast, $fast]) !== $fast
    || $fast->wait() !== 'ready' || !$neverStarted->cancel()) {
    throw new RuntimeException('waitAny lost handle identity or started extra tasks');
}
try {
    VSlim\Task::waitAny([]);
    throw new LogicException('waitAny accepted an empty batch');
} catch (ValueError $error) {
    if (!str_contains($error->getMessage(), 'at least one TaskHandle')) {
        throw $error;
    }
}
try {
    VSlim\Task::waitAny([$fast, new stdClass()]);
    throw new LogicException('waitAny accepted a non-handle');
} catch (TypeError $error) {
    if (!str_contains($error->getMessage(), 'expects TaskHandle instances')) {
        throw $error;
    }
}
$slot = VSlim\Task::spawn(static function (): string {
    sleepTask(5);
    return 'original';
}, []);
$originalHandle = WeakReference::create($slot);
$replaceSlot = VSlim\Task::spawn(static function () use (&$slot): void {
    $slot = VSlim\Task::spawn(static fn () => 'replacement', []);
    gc_collect_cycles();
    sleepTask(50);
}, []);
$selectedHandle = VSlim\Task::waitAny([&$slot, $replaceSlot]);
if ($selectedHandle !== $originalHandle->get() || $selectedHandle === $slot
    || $selectedHandle->wait() !== 'original') {
    throw new RuntimeException('A reference assignment changed the handles being observed');
}
$replaceSlot->cancel();
$failedReason = new DomainException('First task failed');
$failed = VSlim\Task::spawn(static fn () => throw $failedReason, []);
if (VSlim\Task::waitAny([$failed]) !== $failed) {
    throw new RuntimeException('A failed task did not settle the wait');
}
if ($failed->status() !== VSlim\TaskStatus::Rejected
    || $failed->outcome() !== ['status' => 'rejected', 'reason' => $failedReason]) {
    throw new RuntimeException('Inspecting a failed task did not return its original Throwable');
}
try {
    $failed->wait();
    throw new LogicException('The first task lost its exception');
} catch (DomainException $error) {
    if ($error !== $failedReason) {
        throw $error;
    }
}
$cancelledReason = new DomainException('First task was cancelled');
$cancelled = VSlim\Task::spawn(static fn () => throw new LogicException('Invoked a cancelled task'), []);
$cancelled->cancel($cancelledReason);
if ($cancelled->status() !== VSlim\TaskStatus::Rejected
    || $cancelled->outcome() !== ['status' => 'rejected', 'reason' => $cancelledReason]) {
    throw new RuntimeException('Inspecting a cancelled task did not return its original Throwable');
}
if (VSlim\Task::waitAny([$cancelled, $fast]) !== $cancelled) {
    throw new RuntimeException('A cancellation did not settle the wait in input order');
}
try {
    $cancelled->wait(timeoutMs: 0);
    throw new LogicException('The first task lost its cancellation');
} catch (DomainException $error) {
    if ($error !== $cancelledReason) {
        throw $error;
    }
}

$catchesCancel = VSlim\Task::spawn(static function () use ($cancelledReason): string {
    try {
        sleepTask(1000);
        throw new RuntimeException('The scheduled task did not observe cancellation');
    } catch (DomainException $error) {
        if ($error !== $cancelledReason) {
            throw $error;
        }
        return 'recovered';
    }
}, []);
$cancelAndObserve = VSlim\Task::spawn(static function () use ($catchesCancel, $cancelledReason): void {
    sleepTask(0);
    if (!$catchesCancel->cancel($cancelledReason) || $catchesCancel->status() !== VSlim\TaskStatus::Pending
        || $catchesCancel->outcome() !== null) {
        throw new RuntimeException('An undelivered cancellation was reported as a task outcome');
    }
}, []);
if (VSlim\Task::waitAll([$catchesCancel, $cancelAndObserve]) !== ['recovered', null]
    || $catchesCancel->status() !== VSlim\TaskStatus::Fulfilled
    || $catchesCancel->outcome() !== ['status' => 'fulfilled', 'value' => 'recovered']) {
    throw new RuntimeException('A handled cancellation was reported as a rejection');
}

$settlementSignature = new ReflectionMethod(VSlim\Task::class, 'waitAllSettled');
$settlementTimeout = $settlementSignature->getParameters()[1];
if ((string) $settlementSignature->getReturnType() !== '?array'
    || $settlementTimeout->getName() !== 'timeoutMs' || $settlementTimeout->getDefaultValue() !== -1) {
    throw new RuntimeException('waitAllSettled lost its nullable return or timeout metadata');
}
$settlementStarts = 0;
$laterSuccess = VSlim\Task::spawn(static function () use (&$settlementStarts): mixed {
    ++$settlementStarts;
    sleepTask(1);
    return null;
}, []);
$laterFailure = VSlim\Task::spawn(static function () use ($failedReason): void {
    sleepTask(0);
    throw $failedReason;
}, []);
if (VSlim\Task::waitAllSettled([$laterSuccess], timeoutMs: 0) !== null || $settlementStarts !== 0
    || VSlim\Task::waitAllSettled([], 0) !== []) {
    throw new RuntimeException('An immediate settlement check changed a queued or empty batch');
}
try {
    VSlim\Task::waitAllSettled([$laterSuccess, new stdClass()]);
    throw new LogicException('waitAllSettled accepted a non-handle');
} catch (TypeError $error) {
    if (!str_contains($error->getMessage(), 'waitAllSettled expects TaskHandle instances')
        || $settlementStarts !== 0) {
        throw $error;
    }
}
$settlements = VSlim\Task::waitAllSettled(
    tasks: ['failure' => $laterFailure, 'cancel' => $cancelled, 'null' => $laterSuccess,
        'repeat' => $laterSuccess, 'result' => $probeOnly],
    timeoutMs: 1000,
);
if ($settlements !== [
    ['status' => 'rejected', 'reason' => $failedReason],
    ['status' => 'rejected', 'reason' => $cancelledReason],
    ['status' => 'fulfilled', 'value' => null],
    ['status' => 'fulfilled', 'value' => null],
    ['status' => 'fulfilled', 'value' => 1],
] || $settlementStarts !== 1
    || VSlim\Task::waitAllSettled([$laterFailure, $cancelled], 0) !== array_slice($settlements, 0, 2)) {
    throw new RuntimeException('Batch settlements lost input order, a duplicate, or an original outcome');
}
try {
    VSlim\Task::waitAll([$laterFailure, $laterSuccess]);
    throw new LogicException('Inspecting an exception consumed it from the task');
} catch (DomainException $error) {
    if ($error !== $failedReason) {
        throw $error;
    }
}

[$raceReader, $raceWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($raceReader, false);
$raceStarts = 0;
$childReference = null;
$waitingParent = VSlim\Task::spawn(static function () use ($raceReader, &$raceStarts, &$childReference): string {
    ++$raceStarts;
    $child = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($raceReader, 1), []);
    $sibling = VSlim\Task::spawn(static function () use ($raceReader): string {
        sleepTask(10);
        return VSlim\Task::readExactly($raceReader, 1);
    }, []);
    $childReference = WeakReference::create($child);
    return implode('', VSlim\Task::waitAll([$child, $sibling]));
}, []);
$winner = VSlim\Task::spawn(static function (): int {
    sleepTask(5);
    return 7;
}, []);
$race = VSlim\Task::spawn(static fn () => VSlim\Task::waitAny([$waitingParent, $winner]), []);
try {
    if ($race->wait() !== $winner || $winner->wait() !== 7 || $raceStarts !== 1) {
        throw new RuntimeException('Nested waitAny did not select the first task to settle');
    }
    gc_collect_cycles();
    if ($childReference?->get() === null) {
        throw new RuntimeException('The suspended task lost ownership of its child');
    }
    $writer = VSlim\Task::spawn(static fn () => fwrite($raceWriter, 'xy'), []);
    if (VSlim\Task::waitAll([$waitingParent, $writer]) !== ['xy', 2] || $raceStarts !== 1) {
        throw new RuntimeException('A pending task lost its batch when it rejoined the scheduler');
    }
    gc_collect_cycles();
    if ($childReference->get() !== null) {
        throw new RuntimeException('A natural completion kept a child alive after the next wait');
    }
} finally {
    fclose($raceReader);
    fclose($raceWriter);
}

$dependent = null;
$alternative = VSlim\Task::spawn(static fn () => 10, []);
$dependent = VSlim\Task::spawn(static function () use (&$dependent, $alternative): int {
    return VSlim\Task::waitAny([$dependent, $alternative])->wait();
}, []);
if ($dependent->wait() !== 10) {
    throw new RuntimeException('A cyclic alternative hid runnable work from waitAny');
}
$cycle = null;
$cycle = VSlim\Task::spawn(static function () use (&$cycle): void {
    VSlim\Task::waitAny([$cycle]);
}, []);
try {
    $cycle->wait();
    throw new RuntimeException('waitAny accepted a cycle with no runnable alternative');
} catch (LogicException $error) {
    if (!str_contains($error->getMessage(), 'recursively')) {
        throw $error;
    }
}

$gate = tempnam(sys_get_temp_dir(), 'vphp-task-any-');
unlink($gate);
try {
    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    $chooser = VSlim\Task::spawn(static fn () => VSlim\Task::waitAny([$native]), []);
    $release = VSlim\Task::spawn(static function () use ($gate): bool {
        sleepTask(5);
        return touch($gate);
    }, []);
    if (VSlim\Task::waitAll([$chooser, $release]) !== [$native, true]
        || $native->wait() !== $expected) {
        throw new RuntimeException('A native task did not wake a suspended waitAny');
    }
    unlink($gate);
    unlink($gate . '.done');
    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    if ($native->status() !== VSlim\TaskStatus::Pending || $native->outcome() !== null) {
        throw new RuntimeException('Inspecting a running native task did not return a pending state');
    }
    if (VSlim\Task::waitAny([$native], timeoutMs: 20) !== null) {
        throw new RuntimeException('An unfinished native job ignored the selection deadline');
    }
    if (VSlim\Task::waitAll([$probeOnly, $native], timeoutMs: 20) !== null) {
        throw new RuntimeException('An unfinished native job ignored the batch deadline');
    }
    if (VSlim\Task::waitAllSettled([$probeOnly, $native], timeoutMs: 20) !== null) {
        throw new RuntimeException('The settlement batch exposed partial results on timeout');
    }
    try {
        $native->wait(timeoutMs: 20);
        throw new RuntimeException('An unfinished native job ignored the handle deadline');
    } catch (VSlim\TaskTimeoutException) {
    }
    $winner = VSlim\Task::spawn(static fn () => sleepTask(5), []);
    if (VSlim\Task::waitAny([$native, $winner]) !== $winner) {
        throw new RuntimeException('A pending native task delayed a settled PHP peer');
    }
    touch($gate);
    if (VSlim\Task::waitAny([$native]) !== $native || $native->status() !== VSlim\TaskStatus::Fulfilled
        || $native->outcome() !== ['status' => 'fulfilled', 'value' => $expected] || $native->wait() !== $expected) {
        throw new RuntimeException('A native task could not rejoin a later waitAny');
    }
    if (VSlim\Task::waitAll([$native, $probeOnly], 0) !== [$expected, 1]) {
        throw new RuntimeException('A zero batch timeout lost a settled native result');
    }
    if (VSlim\Task::waitAllSettled([$native, $cancelled]) !== [
        ['status' => 'fulfilled', 'value' => $expected],
        ['status' => 'rejected', 'reason' => $cancelledReason],
    ]) {
        throw new RuntimeException('A mixed settlement batch lost a native or cancelled outcome');
    }
    unlink($gate);
    unlink($gate . '.done');
    $native = VSlim\Task::spawn('TaskProbeNativeGate', [$gate]);
    $observer = VSlim\Task::spawn(static fn () => VSlim\Task::waitAllSettled([$native, $cancelled]), []);
    $release = VSlim\Task::spawn(static function () use ($gate): bool {
        sleepTask(5);
        return touch($gate);
    }, []);
    if (VSlim\Task::waitAll([$observer, $release]) !== [[
        ['status' => 'fulfilled', 'value' => $expected],
        ['status' => 'rejected', 'reason' => $cancelledReason],
    ], true]) {
        throw new RuntimeException('A nested settlement batch blocked the native job or its PHP peer');
    }
} finally {
    @unlink($gate);
    @unlink($gate . '.done');
}

$blockingListener = stream_socket_server('tcp://127.0.0.1:0');
try {
    VSlim\Task::accept($blockingListener, 0);
    throw new LogicException('A blocking listener was accepted');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'nonblocking PHP socket listener')) {
        throw $error;
    }
} finally {
    fclose($blockingListener);
}
$listenerContext = stream_context_create(['socket' => ['backlog' => 5]]);
$listener = VSlim\Task::listen(address: 'tcp://127.0.0.1:0', context: $listenerContext);
if (stream_get_meta_data($listener)['blocked']
    || stream_context_get_options($listener) !== stream_context_get_options($listenerContext)) {
    throw new RuntimeException('The listener lost nonblocking mode or context');
}
$address = 'tcp://' . stream_socket_get_name($listener, false);
$context = stream_context_create(['socket' => ['tcp_nodelay' => true]]);
$connect = VSlim\Task::spawn(static function () use ($address, $context): string {
    $socket = VSlim\Task::connect(address: $address, context: $context);
    try {
        if (stream_get_meta_data($socket)['blocked']
            || stream_context_get_options($socket) !== stream_context_get_options($context)) {
            throw new RuntimeException('The connection did not preserve nonblocking mode or context');
        }
        VSlim\Task::writeAll($socket, "p\0");
        return VSlim\Task::readExactly($socket, 2, 1000);
    } finally {
        fclose($socket);
    }
}, []);
$accept = VSlim\Task::spawn(static function () use ($listener): string {
    $socket = VSlim\Task::accept(listener: $listener, timeoutMs: 1000);
    try {
        if (stream_get_meta_data($socket)['blocked']
            || stream_context_get_options($socket) !== stream_context_get_options($listener)) {
            throw new RuntimeException('The accepted stream lost nonblocking mode or context');
        }
        $data = VSlim\Task::readExactly($socket, 2, 1000);
        VSlim\Task::writeAll($socket, "q\0");
        return $data;
    } finally {
        fclose($socket);
    }
}, []);
if (VSlim\Task::waitAll([$accept, $connect]) !== ["p\0", "q\0"]) {
    throw new RuntimeException('The connected stream did not exchange binary data with its peer');
}

foreach ([0, 20] as $timeout) {
    $started = hrtime(true);
    try {
        VSlim\Task::accept($listener, $timeout);
        throw new LogicException('An idle listener ignored its deadline');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Timed out accepting PHP stream')
            || ($timeout > 0 && hrtime(true) - $started < 15_000_000)) {
            throw $error;
        }
    }
}
$cancelledAccept = VSlim\Task::spawn(static fn () => VSlim\Task::accept($listener), []);
$readPeer = static function () use ($listener): string {
    $peer = VSlim\Task::accept($listener, 1000);
    try {
        return VSlim\Task::readExactly($peer, 1, 1000);
    } finally {
        fclose($peer);
    }
};
$firstAccept = VSlim\Task::spawn($readPeer, []);
$secondAccept = VSlim\Task::spawn($readPeer, []);
$acceptReason = new DomainException('Cancel one listener wait');
$sendPeers = VSlim\Task::spawn(static function () use ($address, $cancelledAccept, $acceptReason, $firstAccept): string {
    if (!$cancelledAccept->cancel($acceptReason)) {
        throw new RuntimeException('The pending accept was not cancelled');
    }
    $first = VSlim\Task::connect($address);
    try {
        VSlim\Task::writeAll($first, 'a');
        $result = $firstAccept->wait();
    } finally {
        fclose($first);
    }
    $second = VSlim\Task::connect($address);
    try {
        VSlim\Task::writeAll($second, 'b');
    } finally {
        fclose($second);
    }
    return $result;
}, []);
if (VSlim\Task::waitAll([$firstAccept, $secondAccept, $sendPeers]) !== ['a', 'b', 'a']) {
    throw new RuntimeException('Concurrent accepts did not receive distinct peers');
}
try {
    $cancelledAccept->wait();
    throw new LogicException('Accept cancellation was lost');
} catch (DomainException $error) {
    if ($error !== $acceptReason) {
        throw $error;
    }
}

$closingListener = VSlim\Task::listen('tcp://127.0.0.1:0');
$acceptUntilClosed = static function () use ($closingListener): string {
    try {
        VSlim\Task::accept($closingListener);
        throw new LogicException('A closed listener returned a connection');
    } catch (Exception $error) {
        return $error->getMessage();
    }
};
$closingWaits = [
    VSlim\Task::spawn($acceptUntilClosed, []),
    VSlim\Task::spawn($acceptUntilClosed, []),
    VSlim\Task::spawn(static function () use ($closingListener): bool {
        VSlim\Task::sleep(0);
        return fclose($closingListener);
    }, []),
];
$closedMessage = 'PHP socket listener closed while waiting to accept';
if (VSlim\Task::waitAll($closingWaits) !== [$closedMessage, $closedMessage, true]) {
    throw new RuntimeException('Closing a listener did not wake all accept waiters');
}

$changingListener = VSlim\Task::listen('tcp://127.0.0.1:0');
$changingAddress = 'tcp://' . stream_socket_get_name($changingListener, false);
$pendingAccept = VSlim\Task::spawn(static function () use ($changingListener): string {
    try {
        $unexpectedPeer = VSlim\Task::accept($changingListener, 1000);
        fclose($unexpectedPeer);
        return 'accepted';
    } catch (Exception $error) {
        return $error->getMessage();
    }
}, []);
$connectAfterChangingMode = VSlim\Task::spawn(static function () use ($changingListener, $changingAddress) {
    VSlim\Task::sleep(0);
    if (!stream_set_blocking($changingListener, true)) {
        throw new RuntimeException('Could not change the listener mode');
    }
    return VSlim\Task::connect($changingAddress, 1000);
}, []);
[$acceptError, $client] = VSlim\Task::waitAll([$pendingAccept, $connectAfterChangingMode]);
try {
    if (!str_contains($acceptError, 'nonblocking PHP socket listener')) {
        throw new RuntimeException('Accept did not recheck blocking mode after resuming: ' . $acceptError);
    }
    if (!stream_get_meta_data($changingListener)['blocked']) {
        throw new RuntimeException('Accept changed the mode of a borrowed listener');
    }
    stream_set_blocking($changingListener, false);
    $peer = VSlim\Task::accept($changingListener, 0);
    fclose($peer);
} finally {
    fclose($client);
    fclose($changingListener);
}

if (in_array('tls', stream_get_transports(), true)
    && is_resource($tlsListener = @stream_socket_server('tls://127.0.0.1:0'))) {
    stream_set_blocking($tlsListener, false);
    try {
        VSlim\Task::accept($tlsListener, 0);
        throw new LogicException('A TLS listener was treated as a plain socket');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Expected a plain TCP or Unix socket listener')) {
            throw $error;
        }
    } finally {
        fclose($tlsListener);
    }
}

$streamCount = count(get_resources('stream'));
try {
    VSlim\Task::connect($address, 100, context: 42);
    throw new LogicException('An invalid connection context was accepted');
} catch (TypeError $error) {
    if (!str_contains($error->getMessage(), 'Socket context') || count(get_resources('stream')) !== $streamCount) {
        throw $error;
    }
}
$connecting = VSlim\Task::spawn(static fn () => VSlim\Task::connect($address, 1000), []);
$cancelConnectReason = new DomainException('Cancel an in-progress connection wait');
$cancelConnect = VSlim\Task::spawn(static fn () => $connecting->cancel($cancelConnectReason), []);
try {
    VSlim\Task::waitAll([$connecting, $cancelConnect]);
    throw new LogicException('Connection cancellation was ignored');
} catch (DomainException $error) {
    if ($error !== $cancelConnectReason || !$cancelConnect->wait()
        || count(get_resources('stream')) !== $streamCount) {
        throw $error;
    }
}
fclose($listener);
try {
    VSlim\Task::connect($address, 100);
    throw new LogicException('A refused connection was reported as successful');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'Unable to connect PHP stream')
        || count(get_resources('stream')) !== $streamCount - 1) {
        throw $error;
    }
}

// Linux can drop SYNs when the accept queue is full. Keep the queue full
// until the next connection deadline rather than depending on an external IP.
if (PHP_OS_FAMILY === 'Linux'
    && trim((string) @file_get_contents('/proc/sys/net/ipv4/tcp_abort_on_overflow')) === '0') {
    $backlogContext = stream_context_create(['socket' => ['backlog' => 1]]);
    $listener = stream_socket_server('tcp://127.0.0.1:0', $errno, $reason,
        STREAM_SERVER_BIND | STREAM_SERVER_LISTEN, $backlogContext);
    $address = 'tcp://' . stream_socket_get_name($listener, false);
    $clients = [];
    $timedOut = false;
    try {
        for ($index = 0; $index < 16; ++$index) {
            $started = hrtime(true);
            $open = count(get_resources('stream'));
            try {
                $clients[] = VSlim\Task::connect($address, 40);
            } catch (Exception $error) {
                if (!str_contains($error->getMessage(), 'Timed out connecting PHP stream')
                    || hrtime(true) - $started < 30_000_000 || count(get_resources('stream')) !== $open) {
                    throw $error;
                }
                $timedOut = true;
                break;
            }
        }
        if (!$timedOut) {
            throw new RuntimeException('The Linux accept queue did not produce a connection timeout');
        }
    } finally {
        foreach ($clients as $client) {
            fclose($client);
        }
        fclose($listener);
    }
}

if (PHP_OS_FAMILY !== 'Windows' && in_array('unix', stream_get_transports(), true)) {
    $unixPath = tempnam('/tmp', 'vphp-connect-');
    unlink($unixPath);
    $unixContext = stream_context_create(['socket' => ['backlog' => 3]]);
    $unixListener = VSlim\Task::listen("unix://$unixPath", $unixContext);
    unset($unixContext);
    $unixClient = null;
    $unixPeer = null;
    try {
        $unixClient = VSlim\Task::connect("unix://$unixPath", 1000);
        $unixPeer = VSlim\Task::accept($unixListener, 0);
        fclose($unixListener);
        if (VSlim\Task::writeAll($unixClient, 'u', 100) !== 1 || fread($unixPeer, 1) !== 'u'
            || stream_context_get_options($unixPeer) !== ['socket' => ['backlog' => 3]]) {
            throw new RuntimeException('The connected Unix stream did not exchange data');
        }
    } finally {
        if (is_resource($unixPeer)) {
            fclose($unixPeer);
        }
        if (is_resource($unixClient)) {
            fclose($unixClient);
        }
        if (is_resource($unixListener)) {
            fclose($unixListener);
        }
        unlink($unixPath);
    }
}

[$writeReader, $writeWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($writeReader, false);
stream_set_blocking($writeWriter, false);
$payload = str_repeat("ab\0c", 1_048_576);
$send = VSlim\Task::spawn(static fn () => VSlim\Task::writeAll($writeWriter, $payload, 30000), []);
$receive = VSlim\Task::spawn(static function () use ($writeReader, $payload): string {
    VSlim\Task::sleep(0);
    $bytes = '';
    while (strlen($bytes) < strlen($payload)) {
        if (!VSlim\Task::awaitReadable($writeReader, 30000)) {
            throw new RuntimeException('Timed out draining the writeAll test socket');
        }
        $chunk = fread($writeReader, 8192);
        if ($chunk === false || $chunk === '') {
            throw new RuntimeException('The writer stopped before sending all bytes');
        }
        $bytes .= $chunk;
    }
    return $bytes;
}, []);
if (VSlim\Task::waitAll([$send, $receive]) !== [strlen($payload), $payload]
    || !is_resource($writeWriter)) {
    throw new RuntimeException('Writing across backpressure changed bytes or stream ownership');
}

$started = hrtime(true);
try {
    VSlim\Task::writeAll($writeWriter, $payload, 20);
    throw new LogicException('A full socket ignored its write deadline');
} catch (Exception $error) {
    if (hrtime(true) - $started < 15_000_000
        || !preg_match('/Timed out writing to PHP stream after writing ([0-9]+) bytes/', $error->getMessage(), $matches)) {
        throw $error;
    }
}
$partial = stream_get_contents($writeReader);
if ($partial === '' || $partial !== substr($payload, 0, (int) $matches[1])) {
    throw new RuntimeException('The timeout reported the wrong partial byte count');
}

try {
    VSlim\Task::writeAll($writeWriter, $payload, 0);
    throw new LogicException('A zero timeout waited for the peer');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'Timed out writing to PHP stream')) {
        throw $error;
    }
}
$waitingWrite = VSlim\Task::spawn(static fn () => VSlim\Task::writeAll($writeWriter, $payload), []);
$cancelWriteReason = new DomainException('Cancel a backpressured writer');
$cancelWrite = VSlim\Task::spawn(static function () use ($waitingWrite, $cancelWriteReason): bool {
    VSlim\Task::sleep(0);
    return $waitingWrite->cancel($cancelWriteReason);
}, []);
try {
    VSlim\Task::waitAll([$waitingWrite, $cancelWrite]);
    throw new LogicException('The writer ignored cancellation');
} catch (DomainException $error) {
    if ($error !== $cancelWriteReason || !$cancelWrite->wait() || !is_resource($writeWriter)) {
        throw $error;
    }
}
fclose($writeReader);
fclose($writeWriter);

[$exactReader, $exactWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($exactReader, false);
stream_set_blocking($exactWriter, false);
fwrite($exactWriter, "x\0");
$exactRead = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($exactReader, 4, 1000), []);
$exactWrite = VSlim\Task::spawn(static function () use ($exactWriter): int {
    VSlim\Task::sleep(0);
    return fwrite($exactWriter, 'yztail');
}, []);
if (VSlim\Task::waitAll([$exactRead, $exactWrite]) !== ["x\0yz", 6]
    || VSlim\Task::readExactly($exactReader, 4, 0) !== 'tail') {
    throw new RuntimeException('Short reads lost bytes or consumed the following frame');
}

$readyBytes = str_repeat('r', 8193);
$readyStream = tmpfile();
fwrite($readyStream, $readyBytes);
rewind($readyStream);
if (stream_set_blocking($readyStream, false)
    && (stream_get_meta_data($readyStream)['blocked'] ?? true) === false
    && VSlim\Task::readExactly($readyStream, strlen($readyBytes), 0) !== $readyBytes) {
    throw new RuntimeException('A zero timeout failed to read all immediately available bytes');
}
fclose($readyStream);

fwrite($exactWriter, 't');
$started = hrtime(true);
try {
    VSlim\Task::readExactly($exactReader, 2, 20);
    throw new LogicException('A partial read ignored its deadline');
} catch (Exception $error) {
    if (hrtime(true) - $started < 15_000_000
        || !str_contains($error->getMessage(), 'Timed out reading PHP stream after reading 1 of 2 bytes')) {
        throw $error;
    }
}

$waitingRead = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($exactReader, 1), []);
$cancelReadReason = new DomainException('Cancel an exact read');
$cancelRead = VSlim\Task::spawn(static function () use ($waitingRead, $cancelReadReason): bool {
    VSlim\Task::sleep(0);
    return $waitingRead->cancel($cancelReadReason);
}, []);
try {
    VSlim\Task::waitAll([$waitingRead, $cancelRead]);
    throw new LogicException('The reader ignored cancellation');
} catch (DomainException $error) {
    if ($error !== $cancelReadReason || !$cancelRead->wait() || !is_resource($exactReader)) {
        throw $error;
    }
}

fwrite($exactWriter, 'e');
fclose($exactWriter);
try {
    VSlim\Task::readExactly($exactReader, 2, 1000);
    throw new LogicException('An exact read accepted early EOF');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'PHP stream reached EOF after reading 1 of 2 bytes')) {
        throw $error;
    }
}
fclose($exactReader);

[$lineReader, $lineWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($lineReader, false);
stream_set_blocking($lineWriter, false);
fwrite($lineWriter, "h\0");
$lineRead = VSlim\Task::spawn(static fn () => VSlim\Task::readLine($lineReader, 5, 1000), []);
$lineWrite = VSlim\Task::spawn(static function () use ($lineWriter): int {
    VSlim\Task::sleep(0);
    return fwrite($lineWriter, "i\r\nnext\n");
}, []);
if (VSlim\Task::waitAll([$lineRead, $lineWrite]) !== ["h\0i\r\n", 8]
    || VSlim\Task::readLine($lineReader, 5, 0) !== "next\n") {
    throw new RuntimeException('Fragmented lines lost bytes or consumed the following line');
}

fwrite($lineWriter, "long\n");
try {
    VSlim\Task::readLine($lineReader, 3, 50);
    throw new LogicException('A line exceeded its byte limit');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'PHP stream line exceeds the 3 byte limit')) {
        throw $error;
    }
}
if (VSlim\Task::readLine($lineReader, 2, 0) !== "g\n") {
    throw new RuntimeException('The line limit consumed bytes past the limit');
}

fwrite($lineWriter, 'partial');
$started = hrtime(true);
try {
    VSlim\Task::readLine($lineReader, 16, 20);
    throw new LogicException('An incomplete line ignored its deadline');
} catch (Exception $error) {
    if (hrtime(true) - $started < 15_000_000
        || !str_contains($error->getMessage(), 'Timed out reading PHP stream after reading 7')) {
        throw $error;
    }
}

$waitingLine = VSlim\Task::spawn(static fn () => VSlim\Task::readLine($lineReader, 16), []);
$cancelLineReason = new DomainException('Cancel a line read');
$cancelLine = VSlim\Task::spawn(static function () use ($waitingLine, $cancelLineReason): bool {
    VSlim\Task::sleep(0);
    return $waitingLine->cancel($cancelLineReason);
}, []);
try {
    VSlim\Task::waitAll([$waitingLine, $cancelLine]);
    throw new LogicException('The line reader ignored cancellation');
} catch (DomainException $error) {
    if ($error !== $cancelLineReason || !$cancelLine->wait() || !is_resource($lineReader)) {
        throw $error;
    }
}

fwrite($lineWriter, 'end');
fclose($lineWriter);
try {
    VSlim\Task::readLine($lineReader, 16, 1000);
    throw new LogicException('An unterminated line was accepted at EOF');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'PHP stream reached EOF before LF after reading 3 bytes')) {
        throw $error;
    }
}
fclose($lineReader);

[$copySource, $copyInput] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
[$copyOutput, $copyDestination] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
foreach ([$copySource, $copyInput, $copyOutput, $copyDestination] as $socket) {
    stream_set_blocking($socket, false);
}
$copyBytes = str_repeat("copy\0", 104_858);
$copyLength = strlen($copyBytes);
$copy = VSlim\Task::spawn(static fn () => VSlim\Task::copyStream($copySource, $copyDestination, $copyLength, 5000), []);
$feedCopy = VSlim\Task::spawn(static fn () => VSlim\Task::writeAll($copyInput, $copyBytes . 'tail', 5000), []);
$drainCopy = VSlim\Task::spawn(static fn () => VSlim\Task::readExactly($copyOutput, $copyLength, 5000), []);
if (VSlim\Task::waitAll([$copy, $feedCopy, $drainCopy]) !== [$copyLength, $copyLength + 4, $copyBytes]
    || VSlim\Task::readExactly($copySource, 4, 50) !== 'tail'
    || !is_resource($copyDestination)) {
    throw new RuntimeException('Copying across backpressure changed the bytes, limit, or resource ownership');
}

$pendingCopy = VSlim\Task::spawn(static fn () => VSlim\Task::copyStream($copySource, $copyDestination, 1), []);
$cancelCopyReason = new DomainException('Cancel the stream copy');
$cancelCopy = VSlim\Task::spawn(static function () use ($pendingCopy, $cancelCopyReason): bool {
    VSlim\Task::sleep(0);
    return $pendingCopy->cancel($cancelCopyReason);
}, []);
try {
    VSlim\Task::waitAll([$pendingCopy, $cancelCopy]);
    throw new LogicException('The copier ignored cancellation');
} catch (DomainException $error) {
    if ($error !== $cancelCopyReason || !$cancelCopy->wait()
        || !is_resource($copySource) || !is_resource($copyDestination)) {
        throw $error;
    }
}

fwrite($copyInput, 'end');
fclose($copyInput);
if (VSlim\Task::copyStream($copySource, $copyDestination, timeoutMs: 100) !== 3
    || VSlim\Task::readExactly($copyOutput, 3, 100) !== 'end'
    || VSlim\Task::copyStream($copySource, $copyDestination, 5, 0) !== 0) {
    throw new RuntimeException('Copying to EOF returned an incorrect byte count');
}
fclose($copySource);
fclose($copyDestination);
fclose($copyOutput);

if (PHP_OS_FAMILY !== 'Windows') {
    [$copySource, $copyInput] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    [$copyOutput, $copyDestination] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    foreach ([$copySource, $copyInput, $copyOutput, $copyDestination] as $socket) {
        stream_set_blocking($socket, false);
    }
    try {
        VSlim\Task::writeAll($copyDestination, $copyBytes, 0);
        throw new LogicException('The deadline test did not fill the destination');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Timed out writing to PHP stream')) {
            throw $error;
        }
    }
    $copy = VSlim\Task::spawn(static fn () => VSlim\Task::copyStream($copySource, $copyDestination, 1, 600), []);
    $feed = VSlim\Task::spawn(static function () use ($copyInput): int {
        VSlim\Task::sleep(200);
        return fwrite($copyInput, 'x');
    }, []);
    $drain = VSlim\Task::spawn(static function () use ($copyOutput): string {
        VSlim\Task::sleep(700);
        return stream_get_contents($copyOutput);
    }, []);
    try {
        VSlim\Task::waitAll([$copy, $feed, $drain]);
        throw new LogicException('Copying reset its timeout after reading the source');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Timed out writing to PHP stream after writing 0 bytes')
            || $feed->wait() !== 1 || $drain->wait() === '') {
            throw $error;
        }
    }
    foreach ([$copySource, $copyInput, $copyOutput, $copyDestination] as $socket) {
        fclose($socket);
    }
}

foreach ([
    'exact' => static fn ($source, $destination) => VSlim\Task::readExactly($source, 2, 1000),
    'line' => static fn ($source, $destination) => VSlim\Task::readLine($source, 2, 1000),
    'generator' => static fn ($source, $destination) => streamGenerator($source, 1000)->current(),
    'copy-source' => static fn ($source, $destination) => VSlim\Task::copyStream($source, $destination, 2, 1000),
    'copy-destination' => static fn ($source, $destination) => VSlim\Task::copyStream($source, $destination, 2, 1000),
] as $operation => $read) {
    [$source, $input] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    [$output, $destination] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    foreach ([$source, $input, $destination, $output] as $socket) {
        stream_set_blocking($socket, false);
    }
    try {
        // A partial line or exact read gives the error a meaningful byte count.
        $partialRead = in_array($operation, ['exact', 'line'], true);
        if ($partialRead) {
            fwrite($input, 'a');
        }
        $changed = $operation === 'copy-destination' ? $destination : $source;
        $tail = $partialRead ? "\n" : "b\n";
        try {
            waitPair(
                static fn () => $read($source, $destination),
                static function () use ($changed, $input, $tail): void {
                    sleepTask(0);
                    stream_set_blocking($changed, true);
                    fwrite($input, $tail);
                },
            );
            throw new LogicException("$operation continued after its stream became blocking");
        } catch (Exception $error) {
            if (!str_contains($error->getMessage(), 'became blocking')
                || ($partialRead && !str_contains($error->getMessage(), 'after reading 1 of 2 bytes'))) {
                throw $error;
            }
        }
        if (!stream_get_meta_data($changed)['blocked']) {
            throw new RuntimeException("$operation changed the caller's stream mode");
        }
        stream_set_blocking($changed, false);
        if (VSlim\Task::readExactly($source, strlen($tail), 0) !== $tail || fread($output, 1) !== '') {
            throw new RuntimeException("$operation consumed extra bytes after the mode change");
        }
    } finally {
        foreach ([$source, $input, $destination, $output] as $socket) {
            fclose($socket);
        }
    }
}

$fillSocket = static function ($socket) use ($payload): int {
    try {
        VSlim\Task::writeAll($socket, $payload, 0);
        throw new LogicException('The mode-change test did not fill the writer');
    } catch (Exception $error) {
        if (!preg_match('/Timed out writing to PHP stream after writing ([0-9]+) bytes/', $error->getMessage(), $matches)) {
            throw $error;
        }
    }
    return (int) $matches[1];
};
[$queuedReader, $queuedWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
[$copySource, $copyInput] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
foreach ([$queuedReader, $queuedWriter, $copySource, $copyInput] as $socket) {
    stream_set_blocking($socket, false);
}
try {
    $bufferedBytes = $fillSocket($queuedWriter);
    $drain = VSlim\Task::spawn(static function () use ($queuedReader, $queuedWriter): string {
        sleepTask(0);
        stream_set_blocking($queuedWriter, true);
        return stream_get_contents($queuedReader);
    }, []);
    $pendingWrite = VSlim\Task::spawn(static fn () => VSlim\Task::writeAll($queuedWriter, 'z', 1000), []);
    try {
        VSlim\Task::waitAll([$pendingWrite, $drain]);
        throw new LogicException('The writer continued after its stream became blocking');
    } catch (Exception $error) {
        $drained = $drain->wait();
        if ($error->getMessage() !== 'PHP stream became blocking after writing 0 bytes'
            || !stream_get_meta_data($queuedWriter)['blocked']
            || $drained . stream_get_contents($queuedReader) !== substr($payload, 0, $bufferedBytes)) {
            throw $error;
        }
    }
    stream_set_blocking($queuedWriter, false);
    if (VSlim\Task::writeAll($queuedWriter, 'z', 1000) !== 1
        || VSlim\Task::readExactly($queuedReader, 1, 1000) !== 'z') {
        throw new RuntimeException('The writer could not be reused after returning to nonblocking mode');
    }

    $bufferedBytes = $fillSocket($queuedWriter);
    fwrite($copyInput, 'a');
    $pendingCopy = VSlim\Task::spawn(static fn () => VSlim\Task::copyStream($copySource, $queuedWriter, 2, 1000), []);
    $drain = VSlim\Task::spawn(static function () use ($copySource, $copyInput, $queuedReader): string {
        sleepTask(0);
        stream_set_blocking($copySource, true);
        fwrite($copyInput, 'b');
        return stream_get_contents($queuedReader);
    }, []);
    try {
        VSlim\Task::waitAll([$pendingCopy, $drain]);
        throw new LogicException('Copy read again after its source became blocking during a write wait');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'became blocking after copying 1 bytes')
            || !stream_get_meta_data($copySource)['blocked']
            || $drain->wait() . stream_get_contents($queuedReader) !== substr($payload, 0, $bufferedBytes) . 'a') {
            throw $error;
        }
    }
    stream_set_blocking($copySource, false);
    if (VSlim\Task::readExactly($copySource, 1, 0) !== 'b') {
        throw new RuntimeException('Copy consumed source data after its mode changed');
    }
} finally {
    fclose($queuedReader);
    fclose($queuedWriter);
    fclose($copySource);
    fclose($copyInput);
}

[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
stream_set_blocking($writer, false);

$started = hrtime(true);
if (awaitStream($reader, false, 20) !== false || hrtime(true) - $started < 15_000_000
    || awaitStream($writer, true, 0) !== true) {
    throw new RuntimeException('Polling from the main stack lost readiness or the deadline');
}
fwrite($writer, "m\0");
if (!awaitStream($reader, false, 0) || fread($reader, 1) !== 'm'
    || !awaitStream($reader, false, 0) || fread($reader, 1) !== "\0"
    || awaitStream($reader, false, 0)) {
    throw new RuntimeException('Main stack polling lost buffered bytes or reported stale readiness');
}
try {
    awaitStream($reader, false, -1);
    throw new LogicException('The PHP main stack accepted an unbounded wait');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'scheduled task')) {
        throw $error;
    }
}

$events = [];
$pair = waitPair(
    static function () use ($reader, &$events): string {
        $events[] = 'reader starts';
        if (!awaitStream($reader, false, 1000)) {
            throw new RuntimeException('Read unexpectedly timed out');
        }
        $events[] = 'reader resumes';
        return fread($reader, 2);
    },
    static function () use ($writer, &$events): int {
        sleepTask(4);
        if (!awaitStream($writer, true, 1000)) {
            throw new RuntimeException('Write unexpectedly timed out');
        }
        $events[] = 'writer resumes';
        return fwrite($writer, 'ok');
    },
);
if ($pair !== ['ok', 2] || $events !== ['reader starts', 'writer resumes', 'reader resumes']) {
    throw new RuntimeException('The two Fibers did not share I/O scheduling');
}

final class TaskCastStream
{
    public $context;
    public static $socket;
    public static Throwable $failure;
    public static int $castsUntilFailure;
    public static $streamToClose = null;

    public function stream_open($path, $mode, $options, &$openedPath): bool { return true; }

    public function stream_cast($castAs)
    {
        if (is_resource(self::$streamToClose)) {
            fclose(self::$streamToClose);
            self::$streamToClose = null;
        }
        if (--self::$castsUntilFailure === 0) {
            throw self::$failure;
        }
        return self::$socket;
    }
}

stream_wrapper_register('vphptaskcast', TaskCastStream::class);
TaskCastStream::$socket = $reader;
TaskCastStream::$failure = new DomainException('Failed to resolve a waiting stream descriptor');
$castStream = fopen('vphptaskcast://socket', 'rb');
$catchCastFailure = static function () use ($castStream): bool {
    try {
        awaitStream($castStream, false, 100);
        throw new LogicException('The stream cast failure was lost');
    } catch (DomainException $error) {
        sleepTask(0);
        return $error === TaskCastStream::$failure;
    }
};
TaskCastStream::$castsUntilFailure = 2;
if (waitPair($catchCastFailure, static function (): string {
    sleepTask(0);
    return 'peer';
}) !== [true, 'peer']) {
    throw new RuntimeException('The probing failure escaped the waiting Fiber');
}

TaskCastStream::$castsUntilFailure = 3;
fwrite($writer, 'x');
if (waitPair(
    static fn () => awaitStream($reader, false, 100) ? fread($reader, 1) : null,
    $catchCastFailure,
) !== ['x', true]) {
    throw new RuntimeException('The recheck failure escaped the waiting Fiber');
}
TaskCastStream::$castsUntilFailure = 2;
if (waitPair(
    static function () use ($reader, $castStream): bool {
        try {
            VSlim\Task::waitStreams(read: [$reader, $castStream], timeoutMs: 100);
            throw new LogicException('The stream set lost the original cast exception');
        } catch (DomainException $error) {
            return $error === TaskCastStream::$failure;
        }
    },
    static fn () => 'peer',
) !== [true, 'peer']) {
    throw new RuntimeException('The stream set let its cast exception escape the waiting Fiber');
}
[$castClosed, $castPeer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
TaskCastStream::$streamToClose = $castClosed;
TaskCastStream::$castsUntilFailure = -1;
try {
    VSlim\Task::waitStreams(read: [$castClosed, $castStream], timeoutMs: 0);
    throw new LogicException('A later stream cast silently invalidated an earlier watch');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'closed while preparing the wait')) {
        throw $error;
    }
} finally {
    fclose($castPeer);
}
fclose($castStream);
stream_wrapper_unregister('vphptaskcast');

$readFailure = new DomainException('failure after reading');
$readCount = 0;
$peerFinished = false;
try {
    waitPair(
        static function () use ($reader, $readFailure, &$readCount): never {
            if (!awaitStream($reader, false, 1000) || fread($reader, 1) !== '!') {
                throw new RuntimeException('The resumed task did not read its byte');
            }
            ++$readCount;
            throw $readFailure;
        },
        static function () use ($writer, &$peerFinished): void {
            fwrite($writer, '!');
            sleepTask(0);
            $peerFinished = true;
        },
    );
    throw new RuntimeException('A task failure after reading was lost');
} catch (DomainException $caught) {
    if ($caught !== $readFailure || $readCount !== 1 || !$peerFinished) {
        throw new RuntimeException('Finishing a resumed task lost its failure or abandoned its peer', 0, $caught);
    }
}

if (waitPair(
    static fn () => awaitStream($reader, false, 5),
    static fn () => awaitStream($reader, false, 0),
) !== [false, false]) {
    throw new RuntimeException('The poller lost a deadline or an immediate timeout');
}

fwrite($writer, '1');
if (waitPair(
    static function () use ($reader, $writer): string {
        if (!awaitStream($reader, false, 1000)) {
            throw new RuntimeException('The first reader did not wake');
        }
        $byte = fread($reader, 1);
        sleepTask(0);
        fwrite($writer, '2');
        return $byte;
    },
    static fn () => awaitStream($reader, false, 1000) ? fread($reader, 1) : null,
) !== ['1', '2']) {
    throw new RuntimeException('A second reader resumed before fresh data arrived');
}

fwrite($writer, '3');
if (waitPair(
    static fn () => awaitStream($reader, false, 0) ? fread($reader, 1) : null,
    static fn () => awaitStream($reader, false, 0),
) !== ['3', false]) {
    throw new RuntimeException('A zero-timeout reader observed stale readiness');
}

fwrite($writer, '45');
$readReadyByte = static fn () => awaitStream($reader, false, 0) ? fread($reader, 1) : null;
set_error_handler(static function (int $severity, string $message): never {
    throw new ErrorException($message, 0, $severity);
}, E_WARNING);
try {
    $bufferedPair = waitPair($readReadyByte, $readReadyByte);
} finally {
    restore_error_handler();
}
if ($bufferedPair !== ['4', '5']) {
    throw new RuntimeException('Rechecking readiness dropped a byte buffered by PHP');
}

try {
    waitWithArgs(static fn () => streamGenerator($reader, 0)->current(), []);
    throw new LogicException('A generator ignored its stream wait timeout');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'Timed out waiting for PHP stream data') || !is_resource($reader)) {
        throw $error;
    }
}

$started = hrtime(true);
try {
    streamGenerator($reader, 20)->current();
    throw new LogicException('A generator on the request thread ignored its stream wait timeout');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'Timed out waiting for PHP stream data') || !is_resource($reader)
        || hrtime(true) - $started < 15_000_000) {
        throw $error;
    }
}

[$streamReader, $streamWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($streamReader, false);
stream_set_blocking($streamWriter, false);
$generator = streamGenerator($streamReader, 1000);
if (waitPair(
    static function () use ($generator, $streamReader): string {
        $body = '';
        foreach ($generator as $chunk) {
            $body .= $chunk;
            if ($body === "first\0") {
                fwrite($streamReader, '!');
            }
        }
        return $body;
    },
    static function () use ($streamWriter): void {
        sleepTask(0);
        fwrite($streamWriter, "first\0");
        if (!awaitStream($streamWriter, false, 1000) || fread($streamWriter, 1) !== '!') {
            throw new RuntimeException('The generator did not deliver its first chunk before EOF');
        }
        fwrite($streamWriter, 'last');
        fclose($streamWriter);
    },
) !== ["first\0last", null] || !feof($streamReader)) {
    throw new RuntimeException('The generator did not read across a scheduled stream wait and EOF');
}
fclose($streamReader);

[$closedReader, $openWriter] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($closedReader, false);
try {
    waitPair(
        static fn () => streamGenerator($closedReader, 1000)->current(),
        static function () use ($closedReader): void {
            sleepTask(0);
            fclose($closedReader);
        },
    );
    throw new LogicException('Closing the stream left the parked generator alive');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'PHP stream closed while waiting for data')) {
        throw $error;
    }
}
fclose($openWriter);

$start = hrtime(true);
if (waitPair(static fn () => sleepTask(0), static fn () => sleepTask(8)) !== [null, null]
    || hrtime(true) - $start < 6_000_000) {
    throw new RuntimeException('The scheduler did not keep timer-only tasks alive');
}

$callback = static fn ($first, $middle = 'default', $last = null, ...$rest) =>
    [$first, $middle, $last, $rest];
$args = ['tag' => 'extra', 'last' => null, 'first' => 'named'];
if (waitWithArgs($callback, $args) !== ['named', 'default', null, ['tag' => 'extra']]
    || waitWithArgs($callback, [12 => 'positional', 'last' => 'final']) !== ['positional', 'default', 'final', []]) {
    throw new RuntimeException('Task arguments did not follow PHP named-argument rules');
}
try {
    waitWithArgs(static fn ($value) => $value, ['value' => 1, 0 => 2]);
    throw new RuntimeException('A positional argument followed a named argument');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'Cannot use positional argument after named argument')) {
        throw $error;
    }
}

$failure = new DomainException('original task failure');
$peerCompleted = false;
try {
    waitPair(
        static fn () => throw $failure,
        static function () use (&$peerCompleted): void { $peerCompleted = true; },
    );
    throw new RuntimeException('A failed task returned normally');
} catch (DomainException $error) {
    if ($error !== $failure || !$peerCompleted) {
        throw new RuntimeException('The task group lost the original failure or abandoned its peer');
    }
}

fclose($writer);
fclose($reader);

[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
fwrite($writer, 'x');
if (waitPair(
    static function () use ($reader): bool {
        $ready = awaitStream($reader, false, 1000);
        fclose($reader);
        return $ready;
    },
    static fn () => awaitStream($reader, false, 1000),
) !== [true, false]) {
    throw new RuntimeException('Poll readiness survived closure of the stream by another Fiber');
}
fclose($writer);

[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
fclose($writer);
if (waitPair(
    static fn () => awaitStream($reader, false, 1000) ? fread($reader, 1) : null,
    static fn () => null,
) !== ['', null] || !feof($reader)) {
    throw new RuntimeException('A peer disconnect did not wake the reader with EOF');
}
fclose($reader);

if (isset($argv[1])) {
    $stub = file_get_contents($argv[1]);
    if (!str_contains($stub, "/** @var callable */\n        protected \$callable;")) {
        throw new RuntimeException('The generated stub lost the callable property PHPDoc');
    }
    if (!str_contains($stub, 'function aggregateIterator(\IteratorAggregate $value): \Traversable {}')
        || !str_contains($stub, 'final class TaskChannel implements \IteratorAggregate, \Traversable')
        || !str_contains($stub, 'function getIterator(): \Traversable {}')) {
        throw new RuntimeException('The generated stub lost its IteratorAggregate contract');
    }
}

$reason = new DomainException('queued task cancelled');
try {
    VPHP\TaskProbe\cancelQueued(
        static fn () => throw new RuntimeException('A cancelled task ran'),
        $reason,
    );
    throw new RuntimeException('Queued cancellation was lost');
} catch (DomainException $caught) {
    if ($caught !== $reason) {
        throw $caught;
    }
}

$cleanupFailure = new RuntimeException('cleanup failure');
foreach ([null, $failure] as $original) {
    $calls = 0;
    try {
        VPHP\TaskProbe\runCleanup(
            static fn () => $original === null ? null : throw $original,
            static function () use (&$calls, $cleanupFailure): void {
                ++$calls;
                throw $cleanupFailure;
            },
        );
        throw new LogicException('Cleanup did not propagate an exception');
    } catch (Throwable $caught) {
        if ($caught !== ($original ?? $cleanupFailure) || $calls !== 1) {
            throw new RuntimeException('Cleanup changed exception identity or did not run', 0, $caught);
        }
    }
}
