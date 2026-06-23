<?php
$arr = ["a" => 10, "b" => 20];

foreach ($arr as $val) {
    echo $val;
    echo "\n";
}

foreach ($arr as $key => $val) {
    echo $key;
    echo ":";
    echo $val;
    echo "\n";
}
