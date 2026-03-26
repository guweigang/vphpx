--TEST--
vhttpd mcp queues sampling/createMessage onto the session SSE stream
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

function sse_connect(string $host, int $port, string $sessionId): mixed {
    $conn = @stream_socket_client("tcp://{$host}:{$port}", $errno, $errstr, 5.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    stream_set_timeout($conn, 5);
    $req = "GET /mcp HTTP/1.1\r\n"
        . "Host: {$host}:{$port}\r\n"
        . "Accept: text/event-stream\r\n"
        . "Mcp-Session-Id: {$sessionId}\r\n"
        . "Origin: http://{$host}:{$port}\r\n"
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

function sse_read_event($conn): ?string {
    $buffer = '';
    while (!str_contains($buffer, "\n\n")) {
        $chunk = fread($conn, 2048);
        if ($chunk === '' || $chunk === false) {
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
$tmp = sys_get_temp_dir() . '/vhttpd_mcp_sampling_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$sock = $tmp . '/worker.sock';

$cmd = sprintf(
    '%s --host 127.0.0.1 --port %d --pid-file %s --event-log %s --admin-host 127.0.0.1 --admin-port %d --worker-autostart 1 --worker-socket %s --worker-cmd %s >> %s 2>&1 &',
    escapeshellarg($bin),
    $dataPort,
    escapeshellarg($pidFile),
    escapeshellarg($eventLog),
    $adminPort,
    escapeshellarg($sock),
    escapeshellarg('php -d extension=' . $root . '/vslim.so ' . $repoRoot . '/vhttpd/php/package/bin/php-worker'),
    escapeshellarg($stdoutLog),
);

$envCmd = 'VHTTPD_APP=' . escapeshellarg($app) . ' ' . $cmd;
exec($envCmd);

$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $health = @file_get_contents('http://127.0.0.1:' . $dataPort . '/health', false, $ctx);
    if ($health !== false && trim($health) === 'OK') {
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
    . "Origin: http://127.0.0.1:{$dataPort}\r\n";

$initCtx = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
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

$sse = sse_connect('127.0.0.1', $dataPort, $sessionId);
$connected = sse_read_event($sse);
echo (is_string($connected) && str_contains($connected, ': connected') ? "sse_open\n" : "sse_bad\n");

$sampleCtx = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers . 'Mcp-Session-Id: ' . $sessionId . "\r\n",
        'content' => '{"jsonrpc":"2.0","id":9,"method":"debug/sample","params":{"topic":"runtime contract"}}',
    ],
]);
$sampleRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $sampleCtx);
$sampleBody = is_string($sampleRaw) ? json_decode($sampleRaw, true) : null;
echo ((is_array($sampleBody) && ($sampleBody['result']['queued'] ?? false) === true) ? "sample_ok\n" : "sample_bad\n");

$event = sse_read_event($sse);
$samplingOk = is_string($event)
    && str_contains($event, 'sampling/createMessage')
    && str_contains($event, 'Summarize topic: runtime contract')
    && str_contains($event, 'You are a concise assistant.')
    && str_contains($event, '"maxTokens":128');
echo ($samplingOk ? "sampling_event_ok\n" : "sampling_event_bad\n");

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
sample_ok
sampling_event_ok
stopped
