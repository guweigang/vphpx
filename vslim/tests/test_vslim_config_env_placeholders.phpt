--TEST--
VSlim Config resolves shell-style env placeholders with typed variants
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
putenv('VSLIM_CFG_APP_NAME=EnvDemo');
putenv('VSLIM_CFG_APP_DEBUG=on');
putenv('VSLIM_CFG_HTTP_PORT=20999');
putenv('VSLIM_CFG_APP_RATIO=2.75');
putenv('VSLIM_CFG_EMPTY=');
putenv('VSLIM_CFG_HOST1=db-a');
putenv('VSLIM_CFG_HOST2=db-b');

$cfg = new VSlim\Config();
$cfg->loadText(<<<'TOML'
[app]
name = "${env.VSLIM_CFG_APP_NAME:-VSlim}"
debug = "${env.bool.VSLIM_CFG_APP_DEBUG:-false}"
port = "${env.int.VSLIM_CFG_HTTP_PORT:-8080}"
ratio = "${env.float.VSLIM_CFG_APP_RATIO:-1.5}"
fallback = "${env.VSLIM_CFG_EMPTY:-fallback}"
missing = "${env.VSLIM_CFG_MISSING}"

[db]
hosts = ["${env.VSLIM_CFG_HOST1:-127.0.0.1}", "${env.VSLIM_CFG_HOST2:-127.0.0.2}"]
TOML);

echo $cfg->getString('app.name', 'x') . PHP_EOL;
echo ($cfg->getBool('app.debug', false) ? 'debug-on' : 'debug-off') . PHP_EOL;
echo $cfg->getInt('app.port', 0) . PHP_EOL;
echo $cfg->getFloat('app.ratio', 0.0) . PHP_EOL;
echo $cfg->getString('app.fallback', 'x') . PHP_EOL;
echo ($cfg->has('app.missing') ? 'has' : 'no') . PHP_EOL;
echo $cfg->getString('app.missing', 'n/a') . PHP_EOL;
$hosts = $cfg->getList('db.hosts');
echo count($hosts) . ':' . $hosts[0] . ':' . $hosts[1] . PHP_EOL;
?>
--EXPECT--
EnvDemo
debug-on
20999
2.75
fallback
no
n/a
2:db-a:db-b
