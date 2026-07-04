<?php
// 回归测试：没有 return 或显式返回 void 的自定义函数在被动态注册为 runtime 反射适配器时，
// 应被生成为独立执行语句加 return rt.new_null()，防止 used as value 错误。

function test_void_func($msg) {
    echo $msg;
}

// 动态调用 test_void_func 以触发 t.has_dynamic_func_call = true 及 test_void_func 的包装注册
$func_name = 'test_void_func';
$func_name('hello');
