--TEST--
vhttpd mcp phase A serves initialize plus builtin tools, resources, and prompts over POST /mcp
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
$app = $repoRoot . '/vhttpd/examples/mcp-app.php';


$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_mcp_phase_a_' . getmypid() . '_' . $dataPort;
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
    . "MCP-Protocol-Version: 2025-11-05\r\n";

$ctx = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
    ],
]);
$initRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctx);
$initBody = is_string($initRaw) ? json_decode($initRaw, true) : null;
$initOk = is_array($initBody)
    && (($initBody['result']['serverInfo']['name'] ?? '') === 'vhttpd-mcp-demo')
    && (($initBody['result']['protocolVersion'] ?? '') === '2025-11-05');
echo $initOk ? "init_ok\n" : "init_bad\n";

$ctx2 = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}',
    ],
]);
$toolsRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctx2);
$toolsBody = is_string($toolsRaw) ? json_decode($toolsRaw, true) : null;
$toolsOk = is_array($toolsBody)
    && (($toolsBody['result']['tools'][0]['name'] ?? '') === 'echo')
    && (($toolsBody['result']['tools'][0]['inputSchema']['required'][0] ?? '') === 'text');
echo $toolsOk ? "tools_ok\n" : "tools_bad\n";

$ctx3 = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":3,"method":"resources/list","params":{}}',
    ],
]);
$resourcesRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctx3);
$resourcesBody = is_string($resourcesRaw) ? json_decode($resourcesRaw, true) : null;
$resourcesOk = is_array($resourcesBody)
    && (($resourcesBody['result']['resources'][0]['uri'] ?? '') === 'resource://demo/readme');
echo $resourcesOk ? "resources_ok\n" : "resources_bad\n";

$ctx4 = stream_context_create([
    'http' => [
        'method' => 'POST',
        'timeout' => 1.0,
        'ignore_errors' => true,
        'header' => $headers,
        'content' => '{"jsonrpc":"2.0","id":4,"method":"prompts/list","params":{}}',
    ],
]);
$promptsRaw = @file_get_contents('http://127.0.0.1:' . $dataPort . '/mcp', false, $ctx4);
$promptsBody = is_string($promptsRaw) ? json_decode($promptsRaw, true) : null;
$promptsOk = is_array($promptsBody)
    && (($promptsBody['result']['prompts'][0]['name'] ?? '') === 'welcome');
echo $promptsOk ? "prompts_ok\n" : "prompts_bad\n";

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
tools_ok
resources_ok
prompts_ok
stopped
