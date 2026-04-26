--TEST--
Persistent fallback zval counter rises and falls around compatibility storage
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$resource = v_new_coach();
echo v_persistent_fallback_counter_probe($resource), PHP_EOL;
?>
--EXPECT--
kind=fallback_zval;during_delta=1;after_delta=0
