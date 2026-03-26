--TEST--
PhpWorker websocket frame protocol accepts open, message and close events
--SKIPIF--
<?php
$probe = sys_get_temp_dir() . '/vphp_worker_ws_probe_' . getmypid() . '.sock';
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

require_once dirname(__DIR__) . '/../../vhttpd/php/package/src/legacy_aliases.php';

$root = dirname(__DIR__);
$workerBin = $root . '/../../vhttpd/php/package/bin/php-worker';
$app = $root . '/../../vhttpd/examples/websocket_echo_app.php';
$sock = sys_get_temp_dir() . '/vslim_php_worker_ws_' . getmypid() . '.sock';
$log = sys_get_temp_dir() . '/vslim_php_worker_ws_' . getmypid() . '.log';
@unlink($sock);
@unlink($log);

$cmd = sprintf(
    'VHTTPD_APP=%s php %s --socket %s > %s 2>&1 & echo $!',
    escapeshellarg($app),
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

$connect = static function (string $sockPath) {
    $errno = 0;
    $errstr = '';
    $conn = @stream_socket_client('unix://' . $sockPath, $errno, $errstr, 2.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    return $conn;
};

$readFrames = static function ($conn, array $request): array {
    \VPhp\VHttpd\PhpWorker\Client::writeFrame(
        $conn,
        (string) json_encode($request, JSON_UNESCAPED_UNICODE),
    );
    $frames = [];
    while (true) {
        $raw = \VPhp\VHttpd\PhpWorker\Client::readFrame($conn);
        if (!is_string($raw) || $raw === '') {
            break;
        }
        $frame = json_decode($raw, true);
        if (!is_array($frame)) {
            break;
        }
        $frames[] = $frame;
        if (($frame['event'] ?? '') === 'done') {
            break;
        }
    }
    return $frames;
};

$conn = $connect($sock);
$openFrames = $readFrames($conn, [
    'mode' => 'websocket',
    'event' => 'open',
    'id' => 'ws-1',
    'path' => '/ws',
    'query' => [],
    'headers' => ['host' => 'demo.local'],
    'remote_addr' => '127.0.0.1',
    'request_id' => 'ws-1',
    'trace_id' => 'trace-ws-1',
]);
echo ($openFrames[0]['event'] ?? '') . PHP_EOL;
echo ($openFrames[1]['event'] ?? '') . '|' . ($openFrames[1]['data'] ?? '') . PHP_EOL;
echo ($openFrames[2]['event'] ?? '') . PHP_EOL;

$msgFrames = $readFrames($conn, [
    'mode' => 'websocket',
    'event' => 'message',
    'id' => 'ws-1',
    'opcode' => 'text',
    'data' => 'hello',
]);
echo ($msgFrames[0]['event'] ?? '') . '|' . ($msgFrames[0]['data'] ?? '') . PHP_EOL;
echo ($msgFrames[1]['event'] ?? '') . PHP_EOL;

$closeFrames = $readFrames($conn, [
    'mode' => 'websocket',
    'event' => 'close',
    'id' => 'ws-1',
    'code' => 1000,
    'reason' => 'client closed',
]);
echo ($closeFrames[0]['event'] ?? '') . PHP_EOL;

fclose($conn);

if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
?>
--EXPECT--
worker_ready
accept
send|echo:connected
done
send|echo:hello
done
done
