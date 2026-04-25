--TEST--
VSlim Config loads and merges config directory TOML files
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$dir = sys_get_temp_dir() . '/vslim-config-' . uniqid();
mkdir($dir);

file_put_contents($dir . '/app.toml', <<<TOML
[app]
name = "dir-demo"
env = "test"

[http]
host = "127.0.0.1"
TOML);

file_put_contents($dir . '/http.toml', <<<TOML
[http]
port = 20880

[app]
debug = true
TOML);

file_put_contents($dir . '/stream.toml', <<<TOML
[stream]
driver = "sse"
TOML);

$cfg = new VSlim\Config();
$cfg->load($dir);

echo $cfg->getString('app.name', 'x') . PHP_EOL;
echo $cfg->getString('app.env', 'x') . PHP_EOL;
echo ($cfg->getBool('app.debug', false) ? 'debug-on' : 'debug-off') . PHP_EOL;
echo $cfg->getString('http.host', 'x') . ':' . $cfg->getInt('http.port', 0) . PHP_EOL;
echo $cfg->getString('stream.driver', 'x') . PHP_EOL;
?>
--EXPECT--
dir-demo
test
debug-on
127.0.0.1:20880
sse
