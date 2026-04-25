--TEST--
VSlim App integrates shared Config instance
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
echo ($app->hasConfig() ? 'has' : 'no') . PHP_EOL;

$app->loadConfigText(<<<TOML
[app]
name = "demo"
port = 19888
debug = true

[db]
hosts = ["a", "b"]
TOML);

echo ($app->hasConfig() ? 'has' : 'no') . PHP_EOL;

$cfg = $app->config();
echo $cfg->getString('app.name', 'x') . PHP_EOL;
echo $cfg->getInt('app.port', 0) . PHP_EOL;
echo ($cfg->getBool('app.debug', false) ? 'debug-on' : 'debug-off') . PHP_EOL;
$hosts = $cfg->getList('db.hosts');
echo count($hosts) . ':' . $hosts[0] . ':' . $hosts[1] . PHP_EOL;

$cfgFromContainer = $app->container()->get('config');
echo get_class($cfgFromContainer) . PHP_EOL;
echo $cfgFromContainer->getString('app.name', 'x') . PHP_EOL;
?>
--EXPECT--
no
has
demo
19888
debug-on
2:a:b
VSlim\Config
demo
