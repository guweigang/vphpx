--TEST--
vhttpd mcp sampling policy drop suppresses sampling SSE delivery and increments dropped metric
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) print "skip";
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

function last_response_headers(): array {
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($GLOBALS['http_response_header'] ?? []);
    return is_array($headers) ? $headers : [];
}

function sse_connect(string $host, int $port, string $sessionId, string $origin): mixed {
    $conn = @stream_socket_client("tcp://{$host}:{$port}", $errno, $errstr, 5.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    stream_set_timeout($conn, 2);
    $req = "GET /mcp HTTP/1.1\r\n"
        . "Host: {$host}:{$port}\r\n"
        . "Accept: text/event-stream\r\n"
        . "Origin: {$origin}\r\n"
        . "Mcp-Session-Id: {$sessionId}\r\n"
        . "Connection: keep-alive\r\n\r\n";
    fwrite($conn, $req);
    $response = '';
    while (!str_contains($response, "\r\n\r\n")) {
        $chunk = fread($conn, 2048);
        if ($chunk === '' || $chunk === false) {
            break;
        }
        $response .= $chunk;
    }
    if (!str_contains($response, "200 OK")) {
        throw new RuntimeException("sse_handshake_failed: {$response}");
    }
    return $conn;
}

function sse_read_event($conn, int $timeoutSeconds = 2): ?string {
    stream_set_timeout($conn, $timeoutSeconds);
    $buffer = '';
    while (!str_contains($buffer, "\n\n")) {
        $chunk = fread($conn, 2048);
        if ($chunk === '' || $chunk === false) {
            $meta = stream_get_meta_data($conn);
            if (($meta['timed_out'] ?? false) === true) {
                return null;
            }
            return null;
        }
        $buffer .= $chunk;
    }
    return $buffer;
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';
$app = $repoRoot . '/vhttpd/examples/mcp-app.php';


$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_mcp_sampling_drop_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$sock = $tmp . '/worker.sock';
$config = $tmp . '/mcp.toml';
$origin = 'http://127.0.0.1:' . $dataPort;

$configBody = <<<TOML
[server]
host = "127.0.0.1"
port = {$dataPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
pool_size = 2
socket = "{$sock}"
read_timeout_ms = 3000
cmd = "php -d extension={$root}/vslim.so {$repoRoot}/vhttpd/php/package/bin/php-worker"

[worker.env]
VHTTPD_APP = "{$app}"

[admin]
host = "127.0.0.1"
port = {$adminPort}
token = ""

[mcp]
sampling_capability_policy = "drop"
allowed_origins = ["{$origin}"]
TOML;
file_put_contents($config, $configBody);

$cmd = sprintf(
    '%s --config %s >> %s 2>&1 &',
    escapeshellarg($bin),
    escapeshellarg($config),
    escapeshellarg($stdoutLog),
);
exec($cmd);

$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $meta = @file_get_contents('http://127.0.0.1:' . $dataPort . '/meta', false, $ctx);
    if (is_string($meta) && str_contains($meta, 'mcp')) {
        $ready = true;
        break;
    }
    usleep(100000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$headers = "Content-Type: application/json\r\n"
    . "Accept: application/json, text/event-stream\r\n"
    . "MCP-Protocol-Version: 2025-11-05\r\n"
    . "Origin: {$origin}\r\n";

$initCtx = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05","capabilities":{"roots":{"listChanged":true}}}}',
    ],
]);
@file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $initCtx);
$sessionId = '';
foreach (last_response_headers() as $line) {
    if (stripos($line, 'Mcp-Session-Id:') === 0) {
        $sessionId = trim(substr($line, strlen('Mcp-Session-Id:')));
        break;
    }
}
echo ($sessionId !== '' ? "session_ok\n" : "session_bad\n");

$sse = sse_connect('127.0.0.1', $dataPort, $sessionId, $origin);
$connected = sse_read_event($sse, 2);
echo (is_string($connected) && str_contains($connected, ': connected') ? "sse_open\n" : "sse_bad\n");

$beforeRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime');
$before = is_string($beforeRaw) ? json_decode($beforeRaw, true) : null;
echo (int) (($before['stats']['mcp_sampling_capability_dropped_total'] ?? -1)), "\n";

$sampleCtx = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers . "Mcp-Session-Id: {$sessionId}\r\n",
        'content' => '{"jsonrpc":"2.0","id":9,"method":"debug/sample","params":{"topic":"runtime contract"}}',
    ],
]);
$sampleRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $sampleCtx);
$sampleBody = is_string($sampleRaw) ? json_decode($sampleRaw, true) : null;
echo ((is_array($sampleBody) && ($sampleBody['result']['queued'] ?? false) === true) ? "sample_ok\n" : "sample_bad\n");

$event = sse_read_event($sse, 1);
echo ($event === null ? "sampling_suppressed\n" : "sampling_leaked\n");

$afterRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime');
$after = is_string($afterRaw) ? json_decode($afterRaw, true) : null;
echo (int) (($after['stats']['mcp_sampling_capability_dropped_total'] ?? -1)), "\n";

fclose($sse);
$pid = is_file($pidFile) ? (int) trim((string) file_get_contents($pidFile)) : 0;
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    usleep(200000);
    exec(sprintf('kill -0 %d >/dev/null 2>&1', $pid), $noop, $alive);
    echo $alive === 0 ? "still_running\n" : "stopped\n";
} else {
    echo "stopped\n";
}
?>
--EXPECT--
ready
session_ok
sse_open
0
sample_ok
sampling_suppressed
1
stopped
