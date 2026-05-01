--TEST--
Variadic closure export - V closure accepts arbitrary PHP args as PhpValue
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$cb = v_get_variadic_value_closure();
echo $cb(), "\n";
echo $cb("book", 3, true), "\n";

$rf = new ReflectionFunction($cb);
echo "params: " . $rf->getNumberOfParameters() . "\n";
echo "required: " . $rf->getNumberOfRequiredParameters() . "\n";
$param = $rf->getParameters()[0];
echo "variadic: " . ($param->isVariadic() ? "yes" : "no") . "\n";
echo "name: " . $param->getName() . "\n";

$zval = v_get_variadic_zval_closure();
echo $zval("z", 9), "\n";

$void = v_get_variadic_zval_void();
var_dump($void("ignored"));

$scalarString = v_get_variadic_scalar_string();
echo $scalarString("book", 3, true, 1.5), "\n";

$scalarInt = v_get_variadic_scalar_i64();
echo $scalarInt(1, "2", true, 4.8), "\n";

$scalarValue = v_get_variadic_scalar_value();
var_dump($scalarValue(false));

try {
    $scalarString(["not-scalar"]);
} catch (Throwable $e) {
    echo "caught: " . $e->getMessage() . "\n";
}
?>
--EXPECT--
0:
3:book|3|1
params: 1
required: 0
variadic: yes
name: args
2:z|9
NULL
4:book|3|true|1.5
8
bool(false)
caught: expected V scalar, got array
