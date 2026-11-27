--TEST--
vslim websocket callback sees userland connection object consistently for method and instance probes
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php

class ProbeConnBase {}

final class ProbeConnSink extends ProbeConnBase
{
    public function accept(): void {}
    public function setMeta(string $key, string $value): void {}
    public function clearMeta(string $key): void {}
}

final class ProbeWsHandler
{
    public array $seen = [];

    public function handleWebSocket(array $frame, $conn): ?string
    {
        if (($frame['event'] ?? '') !== 'message') {
            return null;
        }
        $this->seen = VSlim\Debug\ObjectProbe::probe($conn, ProbeConnSink::class, 'setMeta');
        return json_encode($this->seen, JSON_UNESCAPED_UNICODE);
    }
}

$app = new VSlim\App();
$handler = new ProbeWsHandler();
$handlerProbe = VSlim\Debug\ObjectProbe::probe(methodName: 'handleWebSocket', className: ProbeWsHandler::class, obj: $handler);
$connProbe = VSlim\Debug\ObjectProbe::probe(new ProbeConnSink(), ProbeConnSink::class, 'setMeta');
echo 'handler.method_exists=', $handlerProbe['method_exists'] ?? 'missing', PHP_EOL;
echo 'handler.is_instance_of=', $handlerProbe['is_instance_of'] ?? 'missing', PHP_EOL;
echo 'conn.method_exists=', $connProbe['method_exists'] ?? 'missing', PHP_EOL;
echo 'conn.is_instance_of=', $connProbe['is_instance_of'] ?? 'missing', PHP_EOL;
$app->websocket('/ws', $handler);

$conn = new ProbeConnSink();
$raw = $app->handleWebSocket([
    'event' => 'message',
    'id' => 'probe-1',
    'path' => '/ws',
    'data' => '{}',
], $conn);

echo 'raw.type=', gettype($raw), PHP_EOL;
echo 'raw.value=', is_string($raw) ? $raw : var_export($raw, true), PHP_EOL;
echo 'seen.count=', count($handler->seen), PHP_EOL;

$data = json_decode($raw, true);
if (is_array($data)) {
    ksort($data);
    foreach ($data as $k => $v) {
        echo $k . '=' . $v . PHP_EOL;
    }
}

$seen = [];
$slot = null;
$app->websocket('/closure', static function &($connection, ...$arguments) use ($conn, &$seen, &$slot): mixed {
    if ($connection !== $conn) {
        throw new RuntimeException('The callback did not receive the original connection');
    }
    $frame = $arguments[array_key_last($arguments)];
    $event = $frame['event'];
    $seen[] = [$event, array_slice($arguments, 0, -1)];
    $slot = $event === 'message' ? ['data' => $arguments[0]] : null;
    return $slot;
});
$app->handleWebSocket(['event' => 'open', 'id' => 'closure', 'path' => '/closure'], $conn);
$reply = $app->handleWebSocket(['event' => 'message', 'id' => 'closure', 'data' => "a\0b"], $conn);
$app->handleWebSocket(['event' => 'close', 'id' => 'closure', 'code' => 1001, 'reason' => 'bye'], $conn);
if ($reply !== ['data' => "a\0b"] || $seen !== [['open', []], ['message', ["a\0b"]], ['close', [1001, 'bye']]]) {
    throw new RuntimeException('A WebSocket route closure lost an event, argument, or reference result');
}

$invokable = new class {
    public object $reply;
    public function &__invoke($conn, string $message): object { return $this->reply; }
};
$original = $invokable->reply = new stdClass();
$app->container()->set('invokable-handler', $invokable);
$app->websocket('/invokable', 'invokable-handler');
$result = $app->handleWebSocket(['event' => 'message', 'id' => 'invokable', 'path' => '/invokable'], $conn);
$invokable->reply = new stdClass();
if ($result !== $original) {
    throw new RuntimeException('An invokable WebSocket service lost its result object');
}
$service = new class {
    private array $reply = [];
    public function &receive($conn, string $message, array $frame): array
    {
        $this->reply = ['message' => $message, 'id' => $frame['id']];
        return $this->reply;
    }
};
$app->container()->set('method-handler', $service);
$app->websocket('/service', ['method-handler', 'receive']);
if ($app->handleWebSocket(['event' => 'message', 'id' => 'service', 'path' => '/service', 'data' => 'data'], $conn)
    !== ['message' => 'data', 'id' => 'service']) {
    throw new RuntimeException('The WebSocket service method lost its frame arguments');
}

