--TEST--
VSlim cancels queued tasks and wakes parked Fibers with the original Throwable
--SKIPIF--
<?php
if (!extension_loaded('vslim')) print 'skip vslim required';
?>
--FILE--
<?php
declare(strict_types=1);

use VSlim\Task;
use VSlim\TaskCancelledException;
use VSlim\TaskHandle;

$hits = 0;
$queued = Task::spawn(static function () use (&$hits): void { ++$hits; }, []);
if (!$queued->cancel() || $queued->cancel()) {
    throw new RuntimeException('A queued task did not accept exactly one cancellation');
}
$first = null;
for ($i = 0; $i < 2; ++$i) {
    try {
        $queued->wait();
        throw new RuntimeException('A cancelled queued task returned');
    } catch (TaskCancelledException $failure) {
        $first ??= $failure;
        if ($first !== $failure || $failure->getMessage() !== 'Task was cancelled') {
            throw new RuntimeException('The default cancellation was replaced');
        }
    }
}
if ($hits !== 0 || (new TaskHandle())->cancel()) {
    throw new RuntimeException('Cancelling a queued or empty handle invoked work');
}

$unstarted = Task::spawn(static function () use (&$hits): void { ++$hits; }, []);
$cancelQueued = Task::spawn(static fn () => $unstarted->cancel(), []);
try {
    Task::waitAll([$cancelQueued, $unstarted]);
    throw new RuntimeException('A task already enrolled in the batch survived cancellation');
} catch (TaskCancelledException $failure) {
    if ($hits !== 0 || $cancelQueued->wait() !== true || $cancelQueued->cancel()) {
        throw new RuntimeException('Cancelling one task changed the result of its completed peer');
    }
}

$domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
stream_set_blocking($writer, false);
$events = [];
$reason = new DomainException('cancel read');
$read = Task::spawn(static function () use ($reader, &$events): void {
    try {
        $events[] = 'read parked';
        Task::awaitReadable($reader, 1000);
        throw new RuntimeException('The cancelled reader resumed normally');
    } finally {
        $events[] = 'reader cleanup';
    }
}, []);
$waiter = Task::spawn(static function () use ($read, $reason, &$events): void {
    try {
        $read->wait();
        throw new RuntimeException('The waiter missed the cancellation');
    } catch (DomainException $failure) {
        if ($failure !== $reason) {
            throw $failure;
        }
        $events[] = 'waiter caught original';
    }
}, []);
$cancelRead = Task::spawn(static function () use ($read, $reason, &$events): int {
    if (!$read->cancel(reason: $reason) || $read->cancel()) {
        throw new RuntimeException('Cancellation was lost or replaced while the Fiber was parked');
    }
    $events[] = 'peer requested cancellation';
    return 3;
}, []);
try {
    Task::waitAll([$read, $waiter, $cancelRead]);
    throw new RuntimeException('The group swallowed cancellation');
} catch (DomainException $failure) {
    if ($failure !== $reason || $cancelRead->wait() !== 3 || $waiter->wait() !== null
        || $events !== ['read parked', 'peer requested cancellation', 'reader cleanup', 'waiter caught original']) {
        throw new RuntimeException('The cancelled reader or its waiters did not settle in order');
    }
}

$reason = new DomainException('cancel waiter');
$dependency = Task::spawn(static function () use ($reader): string {
    if (!Task::awaitReadable($reader, 1000)) {
        throw new RuntimeException('The dependency was cancelled with its waiter');
    }
    return fread($reader, 1);
}, []);
$waiter = Task::spawn(static function () use ($dependency, $reason): string {
    try {
        return $dependency->wait();
    } catch (DomainException $failure) {
        if ($failure !== $reason) {
            throw $failure;
        }
        return 'handled';
    }
}, []);
$cancelWaiter = Task::spawn(static function () use ($writer, $waiter, $reason): int {
    if (!$waiter->cancel($reason)) {
        throw new RuntimeException('A task parked on a dependency could not be cancelled');
    }
    return fwrite($writer, 'r');
}, []);
if (Task::waitAll([$waiter, $dependency, $cancelWaiter]) !== ['handled', 'r', 1]) {
    throw new RuntimeException('Cancellation recovery disturbed the still-running dependency');
}
$self = null;
$self = Task::spawn(static function () use (&$self, $reader): int {
    if (!$self->cancel()) {
        throw new RuntimeException('The running task could not request its own cancellation');
    }
    try {
        Task::awaitReadable($reader, 1000);
    } catch (TaskCancelledException) {
        return 7;
    }
    throw new RuntimeException('Cancellation was not delivered at the next suspension');
}, []);
if ($self->wait() !== 7) {
    throw new RuntimeException('A task could not recover from its own cancellation');
}

fclose($writer);
fclose($reader);

$refs = (static function (): array {
    $task = Task::spawn(static fn () => null, []);
    $cancellation = new class extends RuntimeException {
        public TaskHandle $task;
    };
    $cancellation->task = $task;
    $task->cancel($cancellation);
    return [WeakReference::create($task), WeakReference::create($cancellation)];
})();
gc_collect_cycles();
if ($refs[0]->get() !== null || $refs[1]->get() !== null) {
    throw new RuntimeException('A settled cancellation escaped cycle collection');
}

echo "cancellation ok\n";
?>
--EXPECT--
cancellation ok
