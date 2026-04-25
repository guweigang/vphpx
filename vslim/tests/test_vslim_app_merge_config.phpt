--TEST--
VSlim App can merge config overlays into shared config repository
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();

$app->loadConfigText(<<<TOML
[app]
name = "base"

[cache]
prefix = "base"
TOML);

$app->mergeConfigText(<<<TOML
[cache]
prefix = "overlay"
default_ttl_seconds = 30
TOML);

echo $app->config()->getString('app.name', 'x') . PHP_EOL;
echo $app->config()->getString('cache.prefix', 'x') . PHP_EOL;
echo $app->config()->getInt('cache.default_ttl_seconds', 0) . PHP_EOL;
echo $app->cache()->namespace() . PHP_EOL;
echo $app->cache()->defaultTtlSeconds() . PHP_EOL;
?>
--EXPECT--
base
overlay
30
overlay
30