$sendObject = static fn () => new stdClass();
$app->websocket('/ephemeral', $sendObject);
$directReply = $app->handleWebSocket(['event' => 'message', 'id' => 'ephemeral', 'path' => '/ephemeral'], $conn);
$componentReply = (new VSlim\WebSocket\App())->onMessage($sendObject)->handleWebSocket(['event' => 'message'], $conn);
$weakDirect = WeakReference::create($directReply);
$weakComponent = WeakReference::create($componentReply);
unset($directReply, $componentReply);
if ($weakDirect->get() !== null || $weakComponent->get() !== null) {
    throw new RuntimeException('A WebSocket bridge kept an otherwise unreferenced callback result');
}

$protocolHandler = new class {
    public int $fallbackCalls = 0;
    private string $reply = 'method';
    public function __invoke(): string { ++$this->fallbackCalls; return 'wrong'; }
    public function &onMessage(): string { return $this->reply; }
};
$app->websocket('/protocol', $protocolHandler);
if ($app->handleWebSocket(['event' => 'open', 'id' => 'protocol', 'path' => '/protocol'], $conn) !== null
    || $app->handleWebSocket(['event' => 'message', 'id' => 'protocol'], $conn) !== 'method'
    || $protocolHandler->fallbackCalls !== 0) {
    throw new RuntimeException('A WebSocket protocol object did not keep lifecycle method precedence');
}

$rejectedCalls = 0;
$app->websocket('/rejected', static function &() use (&$rejectedCalls): bool {
    ++$rejectedCalls;
    $reject = false;
    return $reject;
});
if ($app->handleWebSocket(['event' => 'open', 'id' => 'rejected', 'path' => '/rejected'], $conn) !== false
    || $app->handleWebSocket(['event' => 'message', 'id' => 'rejected'], $conn) !== null || $rejectedCalls !== 1) {
    throw new RuntimeException('A rejected WebSocket route left a connection binding');
}

$tracked = new class {
    public function id(): string { return 'tracked'; }
    public function rejected(): bool { throw new LogicException('This is a userland connection'); }
    public function closed(): bool { throw new LogicException('This is a userland connection'); }
};
$socketApp = new VSlim\WebSocket\App();
$failure = new DomainException('WebSocket callback failed');
$app->websocket('/failed', static fn () => throw $failure);
try {
    $app->handleWebSocket(['event' => 'open', 'id' => 'failed', 'path' => '/failed'], $conn);
    throw new RuntimeException('The route open exception was lost');
} catch (DomainException $error) {
    if ($error !== $failure || $app->handleWebSocket(['event' => 'message', 'id' => 'failed'], $conn) !== null) {
        throw new RuntimeException('A throwing WebSocket route changed the exception or left a connection binding');
    }
}
foreach ([false, true] as $throw) {
    $socketApp->onOpen(static function &($connection) use ($socketApp, $failure, $throw): bool {
        $socketApp->join('pending', $connection);
        if ($throw) {
            throw $failure;
        }
        $reject = false;
        return $reject;
    });
    try {
        if ($socketApp->handleWebSocket(['event' => 'open'], $tracked) !== false || $throw) {
            throw new RuntimeException('The open callback result or exception was lost');
        }
    } catch (DomainException $error) {
        if (!$throw || $error !== $failure) {
            throw $error;
        }
    }
    if ($socketApp->hasConnection($tracked) || $socketApp->members('pending') !== []) {
        throw new RuntimeException('A failed WebSocket open left connection state');
    }
}
$socketApp->onOpen(static fn (): bool => true);
$socketApp->handleWebSocket(['event' => 'open'], $tracked);
$socketApp->join('pending', $tracked);
$socketApp->onClose(static fn () => throw $failure);
try {
    $socketApp->handleWebSocket(['event' => 'close'], $tracked);
    throw new RuntimeException('The close callback exception was lost');
} catch (DomainException $error) {
    if ($error !== $failure || $socketApp->hasConnection($tracked) || $socketApp->members('pending') !== []) {
        throw new RuntimeException('A failed WebSocket close lost the original exception or left connection state');
    }
}

