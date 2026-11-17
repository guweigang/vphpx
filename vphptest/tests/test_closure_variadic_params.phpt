--TEST--
Variadic closure export forwards empty and mixed arguments and rejects non-scalars for scalar closures
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
echo $zval(), "\n";
echo $zval("z", 9), "\n";

$void = v_get_variadic_zval_void();
var_dump($void(), $void("ignored", 7));

$scalarString = v_get_variadic_scalar_string();
echo $scalarString("book", 3, true, 1.5), "\n";

$scalarInt = v_get_variadic_scalar_i64();
echo $scalarInt(1, "2", true, 4.8), "\n";

$scalarValue = v_get_variadic_scalar_value();
var_dump($scalarValue(false));

foreach ([["not-scalar"], new stdClass()] as $invalid) {
    try {
        $scalarString("valid-prefix", $invalid);
        echo "unexpected success\n";
    } catch (Throwable $e) {
        echo get_class($e) . ": " . $e->getMessage() . "\n";
    }
}
echo $scalarString(), "\n";

foreach (['v_invoke_legacy_variadic_scalar', 'v_invoke_legacy_variadic_scalar_alias'] as $legacy) {
    var_dump($legacy(), $legacy(1, "2", true, 4.8));
    try {
        $legacy("valid-prefix", ["not-scalar"]);
        echo "unexpected legacy success\n";
    } catch (Throwable $e) {
        echo get_class($e) . ": " . $e->getMessage() . "\n";
    }
    var_dump($legacy());
}

foreach (['v_invoke_legacy_variadic_void', 'v_invoke_legacy_variadic_void_alias'] as $legacyVoid) {
    var_dump($legacyVoid());
    var_dump($legacyVoid('book', 3, true, 1.5));
    foreach ([['not-scalar'], new stdClass()] as $invalid) {
        try {
            $legacyVoid('valid-prefix', $invalid);
            echo "unexpected legacy void success\n";
        } catch (Throwable $e) {
            echo get_class($e) . ': ' . $e->getMessage() . "\n";
        }
    }
    var_dump($legacyVoid());
}
?>
--EXPECT--
0:
3:book|3|1
params: 1
required: 0
variadic: yes
name: args
0:
2:z|9
NULL
NULL
4:book|3|true|1.5
8
bool(false)
Exception: expected V scalar, got array
Exception: expected V scalar, got object
0:
string(2) "0:"
string(14) "4:1|2|true|4.8"
Exception: expected V scalar, got array
string(2) "0:"
int(0)
int(8)
Exception: expected V scalar, got array
int(0)
0:
NULL
4:book|3|true|1.5
NULL
Exception: expected V scalar, got array
Exception: expected V scalar, got object
0:
NULL
0:
NULL
4:book|3|true|1.5
NULL
Exception: expected V scalar, got array
Exception: expected V scalar, got object
0:
NULL
