<?php
declare(strict_types=1);

final class WorkerHeadStreamProbe
{
    public $context;
    private string $path;
    private int $position = 0;

    public function stream_open(string $path, string $mode, int $options, &$openedPath): bool
    {
        $this->path = substr($path, strlen('vslimheadprobe://'));
        return true;
    }

    public function stream_read(int $length): string
    {
        file_put_contents($this->path, 'read');
        ++$this->position;
        return 'x';
    }

    public function stream_eof(): bool { return $this->position > 0; }
    public function stream_stat(): array { return []; }
    public function stream_tell(): int { return $this->position; }
    public function stream_seek(int $offset, int $whence): bool
    {
        $this->position = $offset;
        return true;
    }
}

stream_wrapper_register('vslimheadprobe', WorkerHeadStreamProbe::class);

require_once __DIR__ . '/vslim_envelope_map_fixture.php';

final class WorkerForeignPsrResponse implements \Psr\Http\Message\ResponseInterface
{
    public function __construct(
        private \Psr\Http\Message\ResponseInterface $metadata,
        private string $file,
        private string $accessLog,
        private ?RuntimeException $bodyFailure = null,
    ) {}

    public function getProtocolVersion(): string { return $this->metadata->getProtocolVersion(); }
    public function withProtocolVersion($version): self { return $this->withMetadata($this->metadata->withProtocolVersion($version)); }
    public function getHeaders(): array { return $this->metadata->getHeaders(); }
    public function hasHeader($name): bool { return $this->metadata->hasHeader($name); }
    public function getHeader($name): array { return $this->metadata->getHeader($name); }
    public function getHeaderLine($name): string { return $this->metadata->getHeaderLine($name); }
    public function withHeader($name, $value): self { return $this->withMetadata($this->metadata->withHeader($name, $value)); }
    public function withAddedHeader($name, $value): self { return $this->withMetadata($this->metadata->withAddedHeader($name, $value)); }
    public function withoutHeader($name): self { return $this->withMetadata($this->metadata->withoutHeader($name)); }
    public function withBody(\Psr\Http\Message\StreamInterface $body): \Psr\Http\Message\MessageInterface { return $this->metadata->withBody($body); }
    public function getStatusCode(): int { return $this->metadata->getStatusCode(); }
    public function withStatus($code, $reasonPhrase = ''): self { return $this->withMetadata($this->metadata->withStatus($code, $reasonPhrase)); }
    public function getReasonPhrase(): string { return $this->metadata->getReasonPhrase(); }

    private function withMetadata(\Psr\Http\Message\ResponseInterface $metadata): self
    {
        return new self($metadata, $this->file, $this->accessLog, $this->bodyFailure);
    }

    public function getBody(): \Psr\Http\Message\StreamInterface
    {
        file_put_contents($this->accessLog, "getBody\n", FILE_APPEND);
        if ($this->bodyFailure !== null) {
            $failure = $this->bodyFailure;
            $this->bodyFailure = null;
            throw $failure;
        }
        return (new VSlim\Psr17\StreamFactory())->createStreamFromFile($this->file, 'rb');
    }
}

