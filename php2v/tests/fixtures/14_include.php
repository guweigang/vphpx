<?php
// 动态拼接路径，测试变量路径支持
$path = 'tests/fixtures/14_included.inc';

// 测试 include 并捕获返回值
$ret = include $path;
echo $ret;
echo "\n";

// 测试 include_once 不会再次执行（测试去重）
$ret2 = include_once $path;
echo "once_done\n";
