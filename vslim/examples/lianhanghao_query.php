<?php
declare(strict_types=1);

function envv(string $key, ?string $default = null): ?string
{
    $value = getenv($key);
    if ($value === false || $value === '') {
        return $default;
    }
    return $value;
}

function usage(): void
{
    fwrite(STDERR, <<<TXT
Usage:
  php -d extension=./vslim.so vslim/examples/lianhanghao_query.php <mode> <keyword> [limit]

Modes:
  cnaps   Exact match by cnaps
  bank    Fuzzy match by bank
  name    Fuzzy match by name
  city    Fuzzy match by city

Examples:
  php -d extension=./vslim.so vslim/examples/lianhanghao_query.php cnaps 102100099996
  php -d extension=./vslim.so vslim/examples/lianhanghao_query.php bank 招商 5
  php -d extension=./vslim.so vslim/examples/lianhanghao_query.php city 深圳 10

Environment:
  DB_TRANSPORT        direct | vhttpd_upstream   (default: vhttpd_upstream)
  DB_HOST             direct mysql host          (default: 127.0.0.1)
  DB_PORT             direct mysql port          (default: 3306)
  DB_USERNAME         direct mysql username      (default: root)
  DB_PASSWORD         direct mysql password      (default: empty)
  DB_NAME             direct mysql database      (default: kaikuhang)
  DB_UPSTREAM_SOCKET  upstream socket fallback
  VHTTPD_DB_SOCKET    injected by vhttpd worker

TXT);
}

$mode = $argv[1] ?? '';
$keyword = $argv[2] ?? '';
$limit = max(1, min(50, (int)($argv[3] ?? '10')));

if ($mode === '' || $keyword === '') {
    usage();
    exit(1);
}

$transport = envv('DB_TRANSPORT', 'vhttpd_upstream');
$socket = envv('VHTTPD_DB_SOCKET', envv('DB_UPSTREAM_SOCKET', '/tmp/vhttpd_db.sock'));
$host = envv('DB_HOST', '127.0.0.1');
$port = (int)envv('DB_PORT', '3306');
$username = envv('DB_USERNAME', 'root');
$password = envv('DB_PASSWORD', '');
$database = envv('DB_NAME', 'kaikuhang');

/** @var VSlim\App $app */
$app = VSlim\App::demo();
$app->loadConfigText(<<<TOML
[database]
driver = "mysql"
transport = "{$transport}"
timeout_ms = 1000
pool_name = "default"

[database.mysql]
host = "{$host}"
port = {$port}
username = "{$username}"
password = "{$password}"
database = "{$database}"

[database.upstream]
socket = "{$socket}"
TOML);

$db = $app->db();
$cfg = $db->config();

echo 'transport=' . $cfg->transport() . PHP_EOL;
echo 'database=' . $cfg->database() . PHP_EOL;
if ($cfg->transport() === 'vhttpd_upstream') {
    echo 'socket=' . $cfg->upstreamSocket() . PHP_EOL;
}

if (!$db->connect()) {
    fwrite(STDERR, 'connect_failed=' . $db->lastError() . PHP_EOL);
    exit(2);
}

$query = $db->table('lianhanghao')->select([
    'id',
    'cnaps',
    'name',
    'bank',
    'bank_en',
    'provi',
    'city',
    'area',
    'bank_address',
]);

switch ($mode) {
    case 'cnaps':
        $result = $query->where('cnaps', $keyword)->first();
        break;
    case 'bank':
        $result = $query->whereOp('bank', 'LIKE', '%' . $keyword . '%')
            ->orderBy('id', 'asc')
            ->limit($limit)
            ->get();
        break;
    case 'name':
        $result = $query->whereOp('name', 'LIKE', '%' . $keyword . '%')
            ->orderBy('id', 'asc')
            ->limit($limit)
            ->get();
        break;
    case 'city':
        $result = $query->whereOp('city', 'LIKE', '%' . $keyword . '%')
            ->orderBy('id', 'asc')
            ->limit($limit)
            ->get();
        break;
    default:
        fwrite(STDERR, "unsupported_mode={$mode}\n");
        usage();
        exit(3);
}

echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT) . PHP_EOL;
