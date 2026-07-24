<?php
$val = "123";
$int_val = (int)$val;
$double_val = (double)$val;
$bool_val = (bool)$val;
$string_val = (string)$int_val;
$arr_val = (array)$val;
$obj_val = (object)$val;

echo $int_val;
echo $double_val;
echo $bool_val;
echo $string_val;
