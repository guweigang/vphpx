--TEST--
VSlim Task facade exposes list and spawn APIs to PHP userland
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
echo class_exists('VSlim\\Task') ? "task-class-ok\n" : "task-class-miss\n";
echo class_exists('VSlim\\TaskHandle') ? "task-handle-ok\n" : "task-handle-miss\n";

$tasks = VSlim\Task::list();
echo is_array($tasks) ? "list-array\n" : "list-miss\n";
echo count($tasks) . PHP_EOL;

$hits = 0;
$spawn = new ReflectionMethod(VSlim\Task::class, 'spawn');
[$target, $params] = $spawn->getParameters();
if (!$spawn->isStatic() || $spawn->getNumberOfRequiredParameters() !== 2
    || $target->getName() !== 'target' || (string) $target->getType() !== 'mixed'
    || $params->getName() !== 'params' || (string) $params->getType() !== 'array'
    || (string) $spawn->getReturnType() !== VSlim\TaskHandle::class) {
    throw new RuntimeException('Unexpected Task::spawn signature');
}
$handle = VSlim\Task::spawn(params: ['alpha', 2], target: function (string $label, int $count) use (&$hits) {
    $hits++;
    return [$label, $count, $hits];
});
$first = $handle->wait();
$second = $handle->wait();
echo $hits . PHP_EOL;
echo implode(',', $first) . PHP_EOL;
echo implode(',', $second) . PHP_EOL;

$params = ['right' => null, 'left' => 'L', 'tag' => 'extra'];
$named = VSlim\Task::spawn(
    static fn ($left, $middle = 'default', $right = 'R', ...$rest) => [$left, $middle, $right, $rest],
    $params,
);
$params['left'] = 'changed after spawn';
if ($named->wait() !== ['L', 'default', null, ['tag' => 'extra']]) {
    throw new RuntimeException('Queued PHP arguments lost their names or changed after spawn');
}
$invalid = VSlim\Task::spawn(static fn ($value) => $value, ['unknown' => 1, 'value' => 2]);
$original = null;
for ($attempt = 0; $attempt < 2; ++$attempt) {
    try {
        $invalid->wait();
        throw new RuntimeException('The task accepted an unknown named argument');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'Unknown named parameter $unknown')
            || ($original !== null && $error !== $original)) {
            throw $error;
        }
        $original = $error;
    }
}

final class InvokeTask
{
    public function __invoke(string $label, int $count): array
    {
        return [strtoupper($label), $count + 1];
    }
}

$objectHandle = VSlim\Task::spawn(new InvokeTask(), ['beta', 3]);
$objectResult = $objectHandle->wait();
echo implode(',', $objectResult) . PHP_EOL;

try {
    VSlim\Task::spawn('missing-task', []);
    echo "spawn-miss\n";
} catch (Throwable $e) {
    echo get_class($e) . PHP_EOL;
    echo $e->getMessage() . PHP_EOL;
}

$failure = new LogicException('task failed');
$hits = 0;
$failed = VSlim\Task::spawn(static function () use (&$hits, $failure) {
    ++$hits;
    throw $failure;
}, []);
for ($attempt = 0; $attempt < 2; ++$attempt) {
    try {
        $failed->wait();
        throw new RuntimeException('Task failure was lost');
    } catch (LogicException $caught) {
        if ($caught !== $failure) {
            throw $caught;
        }
    }
}
if ($hits !== 1) {
    throw new RuntimeException('A failed task ran more than once');
}

$hits = 0;
$recursive = null;
$recursive = VSlim\Task::spawn(static function () use (&$hits, &$recursive) {
    if (++$hits > 1) {
        throw new RuntimeException('A recursive wait re-entered the task');
    }
    return $recursive->wait();
}, []);
try {
    $recursive->wait();
    throw new RuntimeException('A task waited on itself');
} catch (LogicException $error) {
    if ($hits !== 1 || !str_contains($error->getMessage(), 'recursively')) {
        throw $error;
    }
}

foreach ([false, true] as $resolved) {
    $refs = (static function () use ($resolved): array {
        $handle = null;
        $callback = static function () use (&$handle) { return $handle; };
        $handle = VSlim\Task::spawn($callback, []);
        if ($resolved && $handle->wait() !== $handle) {
            throw new RuntimeException('A task lost its object result');
        }
        return [WeakReference::create($handle), WeakReference::create($callback)];
    })();
    gc_collect_cycles();
    if ($refs[0]->get() !== null || $refs[1]->get() !== null) {
        throw new RuntimeException('A task escaped cycle collection');
    }
}

try {
    VSlim\Task::waitAll([new VSlim\App()]);
    throw new RuntimeException('waitAll accepted a different extension object');
} catch (TypeError $error) {
    if ($error->getMessage() !== 'waitAll expects TaskHandle instances') {
        throw $error;
    }
}

