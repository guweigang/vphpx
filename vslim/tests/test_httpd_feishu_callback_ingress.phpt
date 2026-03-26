--TEST--
vhttpd feishu callback ingress handles challenge validation and action dispatch bridge
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
$probeSock = sys_get_temp_dir() . '/vhttpd_feishu_callback_probe_' . getmypid() . '.sock';
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

function last_response_headers(): array {
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($GLOBALS['http_response_header'] ?? []);
    return is_array($headers) ? $headers : [];
}

function http_json(string $url, array $options = [], ?array &$responseHeaders = null): ?array {
    $ctx = stream_context_create([
        'http' => $options + [
            'timeout' => 2.0,
            'ignore_errors' => true,
        ],
    ]);
    $raw = @file_get_contents($url, false, $ctx);
    $responseHeaders = last_response_headers();
    return is_string($raw) ? json_decode($raw, true) : null;
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';

$dataPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_feishu_callback_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$sock = $tmp . '/worker.sock';
$token = 'admin-token';
$fixtureApp = $tmp . '/callback-app.php';
$configFile = $tmp . '/vhttpd.toml';

file_put_contents($fixtureApp, <<<'PHP'
<?php
declare(strict_types=1);
use VPhp\VSlim\App\Feishu\BotAdapter;
return [
    'websocket_upstream' => static function (array $frame): array {
        $action = BotAdapter::parseCardAction($frame);
        if ($action === null) {
            return ['handled' => false, 'commands' => []];
        }

        $actionTag = (string) ($action['action_tag'] ?? '');
        if ($actionTag === '') {
            return ['handled' => false, 'commands' => []];
        }
        return [
            'handled' => true,
            'commands' => [],
        ];
    },
];
PHP);

file_put_contents($configFile, <<<TOML
[server]
host = "127.0.0.1"
port = {$dataPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
socket = "{$sock}"
cmd = "php {$repoRoot}/vhttpd/php/package/bin/php-worker"

[worker.env]
VHTTPD_APP = "{$fixtureApp}"

[admin]
host = "127.0.0.1"
port = {$adminPort}
token = "{$token}"

[feishu]
enabled = true

[feishu.main]
verification_token = "verify-main"
TOML);

$cmd = sprintf(
    '%s --config %s >> %s 2>&1 &',
    escapeshellarg($bin),
    escapeshellarg($configFile),
    escapeshellarg($stdoutLog),
);
exec($cmd);

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

$challenge = http_json(
    'http://127.0.0.1:' . $dataPort . '/callbacks/feishu/main',
    [
        'method' => 'POST',
        'header' => "Content-Type: application/json\r\n",
        'content' => json_encode([
            'type' => 'url_verification',
            'challenge' => 'challenge-1',
            'token' => 'verify-main',
        ], JSON_UNESCAPED_UNICODE),
    ],
    $challengeHeaders,
);
echo (($challenge['challenge'] ?? '') === 'challenge-1' ? "challenge_ok\n" : "challenge_bad\n");

$invalid = http_json(
    'http://127.0.0.1:' . $dataPort . '/callbacks/feishu/main',
    [
        'method' => 'POST',
        'header' => "Content-Type: application/json\r\n",
        'content' => json_encode([
            'type' => 'url_verification',
            'challenge' => 'challenge-2',
            'token' => 'wrong-token',
        ], JSON_UNESCAPED_UNICODE),
    ],
    $invalidHeaders,
);
$invalidStatus = is_array($invalidHeaders) && str_contains((string) ($invalidHeaders[0] ?? ''), '403');
echo ($invalidStatus && (($invalid['error'] ?? '') === 'invalid_feishu_callback_token') ? "invalid_token_ok\n" : "invalid_token_bad\n");

$action = http_json(
    'http://127.0.0.1:' . $dataPort . '/callbacks/feishu/main',
    [
        'method' => 'POST',
        'header' => "Content-Type: application/json\r\n",
        'content' => json_encode([
            'schema' => '2.0',
            'token' => 'verify-main',
            'header' => [
                'event_id' => 'evt_card_1',
                'event_type' => 'card.action.trigger',
            ],
            'event' => [
                'open_message_id' => 'om_card_1',
                'action' => [
                    'tag' => 'button',
                    'value' => [
                        'action' => 'approve',
                    ],
                ],
            ],
        ], JSON_UNESCAPED_UNICODE),
    ],
    $actionHeaders,
);
echo ((($action['code'] ?? -1) === 0) ? "action_ack_ok\n" : "action_ack_bad\n");

$activities = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket/activities?provider=feishu&instance=main',
    [
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
);
$dispatchOk = is_array($activities)
    && (($activities['returned_count'] ?? 0) >= 1)
    && (($activities['activities'][0]['event_type'] ?? '') === 'card.action.trigger')
    && (($activities['activities'][0]['target_type'] ?? '') === 'open_message_id')
    && (($activities['activities'][0]['target'] ?? '') === 'om_card_1')
    && (($activities['activities'][0]['worker_handled'] ?? false) === true);
echo $dispatchOk ? "dispatch_ok\n" : "dispatch_bad\n";

$events = http_json(
    'http://127.0.0.1:' . $adminPort . '/admin/runtime/upstreams/websocket/events?provider=feishu&instance=main',
    [
        'header' => "x-vhttpd-admin-token: {$token}\r\n",
    ],
);
$eventsOk = is_array($events)
    && (($events['returned_count'] ?? 0) >= 1)
    && (($events['events'][0]['event_type'] ?? '') === 'card.action.trigger')
    && (($events['events'][0]['metadata']['action_tag'] ?? '') === 'button');
echo $eventsOk ? "events_ok\n" : "events_bad\n";

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
@unlink($configFile);
?>
--EXPECT--
ready
challenge_ok
invalid_token_ok
action_ack_ok
dispatch_ok
events_ok
stopped
