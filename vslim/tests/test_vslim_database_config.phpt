--TEST--
VSlim app database manager uses config defaults
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->loadConfigText(<<<TOML
[database]
driver = "mysql"
pool_size = 9

[database.mysql]
host = "db.internal"
port = 3307
username = "demo"
password = "secret"
database = "vslim_demo"
TOML);

$db = $app->database();
$dbAlias = $app->db();
$cfg = $db->config();
$fromContainer = $app->container()->get('database');

echo $db->driver() . PHP_EOL;
echo $db->poolSize() . PHP_EOL;
echo ($db->isConnected() ? 'connected' : 'not-connected') . PHP_EOL;
echo $cfg->host() . ':' . $cfg->port() . PHP_EOL;
echo $cfg->username() . '|' . $cfg->database() . PHP_EOL;
echo ($fromContainer === $db ? 'same' : 'diff') . PHP_EOL;
echo ($dbAlias === $db ? 'same' : 'diff') . PHP_EOL;
echo $db->affectedRows() . PHP_EOL;
echo $db->lastInsertId() . PHP_EOL;

foreach (['setTimeoutMs' => ['timeoutMs', 'int'], 'setUpstreamSocket' => ['socketPath', 'string']] as $method => [$name, $type]) {
    $signature = new ReflectionMethod(VSlim\Database\Config::class, $method);
    $parameter = $signature->getParameters()[0];
    if ($signature->getNumberOfRequiredParameters() !== 1 || $parameter->getName() !== $name
        || (string) $parameter->getType() !== $type || (string) $signature->getReturnType() !== VSlim\Database\Config::class) {
        throw new RuntimeException("Unexpected database config signature for $method");
    }
}
$defaults = new VSlim\Database\Config();
if ($defaults->timeoutMs() !== 1000 || $defaults->setTimeoutMs(timeoutMs: 0)->timeoutMs() !== 1000
    || $defaults->setUpstreamSocket(socketPath: ' /tmp/db.sock ')->upstreamSocket() !== '/tmp/db.sock') {
    throw new RuntimeException('Unexpected database config defaults or normalization');
}
$bad = (new VSlim\Database\Manager())
    ->setConfig(config: $defaults->setDriver(driver: 'sqlite'));
$customApp = (new VSlim\App())->setDatabase(database: $bad);
if (!$customApp->hasDatabase() || $customApp->db() !== $bad || $customApp->container()->get('database') !== $bad) {
    throw new RuntimeException('Expected a shared database manager');
}

foreach (['query', 'execute', 'queryParams', 'executeParams', 'beginTransaction'] as $method) {
    try {
        if ($method === 'beginTransaction') {
            $bad->$method();
        } elseif (str_ends_with($method, 'Params')) {
            $bad->$method(params: ['1'], query: 'select ?');
        } else {
            $bad->$method('select 1');
        }
        echo "no-exception\n";
    } catch (RuntimeException $e) {
        echo $method . ':' . str_contains($e->getMessage(), 'not supported yet') . PHP_EOL;
    }
}
?>
--EXPECT--
mysql
9
not-connected
db.internal:3307
demo|vslim_demo
same
same
0
0
query:1
execute:1
queryParams:1
executeParams:1
beginTransaction:1