$completed = VSlim\Task::spawn(static fn () => 6, []);
$follower = VSlim\Task::spawn(static fn () => $completed->wait() + 1, []);
if (VSlim\Task::waitAll([$completed, $follower]) !== [6, 7]) {
    throw new RuntimeException('A task could not read a completed peer result');
}

$cycleA = $cycleB = $cycleC = null;
$cycleA = VSlim\Task::spawn(static function () use (&$cycleB): int {
    try {
        return $cycleB->wait();
    } catch (LogicException $error) {
        if (!str_contains($error->getMessage(), 'recursively')) {
            throw $error;
        }
        return 10;
    }
}, []);
$cycleB = VSlim\Task::spawn(static function () use (&$cycleC): int {
    return 1 + $cycleC->wait();
}, []);
$cycleC = VSlim\Task::spawn(static fn () => 1 + $cycleA->wait(), []);
if (VSlim\Task::waitAll([$cycleA, $cycleB, $cycleC]) !== [10, 12, 11]) {
    throw new RuntimeException('A task cycle could not be caught within the waiting Fiber');
}

$outer = $inner = null;
$outer = VSlim\Task::spawn(static function () use (&$inner): mixed {
    $foreignDriver = new Fiber(static fn () => VSlim\Task::waitAll([$inner])[0]);
    $foreignDriver->start();
    return $foreignDriver->getReturn();
}, []);
$inner = VSlim\Task::spawn(static fn () => $outer->wait(), []);
try {
    $outer->wait();
    throw new RuntimeException('Nested groups allowed a dependency on an outer suspended task');
} catch (LogicException $caught) {
    if (!str_contains($caught->getMessage(), 'recursively')) {
        throw $caught;
    }
}

$parent = null;
$childReference = null;
$childResult = null;
$parent = VSlim\Task::spawn(static function () use (&$parent, &$childReference, &$childResult): int {
    $child = VSlim\Task::spawn(static function () use (&$parent, &$childResult): void {
        $childResult = $parent->wait() + 1;
    }, []);
    $childReference = WeakReference::create($child);
    try {
        $child->wait();
        throw new RuntimeException('A child waited recursively on its parent');
    } catch (LogicException $caught) {
        if (!str_contains($caught->getMessage(), 'recursively')) {
            throw $caught;
        }
        return 20;
    }
}, []);
if ($parent->wait() !== 20 || $childResult !== 21) {
    throw new RuntimeException('A joined child did not finish after its parent recovered');
}
gc_collect_cycles();
if ($childReference->get() !== null) {
    throw new RuntimeException('The group retained a finished child');
}

$error = new DomainException('peer failed');
$failingPeer = VSlim\Task::spawn(static fn () => throw $error, []);
$caughtPeer = null;
$waitingPeer = VSlim\Task::spawn(static function () use ($failingPeer, &$caughtPeer): void {
    try {
        $failingPeer->wait();
    } catch (DomainException $caught) {
        $caughtPeer = $caught;
    }
}, []);
try {
    VSlim\Task::waitAll([$waitingPeer, $failingPeer]);
    throw new RuntimeException('waitAll swallowed the failing peer');
} catch (DomainException $caught) {
    if ($caught !== $error || $caughtPeer !== $error) {
        throw new RuntimeException('The waiting Fiber did not receive the original peer failure');
    }
}

$domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
stream_set_blocking($writer, false);
$observed = [];
$read = VSlim\Task::spawn(static function () use ($reader, &$observed) {
    $observed[] = 'read parked';
    if (!VSlim\Task::awaitReadable(stream: $reader, timeoutMs: 1000)) {
        throw new RuntimeException('Reader timed out');
    }
    $observed[] = 'read ready';
    return fread($reader, 1);
}, []);
$write = VSlim\Task::spawn(static function () use ($writer, &$observed) {
    if (!VSlim\Task::awaitWritable($writer, 1000)) {
        throw new RuntimeException('Writer timed out');
    }
    $observed[] = 'write ready';
    return fwrite($writer, 'x');
}, []);
$format = VSlim\Task::spawn(static function () use ($read, &$observed): string {
    $observed[] = 'format waits';
    return strtoupper($read->wait());
}, []);
$wrap = VSlim\Task::spawn(static fn () => '[' . $format->wait() . ']', []);
if (VSlim\Task::waitAll(tasks: [$wrap, $format, $read, $write, $read]) !== ['[X]', 'X', 'x', 1, 'x']
    || $observed !== ['format waits', 'read parked', 'write ready', 'read ready']) {
    throw new RuntimeException('Tasks did not run cooperatively through the shared poller');
}

