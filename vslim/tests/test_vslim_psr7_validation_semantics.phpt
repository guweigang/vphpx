--TEST--
VSlim PSR-7 request and response validation follows stricter PSR semantics
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\Http\Message {
    if (!interface_exists(MessageInterface::class, false)) {
        interface MessageInterface {
            public function getProtocolVersion(): string;
            public function withProtocolVersion(string $version);
            public function getHeaders(): array;
            public function hasHeader(string $name): bool;
            public function getHeader($name): array;
            public function getHeaderLine($name): string;
            public function withHeader($name, $value);
            public function withAddedHeader($name, $value);
            public function withoutHeader($name);
            public function getBody(): StreamInterface;
            public function withBody(StreamInterface $body);
        }
    }
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
    if (!interface_exists(ServerRequestInterface::class, false)) {
        interface ServerRequestInterface extends RequestInterface {
            public function getServerParams(): array;
            public function getCookieParams(): array;
            public function withCookieParams(array $cookies);
            public function getQueryParams(): array;
            public function withQueryParams(array $query);
            public function getUploadedFiles(): array;
            public function withUploadedFiles(array $uploadedFiles);
            public function getParsedBody();
            public function withParsedBody($data);
            public function getAttributes(): array;
            public function getAttribute(string $name, $default = null);
            public function withAttribute(string $name, $value);
            public function withoutAttribute(string $name);
        }
    }
    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface extends MessageInterface {
            public function getStatusCode(): int;
            public function withStatus(int $code, string $reasonPhrase = '');
            public function getReasonPhrase(): string;
        }
    }
    if (!interface_exists(ResponseFactoryInterface::class, false)) {
        interface ResponseFactoryInterface {
            public function createResponse(int $code = 200, string $reasonPhrase = ''): ResponseInterface;
        }
    }
    if (!interface_exists(ServerRequestFactoryInterface::class, false)) {
        interface ServerRequestFactoryInterface {
            public function createServerRequest(string $method, $uri, array $serverParams = []): ServerRequestInterface;
        }
    }
    if (!interface_exists(UriFactoryInterface::class, false)) {
        interface UriFactoryInterface {
            public function createUri(string $uri = ''): UriInterface;
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

namespace {
    $responseFactory = new VSlim\Psr17\ResponseFactory();
    $requestFactory = new VSlim\Psr17\ServerRequestFactory();
    $uriFactory = new VSlim\Psr17\UriFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();

    try {
        $responseFactory->createResponse(700);
        echo "factory-status-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "factory-status-invalid\n";
    }

    $response = $responseFactory->createResponse();

    try {
        $response->withStatus(99);
        echo "with-status-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "with-status-invalid\n";
    }

    try {
        $response->withHeader('', 'x');
        echo "header-empty-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "header-empty-invalid\n";
    }

    try {
        $response->withHeader('Bad Header', 'x');
        echo "header-space-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "header-space-invalid\n";
    }

    try {
        $response->withHeader('X-Test', "a\nb");
        echo "header-value-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "header-value-invalid\n";
    }

    $request = $requestFactory->createServerRequest('POST', 'https://example.com/items');

    try {
        $request->withParsedBody('raw-body');
        echo "parsed-scalar-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "parsed-scalar-invalid\n";
    }

    $request2 = $request->withParsedBody((object) ['ok' => true]);
    echo (is_object($request2->getParsedBody()) ? 'parsed-object' : 'parsed-other') . PHP_EOL;

    try {
        $uriFactory->createUri('https://example.com')->withPort(70000);
        echo "port-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "port-invalid\n";
    }

    $body = $streamFactory->createStream('payload');
    $response2 = $response
        ->withHeader('X-Test', ['a', 'b'])
        ->withBody($body)
        ->withStatus(201);
    echo $response2->getHeaderLine('x-test') . '|' . (string) $response2->getBody() . '|' . $response2->getStatusCode() . PHP_EOL;
}
?>
--EXPECT--
factory-status-invalid
with-status-invalid
header-empty-invalid
header-space-invalid
header-value-invalid
parsed-scalar-invalid
parsed-object
port-invalid
a, b|payload|201
