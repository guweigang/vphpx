--TEST--
VSlim exposes V methods on a class extending an autoloaded PHP parent
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip vslim extension missing'; ?>
--FILE--
<?php
$extension = PHP_OS_FAMILY === 'Windows' ? 'php_vslim.dll' : 'vslim.so';
$argv = [
    __FILE__,
    VSlim\Dev\UserlandCounter::class,
    dirname(__DIR__) . '/' . $extension . '.classes.php',
];
require dirname(__DIR__, 2) . '/cmd/vphp/tests/fixtures/userland-subclass/verify.php';
?>
--EXPECT--
userland subclass ok
