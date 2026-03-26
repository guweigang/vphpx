--TEST--
Universal closure export - V exports closures with correct arity for PHP reflection
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo "=== Universal Closure 0 (no args) ===\n";
$c0 = v_get_closure_0();
echo "result: " . $c0() . "\n";

$rf0 = new ReflectionFunction($c0);
echo "params: " . $rf0->getNumberOfParameters() . "\n";
echo "required: " . $rf0->getNumberOfRequiredParameters() . "\n";

echo "\n=== Universal Closure 1 (1 arg) ===\n";
$c1 = v_get_closure_1();
echo "result: " . $c1("hello") . "\n";

$rf1 = new ReflectionFunction($c1);
echo "params: " . $rf1->getNumberOfParameters() . "\n";
echo "required: " . $rf1->getNumberOfRequiredParameters() . "\n";

echo "\n=== Universal Closure 2 (2 args) ===\n";
$c2 = v_get_closure_2();
echo "result: " . $c2("foo", "bar") . "\n";

$rf2 = new ReflectionFunction($c2);
echo "params: " . $rf2->getNumberOfParameters() . "\n";
echo "required: " . $rf2->getNumberOfRequiredParameters() . "\n";

echo "\n=== Universal Closure 3 (3 args) ===\n";
$c3 = v_get_closure_3();
echo "result: " . $c3("a", "b", "c") . "\n";

$rf3 = new ReflectionFunction($c3);
echo "params: " . $rf3->getNumberOfParameters() . "\n";
echo "required: " . $rf3->getNumberOfRequiredParameters() . "\n";

echo "\n=== Universal Closure 4 (4 args) ===\n";
$c4 = v_get_closure_4();
echo "result: " . $c4("w", "x", "y", "z") . "\n";

$rf4 = new ReflectionFunction($c4);
echo "params: " . $rf4->getNumberOfParameters() . "\n";
echo "required: " . $rf4->getNumberOfRequiredParameters() . "\n";

echo "\n=== Universal Closure 3 Void ===\n";
$c3v = v_get_closure_3_void();
$c3v("p", "q", "r");
echo "void call ok\n";

$rf3v = new ReflectionFunction($c3v);
echo "params: " . $rf3v->getNumberOfParameters() . "\n";

echo "\n=== Universal Closure 4 Void ===\n";
$c4v = v_get_closure_4_void();
$c4v("1", "2", "3", "4");
echo "void call ok\n";

$rf4v = new ReflectionFunction($c4v);
echo "params: " . $rf4v->getNumberOfParameters() . "\n";

echo "\nDone.\n";
?>
--EXPECT--
=== Universal Closure 0 (no args) ===
result: universal-0-result
params: 0
required: 0

=== Universal Closure 1 (1 arg) ===
result: got:hello
params: 1
required: 1

=== Universal Closure 2 (2 args) ===
result: foo+bar
params: 2
required: 2

=== Universal Closure 3 (3 args) ===
result: a+b+c
params: 3
required: 3

=== Universal Closure 4 (4 args) ===
result: w+x+y+z
params: 4
required: 4

=== Universal Closure 3 Void ===
void call ok
params: 3

=== Universal Closure 4 Void ===
void call ok
params: 4

Done.
