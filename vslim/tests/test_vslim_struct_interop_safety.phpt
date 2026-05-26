--TEST--
VSlim compiler supports struct interop type safety and inheritance polymorphism
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$box = new VSlim\Compiler\ModuleProbeBox();
$readOnlyBox = new VSlim\Compiler\ModuleProbeReadOnlyBox();

// 1. 测试正常调用
echo "--- Testing standard struct param ---\n";
echo $box->test_struct_param($readOnlyBox) . "\n";

// 2. 测试子类继承（向上多态映射）
echo "--- Testing inherited struct param ---\n";
readonly class ChildBox extends \VSlim\Compiler\ModuleProbeReadOnlyBox {}
$childBox = new ChildBox();
echo $box->test_struct_param($childBox) . "\n";

// 3. 测试非匹配的绑定类对象传入（安全性防范，确保不崩溃）
echo "--- Testing mismatched bound class safety ---\n";
try {
    // 传入的本身也是绑定了结构体的 VSlim\Compiler\ModuleProbeBox
    $box->test_struct_param($box);
} catch (Throwable $e) {
    echo "Caught: " . get_class($e) . " - " . $e->getMessage() . "\n";
}

// 4. 测试非绑定类对象传入（安全性防范，确保不崩溃）
echo "--- Testing unbound class safety ---\n";
try {
    $std = new stdClass();
    $box->test_struct_param($std);
} catch (Throwable $e) {
    echo "Caught: " . get_class($e) . " - " . $e->getMessage() . "\n";
}
?>
--EXPECTF--
--- Testing standard struct param ---
readonly-box
--- Testing inherited struct param ---
readonly-box
--- Testing mismatched bound class safety ---
Caught: Exception - argument 0 must be object bound to module_probex.VSlimModuleProbeReadOnlyBox, got object
--- Testing unbound class safety ---
Caught: Exception - argument 0 must be object bound to module_probex.VSlimModuleProbeReadOnlyBox, got object
