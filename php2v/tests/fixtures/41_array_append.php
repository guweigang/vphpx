<?php
// 回归测试：向被推断为 []rt.PhpVal 原生数组追加原生标量 (如 string) 时，
// 应自动进行 PhpVal 装箱，避免编译失败。

function test_array_append($val) {
    $arr = []; // 会被声明为 []rt.PhpVal
    $arr[] = '<option>' . $val . '</option>'; // 右侧是原生 string 的加法连接，需要自动装箱
    return $arr;
}
