<?php
// 验证 eval 逃生通道
eval("echo 'eval works\n';");

// 验证通用内置函数动态桥接 (V 侧未实现 strlen 之外的其他字符串及加密函数)
$md5_res = md5("hello");
echo $md5_res;
echo "\n";

$json_res = json_encode([1, 2, 3]);
echo $json_res;
echo "\n";
