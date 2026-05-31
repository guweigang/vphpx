--TEST--
vphp compiler supports variadic parameters interop for methods and functions
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
// 1. 测试反射以验证 variadic 的正确性
echo "--- Testing Reflection ---\n";
$rf = new ReflectionFunction('v_compiler_probe_variadic');
$params = $rf->getParameters();
echo "Function args count: ", count($params), "\n";
echo "Function arg isVariadic: ", ($params[0]->isVariadic() ? 'yes' : 'no'), "\n";

$rc = new ReflectionClass('VPHP\Compiler\ModuleProbeBox');
$rm = $rc->getMethod('test_variadic');
$mParams = $rm->getParameters();
echo "Method args count: ", count($mParams), "\n";
echo "Method 2nd arg name: ", $mParams[1]->getName(), "\n";
echo "Method 2nd arg isVariadic: ", ($mParams[1]->isVariadic() ? 'yes' : 'no'), "\n";

// 2. 测试全局变参函数执行
echo "--- Testing Variadic Function ---\n";
echo "Sum of empty: ", v_compiler_probe_variadic(), "\n";
echo "Sum of [1, 2, 3]: ", v_compiler_probe_variadic(1, 2, 3), "\n";
echo "Sum of [10, -5, 20, 30]: ", v_compiler_probe_variadic(10, -5, 20, 30), "\n";

// 3. 测试成员变参方法执行
echo "--- Testing Variadic Method ---\n";
$box = new VPHP\Compiler\ModuleProbeBox();
echo "Join empty with comma: ", $box->test_variadic(','), "\n";
echo "Join standard strings: ", $box->test_variadic('-', 'a', 'b', 'c'), "\n";
echo "Join long strings: ", $box->test_variadic('::', 'hello', 'world', 'vphp', 'variadic'), "\n";
?>
--EXPECT--
--- Testing Reflection ---
Function args count: 1
Function arg isVariadic: yes
Method args count: 2
Method 2nd arg name: args
Method 2nd arg isVariadic: yes
--- Testing Variadic Function ---
Sum of empty: 0
Sum of [1, 2, 3]: 6
Sum of [10, -5, 20, 30]: 55
--- Testing Variadic Method ---
Join empty with comma: 
Join standard strings: a-b-c
Join long strings: hello::world::vphp::variadic
