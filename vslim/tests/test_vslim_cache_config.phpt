--TEST--
VSlim app cache services use config defaults
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$cfg = <<<'TOML'
[cache]
prefix = 'cfg-cache'
default_ttl_seconds = 5

[cache.pool]
prefix = 'cfg-pool'
default_ttl_seconds = 7
TOML;

$app = new VSlim\App();
$app->load_config_text($cfg);

$cache = $app->cache();
echo $cache->namespace(), "\n";
echo $cache->defaultTtlSeconds(), "\n";

$pool = $app->cachePool();
echo $pool->namespace(), "\n";
echo $pool->defaultTtlSeconds(), "\n";
?>
--EXPECT--
cfg-cache
5
cfg-pool
7
