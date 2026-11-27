--TEST--
PHP default overrides for flattened @[params] fields match reflection and omitted calls
--FILE--
<?php
declare(strict_types=1);

$processor = new CallableProcessor('method');
// Explicit null and explicit count bypass the defaults, even before the constant exists.
echo v_php_overridden_params('explicit', null, 'given', 7, 'set', [9], false), "\n";
echo $processor->overriddenParams(null, 'given', 8, 'set', [9], false), "\n";
try {
    v_php_overridden_params('missing constant');
} catch (Error $error) {
    echo str_contains($error->getMessage(), 'VPHP_PARAMS_OVERRIDE_COUNT') ? "undefined constant\n" : $error->getMessage() . "\n";
}
define('VPHP_PARAMS_OVERRIDE_COUNT', 42);

$function = new ReflectionFunction('v_php_overridden_params');
$method = new ReflectionMethod(CallableProcessor::class, 'overriddenParams');
foreach ([$function, $method] as $reflection) {
    $defaults = [];
    foreach ($reflection->getParameters() as $param) {
        if ($param->isDefaultValueAvailable()) {
            $defaults[$param->getName()] = $param->getDefaultValue();
        }
    }
    echo json_encode($defaults, JSON_THROW_ON_ERROR), "\n";
}

echo v_php_overridden_params('function'), "\n";
echo $processor->overriddenParams(), "\n";
echo v_php_overridden_params('position', 'given'), "\n";
echo $processor->overriddenParams('given'), "\n";
echo v_php_overridden_params(tail: false, prefix: 'named'), "\n";
echo $processor->overriddenParams(tail: false, option: null), "\n";
echo $method->invokeArgs($processor, ['nullable' => 'supplied']), "\n";
echo v_php_computed_params('counter'), "\n";
?>
--EXPECT--
explicit:<null>:given:7:set:1:false
method:<null>:given:8:set:1:false
undefined constant
{"option":"php\tvalue","spacer":"native spacer","count":42,"nullable":null,"items":[1,2],"tail":true}
{"option":"php\tvalue","spacer":"native spacer","count":42,"nullable":null,"items":[1,2],"tail":true}
function:php	value:native spacer:42:<null>:2:true
method:php	value:native spacer:42:<null>:2:true
position:given:native spacer:42:<null>:2:true
method:given:native spacer:42:<null>:2:true
named:php	value:native spacer:42:<null>:2:false
method:<null>:native spacer:42:<null>:2:false
method:php	value:native spacer:42:supplied:2:true
counter:1:auto-2:true
