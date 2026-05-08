--TEST--
PHP direct arguments default to camelCase names
--FILE--
<?php
echo v_php_direct_arg_camel_api('Ada', 'Lovelace') . PHP_EOL;
echo v_php_direct_arg_camel_api(defaultValue: 'Hopper', firstName: 'Grace') . PHP_EOL;
$rf = new ReflectionFunction('v_php_direct_arg_camel_api');
foreach ($rf->getParameters() as $p) {
    echo $p->getName() . PHP_EOL;
}
?>
--EXPECT--
direct=Ada:Lovelace
direct=Grace:Hopper
firstName
defaultValue
