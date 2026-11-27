--TEST--
Literal @[params] defaults match reflection in functions, methods, and closures
--FILE--
<?php
declare(strict_types=1);

$closure = v_get_struct_literal_defaults_closure();
$expected = [
    'message' => "a\n\t\0☺\$'\\\"",
    'raw' => '\n${literal}',
    'octal' => -15,
    'binary' => 161,
    'floating' => 2.0,
    'single' => unpack('f', pack('f', 0.1))[1],
    'option' => 'present',
    'nullable' => null,
    'items' => [1, 16],
    'empty' => [],
    'lookup' => ['count' => 16],
    'tail' => true,
];

foreach ([
    'function' => ['v_php_literal_params', new ReflectionFunction('v_php_literal_params')],
    'method' => [[CallableProcessor::class, 'literalParams'], new ReflectionMethod(CallableProcessor::class, 'literalParams')],
    'closure' => [$closure, new ReflectionFunction($closure)],
] as $kind => [$callable, $reflection]) {
    $defaults = [];
    foreach ($reflection->getParameters() as $parameter) {
        $defaults[$parameter->getName()] = $parameter->getDefaultValue();
    }
    echo $kind, "\n";
    var_dump($defaults === $expected);
    $omitted = $callable();
    var_dump(str_starts_with($omitted, bin2hex($expected['message']) . '|'));
    var_dump($omitted === $callable(...$defaults));
    var_dump($callable(tail: false) === $callable(...array_replace($defaults, ['tail' => false])));
    $explicit = $callable(tail: false, option: null, nullable: 4, items: [3], message: 'explicit');
    var_dump($explicit === $callable(...array_replace($defaults, [
        'tail' => false, 'option' => null, 'nullable' => 4, 'items' => [3], 'message' => 'explicit',
    ])));
    var_dump($explicit !== $omitted && str_starts_with($explicit, bin2hex('explicit') . '|'));
}
?>
--EXPECT--
function
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
method
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
closure
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
