<?php
namespace Psr\Http\Message {
    if (!interface_exists(StreamInterface::class, false)) {
        interface StreamInterface {
            public function __toString(): string;
            public function close(): void;
            public function detach();
            public function getSize(): ?int;
            public function tell(): int;
            public function eof(): bool;
            public function isSeekable(): bool;
            public function seek(int $offset, int $whence = SEEK_SET): void;
            public function rewind(): void;
            public function isWritable(): bool;
            public function write(string $string): int;
            public function isReadable(): bool;
            public function read(int $length): string;
            public function getContents(): string;
            public function getMetadata($key = null);
        }
    }
    if (!interface_exists(UriInterface::class, false)) {
        interface UriInterface {
            public function getScheme(): string;
            public function getAuthority(): string;
            public function getUserInfo(): string;
            public function getHost(): string;
            public function getPort(): ?int;
            public function getPath(): string;
            public function getQuery(): string;
            public function getFragment(): string;
            public function withScheme(string $scheme);
            public function withUserInfo(string $user, ?string $password = null);
            public function withHost(string $host);
            public function withPort(?int $port);
            public function withPath(string $path);
            public function withQuery(string $query);
            public function withFragment(string $fragment);
            public function __toString(): string;
        }
    }
    if (!interface_exists(MessageInterface::class, false)) {
        interface MessageInterface {
            public function getProtocolVersion(): string;
            public function withProtocolVersion(string $version);
            public function getHeaders(): array;
            public function hasHeader($name): bool;
            public function getHeader($name): array;
            public function getHeaderLine($name): string;
            public function withHeader($name, $value);
            public function withAddedHeader($name, $value);
            public function withoutHeader($name);
            public function getBody(): StreamInterface;
            public function withBody(StreamInterface $body);
        }
    }
    if (!interface_exists(RequestInterface::class, false)) {
        interface RequestInterface extends MessageInterface {
            public function getRequestTarget(): string;
            public function withRequestTarget(string $requestTarget);
            public function getMethod(): string;
            public function withMethod(string $method);
            public function getUri(): UriInterface;
            public function withUri(UriInterface $uri, bool $preserveHost = false);
        }
    }
    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface extends MessageInterface {
            public function getStatusCode(): int;
            public function withStatus(int $code, string $reasonPhrase = '');
            public function getReasonPhrase(): string;
        }
    }
    if (!interface_exists(RequestFactoryInterface::class, false)) {
        interface RequestFactoryInterface {
            public function createRequest(string $method, $uri): RequestInterface;
        }
    }
    if (!interface_exists(StreamFactoryInterface::class, false)) {
        interface StreamFactoryInterface {
            public function createStream(string $content = ''): StreamInterface;
            public function createStreamFromFile(string $filename, string $mode = 'r'): StreamInterface;
            public function createStreamFromResource($resource): StreamInterface;
        }
    }
}

namespace Psr\Http\Client {
    if (!interface_exists(ClientExceptionInterface::class, false)) {
        interface ClientExceptionInterface extends \Throwable {}
    }
    if (!interface_exists(RequestExceptionInterface::class, false)) {
        interface RequestExceptionInterface extends ClientExceptionInterface {
            public function getRequest(): \Psr\Http\Message\RequestInterface;
        }
    }
    if (!interface_exists(NetworkExceptionInterface::class, false)) {
        interface NetworkExceptionInterface extends ClientExceptionInterface {
            public function getRequest(): \Psr\Http\Message\RequestInterface;
        }
    }
    if (!interface_exists(ClientInterface::class, false)) {
        interface ClientInterface {
            public function sendRequest(\Psr\Http\Message\RequestInterface $request): \Psr\Http\Message\ResponseInterface;
        }
    }
}

namespace {
    function pick_free_port(): int {
        $server = stream_socket_server('tcp://127.0.0.1:0', $errno, $errstr);
        if (!$server) {
            throw new RuntimeException($errstr ?: 'port probe failed');
        }
        $name = stream_socket_get_name($server, false);
        fclose($server);
        return (int) substr(strrchr($name, ':'), 1);
    }