$ioFailure = new DomainException('reader failed after I/O');
$reads = 0;
$failingRead = VSlim\Task::spawn(static function () use ($reader, $ioFailure, &$reads): never {
    if (!VSlim\Task::awaitReadable($reader, 1000) || fread($reader, 1) !== '!') {
        throw new RuntimeException('The resumed reader did not get its byte');
    }
    ++$reads;
    throw $ioFailure;
}, []);
$observedFailure = null;
$waitingRead = VSlim\Task::spawn(static function () use ($failingRead, &$observedFailure): void {
    try {
        $failingRead->wait();
    } catch (DomainException $caught) {
        $observedFailure = $caught;
    }
}, []);
$write = VSlim\Task::spawn(static fn () => fwrite($writer, '!'), []);
try {
    VSlim\Task::waitAll([$waitingRead, $failingRead, $write]);
    throw new RuntimeException('waitAll lost the reader failure');
} catch (DomainException $caught) {
    if ($caught !== $ioFailure || $observedFailure !== $ioFailure || $reads !== 1 || $write->wait() !== 1) {
        throw new RuntimeException('The reader failure did not reach both waiters after I/O', 0, $caught);
    }
}

$sequence = [];
$parent = VSlim\Task::spawn(static function () use ($reader, &$sequence): string {
    $sequence[] = 'parent creates child';
    $child = VSlim\Task::spawn(static function () use ($reader, &$sequence): string {
        $sequence[] = 'child parks';
        if (!VSlim\Task::awaitReadable($reader, 1000)) {
            throw new RuntimeException('A joined child blocked its writing peer');
        }
        $byte = fread($reader, 1);
        $grandchild = VSlim\Task::spawn(static fn () => strtoupper($byte), []);
        return $grandchild->wait();
    }, []);
    return $child->wait();
}, []);
$peer = VSlim\Task::spawn(static function () use ($writer, &$sequence): int {
    VSlim\Task::awaitWritable($writer, 1000);
    $sequence[] = 'peer writes';
    return fwrite($writer, 'j');
}, []);
if (VSlim\Task::waitAll([$parent, $peer]) !== ['J', 1]
    || $sequence !== ['parent creates child', 'child parks', 'peer writes']) {
    throw new RuntimeException('The scheduler did not advance dynamically joined tasks');
}

$batch = VSlim\Task::spawn(static function () use ($reader, $writer): array {
    $batchReader = VSlim\Task::spawn(static function () use ($reader): string {
        $bytes = '';
        while (strlen($bytes) < 2) {
            if (!VSlim\Task::awaitReadable($reader, 1000)) {
                throw new RuntimeException('A nested batch blocked a writer in its parent group');
            }
            $bytes .= fread($reader, 2 - strlen($bytes));
        }
        return $bytes;
    }, []);
    $batchWriter = VSlim\Task::spawn(static fn () => fwrite($writer, 'b'), []);
    return VSlim\Task::waitAll([$batchReader, $batchWriter, $batchReader]);
}, []);
$batchPeer = VSlim\Task::spawn(static function () use ($writer): int {
    if (!VSlim\Task::awaitWritable($writer, 1000)) {
        throw new RuntimeException('The parent group did not advance its writer');
    }
    return fwrite($writer, 'p');
}, []);
[[$bytes, $written, $duplicate], $peerWritten] = VSlim\Task::waitAll([$batch, $batchPeer]);
if (!in_array($bytes, ['bp', 'pb'], true) || $duplicate !== $bytes || $written !== 1 || $peerWritten !== 1) {
    throw new RuntimeException('An in-task waitAll did not enroll its batch into the parent group');
}

$timeout = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader, 10), []);
$start = hrtime(true);
if ($timeout->wait() !== false || hrtime(true) - $start < 5_000_000) {
    throw new RuntimeException('An idle stream did not time out');
}
fwrite($writer, 'y');
$one = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader, 0), []);
$two = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader, 0), []);
if (VSlim\Task::waitAll([$one, $two]) !== [true, true] || fread($reader, 1) !== 'y') {
    throw new RuntimeException('Two tasks could not share one stream watcher');
}

fwrite($writer, 'a');
$readByte = static fn () => VSlim\Task::awaitReadable($reader, 1000) ? fread($reader, 1) : null;
$firstReader = VSlim\Task::spawn($readByte, []);
$secondReader = VSlim\Task::spawn($readByte, []);
$nextByte = VSlim\Task::spawn(static function () use ($firstReader, $writer): int {
    $firstReader->wait();
    return fwrite($writer, 'b');
}, []);
if (VSlim\Task::waitAll([$firstReader, $secondReader, $nextByte]) !== ['a', 'b', 1]) {
    throw new RuntimeException('A waiting reader resumed before its peer wrote the next byte');
}

