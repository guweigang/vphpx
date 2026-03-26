--TEST--
vhttpd admin exposes runtime capability and upstream snapshots
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

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';
$app = __DIR__ . '/fixtures/vslim_websocket_room_app_fixture.php';


$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_admin_runtime_' . getmypid() . '_' . $dataPort;
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
    if (is_string($meta) && str_contains($meta, 'vslim-websocket-room-fixture')) {
        $ready = true;
        break;
    }
    usleep(100000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$ctxToken = stream_context_create([
    'http' => [
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
]);

$runtimeRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime', false, $ctxToken);
$runtime = is_string($runtimeRaw) ? json_decode($runtimeRaw, true) : null;
$runtimeOk = is_array($runtime)
    && (($runtime['capabilities']['stream'] ?? false) === true)
    && (($runtime['capabilities']['stream_direct'] ?? false) === true)
    && (($runtime['capabilities']['stream_upstream_plan'] ?? false) === true)
    && (($runtime['capabilities']['websocket'] ?? false) === true)
    && (($runtime['capabilities']['mcp'] ?? false) === true)
    && array_key_exists('worker_queue_capacity', $runtime)
    && array_key_exists('worker_queue_timeout_ms', $runtime)
    && array_key_exists('worker_queue_depth', $runtime)
    && array_key_exists('active_websockets', $runtime)
    && array_key_exists('active_upstreams', $runtime)
    && is_array($runtime['stats'] ?? null)
    && array_key_exists('worker_queue_waits_total', $runtime['stats'])
    && array_key_exists('worker_queue_rejected_total', $runtime['stats'])
    && array_key_exists('worker_queue_timeouts_total', $runtime['stats']);
echo $runtimeOk ? "runtime_ok\n" : "runtime_bad\n";

$upstreamsSummaryRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams', false, $ctxToken);
$upstreamsSummary = is_string($upstreamsSummaryRaw) ? json_decode($upstreamsSummaryRaw, true) : null;
$summaryOk = is_array($upstreamsSummary)
    && (($upstreamsSummary['details'] ?? true) === false)
    && array_key_exists('active_count', $upstreamsSummary)
    && (($upstreamsSummary['returned_count'] ?? -1) === 0)
    && is_array($upstreamsSummary['sessions'] ?? null)
    && count($upstreamsSummary['sessions']) === 0;
echo $summaryOk ? "upstreams_summary_ok\n" : "upstreams_summary_bad\n";

$upstreamsDetailRaw = @file_get_contents('http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams?details=1&limit=5&offset=0', false, $ctxToken);
$upstreamsDetail = is_string($upstreamsDetailRaw) ? json_decode($upstreamsDetailRaw, true) : null;
$detailOk = is_array($upstreamsDetail)
    && (($upstreamsDetail['details'] ?? false) === true)
    && (($upstreamsDetail['limit'] ?? 0) === 5)
    && (($upstreamsDetail['offset'] ?? -1) === 0)
    && array_key_exists('returned_count', $upstreamsDetail)
    && is_array($upstreamsDetail['sessions'] ?? null);
echo $detailOk ? "upstreams_detail_ok\n" : "upstreams_detail_bad\n";

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
runtime_ok
upstreams_summary_ok
upstreams_detail_ok
stopped
