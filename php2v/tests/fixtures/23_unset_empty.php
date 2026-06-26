<?php
$a = "";
$b = 0;
$c = null;
$d = "hello";

echo empty($a) ? "a is empty\n" : "a is not empty\n";
echo empty($b) ? "b is empty\n" : "b is not empty\n";
echo empty($c) ? "c is empty\n" : "c is not empty\n";
echo empty($d) ? "d is empty\n" : "d is not empty\n";
echo empty($not_exist) ? "not_exist is empty\n" : "not_exist is not empty\n";

$arr = array("key" => "value", "key2" => "value2");
echo empty($arr["key"]) ? "key is empty\n" : "key is not empty\n";
echo empty($arr["not_exist"]) ? "not_exist key is empty\n" : "not_exist key is not empty\n";

unset($d);
echo empty($d) ? "d is empty after unset\n" : "d is not empty after unset\n";

unset($arr["key"]);
echo empty($arr["key"]) ? "key is empty after unset\n" : "key is not empty after unset\n";