if (VSlim\Task::awaitReadable(stream: $reader, timeoutMs: 0)
    || !VSlim\Task::awaitWritable(stream: $writer, timeoutMs: 0)) {
    throw new RuntimeException('Main stack polling reported incorrect readiness');
}
if (VSlim\Task::writeAll(data: "w\0", stream: $writer, timeoutMs: 50) !== 2
    || VSlim\Task::readExactly(length: 2, stream: $reader, timeoutMs: 50) !== "w\0"
    || VSlim\Task::readExactly(stream: $reader, length: 0, timeoutMs: 0) !== ''
    || VSlim\Task::writeAll(stream: $writer, data: '', timeoutMs: 0) !== 0) {
    throw new RuntimeException('writeAll lost the binary bytes, count, or named arguments');
}
fwrite($writer, "p\0\n");
if (VSlim\Task::readLine(maxBytes: 3, stream: $reader, timeoutMs: 0) !== "p\0\n") {
    throw new RuntimeException('readLine lost the binary bytes or the terminating LF');
}
try {
    VSlim\Task::copyStream(source: $reader, destination: $reader, length: 1, timeoutMs: 0);
    throw new LogicException('Copying a stream to itself was accepted');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'distinct source and destination')) {
        throw $error;
    }
}
fwrite($writer, 'cd');
if (!VSlim\Task::awaitReadable(stream: $reader, timeoutMs: 50) || fread($reader, 1) !== 'c'
    || !VSlim\Task::awaitReadable(stream: $reader, timeoutMs: 0) || fread($reader, 1) !== 'd') {
    throw new RuntimeException('Main stack polling lost socket or PHP buffered data');
}

final class VSlimTaskCastStream
{
    public $context;
    public static $socket;
    public static Throwable $failure;
    private int $casts = 0;

    public function stream_open($path, $mode, $options, &$openedPath): bool { return true; }

    public function stream_cast($castAs)
    {
        if (++$this->casts === 2) {
            throw self::$failure;
        }
        return self::$socket;
    }
}
stream_wrapper_register('vslimtaskcast', VSlimTaskCastStream::class);
VSlimTaskCastStream::$socket = $reader;
VSlimTaskCastStream::$failure = new DomainException('Could not cast the task stream');
$castStream = fopen('vslimtaskcast://socket', 'rb');
$caughtCast = false;
$failingCast = VSlim\Task::spawn(static function () use ($castStream, &$caughtCast): never {
    try {
        VSlim\Task::awaitReadable($castStream, 100);
        throw new LogicException('The cast failure was lost');
    } catch (DomainException $error) {
        $caughtCast = $error === VSlimTaskCastStream::$failure;
        throw $error;
    }
}, []);
$peer = VSlim\Task::spawn(static function (): string {
    VSlim\Task::sleep(0);
    return 'peer';
}, []);
try {
    VSlim\Task::waitAll([$failingCast, $peer]);
    throw new LogicException('The scheduler swallowed the cast failure');
} catch (DomainException $error) {
    if (!$caughtCast || $error !== VSlimTaskCastStream::$failure || $peer->wait() !== 'peer') {
        throw $error;
    }
}
fclose($castStream);
stream_wrapper_unregister('vslimtaskcast');

$foreign = new Fiber(static fn () => VSlim\Task::awaitReadable($reader, 0));
try {
    $foreign->start();
    throw new LogicException('An unmanaged Fiber entered the task scheduler');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'scheduled task')) {
        throw $error;
    }
}
fwrite($writer, 'z');
$default = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader), []);
$parameters = (new ReflectionMethod(VSlim\Task::class, 'awaitReadable'))->getParameters();
if ($default->wait() !== true || $parameters[1]->getName() !== 'timeoutMs'
    || $parameters[1]->getDefaultValue() !== -1) {
    throw new RuntimeException('The default task I/O timeout did not survive the bridge');
}
fclose($writer);
fclose($reader);

[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
$closer = VSlim\Task::spawn(static function () use ($reader): bool {
    $ready = VSlim\Task::awaitReadable($reader, 1000);
    fclose($reader);
    return $ready;
}, []);
$pending = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader), []);
$producer = VSlim\Task::spawn(static fn () => fwrite($writer, 'c'), []);
if (VSlim\Task::waitAll([$closer, $pending, $producer]) !== [true, false, 1]) {
    throw new RuntimeException('The scheduler reported a closed stream as readable');
}
fclose($writer);
?>
--EXPECT--
task-class-ok
task-handle-ok
list-array
0
1
alpha,2,1
alpha,2,1
BETA,4
Exception
Task missing-task not registered
