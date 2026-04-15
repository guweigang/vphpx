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
$handle = VSlim\Task::spawn(function (string $label, int $count) use (&$hits) {
    $hits++;
    return [$label, $count, $hits];
}, ['alpha', 2]);
$first = $handle->wait();
$second = $handle->wait();
echo $hits . PHP_EOL;
echo implode(',', $first) . PHP_EOL;
echo implode(',', $second) . PHP_EOL;

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
