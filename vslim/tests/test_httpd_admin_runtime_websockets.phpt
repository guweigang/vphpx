--TEST--
vhttpd admin websocket runtime endpoint supports summary and detail filters
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) {
    echo "skip vhttpd binary missing";
    return;
}
$probeSock = sys_get_temp_dir() . '/vhttpd_admin_runtime_ws_probe_' . getmypid() . '.sock';
@unlink($probeSock);
$errno = 0;
$errstr = '';
$probe = @stream_socket_server('unix://' . $probeSock, $errno, $errstr);
if (!is_resource($probe)) {
    echo 'skip';
    return;
}
fclose($probe);
@unlink($probeSock);
?>
--FILE--
<?php

function free_port(): int {
    $server = stream_socket_server('tcp://127.0.0.1:0', $errno, $errstr);
    if (!is_resource($server)) {
        throw new RuntimeException("port_probe_failed: {$errstr}");
    }
    $name = stream_socket_get_name($server, false);
    fclose($server);
    $parts = explode(':', (string) $name);
    return (int) end($parts);
}

function ws_handshake(string $host, int $port, string $path): mixed {
    $conn = @stream_socket_client("tcp://{$host}:{$port}", $errno, $errstr, 5.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    $key = base64_encode(random_bytes(16));
    $req = "GET {$path} HTTP/1.1\r\n"
        . "Host: {$host}:{$port}\r\n"
        . "Upgrade: websocket\r\n"
        . "Connection: Upgrade\r\n"
        . "Sec-WebSocket-Key: {$key}\r\n"
        . "Sec-WebSocket-Version: 13\r\n\r\n";
    fwrite($conn, $req);
    $response = '';
    while (!str_contains($response, "\r\n\r\n")) {
        $chunk = fread($conn, 2048);
        if ($chunk === '' || $chunk === false) {
            break;
        }
        $response .= $chunk;
    }
    if (!str_contains($response, "101 Switching Protocols")) {
        throw new RuntimeException("handshake_failed: {$response}");
    }
    return $conn;
}

function ws_read_frame($conn): ?array {
    $h = fread($conn, 2);
    if (!is_string($h) || strlen($h) < 2) {
        return null;
    }
    $b1 = ord($h[0]);
    $b2 = ord($h[1]);
    $opcode = $b1 & 0x0f;
    $masked = ($b2 & 0x80) !== 0;
    $len = $b2 & 0x7f;
    if ($len === 126) {
        $ext = fread($conn, 2);
        if (!is_string($ext) || strlen($ext) < 2) {
            return null;
        }
        $len = unpack('nlen', $ext)['len'];
    } elseif ($len === 127) {
        $ext = fread($conn, 8);
        if (!is_string($ext) || strlen($ext) < 8) {
            return null;
        }
        $parts = unpack('Nhigh/Nlow', $ext);
        $len = ((int) $parts['high'] << 32) | (int) $parts['low'];
    }
    $mask = $masked ? fread($conn, 4) : '';
    $payload = '';
    while (strlen($payload) < $len) {
        $chunk = fread($conn, $len - strlen($payload));
        if ($chunk === '' || $chunk === false) {
            return null;
        }
        $payload .= $chunk;
    }
    if ($masked && is_string($mask) && strlen($mask) === 4) {
        $decoded = '';
        for ($i = 0; $i < $len; $i++) {
            $decoded .= $payload[$i] ^ $mask[$i % 4];
        }
        $payload = $decoded;
    }
    return ['opcode' => $opcode, 'payload' => $payload];
}

function ws_read_json($conn): array {
    $frame = ws_read_frame($conn);
    if (!is_array($frame)) {
        throw new RuntimeException('frame_read_failed');
    }
    $decoded = json_decode((string) $frame['payload'], true);
    if (!is_array($decoded)) {
        throw new RuntimeException('invalid_json_payload: ' . (string) $frame['payload']);
    }
    return $decoded;
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$vhttpdBin = $repoRoot . '/vhttpd/vhttpd';
$app = __DIR__ . '/fixtures/vslim_websocket_room_app_fixture.php';
$serverPort = free_port();
$adminPort = free_port();
$sockPrefix = sys_get_temp_dir() . '/vhttpd_admin_runtime_ws_' . getmypid();
$pidFile = sys_get_temp_dir() . '/vhttpd_admin_runtime_ws_' . getmypid() . '.pid';
$eventLog = sys_get_temp_dir() . '/vhttpd_admin_runtime_ws_' . getmypid() . '.ndjson';
$config = sys_get_temp_dir() . '/vhttpd_admin_runtime_ws_' . getmypid() . '.toml';
$token = 'admin-token';

@unlink($pidFile);
@unlink($eventLog);
@unlink($config);
foreach (glob($sockPrefix . '*.sock') ?: [] as $sock) {
    @unlink($sock);
}

$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$serverPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
read_timeout_ms = 60000
pool_size = 1
websocket_dispatch = true
socket = "{$sockPrefix}.sock"
cmd = "php -d extension={$root}/vslim.so {$repoRoot}/vhttpd/php/package/bin/php-worker"

[worker.env]
VHTTPD_APP = "{$app}"

[admin]
host = "127.0.0.1"
port = {$adminPort}
token = "{$token}"

[assets]
enabled = false
prefix = "/assets"
root = "{$root}/examples/public"
cache_control = "public, max-age=3600"
TOML;

file_put_contents($config, $toml);
$cmd = sprintf('%s --config %s > %s 2>&1 & echo $!', escapeshellarg($vhttpdBin), escapeshellarg($config), escapeshellarg($eventLog . '.log'));
$out = [];
exec($cmd, $out, $code);
$pid = isset($out[0]) ? (int) trim((string) $out[0]) : 0;

$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.5]]);
    $meta = @file_get_contents("http://127.0.0.1:{$serverPort}/meta", false, $ctx);
    if (is_string($meta) && str_contains($meta, 'vslim-websocket-room-fixture')) {
        $ready = true;
        break;
    }
    usleep(100_000);
}
echo $ready ? "server_ready\n" : "server_not_ready\n";
if (!$ready) {
    if ($pid > 0) {
        exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    }
    exit;
}

