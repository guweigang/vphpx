--TEST--
Struct params closure export - V closure accepts typed params struct
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$cb = v_get_struct_param_closure();
echo $cb("book", 3), "\n";

$rf = new ReflectionFunction($cb);
echo "params: " . $rf->getNumberOfParameters() . "\n";
echo "required: " . $rf->getNumberOfRequiredParameters() . "\n";

$methodCb = CallableProcessor::structClosure();
echo $methodCb("pen", 7), "\n";
echo $methodCb(count: 8, name: 'named pen'), "\n";

$default = v_get_struct_default_closure();
$rf = new ReflectionFunction($default);
echo 'defaults: ', $rf->getNumberOfParameters(), '/', $rf->getNumberOfRequiredParameters(), "\n";
foreach ($rf->getParameters() as $parameter) {
    echo $parameter->getName(), ':', $parameter->getType(), ':',
        $parameter->isOptional() ? 'optional' : 'required';
    if ($parameter->isDefaultValueAvailable()) {
        $value = $parameter->getDefaultValue();
        echo ':', is_object($value) && $value->isDynamic() ? 'dynamic' : json_encode($value);
    }
    echo "\n";
}
echo $default('book'), "\n";
echo $default('book', 4), "\n";
echo $default('book', 4, false), "\n";
echo $default(flag: false, name: 'skip count'), "\n";
echo $default(computed: 10, name: 'skip two'), "\n";
echo $default(label: 'tag', name: 'label'), "\n";
echo $default(label: null, name: 'explicit null'), "\n";

$void = v_get_struct_default_closure_void();
var_dump($void('pen'));
var_dump($void('pen', 2, false));
var_dump($void(flag: false, name: 'named void'));
foreach ([
    static fn () => $default(),
    static fn () => $default('book', []),
    static fn () => $void('pen', 2, new stdClass()),
    static fn () => $default(count: [], name: 'named type'),
    static fn () => $void(flag: new stdClass(), name: 'named type'),
    static fn () => $default(label: [], name: 'nullable type'),
] as $invalid) {
    try {
        $invalid();
        echo "unexpected success\n";
    } catch (Throwable $e) {
        echo get_class($e), ': ', $e->getMessage(), "\n";
    }
}
var_dump($void('pen'));
echo v_invoke_legacy_struct_closure(), "\n";
var_dump(v_invoke_legacy_struct_closure_void());

$computed = v_get_struct_computed_defaults_closure();
$computedReflection = new ReflectionFunction($computed);
var_dump(str_contains((string) $computedReflection, 'ClosureDefault'));
[, $first, $second] = $computedReflection->getParameters();
var_dump($first->isOptional(), $first->isDefaultValueAvailable());
$reflectedDefault = $second->getDefaultValue();
var_dump($first->getDefaultValue()->isDynamic(), $first->getDefaultValue()->isDynamic(), $reflectedDefault->isDynamic());
echo $computed(flag: false, second: 91, first: 42, name: 'explicit'), "\n";
echo $computed(flag: false, second: null, first: 42, name: 'explicit null'), "\n";
echo $computed(flag: false, second: 90, name: 'one hole'), "\n";
echo $computed(second: 90, name: 'again', flag: false), "\n";
echo $computed(flag: false, name: 'two holes'), "\n";
echo $computed('tail'), "\n";
echo $computed('partial', 42), "\n";
echo $computedReflection->invokeArgs(['flag' => false, 'name' => 'invokeArgs', 'second' => 90]), "\n";
echo $computed->__invoke(flag: false, second: 90, name: 'invoke'), "\n";
try {
    $computed(second: $reflectedDefault, flag: false, name: 'explicit descriptor');
    echo "unexpected success\n";
} catch (TypeError $e) {
    echo $e->getMessage(), "\n";
}
echo $computed(flag: false, second: 90, name: 'after descriptor'), "\n";

$native = v_get_struct_native_defaults_closure();
$payload = (new ReflectionFunction($native))->getParameters()[0];
var_dump($payload->getDefaultValue()->isDynamic());
echo $native(label: 'native named'), "\n";
echo $native(label: 'native again'), "\n";
echo $native(), "\n";

$failing = v_get_struct_failing_defaults_closure();
foreach ([
    'trailing' => static fn () => $failing(),
    'named' => static fn () => $failing(tail: false),
] as $kind => $call) {
    try {
        $call();
        echo "unexpected success\n";
    } catch (RuntimeException $e) {
        echo $kind, ':', $e->getMessage(), "\n";
    }
}
echo $computed(flag: false, second: 90, name: 'after failures'), "\n";
?>
--EXPECT--
book:3
params: 2
required: 2
pen:7
named pen:8
defaults: 5/1
name:string:required
count:int:optional:7
flag:bool:optional:true
label:?string:optional:null
computed:int:optional:dynamic
book:7:true:7:
book:4:true:7:
book:4:false:7:
skip count:7:false:7:
skip two:7:true:10:
label:7:true:7:tag
explicit null:7:true:7:
pen:7:true:7:
NULL
pen:2:false:7:
NULL
named void:7:false:7:
NULL
ArgumentCountError: closure requires at least 1 argument
TypeError: argument 2 (count): type mismatch: expected int, got array
TypeError: argument 3 (flag): type mismatch: expected bool, got object
TypeError: argument 2 (count): type mismatch: expected int, got array
TypeError: argument 3 (flag): type mismatch: expected bool, got object
TypeError: argument 4 (label): type mismatch: expected string, got array
pen:7:true:7:
NULL
legacy:7:true:7:
legacy void:7:true:7:
NULL
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
explicit:42:91:false
explicit null:42:<null>:false
one hole:1:90:false
again:2:90:false
two holes:3:4:false
tail:5:6:true
partial:42:7:true
invokeArgs:8:90:false
invoke:9:90:false
argument 3 (second): type mismatch: expected int, got object
after descriptor:11:90:false
bool(true)
native named:12
native again:13
trailing:14
trailing:closure default failed
named:closure default failed
after failures:16:90:false
