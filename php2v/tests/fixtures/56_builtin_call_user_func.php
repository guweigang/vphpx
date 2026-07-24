<?php

function my_test_func($a, $b) {
    return $a + $b;
}

class TestClass {
    public static function my_static($a, $b) {
        return $a * $b;
    }
    public function my_method($a, $b) {
        return $a - $b;
    }
}

// 1. call_user_func with global function
echo call_user_func('my_test_func', 10, 20) . "\n";

// 2. call_user_func_array with global function
echo call_user_func_array('my_test_func', [15, 25]) . "\n";

// 3. call_user_func with static method (array format)
echo call_user_func(['TestClass', 'my_static'], 5, 6) . "\n";

// 4. call_user_func with static method (string format)
echo call_user_func('TestClass::my_static', 7, 8) . "\n";

// 5. call_user_func with object method
$obj = new TestClass();
echo call_user_func([$obj, 'my_method'], 50, 20) . "\n";

// 6. call_user_func_array with object method
echo call_user_func_array([$obj, 'my_method'], [100, 40]) . "\n";
