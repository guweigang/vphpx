--TEST--
vhttpd admin websocket upstream fixture provider exposes dispatches, events, and runtime snapshots
--SKIPIF--
<?php
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/src/main.v')) {
    echo "skip vhttpd source missing";
    return;
}
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) {
    echo "skip vhttpd binary missing";
    return;
}
$probeSock = sys_get_temp_dir() . '/vhttpd_fixture_ws_probe_' . getmypid() . '.sock';
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

function http_json(string $url, array $options = []): ?array {
    $ctx = stream_context_create([
        'http' => $options + [
            'timeout' => 2.0,
            'ignore_errors' => true,
        ],
    ]);
    $raw = @file_get_contents($url, false, $ctx);
    return is_string($raw) ? json_decode($raw, true) : null;
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';

$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_fixture_ws_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$sock = $tmp . '/worker.sock';
$token = 'admin-token';
$fixtureApp = $tmp . '/fixture-app.php';

file_put_contents($fixtureApp, <<<'PHP'
<?php
declare(strict_types=1);
return [
    'websocket_upstream' => static function (array $frame): array {
        return [
            'handled' => true,
            'commands' => [
                [
                    'event' => 'send',
                    'provider' => (string) ($frame['provider'] ?? 'fixture'),
                    'instance' => (string) ($frame['instance'] ?? 'main'),
                    'target_type' => (string) ($frame['target_type'] ?? 'fixture_target'),
                    'target' => (string) ($frame['target'] ?? ''),
                    'message_type' => 'text',
                    'text' => 'fixture-ack:' . (string) ($frame['message_id'] ?? ''),
                ],
            ],
        ];
    },
];
PHP);

$cmd = sprintf(
    '%s --host 127.0.0.1 --port %d --pid-file %s --event-log %s --admin-host 127.0.0.1 --admin-port %d --admin-token %s --worker-autostart 1 --worker-socket %s --worker-cmd %s >> %s 2>&1 &',
    escapeshellarg($bin),
    $dataPort,
    escapeshellarg($pidFile),
    escapeshellarg($eventLog),
    $adminPort,
    escapeshellarg($token),
    escapeshellarg($sock),
    escapeshellarg('php ' . $repoRoot . '/vhttpd/php/package/bin/php-worker'),
    escapeshellarg($stdoutLog),
);
exec('VHTTPD_APP=' . escapeshellarg($fixtureApp) . ' ' . $cmd);

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

$headers = "x-vhttpd-admin-token: {$token}\r\nContent-Type: application/json\r\n";
$emit = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket/fixture/emit',
    [
        'method' => 'POST',
        'header' => $headers,
        'content' => json_encode([
            'instance' => 'fixture-main',
            'trace_id' => 'trace-fixture-1',
            'event_type' => 'fixture.message',
            'message_id' => 'fixture-evt-1',
            'target_type' => 'fixture_target',
            'target' => 'room-1',
            'payload' => '{"text":"hello fixture"}',
            'metadata' => ['source' => 'phpt'],
        ], JSON_UNESCAPED_UNICODE),
    ],
);
echo (($emit['provider'] ?? '') === 'fixture' ? "emit_ok\n" : "emit_bad\n");
echo (($emit['worker_handled'] ?? false) ? "emit_handled\n" : "emit_unhandled\n");
echo (($emit['commands'][0]['status'] ?? '') === 'sent' ? "command_sent\n" : "command_bad\n");

$dispatches = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket/activities?provider=fixture&instance=fixture-main',
    [
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
);
$dispatchOk = is_array($dispatches)
    && (($dispatches['returned_count'] ?? 0) === 1)
    && (($dispatches['activities'][0]['provider'] ?? '') === 'fixture')
    && (($dispatches['activities'][0]['instance'] ?? '') === 'fixture-main')
    && (($dispatches['activities'][0]['target_type'] ?? '') === 'fixture_target')
    && (($dispatches['activities'][0]['commands'][0]['status'] ?? '') === 'sent');
echo $dispatchOk ? "dispatches_ok\n" : "dispatches_bad\n";

$events = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket/events?provider=fixture&instance=fixture-main',
    [
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
);
$eventsOk = is_array($events)
    && (($events['returned_count'] ?? 0) === 1)
    && (($events['events'][0]['event_type'] ?? '') === 'fixture.message')
    && (($events['events'][0]['message_id'] ?? '') === 'fixture-evt-1')
    && (($events['events'][0]['metadata']['source'] ?? '') === 'phpt');
echo $eventsOk ? "events_ok\n" : "events_bad\n";

$upstreams = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket?provider=fixture&instance=fixture-main',
    [
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
);
$upstreamsOk = is_array($upstreams)
    && (($upstreams['returned_count'] ?? 0) === 1)
    && (($upstreams['sessions'][0]['provider'] ?? '') === 'fixture')
    && (($upstreams['sessions'][0]['instance'] ?? '') === 'fixture-main');
echo $upstreamsOk ? "upstreams_ok\n" : "upstreams_bad\n";

$pid = is_file($pidFile) ? (int) trim((string) file_get_contents($pidFile)) : 0;
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    usleep(200000);
    exec(sprintf('kill -0 %d >/dev/null 2>&1', $pid), $noop, $alive);
    echo $alive === 0 ? "still_running\n" : "stopped\n";
} else {
    echo "stopped\n";
}
@unlink($fixtureApp);
?>
--EXPECT--
ready
emit_ok
emit_handled
command_sent
dispatches_ok
events_ok
upstreams_ok
stopped
