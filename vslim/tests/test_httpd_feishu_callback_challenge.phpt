--TEST--
vhttpd feishu callback challenge endpoint responds without worker sockets
--SKIPIF--
<?php
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/src/main.v')) {
    print "skip";
    return;
}
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) {
    print "skip";
    return;
}
$probe = @stream_socket_server('tcp://127.0.0.1:0', $errno, $errstr);
if (!is_resource($probe)) {
    print "skip";
    return;
}
fclose($probe);
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
$src = $root . '/../../vhttpd/src';
$bin = $root . '/../../vhttpd/vhttpd';

$dataPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_feishu_challenge_' . getmypid() . '_' . $dataPort;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$configPath = $tmp . '/vhttpd.toml';

$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$dataPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = false

[feishu]
enabled = true

[feishu.main]
verification_token = "verify-main"
TOML;
file_put_contents($configPath, $toml);

$cmd = sprintf(
    '%s --config %s >> %s 2>&1 &',
    escapeshellarg($bin),
    escapeshellarg($configPath),
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

$defaultRoute = http_json(
    'http://127.0.0.1:' . $dataPort . '/callbacks/feishu',
    [
        'method' => 'POST',
        'header' => "Content-Type: application/json\r\n",
        'content' => json_encode([
            'type' => 'url_verification',
            'challenge' => 'challenge-default',
            'token' => 'verify-main',
        ], JSON_UNESCAPED_UNICODE),
    ],
);
echo (($defaultRoute['challenge'] ?? '') === 'challenge-default' ? "default_route_ok\n" : "default_route_bad\n");

$events = [];
if (is_file($eventLog)) {
    $lines = file($eventLog, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    if (is_array($lines)) {
        foreach ($lines as $line) {
            $decoded = json_decode($line, true);
            if (is_array($decoded)) {
                $events[] = $decoded;
            }
        }
    }
}
$seen = false;
foreach ($events as $event) {
    if (($event['type'] ?? '') !== 'http.request') {
        continue;
    }
    if (($event['path'] ?? '') !== '/callbacks/feishu') {
        continue;
    }
    if (($event['callback'] ?? '') === 'challenge') {
        $seen = true;
        break;
    }
}
echo $seen ? "event_ok\n" : "event_missing\n";

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
challenge_ok
invalid_token_ok
default_route_ok
event_ok
stopped
