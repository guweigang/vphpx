--TEST--
PhpCallable wraps arbitrary callable zvals and can persist them through retained callable
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_callable_api(function (string $value): string {
    return strtoupper($value);
}) . PHP_EOL;
?>
--EXPECT--
callable=true:CALLABLE:persistent_owned:AGAIN
