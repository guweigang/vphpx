<?php
declare(strict_types=1);

$socket = $argv[1] ?? getenv('VHTTPD_DB_SOCKET') ?: '/tmp/vhttpd_db.sock';
$sql = $argv[2] ?? 'select 1 as ok';

/** @var VSlim\App $app */
$app = VSlim\App::demo();
$app->load_config_text(<<<TOML
[database]
driver = "mysql"
transport = "vhttpd_upstream"
pool_name = "default"
timeout_ms = 1000

[database.upstream]
socket = "{$socket}"
TOML);

$db = $app->database();
$cfg = $db->config();

echo "socket={$cfg->upstreamSocket()}\n";
echo "transport={$cfg->transport()}\n";

$connected = $db->connect();
echo 'connect=' . ($connected ? 'true' : 'false') . "\n";

$rows = $db->query($sql);
echo 'query=' . json_encode($rows, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n";

$db->beginTransaction();
$txRows = $db->query('select 2 as tx_ok');
echo 'tx_query=' . json_encode($txRows, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n";
$db->commit();
echo "transaction=committed\n";
