--TEST--
PhpValueZBox conversions keep request and persistent counters stable
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_value_zbox_lifecycle_probe(['name' => 'codex', 'n' => 3]), PHP_EOL;
?>
--EXPECT--
owned=request_owned:request-owned:dyn_data:request-owned:false;raw=borrowed:persistent_owned:{"name":"codex","n":3}:{"name":"codex","n":3};ar_delta=0;owned_delta=0;fallback_delta=0
