--TEST--
vhttpd mcp enforces origin allowlist and supports DELETE /mcp
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
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

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$vhttpdBin = $repoRoot . '/vhttpd/vhttpd';
$app = $repoRoot . '/vhttpd/examples/mcp-app.php';
$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_mcp_origin_delete_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$config = $tmp . '/mcp.toml';
$sock = $tmp . '/worker.sock';

$allowedOrigin = "http://127.0.0.1:{$dataPort}";
$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$dataPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
pool_size = 1
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
max_sessions = 100
max_pending_messages = 8
session_ttl_seconds = 900
allowed_origins = ["{$allowedOrigin}"]

[assets]
enabled = false
prefix = "/assets"
root = "{$repoRoot}/vhttpd/examples/public"
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
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $meta = @file_get_contents("http://127.0.0.1:{$dataPort}/meta", false, $ctx);
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
    . "MCP-Protocol-Version: 2025-11-05\r\n";

$ctxForbidden = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers . "Origin: http://evil.example\r\n",
        'content' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
    ],
]);
$forbidden = @file_get_contents("http://127.0.0.1:{$dataPort}/mcp", false, $ctxForbidden);
$forbiddenOk = false;
foreach (last_response_headers() as $line) {
    if (stripos($line, 'HTTP/') === 0 && str_contains($line, '403')) {
        $forbiddenOk = true;
        break;
    }
}
echo $forbiddenOk ? "origin_forbidden_ok\n" : "origin_forbidden_bad\n";

$ctxInit = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers . "Origin: {$allowedOrigin}\r\n",
        'content' => '{"jsonrpc":"2.0","id":2,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
    ],
]);
$init = @file_get_contents("http://127.0.0.1:{$dataPort}/mcp", false, $ctxInit);
$sessionId = '';
foreach (last_response_headers() as $line) {
    if (stripos($line, 'Mcp-Session-Id:') === 0) {
        $sessionId = trim(substr($line, strlen('Mcp-Session-Id:')));
        break;
    }
}
echo ($init !== false && $sessionId !== '') ? "init_ok\n" : "init_bad\n";

$ctxDelete = stream_context_create([
    'http' => [
        'method' => 'DELETE',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => "Origin: {$allowedOrigin}\r\nMcp-Session-Id: {$sessionId}\r\n",
    ],
]);
$deleted = @file_get_contents("http://127.0.0.1:{$dataPort}/mcp", false, $ctxDelete);
$deleteOk = is_string($deleted) && str_contains($deleted, '"deleted":true');
echo $deleteOk ? "delete_ok\n" : "delete_bad\n";

$ctxDeleteAgain = stream_context_create([
    'http' => [
        'method' => 'DELETE',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => "Origin: {$allowedOrigin}\r\nMcp-Session-Id: {$sessionId}\r\n",
    ],
]);
@file_get_contents("http://127.0.0.1:{$dataPort}/mcp", false, $ctxDeleteAgain);
$deleteMissingOk = false;
foreach (last_response_headers() as $line) {
    if (stripos($line, 'HTTP/') === 0 && str_contains($line, '404')) {
        $deleteMissingOk = true;
        break;
    }
}
echo $deleteMissingOk ? "delete_missing_ok\n" : "delete_missing_bad\n";

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
origin_forbidden_ok
init_ok
delete_ok
delete_missing_ok
stopped
