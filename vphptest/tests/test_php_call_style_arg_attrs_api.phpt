--TEST--
PHP argument metadata accepts call-style attributes
--FILE--
<?php
echo v_php_call_style_arg_attrs_api('old', 3) . PHP_EOL;
echo v_php_call_style_arg_attrs_api(valueAlias: 'new') . PHP_EOL;
$rf = new ReflectionFunction('v_php_call_style_arg_attrs_api');
foreach ($rf->getParameters() as $p) {
    echo $p->getName() . ':' . ($p->isOptional() ? 'optional' : 'required') . ':';
    echo $p->isDefaultValueAvailable() ? var_export($p->getDefaultValue(), true) : 'none';
    echo PHP_EOL;
}
?>
--EXPECT--
call_style=old:3
call_style=new:7
valueAlias:required:none
optionalCount:optional:7
