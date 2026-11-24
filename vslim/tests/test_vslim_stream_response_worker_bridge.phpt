--TEST--
php-worker recognizes VSlim StreamResponse objects
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
--FILE--
<?php
declare(strict_types=1);

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
require_once __DIR__ . '/php_worker_package_bootstrap.php';

$app = new VSlim\App();
$app->get('/stream/text', function (mixed $req) {
    $query = method_exists($req, 'getQueryParams') ? $req->getQueryParams() : [];
    return VSlim\Stream\Response::text((function () use ($query): iterable {
        yield "hello:";
        yield $query['name'] ?? 'world';
    })())->setHeader('x-app', 'vslim-stream');
});
function waitForStreamDisconnect(string $trace): void
{
    $deadline = microtime(true) + 3;
    $gate = $trace . '.release';
    while (true) {
        clearstatcache(true, $gate);
        if (is_file($gate)) {
            return;
        }
        if (microtime(true) >= $deadline) {
            throw new RuntimeException('Client did not release the suspended stream');
        }
        usleep(10_000);
    }
}

function disconnectEvents(string $trace): Generator
{
    try {
        file_put_contents($trace, getmypid() . "\n", FILE_APPEND);
        yield ['event' => 'ready', 'data' => 'first'];
        waitForStreamDisconnect($trace);
        file_put_contents($trace, "resumed\n", FILE_APPEND);
        yield ['event' => 'after', 'data' => 'disconnected'];
        file_put_contents($trace, "advanced after disconnect\n", FILE_APPEND);
    } finally {
        file_put_contents($trace, "closed\n", FILE_APPEND);
    }
}

$app->get('/stream/cancel', static function () {
    return VSlim\Stream\Response::sse(disconnectEvents(getenv('VSLIM_STREAM_CANCEL_TRACE')));
});
$app->get('/stream/deferred-cancel', static function () {
    $capture = new stdClass();
    $weak = WeakReference::create($capture);
    $argument = new stdClass();
    $weakArgument = WeakReference::create($argument);
    return VSlim\Stream\Response::sseFrom(
        factory: static function ($trace, $label = 'default', $argument = null) use ($capture, $weak, $weakArgument): Generator {
            if ($label !== 'default' || !$argument instanceof stdClass || $argument !== $weakArgument->get()) {
                throw new RuntimeException('Deferred SSE lost its named factory arguments');
            }
            return (static function () use ($trace, $weak, $weakArgument): Generator {
                if ($weak->get() !== null || $weakArgument->get() !== null) {
                    throw new RuntimeException('Deferred SSE retained the factory or its arguments during delegation');
                }
                yield from disconnectEvents($trace);
            })();
        },
        args: ['argument' => $argument, 'trace' => getenv('VSLIM_STREAM_CANCEL_TRACE')],
    );
});
$app->get('/stream/native-cancel', static function () {
    $trace = getenv('VSLIM_STREAM_CANCEL_TRACE');
    $provider = new VSlim\Psr14\ListenerProvider();
    foreach (['first', 'disconnected', 'unexpected'] as $chunk) {
        $provider->listenAny(new class($trace, $chunk) {
            public function __construct(private string $trace, private string $chunk) {}

            public function __invoke(): void
            {
                throw new LogicException('The stream must consume the listener value');
            }

            public function __toString(): string
            {
                if ($this->chunk === 'first') {
                    file_put_contents($this->trace, getmypid() . "\n", FILE_APPEND);
                } elseif ($this->chunk === 'disconnected') {
                    waitForStreamDisconnect($this->trace);
                    file_put_contents($this->trace, "resumed\n", FILE_APPEND);
                } else {
                    file_put_contents($this->trace, "advanced after disconnect\n", FILE_APPEND);
                }
                return $this->chunk;
            }

            public function __destruct()
            {
                if ($this->chunk === 'unexpected') {
                    file_put_contents($this->trace, "closed\n", FILE_APPEND);
                }
            }
        });
    }
    $events = $provider->getListenersForEvent(new stdClass());
    if (!$events instanceof Generator) {
        throw new RuntimeException('The route must return a native VPHP generator');
    }
    unset($provider);
    return VSlim\Stream\Response::sse($events);
});
final class WorkerResponseErrorProbe
{
    public $context;
    private int $position = 0;

    public function stream_open(string $path, string $mode, int $options, &$openedPath): bool { return true; }
    public function stream_read(int $length): string
    {
        if ($this->position === 0) {
            $chunk = str_repeat("first\0", 1365) . 'xx';
            $this->position = strlen($chunk);
            return $chunk;
        }
        throw new DomainException('PSR-7 response read failed');
    }

