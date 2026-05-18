--TEST--
VSlim Config can merge text and files into one repository
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$dir = sys_get_temp_dir() . '/vslim-config-merge-' . uniqid();
mkdir($dir);

file_put_contents($dir . '/logging.toml', <<<TOML
[logging]
channel = "file"
target = "stdout"
TOML);

$cfg = new VSlim\Config();
$cfg->loadText(<<<TOML
[app]
name = "base"
debug = false
TOML);

$cfg->mergeText(<<<TOML
[app]
debug = true
TOML);

$cfg->mergeFile($dir . '/logging.toml');

echo $cfg->getString('app.name', 'x') . PHP_EOL;
echo ($cfg->getBool('app.debug', false) ? 'debug-on' : 'debug-off') . PHP_EOL;
echo $cfg->getString('logging.channel', 'x') . PHP_EOL;
echo $cfg->getString('logging.target', 'x') . PHP_EOL;
?>
--EXPECT--
base
debug-on
file
stdout
