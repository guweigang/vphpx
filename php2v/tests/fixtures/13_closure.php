<?php
$x = 10;

// 测试普通闭包和外部捕获
$cb = function($y) use ($x) {
    return $x + $y;
};
echo $cb(5);
echo "\n";

// 测试箭头函数和隐式捕获
$fn = fn($z) => $z * $x;
echo $fn(3);
echo "\n";
