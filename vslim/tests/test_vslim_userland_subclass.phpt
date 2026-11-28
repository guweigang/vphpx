--TEST--
VSlim does not ship the userland subclass test fixture
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip vslim extension missing'; ?>
--FILE--
<?php
$extension = PHP_OS_FAMILY === 'Windows' ? 'php_vslim.dll' : 'vslim.so';
var_dump(class_exists('VSlim\\Dev\\UserlandCounter', false));
var_dump(trait_exists('VSlim\\Dev\\UserlandCounterMethods', false));
var_dump(file_exists(dirname(__DIR__) . '/' . $extension . '.classes.php'));
?>
--EXPECT--
bool(false)
bool(false)
bool(false)
