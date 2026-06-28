<?php

class Calculator {
    public function add($a, $b) {
        return $a + $b;
    }
}

function my_strlen($s) {
    return strlen($s);
}

// 1. 动态函数调用
$func = 'my_strlen';
echo $func("hello");
echo "\n";

// 2. 动态实例化类
$cls = 'Calculator';
$calc = new $cls();

// 3. 动态方法调用
$meth = 'add';
echo $calc->$meth(10, 20);
echo "\n";
