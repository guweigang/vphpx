<?php
// 回归测试：若变量被推导为 string 但真实声明为包装类型 (如 PhpVal) 时，
// 调用 strlen(), trim() 等内置函数应进行安全拆箱，防止生成 x.len 或 x.trim_space() 编译失败。

function test_strlen_safety($val) {
    // $val 在入参时是 PhpVal
    // 在这里由于赋值被推导为 string
    $val = "hello"; 
    // 调用 strlen() 和 trim() 时，由于 $val 是包装类型，应转为 (var_val).str().len
    if (strlen($val) > 0) {
        $val = trim($val);
    }
    return $val;
}
