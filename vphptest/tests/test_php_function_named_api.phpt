--TEST--
PhpFunction named API wraps PHP function callable strings
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_function_named_api() . PHP_EOL;
?>
--EXPECT--
function=strtoupper;exists=true;value=FUNC:4:RESULT:SEMANTIC:8;missing=missing