    public function stream_eof(): bool { return false; }
    public function stream_stat(): array { return []; }
    public function stream_tell(): int { return $this->position; }
    public function stream_seek(int $offset, int $whence): bool
    {
        $this->position = $offset;
        return true;
    }
}
stream_wrapper_register('vslimworkererror', WorkerResponseErrorProbe::class);
$app->get('/stream/psr-error', static function () {
    $body = (new VSlim\Psr17\StreamFactory())->createStreamFromFile('vslimworkererror://body');
    return (new VSlim\Psr7\Response())->withBody($body);
});
$app->get('/stream/resource-factory-error', static function () {
    return VSlim\Stream\Response::textFrom(
        static fn () => fopen('vslimworkererror://body', 'rb'),
    );
});
$app->get('/pid', static fn (): string => (string) getmypid());
$app->get('/serializable', static fn () => new class implements JsonSerializable {
    public function jsonSerialize(): mixed { return ['source' => 'worker']; }
});
$app->get('/stringable', static fn () => new class {
    public function __toString(): string { return 'worker fragment'; }
});
$app->get('/array-access', static fn () => new ArrayObject([
    'status' => 207,
    'body' => 'worker offsets',
    'content_type' => 'text/plain',
    'headers' => ['X-Envelope' => 'worker'],
    'unused' => 'ignored',
]));
$app->get('/stream/by-reference', static function &() {
    $stream = VSlim\Stream\Response::textFrom(factory: static fn () => ['reference stream']);
    return $stream;
});
$app->get('/stream/weak-listeners', static function () {
    $listener = static fn (string $chunk): object => new class($chunk) {
        public function __construct(private string $chunk) {}
        public function __invoke(): void {}
        public function __toString(): string { return $this->chunk; }
    };
    $provider = new VSlim\Psr14\ListenerProvider();
    $expired = $listener('expired');
    $live = $listener('weak');
    $provider->listenAny($listener('first'))->listenWeak('*', $expired)
        ->listenWeak('*', $live)->listenAny($listener('last'));
    $entries = $provider->getListenersForEvent(new stdClass());
    unset($expired);
    if (count($provider) !== 3) {
        throw new RuntimeException('The worker counted an expired listener');
    }
    return VSlim\Stream\Response::text((static function () use ($entries, $live): Generator {
        yield from $entries;
        unset($live);
    })());
});

require_once dirname(__DIR__) . '/templates/app/bootstrap/worker.php';
if (defined('VSLIM_TEST_WORKER_ENTRY')) {
    return VSlim\Worker\Adapter::app($app);
}

$raw = $app->dispatchEnvelopeWorker([
    'method' => 'GET',
    'path' => '/stream/text?request_id=req-7',
    'query' => ['request_id' => 'req-7'],
]);

echo (is_object($raw) && $raw instanceof VSlim\Stream\Response ? "raw_stream\n" : "raw_not_stream\n");
echo $raw->streamType . "\n";
echo $raw->header('x-app') . "\n";
echo $raw->header('x-request-id') . "\n";