$alice = ws_handshake('127.0.0.1', $serverPort, '/ws?room=lobby&user=alice');
$aliceOpen = ws_read_json($alice);
$bob = ws_handshake('127.0.0.1', $serverPort, '/ws?room=lobby&user=bob');
$bobOpen = ws_read_json($bob);
$aliceJoin = ws_read_json($alice);
echo ($aliceOpen['type'] ?? ''), '|', ($bobOpen['type'] ?? ''), '|', ($aliceJoin['type'] ?? ''), PHP_EOL;

$ctxToken = stream_context_create([
    'http' => [
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
]);

$summaryRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/websockets', false, $ctxToken);
$summary = is_string($summaryRaw) ? json_decode($summaryRaw, true) : null;
$summaryOk = is_array($summary)
    && (($summary['details'] ?? true) === false)
    && (($summary['active_connections'] ?? 0) === 2)
    && (($summary['active_rooms'] ?? 0) === 1)
    && (($summary['returned_connections'] ?? -1) === 0);
echo $summaryOk ? "summary_ok\n" : "summary_bad\n";

$detailRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/websockets?details=1&limit=10&room=lobby', false, $ctxToken);
$detail = is_string($detailRaw) ? json_decode($detailRaw, true) : null;
$connections = is_array($detail['connections'] ?? null) ? $detail['connections'] : [];
$rooms = is_array($detail['rooms'] ?? null) ? $detail['rooms'] : [];
$detailOk = is_array($detail)
    && (($detail['details'] ?? false) === true)
    && (($detail['returned_connections'] ?? 0) === 2)
    && (($detail['returned_rooms'] ?? 0) === 1)
    && (($detail['room_filter'] ?? '') === 'lobby')
    && count($connections) === 2
    && count($rooms) === 1
    && (($rooms[0]['member_count'] ?? 0) === 2);
echo $detailOk ? "detail_ok\n" : "detail_bad\n";

$aliceId = (string) ($connections[0]['id'] ?? '');
$singleRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/websockets?details=1&conn_id=' . rawurlencode($aliceId), false, $ctxToken);
$single = is_string($singleRaw) ? json_decode($singleRaw, true) : null;
$singleConns = is_array($single['connections'] ?? null) ? $single['connections'] : [];
$singleOk = is_array($single)
    && (($single['conn_id'] ?? '') === $aliceId)
    && (($single['returned_connections'] ?? 0) === 1)
    && count($singleConns) === 1
    && (($singleConns[0]['id'] ?? '') === $aliceId);
echo $singleOk ? "single_ok\n" : "single_bad\n";

fclose($alice);
fclose($bob);
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    usleep(200000);
    exec(sprintf('kill -0 %d >/dev/null 2>&1', $pid), $noop, $alive);
    echo $alive === 0 ? "still_running\n" : "stopped\n";
} else {
    echo "stopped\n";
}
@unlink($config);
foreach (glob($sockPrefix . '*.sock') ?: [] as $sock) {
    @unlink($sock);
}
?>
--EXPECT--
server_ready
system|system|system
summary_ok
detail_ok
single_ok
stopped
