<?php
$a = 10;
$b = null;
$c = 20;

// 1. 标准三元
echo ($a > 5 ? "gt" : "lt") . "\n";
echo ($a < 5 ? "gt" : "lt") . "\n";

// 2. 简写三元
$res1 = $a ?: 15;
echo "res1: " . $res1 . "\n";

$res2 = 0 ?: 15;
echo "res2: " . $res2 . "\n";

// 3. 空接合
$res3 = $b ?? 100;
echo "res3: " . $res3 . "\n";

$res4 = $c ?? 100;
echo "res4: " . $res4 . "\n";
