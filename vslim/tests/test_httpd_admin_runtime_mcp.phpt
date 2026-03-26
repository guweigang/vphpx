--TEST--
vhttpd admin mcp runtime endpoint exposes summary and detail snapshots
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
$bin = $repoRoot . '/vhttpd/vhttpd';
$src = $repoRoot . '/vhttpd/src';
$app = $repoRoot . '/vhttpd/examples/mcp-app.php';


$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_admin_runtime_mcp_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$sock = $tmp . '/worker.sock';
$token = 'admin-token';

$cmd = sprintf(
    '%s --host 127.0.0.1 --port %d --pid-file %s --event-log %s --admin-host 127.0.0.1 --admin-port %d --admin-token %s --worker-autostart 1 --worker-socket %s --worker-cmd %s >> %s 2>&1 &',
    escapeshellarg($bin),
    $dataPort,
    escapeshellarg($pidFile),
    escapeshellarg($eventLog),
    $adminPort,
    escapeshellarg($token),
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
    . "MCP-Protocol-Version: 2025-11-05\r\n";
$ctxInit = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05","capabilities":{"sampling":{},"roots":{"listChanged":true}}}}',
    ],
]);
$init = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctxInit);
$sessionId = '';
foreach (last_response_headers() as $line) {
    if (stripos($line, 'Mcp-Session-Id:') === 0) {
        $sessionId = trim(substr($line, strlen('Mcp-Session-Id:')));
        break;
    }
}
echo ($init !== false && $sessionId !== '') ? "init_ok\n" : "init_bad\n";

$ctxNotify = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 2.0,
        'ignore_errors' => true,
        'header' => $headers . "Mcp-Session-Id: {$sessionId}\r\n",
        'content' => '{"jsonrpc":"2.0","id":2,"method":"debug/notify","params":{"text":"hello admin"}}',
    ],
]);
$notify = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctxNotify);
echo ($notify !== false) ? "notify_ok\n" : "notify_bad\n";

$ctxAdmin = stream_context_create([
    'http' => [
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
]);
$summaryRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/mcp', false, $ctxAdmin);
$summary = is_string($summaryRaw) ? json_decode($summaryRaw, true) : null;
$summaryOk = is_array($summary)
    && (($summary['details'] ?? true) === false)
    && (($summary['active_sessions'] ?? 0) >= 1)
    && (($summary['returned_sessions'] ?? -1) === 0)
    && (($summary['max_pending_messages'] ?? 0) >= 1)
    && array_key_exists('session_ttl_seconds', $summary)
    && (($summary['sampling_capability_policy'] ?? '') === 'warn')
    && is_array($summary['allowed_origins'] ?? null);
echo $summaryOk ? "summary_ok\n" : "summary_bad\n";

$runtimeRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime', false, $ctxAdmin);
$runtime = is_string($runtimeRaw) ? json_decode($runtimeRaw, true) : null;
$runtimeOk = is_array($runtime)
    && (($runtime['active_mcp_sessions'] ?? 0) >= 1)
    && array_key_exists('mcp_sessions_expired_total', $runtime['stats'] ?? [])
    && array_key_exists('mcp_sessions_evicted_total', $runtime['stats'] ?? [])
    && array_key_exists('mcp_pending_dropped_total', $runtime['stats'] ?? [])
    && array_key_exists('mcp_sampling_capability_warnings_total', $runtime['stats'] ?? [])
    && array_key_exists('mcp_sampling_capability_dropped_total', $runtime['stats'] ?? [])
    && array_key_exists('mcp_sampling_capability_errors_total', $runtime['stats'] ?? []);
echo $runtimeOk ? "runtime_ok\n" : "runtime_bad\n";

$detailRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/mcp?details=1&limit=10&session_id=' . rawurlencode($sessionId), false, $ctxAdmin);
$detail = is_string($detailRaw) ? json_decode($detailRaw, true) : null;
$sessions = is_array($detail['sessions'] ?? null) ? $detail['sessions'] : [];
$detailOk = is_array($detail)
    && (($detail['details'] ?? false) === true)
    && (($detail['session_id'] ?? '') === $sessionId)
    && (($detail['returned_sessions'] ?? 0) === 1)
    && count($sessions) === 1
    && (($sessions[0]['id'] ?? '') === $sessionId)
    && (($sessions[0]['pending_count'] ?? 0) >= 1)
    && str_contains((string) ($sessions[0]['client_capabilities_json'] ?? ''), '"sampling"')
    && str_contains((string) ($sessions[0]['client_capabilities_json'] ?? ''), '"roots"');
echo $detailOk ? "detail_ok\n" : "detail_bad\n";

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
init_ok
notify_ok
summary_ok
runtime_ok
detail_ok
stopped
