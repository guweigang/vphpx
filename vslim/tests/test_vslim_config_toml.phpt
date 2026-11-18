--TEST--
VSlim Config loads TOML and exposes typed/mixed accessors
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$path = sys_get_temp_dir() . '/vslim_config_' . getmypid() . '.toml';
file_put_contents($path, <<<TOML
[app]
name = "demo"
debug = true
port = 19888
ratio = 1.5

[db]
hosts = ["db1", "db2"]
TOML);

$cfg = new VSlim\Config();
$cfg->load(path: $path);

echo ($cfg->isLoaded() ? 'loaded' : 'not-loaded') . PHP_EOL;
echo ($cfg->path() === $path ? 'path-ok' : 'path-bad') . PHP_EOL;
echo ($cfg->has('app.name') ? 'has-name' : 'no-name') . PHP_EOL;
echo $cfg->getString('app.name', 'x') . PHP_EOL;
echo $cfg->getInt('app.port', 0) . PHP_EOL;
echo ($cfg->getBool('app.debug', false) ? 'debug-on' : 'debug-off') . PHP_EOL;
$getBool = new ReflectionMethod($cfg, 'getBool');
$defaultValue = $getBool->getParameters()[1];
var_dump($getBool->getNumberOfRequiredParameters(), $defaultValue->getName(), (string) $defaultValue->getType());
var_dump($defaultValue->isOptional(), $defaultValue->getDefaultValue());
var_dump($cfg->getBool(defaultValue: true, key: 'missing.key'), $cfg->getBool('missing.key'));
echo $cfg->getFloat('app.ratio', 0.0) . PHP_EOL;
echo $cfg->getJson('missing.key', '"fallback"') . PHP_EOL;

foreach ([
    'getInt' => ['int', 0, 37],
    'getFloat' => ['float', 0.0, 2.5],
    'get' => ['mixed', null, ['fallback' => 1]],
    'getMap' => ['mixed', [], ['fallback' => 2]],
    'getList' => ['mixed', [], ['first', 'second']],
] as $method => [$type, $default, $custom]) {
    $signature = new ReflectionMethod($cfg, $method);
    $parameter = $signature->getParameters()[1];
    if ($signature->getNumberOfRequiredParameters() !== 1 || (string) $signature->getReturnType() !== $type
        || $parameter->getName() !== 'defaultValue' || (string) $parameter->getType() !== $type
        || !$parameter->isOptional() || $parameter->getDefaultValue() !== $default
        || $cfg->$method('missing.key') !== $default || $cfg->$method(key: 'missing.key') !== $default
        || $cfg->$method(defaultValue: $custom, key: 'missing.key') !== $custom) {
        throw new RuntimeException("Unexpected default or signature for $method");
    }
}
if ($cfg->get(defaultValue: null, key: 'missing.key') !== null
    || $cfg->getMap(defaultValue: null, key: 'missing.key') !== []
    || $cfg->getList(defaultValue: null, key: 'missing.key') !== []) {
    throw new RuntimeException('Unexpected behavior for an explicit null default');
}

$hosts = json_decode($cfg->getJson('db.hosts', '[]'), true);
echo count($hosts) . ':' . $hosts[0] . ':' . $hosts[1] . PHP_EOL;

$all = json_decode($cfg->allJson(), true);
echo $all['app']['name'] . ':' . $all['app']['port'] . PHP_EOL;

$name = $cfg->get('app.name');
echo (is_string($name) ? $name : 'bad') . PHP_EOL;

$missing = $cfg->get('missing.key');
echo (is_null($missing) ? 'null' : 'not-null') . PHP_EOL;

$fallback = $cfg->get('missing.key', ['x' => 1]);
echo ($fallback['x'] ?? -1) . PHP_EOL;

$app = $cfg->getMap('app');
echo $app['name'] . ':' . $app['port'] . ':' . ($app['debug'] ? '1' : '0') . PHP_EOL;

$hostList = $cfg->getList('db.hosts');
echo count($hostList) . ':' . $hostList[0] . ':' . $hostList[1] . PHP_EOL;

$fallbackMap = $cfg->getMap('missing.map', ['d' => 9]);
echo ($fallbackMap['d'] ?? -1) . PHP_EOL;

$fallbackList = $cfg->getList('missing.list', ['x', 'y']);
echo count($fallbackList) . ':' . $fallbackList[0] . ':' . $fallbackList[1] . PHP_EOL;

$wrongTypeMap = $cfg->getMap('app.name', ['z' => 7]);
echo ($wrongTypeMap['z'] ?? -1) . PHP_EOL;

$wrongTypeList = $cfg->getList('app.name', ['m']);
echo count($wrongTypeList) . ':' . $wrongTypeList[0] . PHP_EOL;

unlink($path);
?>
--EXPECT--
loaded
path-ok
has-name
demo
19888
debug-on
int(1)
string(12) "defaultValue"
string(4) "bool"
bool(true)
bool(false)
bool(true)
bool(false)
1.5
"fallback"
2:db1:db2
demo:19888
demo
null
1
demo:19888:1
2:db1:db2
9
2:x:y
7
1:m
