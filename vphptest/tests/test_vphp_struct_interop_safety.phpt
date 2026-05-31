--TEST--
vphp compiler supports struct interop type safety and inheritance polymorphism
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$box = new VPHP\Compiler\ModuleProbeBox();
$readOnlyBox = new VPHP\Compiler\ModuleProbeReadOnlyBox();

echo "--- Testing standard struct param ---\n";
echo $box->test_struct_param($readOnlyBox) . "\n";

$ref = new ReflectionClass(VPHP\Compiler\ModuleProbeReadOnlyBox::class);
echo $ref->isReadOnly() ? "class-readonly-ok\n" : "class-readonly-fail\n";
?>
--EXPECT--
--- Testing standard struct param ---
readonly-box
class-readonly-ok
