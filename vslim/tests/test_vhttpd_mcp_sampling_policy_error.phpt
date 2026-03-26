--TEST--
vhttpd mcp sampling policy error rejects sampling requests without client capability
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

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';
$app = $repoRoot . '/vhttpd/examples/mcp-app.php';


$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_mcp_sampling_error_' . getmypid() . '_' . $dataPort;
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
sampling_capability_policy = "error"
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

$beforeRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime');
$before = is_string($beforeRaw) ? json_decode($beforeRaw, true) : null;
echo (int) (($before['stats']['mcp_sampling_capability_errors_total'] ?? -1)), "\n";

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
$statusLine = '';
foreach (last_response_headers() as $line) {
    if (stripos($line, 'HTTP/') === 0) {
        $statusLine = $line;
        break;
    }
}
echo (str_contains($statusLine, '409') ? "status_409\n" : "status_bad\n");
echo (($sampleBody['error'] ?? '') === 'Sampling capability required' ? "body_ok\n" : "body_bad\n");

$afterRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime');
$after = is_string($afterRaw) ? json_decode($afterRaw, true) : null;
echo (int) (($after['stats']['mcp_sampling_capability_errors_total'] ?? -1)), "\n";

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
0
status_409
body_ok
1
stopped
