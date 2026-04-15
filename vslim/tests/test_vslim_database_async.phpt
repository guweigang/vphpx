--TEST--
VSlim database async query guards and pending results
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
echo class_exists('VSlim\\Database\\PendingResult') ? "pending-class\n" : "pending-miss\n";

$bad = (new VSlim\Database\Manager())
    ->setConfig((new VSlim\Database\Config())->set_driver('sqlite'));

try {
    $bad->queryAsync('select 1');
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'not supported yet') ? "unsupported-driver\n" : "wrong-driver-error\n";
}

$upstream = (new VSlim\Database\Manager())
    ->setConfig((new VSlim\Database\Config())
        ->set_driver('mysql')
        ->setTransport('vhttpd_upstream'));

try {
    $upstream->queryAsync('select 1');
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'only supported for direct mysql transport') ? "unsupported-transport\n" : "wrong-transport-error\n";
}

$unreachable = (new VSlim\Database\Manager())
    ->setConfig((new VSlim\Database\Config())
        ->set_driver('mysql')
        ->set_host('127.0.0.1')
        ->set_port(1)
        ->set_username('root')
        ->set_password('')
        ->setDatabase('demo'));

$pending = $unreachable->queryAsync('select 1');
echo ($pending instanceof VSlim\Database\PendingResult ? "pending-ok\n" : "pending-bad\n");

try {
    $pending->wait();
    echo "no-wait-exception\n";
} catch (RuntimeException $e) {
    echo str_starts_with($e->getMessage(), 'database async query failed:') ? "async-error\n" : "wrong-wait-error\n";
}
echo ($pending->resolved() ? "resolved\n" : "pending\n");
echo ($pending->lastError() !== '' ? "has-last-error\n" : "missing-last-error\n");

$execPending = $unreachable->executeAsync('update users set active = 1');
echo ($execPending instanceof VSlim\Database\PendingResult ? "exec-pending-ok\n" : "exec-pending-bad\n");

try {
    $execPending->wait();
    echo "no-exec-wait-exception\n";
} catch (RuntimeException $e) {
    echo str_starts_with($e->getMessage(), 'database async execute failed:') ? "exec-async-error\n" : "wrong-exec-wait-error\n";
}
echo ($execPending->resolved() ? "exec-resolved\n" : "exec-pending\n");
echo $execPending->affectedRows() . PHP_EOL;
echo $execPending->lastInsertId() . PHP_EOL;
echo ($execPending->lastError() !== '' ? "exec-has-last-error\n" : "exec-missing-last-error\n");
?>
--EXPECT--
pending-class
unsupported-driver
unsupported-transport
pending-ok
async-error
resolved
has-last-error
exec-pending-ok
exec-async-error
exec-resolved
0
0
exec-has-last-error
