--TEST--
VSlim app template public entry can dispatch requests from PHP globals
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$script = realpath(__DIR__ . '/../templates/app/public/index.php');
$server = $_SERVER;
$cookies = $_COOKIE;

$_SERVER['SCRIPT_FILENAME'] = $script;
$_SERVER['REQUEST_METHOD'] = 'GET';
$_SERVER['REQUEST_URI'] = '/health';
$_SERVER['HTTP_HOST'] = 'template.local';
$_SERVER['REMOTE_ADDR'] = '127.0.0.1';
$_COOKIE = [];

ob_start();
include $script;
$health = trim((string) ob_get_clean());
echo $health, PHP_EOL;

$_SERVER = $server;
$_COOKIE = $cookies;
?>
--EXPECT--
ok|vslim-template|provider-ready
