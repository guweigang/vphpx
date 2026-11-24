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

foreach (['reject', 'close'] as $terminal) {
    $router = new VSlim\App();
    $handler = new VSlim\WebSocket\App();
    $calls = 0;
    $handler->onOpen(static function ($conn) use ($handler, $terminal): string {
        $handler->join('pending', $conn);
        if ($terminal === 'reject') {
            $conn->reject(401, 'denied');
        } else {
            $conn->close(1000, 'closed before accept');
        }
        return 'ignored after the connection ends';
    });
    $handler->onMessage(static function () use (&$calls): void { ++$calls; });
    $router->websocket('/terminal', $handler);
    $connection = new VHttpd\PhpWorker\WebSocket\Connection(null, 'terminal');
    $open = ['id' => 'terminal', 'event' => 'open', 'path' => '/terminal'];
    if ($router->handleWebSocket(frame: $open, conn: $connection) !== 'ignored after the connection ends'
        || array_column($connection->frames(), 'event') !== [$terminal]
        || $handler->hasConnection($connection) || $handler->members('pending') !== []) {
        throw new RuntimeException("The open callback kept a connection that sent $terminal");
    }
    $router->handleWebSocket(['id' => 'terminal', 'event' => 'message'], $connection);
    if ($calls !== 0) {
        throw new RuntimeException("The route binding survived the $terminal frame");
    }
    $unretained = WeakReference::create($connection);
    unset($connection);
    if ($unretained->get() !== null) {
        throw new RuntimeException("A connection that sent $terminal remained rooted");
    }
}

foreach ([false, true] as $closeInOpen) {
    $handler = new VSlim\WebSocket\App();
    $handler->onOpen(static function ($conn) use ($handler, $closeInOpen): bool {
        $handler->join('active', $conn);
        $conn->accept();
        $conn->reject();
        if ($closeInOpen) {
            $conn->close();
        }
        return false;
    });
    $closeCalls = 0;
    $handler->onMessage(static fn (): string => 'still connected');
    $handler->onClose(static function () use (&$closeCalls): void { ++$closeCalls; });
    $router = new VSlim\App();
    $router->websocket('/active', $handler);
    $connection = new VHttpd\PhpWorker\WebSocket\Connection(null, 'active');
    $result = $router->handleWebSocket(['id' => 'active', 'event' => 'open', 'path' => '/active'], $connection);
    $events = $closeInOpen ? ['accept', 'close'] : ['accept'];
    if ($result !== false || array_column($connection->frames(), 'event') !== $events
        || !$handler->hasConnection($connection) || $handler->members('active') !== ['active']) {
        throw new RuntimeException('The worker did not preserve an accepted connection');
    }
    if (!$closeInOpen && $router->handleWebSocket(['id' => 'active', 'event' => 'message'], $connection) !== 'still connected') {
        throw new RuntimeException('The accepted route could not dispatch a message');
    }
    $router->handleWebSocket(['id' => 'active', 'event' => 'close'], $connection);
    if ($closeCalls !== 1 || $handler->hasConnection($connection) || $handler->members('active') !== []) {
        throw new RuntimeException('The accepted connection did not dispatch close and release its state');
    }
}

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
