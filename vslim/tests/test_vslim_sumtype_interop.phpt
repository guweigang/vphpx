--TEST--
VSlim compiler supports PHP Union Types and V SumTypes interop with structs and enums
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$box = new VSlim\Compiler\ModuleProbeBox();

// 1. 测试 int 变体
echo "--- Testing Int Variant ---\n";
$res_int = $box->test_sumtype_echo(42);
echo "Result type: ", gettype($res_int), "\n";
echo "Result value: ", $res_int, "\n";

// 2. 测试 Struct (ModuleProbeReadOnlyBox) 变体
echo "--- Testing Struct Variant ---\n";
$readOnlyBox = new VSlim\Compiler\ModuleProbeReadOnlyBox();
$res_struct = $box->test_sumtype_echo($readOnlyBox);
echo "Result class: ", get_class($res_struct), "\n";
echo "Result title: ", $res_struct->title, "\n";
echo "Result value: ", $res_struct->value, "\n";
echo "Is same instance: ", ($res_struct === $readOnlyBox ? "yes" : "no"), "\n";

// 3. 测试 Enum (ModuleProbeKind) 变体
echo "--- Testing Enum Variant ---\n";
$kind = VSlim\Compiler\ModuleProbeKind::beta;
$res_enum = $box->test_sumtype_echo($kind);
echo "Result class: ", get_class($res_enum), "\n";
echo "Result name: ", $res_enum->name, "\n";
echo "Result value: ", $res_enum->value, "\n";
echo "Is same enum case: ", ($res_enum === $kind ? "yes" : "no"), "\n";
?>
--EXPECT--
--- Testing Int Variant ---
Result type: integer
Result value: 42
--- Testing Struct Variant ---
Result class: VSlim\Compiler\ModuleProbeReadOnlyBox
Result title: readonly-box
Result value: 0
Is same instance: yes
--- Testing Enum Variant ---
Result class: VSlim\Compiler\ModuleProbeKind
Result name: beta
Result value: 11
Is same enum case: yes
