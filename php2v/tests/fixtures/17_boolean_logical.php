<?php
function log_true($msg) {
    echo $msg . "\n";
    return true;
}
function log_false($msg) {
    echo $msg . "\n";
    return false;
}

// 1. !
echo "!true: " . (!log_true("t1") ? "yes" : "no") . "\n";
echo "!false: " . (!log_false("f1") ? "yes" : "no") . "\n";

// 2. && 短路
echo "&& test 1:\n";
$res1 = log_false("left_false") && log_true("right_true"); // 右侧不应该执行！
echo "result: " . ($res1 ? "true" : "false") . "\n";

// 3. || 短路
echo "|| test 1:\n";
$res3 = log_true("left_true") || log_true("right_true"); // 右侧不应该执行！
echo "result: " . ($res3 ? "true" : "false") . "\n";