$handlerRefs = (static function () use ($conn): array {
    $router = new VSlim\App();
    $label = 'plain';
    $closure = static fn () => $label;
    $object = new class {
        public function handleWebSocket(): string { return 'object'; }
    };
    $method = new class {
        public function receive(): string { return 'method'; }
    };
    foreach (['plain' => $closure, 'object' => $object, 'method' => [$method, 'receive']] as $id => $handler) {
        $router->websocket('/' . $id, $handler);
        if ($router->handleWebSocket(['event' => 'message', 'id' => $id, 'path' => '/' . $id], $conn) !== $id) {
            throw new RuntimeException('The WebSocket handler did not dispatch');
        }
    }
    return array_map(WeakReference::create(...), [$router, $closure, $object, $method]);
})();
gc_collect_cycles();
foreach ($handlerRefs as $reference) {
    if ($reference->get() !== null) {
        throw new RuntimeException('The WebSocket dispatch retained an acyclic handler');
    }
}

$cycleRefs = (static function () use ($conn): array {
    $router = new VSlim\App();
    $closure = static fn () => $router->routeCount();
    $router->websocket('/cycle', $closure);
    if ($router->handleWebSocket(['event' => 'message', 'id' => 'cycle', 'path' => '/cycle'], $conn) !== 0) {
        throw new RuntimeException('The cyclic route callback did not run');
    }
    $socketApp = new VSlim\WebSocket\App();
    $callback = static fn () => $socketApp->connectionIds();
    $socketApp->onMessage($callback);
    $connection = new class($socketApp) {
        public function __construct(public VSlim\WebSocket\App $socketApp) {}
        public function id(): string { return '42'; }
    };
    $socketApp->remember($connection);
    if ($socketApp->handleWebSocket(['event' => 'message'], $connection) !== ['42']) {
        throw new RuntimeException('The component did not keep its callback or numeric connection ID');
    }
    return array_map(WeakReference::create(...), [$router, $closure, $socketApp, $callback, $connection]);
})();
gc_collect_cycles();
foreach ($cycleRefs as $reference) {
    if ($reference->get() !== null) {
        throw new RuntimeException('A WebSocket application kept a cycle of PHP objects alive');
    }
}

$replacing = new VSlim\WebSocket\App();
$original = static function () use ($replacing): string {
    $replacing->onMessage(static fn (): string => 'new');
    return 'original';
};
$originalRef = WeakReference::create($original);
$replacing->onMessage($original);
unset($original);
if ($replacing->handleWebSocket(['event' => 'message'], $conn) !== 'original'
    || $originalRef->get() !== null
    || $replacing->handleWebSocket(['event' => 'message'], $conn) !== 'new') {
    throw new RuntimeException('Replacing a running WebSocket callback changed its lifetime or the next callback');
}
?>
--EXPECT--
handler.method_exists=true
handler.is_instance_of=true
conn.method_exists=true
conn.is_instance_of=true
raw.type=string
raw.value={"is_object":"true","class":"ProbeConnSink","is_instance_of":"true","is_subclass_of":"false","method_exists":"true","php_is_a":"true","php_method_exists":"true"}
seen.count=7
class=ProbeConnSink
is_instance_of=true
is_object=true
is_subclass_of=false
method_exists=true
php_is_a=true
php_method_exists=true
