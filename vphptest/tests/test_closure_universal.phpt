--TEST--
Variadic ZVal closure export - V exports flexible closures for PHP
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo "=== Variadic ZVal Closure 0 (no args) ===\n";
$c0 = v_get_closure_0();
echo "result: " . $c0() . "\n";

$rf0 = new ReflectionFunction($c0);
echo "params: " . $rf0->getNumberOfParameters() . "\n";
echo "required: " . $rf0->getNumberOfRequiredParameters() . "\n";
echo "variadic: " . ($rf0->getParameters()[0]->isVariadic() ? "yes" : "no") . "\n";

echo "\n=== Variadic ZVal Closure 1 (1 arg) ===\n";
$c1 = v_get_closure_1();
echo "result: " . $c1("hello") . "\n";

$rf1 = new ReflectionFunction($c1);
echo "params: " . $rf1->getNumberOfParameters() . "\n";
echo "required: " . $rf1->getNumberOfRequiredParameters() . "\n";

echo "\n=== Variadic ZVal Closure 2 (2 args) ===\n";
$c2 = v_get_closure_2();
echo "result: " . $c2("foo", "bar") . "\n";

$rf2 = new ReflectionFunction($c2);
echo "params: " . $rf2->getNumberOfParameters() . "\n";
echo "required: " . $rf2->getNumberOfRequiredParameters() . "\n";

echo "\n=== Variadic ZVal Closure 3 (3 args) ===\n";
$c3 = v_get_closure_3();
echo "result: " . $c3("a", "b", "c") . "\n";

$rf3 = new ReflectionFunction($c3);
echo "params: " . $rf3->getNumberOfParameters() . "\n";
echo "required: " . $rf3->getNumberOfRequiredParameters() . "\n";

echo "\n=== Variadic ZVal Closure 4 (4 args) ===\n";
$c4 = v_get_closure_4();
echo "result: " . $c4("w", "x", "y", "z") . "\n";

$rf4 = new ReflectionFunction($c4);
echo "params: " . $rf4->getNumberOfParameters() . "\n";
echo "required: " . $rf4->getNumberOfRequiredParameters() . "\n";

echo "\n=== Variadic ZVal Closure 3 Void ===\n";
$c3v = v_get_closure_3_void();
$c3v("p", "q", "r");
echo "void call ok\n";

$rf3v = new ReflectionFunction($c3v);
echo "params: " . $rf3v->getNumberOfParameters() . "\n";

echo "\n=== Variadic ZVal Closure 4 Void ===\n";
$c4v = v_get_closure_4_void();
$c4v("1", "2", "3", "4");
echo "void call ok\n";

$rf4v = new ReflectionFunction($c4v);
echo "params: " . $rf4v->getNumberOfParameters() . "\n";

echo "\nDone.\n";
?>
--EXPECT--
=== Variadic ZVal Closure 0 (no args) ===
result: variadic-0-result
params: 1
required: 0
variadic: yes

=== Variadic ZVal Closure 1 (1 arg) ===
result: got:hello
params: 1
required: 0

=== Variadic ZVal Closure 2 (2 args) ===
result: foo+bar
params: 1
required: 0

=== Variadic ZVal Closure 3 (3 args) ===
result: a+b+c
params: 1
required: 0

=== Variadic ZVal Closure 4 (4 args) ===
result: w+x+y+z
params: 1
required: 0

=== Variadic ZVal Closure 3 Void ===
void call ok
params: 1

=== Variadic ZVal Closure 4 Void ===
void call ok
params: 1

Done.
