--TEST--
Computed @[params] defaults in PHP functions and methods
--FILE--
<?php
declare(strict_types=1);

$function = new ReflectionFunction('v_php_computed_params');
$method = new ReflectionMethod(CallableProcessor::class, 'computedParams');
foreach ([$function, $method] as $callable) {
    foreach ($callable->getParameters() as $parameter) {
        if ($parameter->isDefaultValueAvailable()) {
            $default = $parameter->getDefaultValue();
            $again = $parameter->getDefaultValue();
            $kind = is_object($default) && $default->isDynamic() && $again->isDynamic()
                ? 'dynamic' : var_export($default, true);
            echo $parameter->getName(), '=', $parameter->getType(), '/', $kind, PHP_EOL;
        }
    }
}

$processor = new CallableProcessor('method');
echo v_php_computed_params(enabled: false, label: null, prefix: 'explicit', sequence: 42), PHP_EOL;
echo $processor->computedParams(label: 'manual', sequence: 43), PHP_EOL;
echo v_php_computed_params(label: 'named', prefix: 'function'), PHP_EOL;
echo v_php_computed_params(label: 'named', prefix: 'function'), PHP_EOL;
echo $processor->computedParams(enabled: false, sequence: 44), PHP_EOL;
echo $processor->computedParams(enabled: false, sequence: 44), PHP_EOL;
echo v_php_computed_params('trailing'), PHP_EOL;
echo $processor->computedParams(enabled: true), PHP_EOL;
echo $method->invokeArgs($processor, ['enabled' => false, 'sequence' => 45]), PHP_EOL;

try {
    v_php_computed_params('descriptor', $function->getParameters()[1]->getDefaultValue());
} catch (TypeError $error) {
    echo "descriptor rejected\n";
}
try {
    $processor->computedParams(enabled: 'wrong');
} catch (TypeError $error) {
    echo "invalid type rejected\n";
}
echo $processor->computedParams(label: null), PHP_EOL;

$boundFunction = v_php_computed_params(...);
$boundMethod = $processor->computedParams(...);
echo $boundFunction(label: 'bound', prefix: 'function'), PHP_EOL;
echo $boundMethod(enabled: false, sequence: 46), PHP_EOL;
if (PHP_VERSION_ID >= 80600) {
    $partialFunction = eval("return v_php_computed_params('partial', enabled: ?);");
    $partialMethod = eval('return $processor->computedParams(sequence: ?, enabled: false);');
    $partialClosure = eval('return v_get_struct_computed_defaults_closure()(\'partial\', flag: ?);');
    foreach ([[$partialFunction, 'enabled', 'bool'], [$partialMethod, 'sequence', 'int'], [$partialClosure, 'flag', 'bool']]
        as [$callback, $name, $type]) {
        $parameters = (new ReflectionFunction($callback))->getParameters();
        if (count($parameters) !== 1 || $parameters[0]->getName() !== $name
            || (string) $parameters[0]->getType() !== $type || $parameters[0]->isOptional()) {
            throw new RuntimeException('The partial closure lost its remaining signature');
        }
    }
    if ($partialFunction(enabled: false) !== 'partial:13:auto-14:false'
        || $partialFunction(enabled: true) !== 'partial:15:auto-16:true'
        || $partialMethod(sequence: 47) !== 'method:47:auto-17:false'
        || $partialClosure(flag: true) !== 'partial:1:2:true'
        || $partialClosure(flag: false) !== 'partial:3:4:false') {
        throw new RuntimeException('A partial closure lost the per-call dynamic defaults');
    }
    $descriptor = $function->getParameters()[1]->getDefaultValue();
    $explicit = eval("return v_php_computed_params('explicit', ?, enabled: false);");
    try {
        $explicit($descriptor);
        throw new RuntimeException('A partial closure accepted an explicit descriptor as an integer');
    } catch (TypeError $error) {
        if (!str_contains($error->getMessage(), '$sequence')) {
            throw $error;
        }
    }
    $ellipsis = eval("return v_php_computed_params('ellipsis', ...);");
    $forward = static fn (...$args) => v_php_computed_params('forwarded', ...$args);
    if ($ellipsis(sequence: 52, label: 'manual') !== 'ellipsis:52:manual:true'
        || $forward(enabled: false) !== 'forwarded:18:auto-19:false') {
        throw new RuntimeException('Unexpected behavior forwarding explicit or omitted defaults');
    }
}
?>
--EXPECT--
sequence=int/dynamic
label=?string/dynamic
enabled=bool/true
sequence=int/dynamic
label=?string/dynamic
enabled=bool/true
explicit:42:null:false
method:43:manual:true
function:1:named:true
function:2:named:true
method:44:auto-3:false
method:44:auto-4:false
trailing:5:auto-6:true
method:7:auto-8:true
method:45:auto-9:false
descriptor rejected
invalid type rejected
method:10:null:true
function:11:bound:true
method:46:auto-12:false
