--TEST--
VPHP typed string parameter attributes support PHP Reflection, defaults and named arguments
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$expected = "line\n" . '"' . '\\' . '${token}雪' . "\0";
$method = new ReflectionFunction('v_typed_string_param');
$param = $method->getParameters()[1];
echo $method->getNumberOfRequiredParameters(), '|', $param->getName(), '|', $param->getType(), '|',
    (int) $param->isOptional(), '|', (int) ($param->getDefaultValue() === $expected), PHP_EOL;
echo (int) (v_typed_string_param('>') === '>' . $expected), '|',
    (int) (v_typed_string_param(suffix: '<', prefix: '>') === '>' . $expected . '<'), '|',
    v_typed_string_param(suffix: '<', defaultValue: '', prefix: '>'), PHP_EOL;

$required = new ReflectionFunction('v_typed_required_string_param');
echo $required->getNumberOfRequiredParameters(), '|', $required->getParameters()[0]->getName(), '|',
    (int) $required->getParameters()[0]->isDefaultValueAvailable(), '|',
    v_typed_required_string_param(text: 'provided'), PHP_EOL;

$raw = (new ReflectionFunction('v_typed_raw_string_param'))->getParameters()[0];
echo $raw->getName(), '|', $raw->getDefaultValue(), '|', v_typed_raw_string_param(), PHP_EOL;
$flag = (new ReflectionFunction('v_typed_alias_bool_param'))->getParameters()[0];
echo $flag->getName(), '|', (int) $flag->getDefaultValue(), '|', (int) v_typed_alias_bool_param(),
    '|', (int) v_typed_alias_bool_param(enabled: false), PHP_EOL;
$flags = new ReflectionFunction('v_typed_bool_params');
echo $flags->getNumberOfRequiredParameters();
foreach ($flags->getParameters() as $flag) {
    echo '|', $flag->getName(), ':', (int) $flag->getDefaultValue();
}
echo PHP_EOL;
echo v_typed_bool_params(), '|', v_typed_bool_params(secondFlag: true),
    '|', v_typed_bool_params(secondFlag: true, firstFlag: false), PHP_EOL;
?>
--EXPECT--
1|defaultValue|string|1|1
1|1|><
1|text|0|provided
text|C:\tmp\$HOME|C:\tmp\$HOME
enabled|1|1|0
0|firstFlag:1|secondFlag:0
2|3|1
