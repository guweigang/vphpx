--TEST--
vphp compiler supports PHP Union Types and V SumTypes interop with structs and enums
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$box = new VPHP\Compiler\ModuleProbeBox();
$readonlyBox = new VPHP\Compiler\ModuleProbeReadOnlyBox();

echo "reflection-ok\n";

echo "--- Testing Variadic ---\n";
echo $box->test_variadic(', ', 'a', 'b', 'c') . "\n";
?>
--EXPECT--
reflection-ok
--- Testing Variadic ---
a, b, c
