<?php
// 回归测试：无 MethodInfo (回退情况) 时，如果调用自定义函数
// 的实参在调用方是原生类型 (如 string)，它应该在调用时被自动装箱为 rt.PhpVal

function test_mysql2date(string $format, $var_date) {
    // 这里 test_wp_date 形参是 PhpVal
    // $format 在这里是原生 string，必须自动装箱为 rt.new_string(format)
    return test_wp_date($format, $var_date);
}

function test_wp_date($format, $timestamp) {
    return $format;
}
