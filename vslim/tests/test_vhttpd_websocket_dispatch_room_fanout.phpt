--TEST--
vhttpd websocket_dispatch mode fans out room messages without connection-owned workers
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
$probeSock = sys_get_temp_dir() . '/vhttpd_ws_dispatch_probe_' . getmypid() . '.sock';
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
declare(strict_types=1);

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

function ws_send_text($conn, string $payload): void {
    $mask = random_bytes(4);
    $len = strlen($payload);
    $header = chr(0x81);
    if ($len < 126) {
        $header .= chr(0x80 | $len);
    } elseif ($len <= 0xffff) {
        $header .= chr(0x80 | 126) . pack('n', $len);
    } else {
        $header .= chr(0x80 | 127) . pack('J', $len);
    }
    $masked = '';
    for ($i = 0; $i < $len; $i++) {
        $masked .= $payload[$i] ^ $mask[$i % 4];
    }
    fwrite($conn, $header . $mask . $masked);
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
    if (($frame['opcode'] ?? 0) === 8) {
        throw new RuntimeException('unexpected_close_frame');
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
$sockPrefix = sys_get_temp_dir() . '/vhttpd_ws_dispatch_room_' . getmypid();
$pidFile = sys_get_temp_dir() . '/vhttpd_ws_dispatch_room_' . getmypid() . '.pid';
$eventLog = sys_get_temp_dir() . '/vhttpd_ws_dispatch_room_' . getmypid() . '.ndjson';
$config = sys_get_temp_dir() . '/vhttpd_ws_dispatch_room_' . getmypid() . '.toml';

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
token = ""

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
echo ($aliceOpen['type'] ?? ''), '|', ($aliceOpen['text'] ?? ''), PHP_EOL;

$bob = ws_handshake('127.0.0.1', $serverPort, '/ws?room=lobby&user=bob');
$bobOpen = ws_read_json($bob);
$aliceJoin = ws_read_json($alice);
echo ($bobOpen['type'] ?? ''), '|', ($bobOpen['text'] ?? ''), PHP_EOL;
echo ($aliceJoin['type'] ?? ''), '|', ($aliceJoin['text'] ?? ''), PHP_EOL;

ws_send_text($alice, (string) json_encode([
    'room' => 'lobby',
    'user' => 'alice',
    'text' => 'hello-dispatch',
], JSON_UNESCAPED_UNICODE));
$aliceSelf = ws_read_json($alice);
$bobRecv = ws_read_json($bob);
ws_send_text($alice, (string) json_encode([
    'room' => 'lobby',
    'text' => '/who',
], JSON_UNESCAPED_UNICODE));
$aliceWho = ws_read_json($alice);
echo ($aliceSelf['user'] ?? ''), '|', ($aliceSelf['text'] ?? ''), '|', (($aliceSelf['self'] ?? false) ? 'self' : 'peer'), PHP_EOL;
echo ($bobRecv['user'] ?? ''), '|', ($bobRecv['text'] ?? ''), '|', (($bobRecv['self'] ?? false) ? 'self' : 'peer'), PHP_EOL;
echo ($aliceWho['text'] ?? ''), PHP_EOL;

fclose($alice);
fclose($bob);
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
@unlink($config);
foreach (glob($sockPrefix . '*.sock') ?: [] as $sock) {
    @unlink($sock);
}
?>
--EXPECT--
server_ready
system|joined lobby
system|joined lobby
system|bob joined
alice|hello-dispatch|self
alice|hello-dispatch|peer
online (2): alice, bob
