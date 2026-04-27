--TEST--
PhpEnum and PhpEnumCase expose enum semantics
--FILE--
<?php
enum PhpValueColor: string
{
    case red = 'r';
    case blue = 'b';
}

echo v_php_enum_api(PhpValueColor::blue) . PHP_EOL;
?>
--EXPECT--
enum=true:true:2:blue:b