return static function (mixed $request, array $envelope = []): mixed {
    $path = (string) ($envelope["path"] ?? "/");

    if ($path === '/task-stream-body') {
        $domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
        [$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
        stream_set_blocking($reader, false);
        try {
            $response = VSlim\Stream\Response::textFrom(static fn () => $reader);
            $consumer = VSlim\Task::spawn(static fn () => iterator_to_array($response->chunks(), false), []);
            $producer = VSlim\Task::spawn(static function () use ($writer): void {
                VSlim\Task::sleep(0);
                fwrite($writer, "fiber\0stream");
                fclose($writer);
            }, []);
            [$chunks] = VSlim\Task::waitAll([$consumer, $producer]);
            return VSlim\Stream\Response::text($chunks)->setHeader('X-Worker-Pid', (string) getmypid());
        } finally {
            fclose($reader);
            if (is_resource($writer)) {
                fclose($writer);
            }
        }
    }

    if ($path === '/task-cancel' || $path === '/task-after-cancel') {
        $domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
        [$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
        stream_set_blocking($reader, false);
        stream_set_blocking($writer, false);
        try {
            $read = VSlim\Task::spawn(static function () use ($reader, $path, $envelope): string {
                try {
                    if (!VSlim\Task::awaitReadable($reader, 1000)) {
                        throw new RuntimeException('Worker task timed out');
                    }
                    $chunk = fread($reader, 1);
                    if ($path === '/task-after-cancel') {
                        fclose($reader);
                    }
                    return $chunk;
                } finally {
                    if ($path === '/task-cancel') {
                        $token = (string) ($envelope['headers']['x-stream-test-token'] ?? '');
                        if (preg_match('/^[0-9]+_[0-9]+$/D', $token)) {
                            file_put_contents(sys_get_temp_dir() . '/vhttpd_stream_' . $token . '/task-pid', (string) getmypid());
                        }
                    }
                }
            }, []);
            $peer = $path === '/task-cancel'
                ? VSlim\Task::spawn(static fn () => $read->cancel(), [])
                : VSlim\Task::spawn(static function ($stream, $delay = 4, $chunk = ''): int {
                    VSlim\Task::sleep($delay);
                    return fwrite($stream, $chunk);
                }, ['chunk' => 'r', 'stream' => $writer]);
            $tasks = [$read, $peer];
            if ($path === '/task-after-cancel') {
                $tasks[] = VSlim\Task::spawn(static fn () => VSlim\Task::awaitReadable($reader), []);
            }
            $results = VSlim\Task::waitAll($tasks);
            if ($path === '/task-after-cancel' && $results[2] !== false) {
                throw new RuntimeException('Worker reported readiness after the stream closed');
            }
            [$body] = $results;
            return ['status' => 200, 'headers' => ['x-worker-pid' => (string) getmypid()], 'body' => $body];
        } finally {
            fclose($writer);
            if (is_resource($reader)) {
                fclose($reader);
            }
        }
    }

    if (str_starts_with($path, '/psr-stream/')) {
        $token = (string) ($envelope['headers']['x-stream-test-token'] ?? '');
        if (!preg_match('/^[0-9]+_[0-9]+$/D', $token)) {
            throw new RuntimeException('Missing worker stream fixture token');
        }
        $dir = sys_get_temp_dir() . '/vhttpd_stream_' . $token;
        $app = new VSlim\App();
        $failure = in_array($path, ['/psr-stream/foreign-after-retry', '/psr-stream/foreign-open-error'], true)
            ? new RuntimeException('body open failed')
            : null;
        $foreign = static fn (int $status): WorkerForeignPsrResponse => new WorkerForeignPsrResponse(
            (new VSlim\Psr7\Response($status))
                ->withHeader('Content-Type', 'application/octet-stream')
                ->withHeader('X-Worker-Pid', (string) getmypid()),
            $dir . '/input.bin',
            $dir . '/foreign-body',
            $failure,
        );
        if ($path === '/psr-stream/foreign-terminal-missing') {
            $app->setNotFoundHandler(static fn () => $foreign(404));
            return $app->dispatchEnvelopeWorker($envelope);
        }
        if ($path === '/psr-stream/foreign-terminal-method') {
            $app->setErrorHandler(static fn () => $foreign(204));
        }
        if ($path === '/psr-stream/foreign-before-halt') {
            $app->before(new class($foreign) implements \Psr\Http\Server\MiddlewareInterface {
                public function __construct(private Closure $foreign) {}

                public function process(
                    \Psr\Http\Message\ServerRequestInterface $request,
                    \Psr\Http\Server\RequestHandlerInterface $handler,
                ): \Psr\Http\Message\ResponseInterface {
                    $handler->handle($request);
                    return ($this->foreign)(204);
                }
            });
        }
        $routes = $app->group('/psr-stream');
        if (str_starts_with($path, '/psr-stream/foreign-middle-')) {
            foreach (['App' => $app, 'Group' => $routes] as $scope => $registrar) {
                $registrar->middleware(new class($scope, $dir) implements \Psr\Http\Server\MiddlewareInterface {
                    public function __construct(private string $scope, private string $dir) {}

                    public function process(
                        \Psr\Http\Message\ServerRequestInterface $request,
                        \Psr\Http\Server\RequestHandlerInterface $handler,
                    ): \Psr\Http\Message\ResponseInterface {
                        $response = $handler->handle($request);
                        if (is_file($this->dir . '/foreign-body')) {
                            throw new RuntimeException('NextHandler acquired the body before middleware requested it');
                        }
                        return $response->withHeader('X-Middle-' . $this->scope, 'ran');
                    }
                });
            }
        }
        if ($path === '/psr-stream/foreign-promoted' || str_starts_with($path, '/psr-stream/foreign-after-')) {
            $app->after(new class($path, $dir, $failure) implements \Psr\Http\Server\MiddlewareInterface {
                public function __construct(
                    private string $path,
                    private string $dir,
                    private ?RuntimeException $failure,
                ) {}

                public function process(
                    \Psr\Http\Message\ServerRequestInterface $request,
                    \Psr\Http\Server\RequestHandlerInterface $handler,
                ): \Psr\Http\Message\ResponseInterface {
                    $response = $handler->handle($request)->withHeader('X-After', 'ran');
                    if (is_file($this->dir . '/foreign-body')) {
                        throw new RuntimeException('The worker acquired the body before middleware requested it');
                    }
                    return match ($this->path) {
                        '/psr-stream/foreign-promoted' => $response->withStatus(202),
                        '/psr-stream/foreign-after-demoted' => $response->withStatus(204),
                        '/psr-stream/foreign-after-replaced' => $response->withBody(
                            (new VSlim\Psr17\StreamFactory())->createStream('replacement'),
                        ),
                        '/psr-stream/foreign-after-read' => $this->checkSharedBody($response),
                        '/psr-stream/foreign-after-retry' => $this->retryBody($response),
                        default => $response,
                    };
                }

                private function checkSharedBody(
                    \Psr\Http\Message\ResponseInterface $response,
                ): \Psr\Http\Message\ResponseInterface {
                    $cloned = $response->withHeader('X-Body-Inspected', 'yes');
                    if ($response->getBody()->read(4) !== 'data' || $response->getBody() !== $cloned->getBody()) {
                        throw new RuntimeException('Middleware copies lost the shared PSR-7 body');
                    }
                    return $cloned;
                }

                private function retryBody(
                    \Psr\Http\Message\ResponseInterface $response,
                ): \Psr\Http\Message\ResponseInterface {
                    try {
                        $response->getBody();
                        throw new LogicException('Opening the body should have thrown');
                    } catch (RuntimeException $caught) {
                        if ($caught !== $this->failure) {
                            throw $caught;
                        }
                    }
                    return $this->checkSharedBody($response);
                }
            });
        }
        $routes->get('/:kind', static function () use ($path, $dir, $foreign) {
            $headers = ['x-worker-pid' => (string) getmypid()];
            if (str_starts_with($path, '/psr-stream/foreign-')) {
                if ($path === '/psr-stream/foreign-before-halt') {
                    throw new RuntimeException('The route ran after a before middleware returned a response');
                }
                $status = match ($path) {
                    '/psr-stream/foreign-no-content', '/psr-stream/foreign-promoted',
                    '/psr-stream/foreign-after-no-content', '/psr-stream/foreign-middle-no-content' => 204,
                    '/psr-stream/foreign-reset' => 205,
                    '/psr-stream/foreign-not-modified' => 304,
                    default => 202,
                };
                return $foreign($status);
            }
            if ($path === '/psr-stream/raw-head') {
                $chunks = (static function () use ($dir): Generator {
                    file_put_contents($dir . '/raw-read', 'read');
                    yield 'suppressed';
                })();
                return VSlim\Stream\Response::textWith($chunks, 202, 'application/octet-stream', $headers);
            }
            $fromFactory = str_starts_with($path, '/psr-stream/factory-resource-');
            if ($fromFactory || str_starts_with($path, '/psr-stream/resource-')) {
                $nonblocking = str_ends_with($path, '-nonblocking-pipe');
                $kind = substr($path, strrpos($path, '-') + 1);
                $filename = match ($kind) {
                    'head' => 'vslimheadprobe://' . $dir . '/resource-read',
                    'pipe' => $dir . '/input.fifo',
                    default => $dir . '/input.bin',
                };
                $open = static function (string $filename, int $offset, ?string $marker = null) use ($nonblocking) {
                    if ($marker !== null) {
                        file_put_contents($marker, 'opened');
                    }
                    $resource = fopen($filename, 'rb');
                    if ($nonblocking && !stream_set_blocking($resource, false)) {
                        throw new RuntimeException('Could not set the fixture to nonblocking mode');
                    }
                    if ($offset !== 0) {
                        fseek($resource, $offset);
                    }
                    return $resource;
                };
                $offset = $kind === 'file' ? 3 : 0;
                if ($fromFactory) {
                    return VSlim\Stream\Response::textFrom(
                        args: ['offset' => $offset, 'filename' => $filename, 'marker' => $dir . '/resource-open'],
                        factory: $open,
                        waitTimeoutMs: $nonblocking ? 2500 : -1,
                    )->setStatus(202)
                        ->setContentType('application/octet-stream')
                        ->setHeader('X-Worker-Pid', $headers['x-worker-pid']);
                }
                if ($nonblocking) {
                    return VSlim\Stream\Response::textStream($open($filename, $offset), waitTimeoutMs: 2500)
                        ->setStatus(202)
                        ->setContentType('application/octet-stream')
                        ->setHeader('X-Worker-Pid', $headers['x-worker-pid']);
                }
                return VSlim\Stream\Response::textWith($open($filename, $offset), 202, 'application/octet-stream', $headers);
            }
            $factory = new VSlim\Psr17\StreamFactory();
            $filename = match ($path) {
                '/psr-stream/pipe' => $dir . '/input.fifo',
                '/psr-stream/head', '/psr-stream/no-content' => 'vslimheadprobe://' . $dir . '/psr-read',
                default => $dir . '/input.bin',
            };
            $body = $factory->createStreamFromFile($filename, 'rb');
            if ($path === '/psr-stream/file') {
                $body->seek(3);
            }
            return (new VSlim\Psr7\Response($path === '/psr-stream/no-content' ? 204 : 202))
                ->withHeader('Content-Type', 'application/octet-stream')
                ->withHeader('X-Worker-Pid', $headers['x-worker-pid'])
                ->withBody($body);
        });
        return $app->dispatchEnvelopeWorker($envelope);
    }

    if (str_starts_with($path, "/stream/sse")) {
        $events = (function () use ($envelope): iterable {
            $rid = (string) (($envelope["headers"]["x-request-id"] ?? "") ?: "no-rid");
            yield [
                "id" => $rid . "-1",
                "event" => "ping",
                "data" => json_encode(["seq" => 1, "request_id" => $rid], JSON_UNESCAPED_UNICODE),
            ];
            yield [
                "id" => $rid . "-2",
                "event" => "ping",
                "data" => json_encode(["seq" => 2, "request_id" => $rid], JSON_UNESCAPED_UNICODE),
            ];
        })();
        return \VHttpd\PhpWorker\StreamResponse::sse($events, 200, [
            "x-stream-source" => "php-worker",
        ]);
    }

    if (str_starts_with($path, "/stream/text")) {
        $chunks = (function (): iterable {
            yield "chunk-a\n";
            yield "chunk-b\n";
        })();
        return \VHttpd\PhpWorker\StreamResponse::text(
            $chunks,
            200,
            "text/plain; charset=utf-8",
            ["x-stream-source" => "php-worker"],
        );
    }

    return [
        "status" => 404,
        "content_type" => "text/plain; charset=utf-8",
        "body" => "Not Found",
    ];
};
