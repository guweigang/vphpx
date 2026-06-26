<?php
$a = 5;

// 测试后置自增
$b = $a++;
echo "b is " . $b . ", a is " . $a . "\n";

// 测试后置自减
$c = $a--;
echo "c is " . $c . ", a is " . $a . "\n";

// 测试前置自增
$d = ++$a;
echo "d is " . $d . ", a is " . $a . "\n";

// 测试前置自减
$e = --$a;
echo "e is " . $e . ", a is " . $a . "\n";
