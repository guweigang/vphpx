<?php
declare(strict_types=1);

use VSlim\Config;

$configPath = __DIR__ . '/config_usage.toml';

$cfg = new Config();
$cfg->load($configPath);

echo "== typed ==\n";
echo "app.name: " . $cfg->getString('app.name', 'n/a') . PHP_EOL;
echo "app.port: " . $cfg->getInt('app.port', 0) . PHP_EOL;
echo "app.debug: " . ($cfg->getBool('app.debug', false) ? 'true' : 'false') . PHP_EOL;
echo "app.ratio: " . $cfg->getFloat('app.ratio', 0.0) . PHP_EOL;
echo "app.env: " . $cfg->getString('app.env', 'n/a') . PHP_EOL;

echo "\n== mixed get ==\n";
echo "feature.flags[0]: " . $cfg->get('feature.flags')[0] . PHP_EOL;
echo "missing (null?): " . (is_null($cfg->get('missing.key')) ? 'null' : 'not-null') . PHP_EOL;
echo "missing with default: " . $cfg->get('missing.key', 'fallback') . PHP_EOL;

echo "\n== map/list ==\n";
$db = $cfg->getMap('db');
echo "db.driver: " . ($db['driver'] ?? 'n/a') . PHP_EOL;
echo "db.hosts count: " . count($cfg->getList('db.hosts')) . PHP_EOL;

$fallbackMap = $cfg->getMap('missing.map', ['driver' => 'sqlite']);
echo "fallback map driver: " . ($fallbackMap['driver'] ?? 'n/a') . PHP_EOL;

$fallbackList = $cfg->getList('missing.list', ['a', 'b']);
echo "fallback list: " . implode(',', $fallbackList) . PHP_EOL;

echo "\n== json bridge ==\n";
echo "all_json: " . $cfg->allJson() . PHP_EOL;
