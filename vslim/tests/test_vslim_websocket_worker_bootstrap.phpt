--TEST--
VSlim websocket bootstrap works through php-worker using extension-native handlers
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
$probe = sys_get_temp_dir() . '/vslim_ws_probe_' . getmypid() . '.sock';
@unlink($probe);
$errno = 0;
$errstr = '';
$server = @stream_socket_server('unix://' . $probe, $errno, $errstr);
if (!is_resource($server)) {
    echo 'skip';
    return;
}
fclose($server);
@unlink($probe);
?>
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/../../vhttpd/php/package/src/legacy_aliases.php';

$root = dirname(__DIR__);
$workerBin = $root . '/../../vhttpd/php/package/bin/php-worker';
$app = __DIR__ . '/fixtures/vslim_websocket_app_fixture.php';
$sock = sys_get_temp_dir() . '/vslim_ws_worker_' . getmypid() . '.sock';
$log = sys_get_temp_dir() . '/vslim_ws_worker_' . getmypid() . '.log';
@unlink($sock);
@unlink($log);

$cmd = sprintf(
    'VHTTPD_APP=%s php -d extension=%s %s --socket %s > %s 2>&1 & echo $!',
    escapeshellarg($app),
    escapeshellarg($root . '/vslim.so'),
    escapeshellarg($workerBin),
    escapeshellarg($sock),
    escapeshellarg($log),
);
$out = [];
exec($cmd, $out, $code);
$pid = isset($out[0]) ? (int) trim((string) $out[0]) : 0;

$ready = false;
$deadline = microtime(true) + 5.0;
while (microtime(true) < $deadline) {
    if (is_file($sock)) {
        $ready = true;
        break;
    }
    usleep(50_000);
}
echo $ready ? "worker_ready\n" : "worker_not_ready\n";
if (!$ready) {
    if ($pid > 0) {
        exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    }
    exit;
}

$conn = @stream_socket_client('unix://' . $sock, $errno, $errstr, 2.0);
if (!is_resource($conn)) {
    echo "connect_failed\n";
    if ($pid > 0) {
        exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    }
    exit;
}
stream_set_blocking($conn, true);

$send = static function ($conn, array $frame): array {
    \VPhp\VHttpd\PhpWorker\Client::writeFrame(
        $conn,
        (string) json_encode($frame, JSON_UNESCAPED_UNICODE),
    );
    $frames = [];
    while (true) {
        $raw = \VPhp\VHttpd\PhpWorker\Client::readFrame($conn);
        if (!is_string($raw) || $raw === '') {
            break;
        }
        $decoded = json_decode($raw, true);
        if (!is_array($decoded)) {
            break;
        }
        $frames[] = $decoded;
        if (($decoded['event'] ?? '') === 'done') {
            break;
        }
    }
    return $frames;
};

$open = $send($conn, [
    'mode' => 'websocket',
    'event' => 'open',
    'id' => 'vslim-ws-1',
    'path' => '/ws',
    'headers' => ['host' => 'demo.local'],
    'query' => [],
    'remote_addr' => '127.0.0.1',
]);
echo ($open[0]['event'] ?? '') . "\n";
echo ($open[1]['event'] ?? '') . '|' . ($open[1]['data'] ?? '') . "\n";
echo ($open[2]['event'] ?? '') . "\n";

$message = $send($conn, [
    'mode' => 'websocket',
    'event' => 'message',
    'id' => 'vslim-ws-1',
    'opcode' => 'text',
    'data' => 'hello',
]);
echo ($message[0]['event'] ?? '') . '|' . ($message[0]['data'] ?? '') . "\n";
echo ($message[1]['event'] ?? '') . "\n";

$close = $send($conn, [
    'mode' => 'websocket',
    'event' => 'message',
    'id' => 'vslim-ws-1',
    'opcode' => 'text',
    'data' => 'bye',
]);
echo ($close[0]['event'] ?? '') . '|' . ($close[0]['reason'] ?? '') . "\n";
echo ($close[1]['event'] ?? '') . "\n";

fclose($conn);
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
?>
--EXPECT--
worker_ready
accept
send|vslim:connected
done
send|vslim:hello
done
close|bye
done
