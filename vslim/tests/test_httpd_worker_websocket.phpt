--TEST--
vhttpd worker supports websocket upgrade and text echo via php-worker
--SKIPIF--
<?php
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) print "skip";
$probe = sys_get_temp_dir() . '/vhttpd_ws_unix_probe_' . getmypid() . '.sock';
@unlink($probe);
$errno = 0;
$errstr = '';
$server = @stream_socket_server('unix://' . $probe, $errno, $errstr);
if (!is_resource($server)) {
    print 'skip';
}
if (is_resource($server)) {
    fclose($server);
}
if (is_file($probe)) {
    @unlink($probe);
}
?>
--FILE--
<?php
declare(strict_types=1);

function ws_read_http_headers($conn): string
{
    $buf = '';
    while (!str_contains($buf, "\r\n\r\n")) {
        $chunk = fread($conn, 1024);
        if (!is_string($chunk) || $chunk === '') {
            break;
        }
        $buf .= $chunk;
    }
    return $buf;
}

function ws_write_masked_text($conn, string $payload, int $opcode = 0x1): void
{
    $len = strlen($payload);
    $mask = random_bytes(4);
    $header = chr(0x80 | $opcode);
    if ($len <= 125) {
        $header .= chr(0x80 | $len);
    } else {
        throw new RuntimeException('payload too large for test helper');
    }
    $masked = '';
    for ($i = 0; $i < $len; $i++) {
        $masked .= $payload[$i] ^ $mask[$i % 4];
    }
    fwrite($conn, $header . $mask . $masked);
}

function ws_read_frame($conn): array
{
    $first = fread($conn, 2);
    if (!is_string($first) || strlen($first) < 2) {
        throw new RuntimeException('frame_header_failed');
    }
    $b1 = ord($first[0]);
    $b2 = ord($first[1]);
    $opcode = $b1 & 0x0f;
    $masked = ($b2 & 0x80) === 0x80;
    $len = $b2 & 0x7f;
    if ($len === 126) {
        $ext = fread($conn, 2);
        if (!is_string($ext) || strlen($ext) < 2) {
            throw new RuntimeException('frame_ext16_failed');
        }
        $len = unpack('nlen', $ext)['len'];
    } elseif ($len === 127) {
        throw new RuntimeException('frame too large for test helper');
    }
    $mask = $masked ? fread($conn, 4) : '';
    $payload = '';
    while (strlen($payload) < $len) {
        $chunk = fread($conn, $len - strlen($payload));
        if (!is_string($chunk) || $chunk === '') {
            throw new RuntimeException('frame_payload_failed');
        }
        $payload .= $chunk;
    }
    if ($masked) {
        $unmasked = '';
        for ($i = 0; $i < $len; $i++) {
            $unmasked .= $payload[$i] ^ $mask[$i % 4];
        }
        $payload = $unmasked;
    }
    return ['opcode' => $opcode, 'payload' => $payload];
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$src = $repoRoot . '/vhttpd/src';
$bin = $repoRoot . '/vhttpd/vhttpd';


$port = 19680 + random_int(0, 200);
$tmp = sys_get_temp_dir() . '/vhttpd_ws_' . getmypid() . '_' . $port;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$workerSock = $tmp . '/worker.sock';
$workerPhp = $root . '/../../vhttpd/php/package/bin/php-worker';
$appFile = $root . '/../../vhttpd/examples/websocket_echo_app.php';

$workerCmd = sprintf(
    'VHTTPD_APP=%s php %s --socket %s',
    escapeshellarg($appFile),
    escapeshellarg($workerPhp),
    escapeshellarg($workerSock),
);

$cmd = sprintf(
    '%s --host %s --port %d --pid-file %s --event-log %s --worker-socket %s --worker-autostart 1 --worker-read-timeout-ms 2000 --worker-cmd %s >> %s 2>&1 &',
    escapeshellarg($bin),
    escapeshellarg('127.0.0.1'),
    $port,
    escapeshellarg($pidFile),
    escapeshellarg($eventLog),
    escapeshellarg($workerSock),
    escapeshellarg($workerCmd),
    escapeshellarg($stdoutLog),
);
exec($cmd);

$base = 'http://127.0.0.1:' . $port;
$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $health = @file_get_contents($base . '/health', false, $ctx);
    if ($health !== false && trim($health) === 'OK') {
        $ready = true;
        break;
    }
    usleep(100_000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$errno = 0;
$errstr = '';
$conn = @stream_socket_client('tcp://127.0.0.1:' . $port, $errno, $errstr, 2.0);
if (!is_resource($conn)) {
    echo "connect_failed\n";
    exit;
}
stream_set_timeout($conn, 2);

$key = base64_encode(random_bytes(16));
$handshake = "GET /ws HTTP/1.1\r\n"
    . "Host: 127.0.0.1:$port\r\n"
    . "Upgrade: websocket\r\n"
    . "Connection: Upgrade\r\n"
    . "Sec-WebSocket-Version: 13\r\n"
    . "Sec-WebSocket-Key: $key\r\n\r\n";
fwrite($conn, $handshake);

$headers = ws_read_http_headers($conn);
echo (str_contains($headers, '101 Switching Protocols') ? "upgrade_101\n" : "upgrade_bad\n");

$welcome = ws_read_frame($conn);
echo (($welcome['opcode'] ?? -1) === 0x1 ? "welcome_text\n" : "welcome_not_text\n");
echo (($welcome['payload'] ?? '') === 'echo:connected' ? "welcome_ok\n" : "welcome_bad\n");

ws_write_masked_text($conn, 'hello');
$echo = ws_read_frame($conn);
echo (($echo['opcode'] ?? -1) === 0x1 ? "echo_text\n" : "echo_not_text\n");
echo (($echo['payload'] ?? '') === 'echo:hello' ? "echo_ok\n" : "echo_bad\n");

ws_write_masked_text($conn, 'bye');
$close = ws_read_frame($conn);
echo (($close['opcode'] ?? -1) === 0x8 ? "close_frame\n" : "close_not_frame\n");

fclose($conn);

$pid = is_file($pidFile) ? (int) trim((string) file_get_contents($pidFile)) : 0;
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    usleep(200_000);
    exec(sprintf('kill -0 %d >/dev/null 2>&1', $pid), $noop, $alive);
    echo $alive === 0 ? "still_running\n" : "stopped\n";
} else {
    echo "stopped\n";
}
?>
--EXPECT--
ready
upgrade_101
welcome_text
welcome_ok
echo_text
echo_ok
close_frame
stopped
