--TEST--
PhpWorker websocket frame protocol accepts open, message and close events
--SKIPIF--
<?php
if (!function_exists('stream_socket_pair')) {
    print 'skip';
}
?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/php_worker_package_bootstrap.php';

$root = dirname(__DIR__);
$app = sys_get_temp_dir() . '/vslim_ws_fixture_' . getmypid() . '.php';
file_put_contents($app, <<<'PHP'
<?php
declare(strict_types=1);

return [
    'websocket' => new \VSlim\WebSocket\App(
        function (\VHttpd\PhpWorker\WebSocket\CommandSink $conn, array $frame): void {
            $conn->accept();
            $conn->send('echo:connected');
        },
        function (\VHttpd\PhpWorker\WebSocket\CommandSink $conn, string $message, array $frame): ?string {
            if ($message === 'bye') {
                $conn->close(1000, 'bye');
                return null;
            }
            return 'echo:' . $message;
        },
        function (\VHttpd\PhpWorker\WebSocket\CommandSink $conn, int $code, string $reason, array $frame): void {
        },
    ),
];
PHP);
$server = new \VHttpd\PhpWorker\Server('/tmp/vslim_php_worker_unused_' . getmypid() . '.sock', $app);
$method = new ReflectionMethod($server, 'handleWebSocketFrame');

$readFrames = static function (\VHttpd\PhpWorker\Server $server, ReflectionMethod $method, array $request): array {
    $pair = stream_socket_pair(STREAM_PF_UNIX, STREAM_SOCK_STREAM, STREAM_IPPROTO_IP);
    if (!is_array($pair)) {
        throw new RuntimeException('socket_pair_failed');
    }
    stream_set_blocking($pair[0], true);
    stream_set_blocking($pair[1], true);
    $method->invoke($server, $pair[0], $request);
    $frames = [];
    while (true) {
        $raw = \VHttpd\PhpWorker\Client::readFrame($pair[1]);
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
    fclose($pair[0]);
    fclose($pair[1]);
    return $frames;
};

echo "worker_ready\n";

$openFrames = $readFrames($server, $method, [
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

$msgFrames = $readFrames($server, $method, [
    'mode' => 'websocket',
    'event' => 'message',
    'id' => 'ws-1',
    'opcode' => 'text',
    'data' => 'hello',
]);
echo ($msgFrames[0]['event'] ?? '') . '|' . ($msgFrames[0]['data'] ?? '') . PHP_EOL;
echo ($msgFrames[1]['event'] ?? '') . PHP_EOL;

$closeFrames = $readFrames($server, $method, [
    'mode' => 'websocket',
    'event' => 'close',
    'id' => 'ws-1',
    'code' => 1000,
    'reason' => 'client closed',
]);
echo ($closeFrames[0]['event'] ?? '') . PHP_EOL;

@unlink($app);
?>
--EXPECT--
worker_ready
accept
send|echo:connected
done
send|echo:hello
done
done
