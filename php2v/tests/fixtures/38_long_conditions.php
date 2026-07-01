<?php
// 测试：长条件表达式（多部分 && / || 组合）
// 源自 WordPress register_block_type 中 is_string($x) && file_exists($x) 等长条件

function validate_and_process($block_type) {
    if (is_string($block_type) && file_exists($block_type)) {
        return 'from_file';
    }

    if (!is_string($block_type) || !file_exists($block_type)) {
        return false;
    }

    return true;
}

function complex_condition($a, $b, $c) {
    if ($a > 0 && $b > 0 && $c > 0) {
        return 'all_positive';
    } elseif ($a == 0 || $b == 0 || $c == 0) {
        return 'has_zero';
    } else {
        return 'mixed';
    }
}
