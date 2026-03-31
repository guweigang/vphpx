--TEST--
VSlim PSR-7 preserves header case in getHeaders and validates method and request target
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
}

namespace {
    $request = (new VSlim\Psr17\RequestFactory())->createRequest('POST', 'https://demo.local/items');
    $response = (new VSlim\Psr17\ResponseFactory())->createResponse();
    $serverRequest = (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('GET', 'https://demo.local/path');

    $request2 = $request
        ->withHeader('X-Custom-Token', 'a')
        ->withAddedHeader('x-custom-token', 'b')
        ->withHeader('ETag', 'v1');
    $response2 = $response->withHeader('Content-Type', 'text/plain');
    $serverRequest2 = $serverRequest->withHeader('X-Trace-Id', 'demo');

    echo implode(',', array_keys($request2->getHeaders())) . PHP_EOL;
    echo $request2->getHeaderLine('X-CUSTOM-TOKEN') . '|' . $request2->getHeaders()['X-Custom-Token'][0] . PHP_EOL;
    echo implode(',', array_keys($response2->getHeaders())) . PHP_EOL;
    echo implode(',', array_keys($serverRequest2->getHeaders())) . PHP_EOL;

    try {
        $request->withMethod('');
        echo "method-empty-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "method-empty-invalid\n";
    }

    try {
        $request->withRequestTarget("bad target");
        echo "target-space-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "target-space-invalid\n";
    }

    try {
        (new VSlim\Psr17\RequestFactory())->createRequest('', '/');
        echo "factory-method-empty-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "factory-method-empty-invalid\n";
    }
}
?>
--EXPECT--
Host,X-Custom-Token,ETag
a, b|a
Content-Type
Host,X-Trace-Id
method-empty-invalid
target-space-invalid
factory-method-empty-invalid
