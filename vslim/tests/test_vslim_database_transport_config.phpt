--TEST--
VSlim database manager recognizes transport config and reserves vhttpd_upstream
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->load_config_text(<<<TOML
[database]
driver = "mysql"
transport = "vhttpd_upstream"
pool_name = "analytics"
timeout_ms = 1800

[database.upstream]
socket = "/tmp/vhttpd-db.sock"
TOML);

$db = $app->database();
$cfg = $db->config();
$client = $db->vhttpdClient();

echo $db->driver() . PHP_EOL;
echo $db->transport() . PHP_EOL;
echo $cfg->poolName() . PHP_EOL;
echo $cfg->timeoutMs() . PHP_EOL;
echo $cfg->upstreamSocket() . PHP_EOL;
echo $client->socketPath() . '|' . $client->connectTimeoutSeconds() . PHP_EOL;

try {
    $db->connect();
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'connect_failed') ? "connect_failed\n" : "unexpected\n";
}
?>
--EXPECT--
mysql
vhttpd_upstream
analytics
1800
/tmp/vhttpd-db.sock
/tmp/vhttpd-db.sock|1.8
connect_failed
