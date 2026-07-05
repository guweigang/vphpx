<?php

// 1. 数组参数包装测试：虽然在函数中推导为数组，但其仍为 PhpVal，取值赋值不应直接生成原生 V 索引
function test_array_param($response) {
    $response['result'] = true;
    return $response;
}

// 2. 原生 Map 变量的 isset 转换测试
function test_native_isset() {
    $local_map = array();
    $local_map['key'] = 'val';
    // 应该翻译为: 'key' in var_local_map
    if (isset($local_map['key'])) {
        echo "isset ok\n";
    }
}

// 3. 嵌套 Map 字面量自动装箱测试
function test_nested_map() {
    $nested = array(
        'type' => 'test',
        'attributes' => array() // 应该被自动包装为 rt.PhpVal
    );
    return $nested;
}

test_array_param(array());
test_native_isset();
test_nested_map();
