--TEST--
VSlim database manager routes query execute and transaction calls through vhttpd_upstream
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (!function_exists('proc_open')) print "skip";
$probe = '/tmp/vslim_db_upstream_probe_' . getmypid() . '.sock';
@unlink($probe);
$errno = 0;
$errstr = '';
$server = @stream_socket_server('unix://' . $probe, $errno, $errstr);
if (!is_resource($server)) {
    print 'skip';
}
if (is_resource($server)) {
    fclose($server);
}
if (is_file($probe)) {
    @unlink($probe);
}
?>
--FILE--
<?php
$tmp = '/tmp/vslim_db_upstream_' . getmypid() . '_' . random_int(1000, 9999);
@mkdir($tmp, 0777, true);
$sock = $tmp . '/db.sock';
$serverScript = $tmp . '/server.php';
$stdoutLog = $tmp . '/server.out';
$stderrLog = $tmp . '/server.err';

$serverPhp = <<<'PHP'
<?php
$socketPath = $argv[1] ?? '';
$requestsPath = $argv[2] ?? '';
@unlink($socketPath);
$errno = 0;
$errstr = '';
$server = stream_socket_server('unix://' . $socketPath, $errno, $errstr);
if (!is_resource($server)) {
    fwrite(STDERR, "bind_failed:$errstr:$errno\n");
    exit(2);
}

$readExactly = static function ($conn, int $len): ?string {
    $buf = '';
    while (strlen($buf) < $len) {
        $chunk = fread($conn, $len - strlen($buf));
        if ($chunk === '' || $chunk === false) {
            return null;
        }
        $buf .= $chunk;
    }
    return $buf;
};

$readFrame = static function ($conn) use ($readExactly): ?string {
    $header = $readExactly($conn, 4);
    if ($header === null) {
        return null;
    }
    $len = unpack('Nlen', $header);
    $size = (int) ($len['len'] ?? 0);
    if ($size <= 0) {
        return null;
    }
    return $readExactly($conn, $size);
};

$writeFrame = static function ($conn, string $payload): void {
    fwrite($conn, pack('N', strlen($payload)) . $payload);
};

$requests = [];
$sessionId = '';
$maxRequests = 7;
for ($i = 0; $i < $maxRequests; $i++) {
    $conn = stream_socket_accept($server, 5.0);
    if (!is_resource($conn)) {
        fwrite(STDERR, "accept_timeout:$i\n");
        exit(3);
    }
    stream_set_timeout($conn, 0, 150000);
    $rawRequest = $readFrame($conn);
    $request = is_string($rawRequest) ? json_decode($rawRequest, true) : null;
    if (!is_array($request)) {
        fclose($conn);
        continue;
    }
    $requests[] = $request;
    $op = (string) ($request['op'] ?? '');
    $reqSessionId = (string) ($request['session_id'] ?? '');
    $pool = (string) ($request['pool'] ?? '');
    $sql = (string) ($request['sql'] ?? '');
    $params = array_map('strval', (array) ($request['params'] ?? []));
    $response = ['ok' => true];

    if ($op === 'ping') {
        $response['pong'] = true;
    } elseif ($op === 'begin_transaction') {
        $sessionId = 'tx-1';
        $response['session_id'] = $sessionId;
    } elseif ($op === 'commit' || $op === 'rollback') {
        $response['session_id'] = $sessionId;
        $sessionId = '';
    } elseif ($op === 'query') {
        $response['rows'] = [[
            'pool' => $pool,
            'session_id' => $reqSessionId,
            'sql' => $sql,
            'params' => implode(',', $params),
        ]];
        $response['affected_rows'] = 0;
        $response['last_insert_id'] = 0;
        if ($sessionId !== '') {
            $response['session_id'] = $sessionId;
        }
    } elseif ($op === 'execute') {
        $response['affected_rows'] = 1;
        $response['last_insert_id'] = 42;
        if ($sessionId !== '') {
            $response['session_id'] = $sessionId;
        }
    } else {
        $response = [
            'ok' => false,
            'error' => [
                'message' => 'unsupported_op',
            ],
        ];
    }

    $writeFrame($conn, json_encode($response, JSON_UNESCAPED_UNICODE));
    fclose($conn);
}

file_put_contents($requestsPath, json_encode($requests, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
fclose($server);
?>
PHP;
file_put_contents($serverScript, $serverPhp);

$requestsPath = $tmp . '/requests.json';
$cmd = sprintf(
    'php %s %s %s',
    escapeshellarg($serverScript),
    escapeshellarg($sock),
    escapeshellarg($requestsPath),
);
$spec = [
    0 => ['pipe', 'r'],
    1 => ['file', $stdoutLog, 'a'],
    2 => ['file', $stderrLog, 'a'],
];
$proc = proc_open($cmd, $spec, $pipes);
if (!is_resource($proc)) {
    throw new RuntimeException('proc_open_failed');
}
foreach ($pipes as $pipe) {
    if (is_resource($pipe)) {
        fclose($pipe);
    }
}

$deadline = microtime(true) + 3.0;
while (microtime(true) < $deadline) {
    clearstatcache(true, $sock);
    if (is_file($sock)) {
        break;
    }
    usleep(20000);
}

$app = VSlim\App::demo();
$app->load_config_text(<<<TOML
[database]
driver = "mysql"
transport = "vhttpd_upstream"
pool_name = "analytics"
timeout_ms = 1800

[database.upstream]
socket = "{$sock}"
TOML);

$db = $app->database();
echo ($db->connect() ? 'connected' : 'not-connected') . PHP_EOL;

$rows = $db->queryParams('SELECT * FROM users WHERE id = ? AND name = ?', ['7', 'alice']);
echo $rows[0]['pool'] . '|' . $rows[0]['session_id'] . '|' . $rows[0]['params'] . PHP_EOL;

echo ($db->beginTransaction() ? 'tx-begin' : 'tx-fail') . PHP_EOL;
$rows = $db->query('SELECT * FROM tx_users');
echo $rows[0]['session_id'] . '|' . $rows[0]['sql'] . PHP_EOL;

$meta = $db->executeParams('UPDATE users SET name = ? WHERE id = ?', ['bob', '7']);
echo $db->affectedRows() . '|' . $db->lastInsertId() . '|' . $meta['affected_rows'] . PHP_EOL;

echo ($db->commit() ? 'tx-commit' : 'tx-commit-fail') . PHP_EOL;
$rows = $db->query('SELECT * FROM after_commit');
echo $rows[0]['session_id'] . '|' . $rows[0]['sql'] . PHP_EOL;

$deadline = microtime(true) + 3.0;
while (microtime(true) < $deadline) {
    $status = proc_get_status($proc);
    if (($status['running'] ?? false) === false) {
        break;
    }
    usleep(20000);
}
$status = proc_get_status($proc);
if (($status['running'] ?? false) === true) {
    proc_terminate($proc);
}
proc_close($proc);

$requests = json_decode((string) @file_get_contents($requestsPath), true) ?: [];
echo count($requests) . PHP_EOL;
echo implode(',', array_column($requests, 'op')) . PHP_EOL;
echo (($requests[3]['session_id'] ?? '') ?: 'none') . PHP_EOL;
echo (($requests[4]['session_id'] ?? '') ?: 'none') . PHP_EOL;
echo (($requests[6]['session_id'] ?? '') ?: 'none') . PHP_EOL;
?>
--EXPECT--
connected
analytics||7,alice
tx-begin
tx-1|SELECT * FROM tx_users
1|42|1
tx-commit
|SELECT * FROM after_commit
7
ping,query,begin_transaction,query,execute,commit,query
tx-1
tx-1
none
