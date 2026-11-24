--TEST--
VPHP updates V object roots concurrently
--FILE--
<?php
var_dump(v_test_concurrent_object_roots());
?>
--EXPECT--
bool(true)
