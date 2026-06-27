<?php
$list = [10, 20];
$list[] = 30;
echo count($list);
echo "\n";
foreach ($list as $item) {
    echo $item;
    echo "\n";
}

$map = ["a" => "hello", "b" => "world"];
echo $map["a"];
echo "\n";
echo count($map);
echo "\n";
foreach ($map as $k => $v) {
    echo $k;
    echo ":";
    echo $v;
    echo "\n";
}
