--TEST--
VSlim binary bundle can load direct mysql database surface
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->load_config_text(<<<TOML
[database]
driver = "mysql"
pool_size = 3

[database.mysql]
host = "127.0.0.1"
port = 3306
username = "bundle"
password = "bundle"
database = "bundle_demo"
TOML);

$db = $app->database();
$cfg = $db->config();

echo $db->driver() . PHP_EOL;
echo $db->poolSize() . PHP_EOL;
echo ($db->is_connected() ? 'connected' : 'not-connected') . PHP_EOL;
echo $cfg->host() . ':' . $cfg->port() . PHP_EOL;
echo $cfg->username() . '|' . $cfg->database() . PHP_EOL;
echo $db->transport() . PHP_EOL;
?>
--EXPECT--
mysql
3
not-connected
127.0.0.1:3306
bundle|bundle_demo
direct
