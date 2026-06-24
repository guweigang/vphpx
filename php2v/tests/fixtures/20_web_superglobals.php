<?php
$_GET['test_key'] = 'hello';
echo "GET test_key: " . $_GET['test_key'] . "\n";

if (isset($_GET['name'])) {
    echo "GET name: " . $_GET['name'] . "\n";
}

$_SERVER['HTTP_HOST'] = 'localhost';
echo "SERVER HOST: " . $_SERVER['HTTP_HOST'] . "\n";
