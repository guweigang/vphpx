--TEST--
VPHP reference parameters preserve PHP names, types and caller storage
--FILE--
<?php
$function = new ReflectionFunction('v_step_reference');
[$step, $cursor] = $function->getParameters();
var_dump($step->isPassedByReference(), $cursor->isPassedByReference());
echo $cursor->getName(), ':', $cursor->getType(), PHP_EOL;

if (PHP_VERSION_ID >= 80600) {
    $partial = eval('return v_step_reference(3, cursor: ?);');
    $parameters = (new ReflectionFunction($partial))->getParameters();
    $partialValue = 5;
    $partial(cursor: $partialValue);
    if (count($parameters) !== 1 || $parameters[0]->getName() !== 'cursor'
        || !$parameters[0]->isPassedByReference() || (string) $parameters[0]->getType() !== 'int'
        || $partialValue !== 8) {
        throw new RuntimeException('The partial application lost the parameter reference');
    }
}

$value = 5;
v_step_reference(cursor: $value, step: 3);
echo $value, PHP_EOL;
var_dump($function->invokeArgs(['cursor' => &$value, 'step' => 1]));
echo $value, PHP_EOL;
$box = new VPHP\Compiler\ModuleProbeBox;
$box->count = 4;
$method = new ReflectionMethod($box, 'stepReference');
var_dump($method->getParameters()[0]->isPassedByReference());
$method->invokeArgs($box, ['cursor' => &$value]);
echo $value, PHP_EOL;
try {
    v_step_reference(1, 3);
} catch (Error $e) {
    echo "literal rejected\n";
}

$optional = (new ReflectionFunction('v_optional_reference'))->getParameters()[0];
var_dump($optional->isPassedByReference(), $optional->isOptional(), $optional->getDefaultValue());
echo v_optional_reference(), PHP_EOL;
echo v_optional_reference(label: 'unused'), PHP_EOL;
$nullable = null;
echo v_optional_reference(label: 'written', cursor: $nullable), ':', $nullable, PHP_EOL;

$first = 4;
$second = 9;
$variadic = (new ReflectionFunction('v_step_references'))->getParameters()[1];
var_dump($variadic->isPassedByReference(), $variadic->isVariadic());
echo v_step_references(2), PHP_EOL;
echo v_step_references(2, $first, $second), ':', $first, ':', $second, PHP_EOL;
try {
    v_step_references(2, unexpected: $first);
} catch (ArgumentCountError $e) {
    echo "named variadic rejected\n";
}

$held = new class {
    public int $number = 4;
    public string $numericString = '5';
};
v_step_reference(1, $held->number);
try {
    v_step_reference(1, $held->numericString);
} catch (TypeError $e) {
    echo "typed property not coerced\n";
}
try {
    v_replace_reference($held->number, 'invalid');
} catch (TypeError $e) {
    echo "invalid assignment rejected\n";
}
var_dump($held->number, $held->numericString);
v_replace_reference($value, ['shared']);
echo $value[0], PHP_EOL;
?>
--EXPECT--
bool(false)
bool(true)
cursor:int
8
NULL
9
bool(true)
13
literal rejected
bool(true)
bool(true)
NULL
omitted
present
present:written
bool(true)
bool(true)
0
2:6:11
named variadic rejected
typed property not coerced
invalid assignment rejected
int(5)
string(1) "5"
shared
