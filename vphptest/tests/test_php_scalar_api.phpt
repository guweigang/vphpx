--TEST--
Php scalar wrappers narrow strictly and coerce explicitly
--FILE--
<?php
echo v_php_scalar_api("42") . PHP_EOL;
echo v_php_scalar_api(7) . PHP_EOL;
echo v_php_scalar_api(3.5) . PHP_EOL;
echo v_php_scalar_api(true) . PHP_EOL;
echo v_php_scalar_strict_api() . PHP_EOL;
?>
--EXPECT--
scalar=string:true:42:42:42.0:true:string_
scalar=integer:true:7:7:7.0:true:int_
scalar=float:true:3.5:3:3.5:true:float_
scalar=boolean:true:1:1:1.0:true:bool_
strict=42:42:4.5:true:true:persistent_owned:false
