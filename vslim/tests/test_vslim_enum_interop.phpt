--TEST--
VSlim compiler supports PHP 8.1+ Enum interoperability with V
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
// 1. 验证 V 暴露的 Enum VSlim\Compiler\ModuleProbeKind 存在
if (!enum_exists(VSlim\Compiler\ModuleProbeKind::class)) {
    echo "Enum not found\n";
    exit;
}

// 2. 验证其为 BackedEnum
$reflection = new ReflectionEnum(VSlim\Compiler\ModuleProbeKind::class);
echo $reflection->isBacked() ? "enum-backed-ok\n" : "enum-backed-fail\n";

// 3. 测试通过实例传递参数并获得对应的 EnumCase 实例回显
$box = new VSlim\Compiler\ModuleProbeBox();
$beta = VSlim\Compiler\ModuleProbeKind::beta;
$res = $box->test_enum_echo($beta);

echo "Echo matches input: ", ($res === $beta ? "yes" : "no"), "\n";
echo "Result type: ", get_class($res), "\n";
echo "Result value: ", $res->value, "\n";

// 4. 测试传入整型（自动转换）并获得对应的 EnumCase 实例回显
$res_int = $box->test_enum_echo(11);
echo "Echo int matches input: ", ($res_int === $beta ? "yes" : "no"), "\n";
?>
--EXPECT--
enum-backed-ok
Echo matches input: yes
Result type: VSlim\Compiler\ModuleProbeKind
Result value: 11
Echo int matches input: yes
