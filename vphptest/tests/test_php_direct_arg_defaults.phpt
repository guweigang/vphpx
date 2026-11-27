--TEST--
Ordinary PHP defaults imply optionality and accept legacy optional declarations
--FILE--
<?php
declare(strict_types=1);

$function = 'v_php_direct_defaults';
$method = [CallableProcessor::class, 'directDefaults'];
echo $function('', 7, null, null, false), "\n";
echo $method('', 8, [9], null, false), "\n";
try {
    $function('');
} catch (Error $error) {
    echo str_contains($error->getMessage(), 'VPHP_ORDINARY_ARG_COUNT')
        ? "undefined constant\n" : $error->getMessage() . "\n";
}

define('VPHP_ORDINARY_ARG_COUNT', 42);
foreach ([
    [$function, new ReflectionFunction($function)],
    [$method, new ReflectionMethod(...$method)],
] as [$call, $reflection]) {
    $parameters = $reflection->getParameters();
    echo 'required=', $reflection->getNumberOfRequiredParameters(), '/', $reflection->getNumberOfParameters(), "\n";
    echo $parameters[1]->getDefaultValueConstantName(), "\n";
    $default = array_map(static fn ($parameter) => $parameter->getDefaultValue(), array_slice($parameters, 1));
    echo json_encode($default, JSON_THROW_ON_ERROR), "\n";
    echo $call('', ...$default), "\n";
    echo $call(''), "\n";
    echo $call('', 3), "\n";
    echo $call(enabled: false, prefix: ''), "\n";
    echo $call(enabled: false, label: null, values: null, prefix: ''), "\n";
    try {
        $call(enabled: false);
    } catch (ArgumentCountError $error) {
        echo "prefix required\n";
    }
}

$legacy = new ReflectionFunction('v_php_legacy_optional_tail');
echo 'legacy required=', $legacy->getNumberOfRequiredParameters(), '/', $legacy->getNumberOfParameters(), "\n";
echo v_php_legacy_optional_tail(1, 2), "\n";
echo v_php_legacy_optional_tail(blocked: 2, before: 1), "\n";
foreach ([
    static fn () => v_php_legacy_optional_tail(1),
    static fn () => v_php_legacy_optional_tail(blocked: 2),
] as $missing) {
    try {
        $missing();
    } catch (ArgumentCountError $error) {
        echo "legacy required argument rejected\n";
    }
}
?>
--EXPECT--
7|<null>|<null>|false
8|[9]|<null>|false
undefined constant
required=1/5
VPHP_ORDINARY_ARG_COUNT
[42,[1,42],"fallback",true]
42|[1,42]|fallback|true
42|[1,42]|fallback|true
3|[1,42]|fallback|true
42|[1,42]|fallback|false
42|<null>|<null>|false
prefix required
required=1/5
VPHP_ORDINARY_ARG_COUNT
[42,[1,42],"fallback",true]
42|[1,42]|fallback|true
42|[1,42]|fallback|true
3|[1,42]|fallback|true
42|[1,42]|fallback|false
42|<null>|<null>|false
prefix required
legacy required=2/3
1|2|0
1|2|0
legacy required argument rejected
legacy required argument rejected