require_once __DIR__ . '/worker_wire_fixture.php';
$trace = tempnam(sys_get_temp_dir(), 'vslim-stream-');
putenv('VSLIM_STREAM_CANCEL_TRACE=' . $trace);
$worker = new WorkerWireFixture(__FILE__, '\VSlim\Worker\Adapter::http');
$frames = iterator_to_array($worker->frames([
    'method' => 'GET',
    'path' => '/stream/text?request_id=req-7',
    'query' => ['request_id' => 'req-7'],
]), false);
echo $frames[0]['event'] . "\n";
echo $frames[0]['stream_type'] . "\n";
echo $frames[0]['headers']['x-app'] . '|' . $frames[0]['headers']['x-request-id'] . "\n";
foreach (array_slice($frames, 1, -1) as $frame) {
    echo base64_decode($frame['data_base64'], true);
}
echo "\n";
try {
    $pid = $worker->request(['method' => 'GET', 'path' => '/pid'])['body'];
    $serializable = $worker->request(['method' => 'GET', 'path' => '/serializable']);
    if ($serializable['status'] !== 200 || $serializable['body'] !== '{"source":"worker"}'
        || ($serializable['headers']['content-type'] ?? '') !== 'application/json; charset=utf-8'
        || $worker->request(['method' => 'GET', 'path' => '/pid'])['body'] !== $pid) {
        throw new RuntimeException('The worker did not normalize the JsonSerializable response');
    }
    $rendered = $worker->request(['method' => 'GET', 'path' => '/stringable']);
    if ($rendered['status'] !== 200 || $rendered['body'] !== 'worker fragment'
        || $worker->request(['method' => 'GET', 'path' => '/pid'])['body'] !== $pid) {
        throw new RuntimeException('The worker did not normalize the Stringable response');
    }
    $arrayAccess = $worker->request(['method' => 'GET', 'path' => '/array-access']);
    if ($arrayAccess['status'] !== 207 || $arrayAccess['body'] !== 'worker offsets'
        || ($arrayAccess['headers']['x-envelope'] ?? '') !== 'worker'
        || $worker->request(['method' => 'GET', 'path' => '/pid'])['body'] !== $pid) {
        throw new RuntimeException('The worker did not normalize the ArrayAccess response');
    }
    $byReference = iterator_to_array($worker->frames(['method' => 'GET', 'path' => '/stream/by-reference']), false);
    if (array_column($byReference, 'event') !== ['start', 'chunk', 'end']
        || base64_decode($byReference[1]['data_base64'], true) !== 'reference stream'
        || $worker->request(['method' => 'GET', 'path' => '/pid'])['body'] !== $pid) {
        throw new RuntimeException('The worker did not stream a response returned by reference');
    }
    foreach (['/stream/psr-error', '/stream/resource-factory-error'] as $path) {
        $failure = iterator_to_array($worker->frames(['method' => 'GET', 'path' => $path]), false);
        $nextPid = $worker->request(['method' => 'GET', 'path' => '/pid'])['body'];
        if (array_column($failure, 'event') !== ['start', 'chunk', 'error']
            || base64_decode($failure[1]['data_base64'], true) !== str_repeat("first\0", 1365) . 'xx'
            || $failure[2]['error_class'] !== DomainException::class
            || $failure[2]['error'] !== 'PSR-7 response read failed'
            || $nextPid !== $pid) {
            throw new RuntimeException('Unexpected stream failure for ' . $path . ': ' . json_encode(
                ['events' => array_column($failure, 'event'), 'last_frame' => end($failure),
                    'pid' => $pid, 'next_pid' => $nextPid], JSON_THROW_ON_ERROR));
        }
    }
    echo "psr_stream_error_same_worker\n";
    $weakStream = iterator_to_array($worker->frames(['method' => 'GET', 'path' => '/stream/weak-listeners']), false);
    $chunks = array_map(static fn (array $frame): string => base64_decode($frame['data_base64'], true),
        array_slice($weakStream, 1, -1));
    if (array_values($chunks) !== ['first', 'weak', 'last']
        || $worker->request(['method' => 'GET', 'path' => '/pid'])['body'] !== $pid) {
        throw new RuntimeException('The worker stream retained an expired listener or changed the listener order');
    }
    foreach (['/stream/cancel' => 'ready', '/stream/deferred-cancel' => 'ready', '/stream/native-cancel' => ''] as $path => $eventName) {
        file_put_contents($trace, '');
        @unlink($trace . '.release');
        $stream = $worker->frames(['method' => 'GET', 'path' => $path]);
        $stream->rewind();
        if (($stream->current()['event'] ?? '') !== 'start') {
            throw new RuntimeException('Expected the SSE start frame');
        }
        $stream->next();
        $first = $stream->current();
        $lines = file($trace, FILE_IGNORE_NEW_LINES);
        if (($first['sse_event'] ?? '') !== $eventName || ($first['data'] ?? '') !== 'first'
            || count($lines) !== 1 || !preg_match('/^\d+$/D', $lines[0])) {
            throw new RuntimeException('The worker did not deliver the first SSE event lazily');
        }
        unset($stream);
        touch($trace . '.release');
        $response = $worker->request(['method' => 'GET', 'path' => '/pid']);
        $finalTrace = file($trace, FILE_IGNORE_NEW_LINES);
        if (($response['status'] ?? 0) !== 200 || ($response['body'] ?? '') !== $lines[0]
            || $finalTrace !== [$lines[0], 'resumed', 'closed']) {
            throw new RuntimeException('Unexpected worker response or generator trace after disconnect at ' . $path . ' ' . json_encode([$response, $finalTrace], JSON_THROW_ON_ERROR));
        }
    }
} finally {
    unset($stream);
    $worker->close();
    putenv('VSLIM_STREAM_CANCEL_TRACE');
    @unlink($trace . '.release');
    unlink($trace);
}
?>
--EXPECT--
raw_stream
text
vslim-stream
req-7
start
text
vslim-stream|req-7
hello:world
psr_stream_error_same_worker
