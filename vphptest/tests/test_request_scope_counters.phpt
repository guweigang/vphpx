--TEST--
Request scope drains request-owned zvals back to stable counters
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_request_scope_counter_probe(1000), PHP_EOL;
echo v_request_scope_counter_probe(1), PHP_EOL;
?>
--EXPECT--
ar_delta=0;owned_delta=0;fallback_delta=0;checksum=true
ar_delta=0;owned_delta=0;fallback_delta=0;checksum=true
