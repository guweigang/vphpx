--TEST--
PhpValue wraps mixed zvals and narrows to semantic wrappers
--FILE--
<?php
echo v_php_value_api(['name' => 'codex', 'score' => 7]) . PHP_EOL;
?>
--EXPECT--
value=array:true:codex:2:persistent_owned