    function start_fixture_server(string $router): array {
        $php = getenv('TEST_PHP_EXECUTABLE') ?: PHP_BINARY;
        $port = pick_free_port();
        $cmd = sprintf(
            '%s -S 127.0.0.1:%d %s',
            escapeshellarg($php),
            $port,
            escapeshellarg($router)
        );
        $spec = [
            0 => ['pipe', 'r'],
            1 => ['file', sys_get_temp_dir() . '/vslim-psr18-server.out', 'a'],
            2 => ['file', sys_get_temp_dir() . '/vslim-psr18-server.err', 'a'],
        ];
        $proc = proc_open($cmd, $spec, $pipes, dirname($router));
        if (!is_resource($proc)) {
            throw new RuntimeException('failed to start built-in server');
        }
        fclose($pipes[0]);

        $ctx = stream_context_create(['http' => ['timeout' => 1]]);
        $health = 'http://127.0.0.1:' . $port . '/health';
        $ok = false;
        for ($i = 0; $i < 40; $i++) {
            $body = @file_get_contents($health, false, $ctx);
            if ($body === 'ok') {
                $ok = true;
                break;
            }
            usleep(50000);
        }
        if (!$ok) {
            proc_terminate($proc);
            proc_close($proc);
            throw new RuntimeException('fixture server did not become healthy');
        }
        return [$proc, $port];
    }

    function stop_fixture_server($proc): void {
        if (is_resource($proc)) {
            proc_terminate($proc);
            proc_close($proc);
        }
    }

    $router = __DIR__ . '/fixtures/psr18_router.php';
    [$proc, $port] = start_fixture_server($router);
    register_shutdown_function(static function () use ($proc): void {
        stop_fixture_server($proc);
    });

    $client = (new VSlim\Psr18\Client())->timeout(5);
    $requestFactory = new VSlim\Psr17\RequestFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();

    $get = $requestFactory
        ->createRequest('GET', 'http://127.0.0.1:' . $port . '/echo?foo=bar')
        ->withHeader('X-Test', 'alpha');
    $response = $client->sendRequest($get);
    $payload = json_decode((string) $response->getBody(), true);
    echo $response->getStatusCode() . '|' . $response->getHeaderLine('x-reply-path') . '|' . $payload['method'] . '|' . $payload['query']['foo'] . '|' . $payload['headers']['X-Test'] . PHP_EOL;

    $post = $requestFactory
        ->createRequest('POST', 'http://127.0.0.1:' . $port . '/submit')
        ->withHeader('Content-Type', 'application/json')
        ->withBody($streamFactory->createStream('{"ok":true}'));
    $postResponse = $client->sendRequest($post);
    $postPayload = json_decode((string) $postResponse->getBody(), true);
    echo $postResponse->getStatusCode() . '|' . $postPayload['method'] . '|' . $postPayload['body'] . '|' . $postPayload['headers']['Content-Type'] . PHP_EOL;

    $notFound = $client->sendRequest($requestFactory->createRequest('GET', 'http://127.0.0.1:' . $port . '/status/404'));
    $serverError = $client->sendRequest($requestFactory->createRequest('GET', 'http://127.0.0.1:' . $port . '/status/500'));
    echo $notFound->getStatusCode() . '|' . $serverError->getStatusCode() . PHP_EOL;

    $badRequest = $requestFactory->createRequest('GET', 'ftp://127.0.0.1/file.txt');
    try {
        $client->sendRequest($badRequest);
        echo "bad-request-miss\n";
    } catch (\Throwable $e) {
        echo get_class($e) . '|' . ($e instanceof Psr\Http\Client\RequestExceptionInterface ? 'rq' : 'no') . '|' . ($e->getRequest() === $badRequest ? 'same' : 'diff') . PHP_EOL;
    }

    $unusedPort = pick_free_port();
    $networkRequest = $requestFactory->createRequest('GET', 'http://127.0.0.1:' . $unusedPort . '/offline');
    try {
        $client->sendRequest($networkRequest);
        echo "network-miss\n";
    } catch (\Throwable $e) {
        echo get_class($e) . '|' . ($e instanceof Psr\Http\Client\NetworkExceptionInterface ? 'net' : 'no') . '|' . ($e->getRequest() === $networkRequest ? 'same' : 'diff') . PHP_EOL;
    }

    stop_fixture_server($proc);
}
?>
