--TEST--
PhpClosure API wraps callable zvals passed from PHP
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_closure_api(function (string $name, int $count): string {
    return strtoupper($name) . ':' . $count;
}) . PHP_EOL;
?>
--EXPECT--
closure=true:CLOSURE:3
