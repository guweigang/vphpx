--TEST--
Callable type bridging - typed callable parameters
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo "=== Global function with callable ===\n";

// Test v_invoke_callable
$cb1 = function() { return "hello"; };
echo v_invoke_callable($cb1) . "\n";

// Test v_invoke_with_arg
$cb2 = function($x) { return strtoupper($x); };
echo v_invoke_with_arg($cb2, "world") . "\n";

echo "\n=== Class method with callable ===\n";

$processor = new CallableProcessor("[PROC] ");
echo $processor->process(function() { return "test"; }) . "\n";
echo $processor->transform(function($s) { return str_repeat($s, 2); }, "ab") . "\n";

echo "\n=== Static method with callable ===\n";

echo CallableProcessor::apply(function($d) { return "got: $d"; }, "data") . "\n";

echo "\n=== Callable helpers on ZVal ===\n";
echo v_call_php_closure_helper(function($data) { return "Helper saw: $data"; }) . "\n";

try {
    v_call_php_closure_helper("not-a-callable");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

echo "\n=== PHP Reflection - callable type hint ===\n";

// Check global function reflection
$rf = new ReflectionFunction('v_invoke_callable');
$params = $rf->getParameters();
echo "v_invoke_callable param 0: ";
$type = $params[0]->getType();
echo ($type !== null ? $type->getName() : "mixed") . "\n";

// Check v_invoke_with_arg reflection
$rf2 = new ReflectionFunction('v_invoke_with_arg');
$params2 = $rf2->getParameters();
echo "v_invoke_with_arg param 0: ";
$type0 = $params2[0]->getType();
echo ($type0 !== null ? $type0->getName() : "mixed") . "\n";
echo "v_invoke_with_arg param 1: ";
$type1 = $params2[1]->getType();
echo ($type1 !== null ? $type1->getName() : "mixed") . "\n";

// Check class method reflection
$rm = new ReflectionMethod('CallableProcessor', 'process');
$mparams = $rm->getParameters();
echo "CallableProcessor::process param 0: ";
$mtype = $mparams[0]->getType();
echo ($mtype !== null ? $mtype->getName() : "mixed") . "\n";

// Check transform method - should have callable + string
$rm2 = new ReflectionMethod('CallableProcessor', 'transform');
$mparams2 = $rm2->getParameters();
echo "CallableProcessor::transform param 0: ";
$mt0 = $mparams2[0]->getType();
echo ($mt0 !== null ? $mt0->getName() : "mixed") . "\n";
echo "CallableProcessor::transform param 1: ";
$mt1 = $mparams2[1]->getType();
echo ($mt1 !== null ? $mt1->getName() : "mixed") . "\n";

echo "\nDone.\n";
?>
--EXPECT--
=== Global function with callable ===
Result: hello
WORLD

=== Class method with callable ===
[PROC] test
[PROC] abab

=== Static method with callable ===
got: data

=== Callable helpers on ZVal ===
Helper executed, PHP said: Helper saw: Message from helper
Caught: zval is not callable

=== PHP Reflection - callable type hint ===
v_invoke_callable param 0: callable
v_invoke_with_arg param 0: callable
v_invoke_with_arg param 1: string
CallableProcessor::process param 0: callable
CallableProcessor::transform param 0: callable
CallableProcessor::transform param 1: string

Done.
