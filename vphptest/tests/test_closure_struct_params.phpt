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
?>
--EXPECT--
book:3
params: 2
required: 2
pen:7
