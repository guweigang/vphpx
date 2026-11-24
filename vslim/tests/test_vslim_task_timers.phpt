--TEST--
VSlim task timers yield to peers, share I/O deadlines and can be cancelled
--SKIPIF--
<?php
if (!extension_loaded('vslim')) print 'skip vslim required';
?>
--FILE--
<?php
declare(strict_types=1);

use VSlim\Task;

$events = [];
$first = Task::spawn(static function () use (&$events): int {
    $events[] = 'before zero';
    Task::sleep(milliseconds: 0);
    $events[] = 'after zero';
    return 1;
}, []);
$second = Task::spawn(static function () use (&$events): int {
    $events[] = 'peer';
    return 2;
}, []);
if (Task::waitAll([$first, $second]) !== [1, 2]
    || $events !== ['before zero', 'peer', 'after zero']) {
    throw new RuntimeException('A zero-duration timer did not yield to its peer');
}

$timer = Task::spawn(static fn () => Task::sleep(12), []);
$started = hrtime(true);
if ($timer->wait() !== null || hrtime(true) - $started < 10_000_000) {
    throw new RuntimeException('A timer-only task returned before its deadline');
}

$domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
stream_set_blocking($writer, false);
$read = Task::spawn(static function () use ($reader): string {
    if (!Task::awaitReadable($reader, 1000)) {
        throw new RuntimeException('An I/O wait prevented its writer timer from firing');
    }
    return fread($reader, 1);
}, []);
$write = Task::spawn(static function () use ($writer): int {
    Task::sleep(10);
    return fwrite($writer, 't');
}, []);
if (Task::waitAll([$read, $write]) !== ['t', 1]) {
    throw new RuntimeException('Timer and I/O wakeups did not share a scheduling loop');
}
fclose($writer);
fclose($reader);

$reason = new DomainException('cancel timer');
$cleaned = false;
$timer = Task::spawn(static function () use (&$cleaned): void {
    try {
        Task::sleep(6000);
        throw new RuntimeException('A cancelled timer returned normally');
    } finally {
        $cleaned = true;
    }
}, []);
$cancel = Task::spawn(static function () use ($timer, $reason): bool {
    Task::sleep(0);
    return $timer->cancel($reason);
}, []);
$started = hrtime(true);
try {
    Task::waitAll([$timer, $cancel]);
    throw new RuntimeException('A timer swallowed cancellation');
} catch (DomainException $failure) {
    if ($failure !== $reason || !$cleaned || $cancel->wait() !== true
        || hrtime(true) - $started >= 5_000_000_000) {
        throw new RuntimeException('A cancelled timer kept its original deadline or lost its cleanup');
    }
}

foreach ([-1, 2_147_483_648] as $milliseconds) {
    $invalid = Task::spawn(static fn () => Task::sleep($milliseconds), []);
    try {
        $invalid->wait();
        throw new RuntimeException('An invalid timer duration was accepted');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'between 0 and 2147483647 milliseconds')) {
            throw $error;
        }
    }
}
$invalid = Task::spawn(static fn () => Fiber::suspend(['timer' => 0]), []);
try {
    $invalid->wait();
    throw new RuntimeException('An invalid timer suspension was accepted');
} catch (LogicException $error) {
    if ($error->getMessage() !== 'Invalid task timer deadline') {
        throw $error;
    }
}
try {
    Task::sleep(0);
    throw new RuntimeException('An unmanaged caller was allowed to arm a timer');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'requires a scheduled task')) {
        throw $error;
    }
}

echo "task timers ok\n";
?>
--EXPECT--
task timers ok
