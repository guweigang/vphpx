--TEST--
VSlim native PSR-17 RequestFactory builds immutable PSR-7 Request objects
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
    if (!interface_exists(UriFactoryInterface::class, false)) {
        interface UriFactoryInterface {
            public function createUri(string $uri = ''): UriInterface;
        }
    }
}

namespace {
    $requestFactory = new VSlim\Psr17\RequestFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();
    $uriFactory = new VSlim\Psr17\UriFactory();

    echo ($requestFactory instanceof Psr\Http\Message\RequestFactoryInterface ? 'rqf-yes' : 'rqf-no') . PHP_EOL;

    $request = $requestFactory->createRequest('POST', 'https://api.example.com:8443/items?trace=1');
    echo get_class($request) . PHP_EOL;
    echo ($request instanceof Psr\Http\Message\RequestInterface ? 'req-yes' : 'req-no') . PHP_EOL;
    echo $request->getMethod() . '|' . $request->getRequestTarget() . PHP_EOL;
    echo get_class($request->getUri()) . '|' . (string) $request->getUri() . PHP_EOL;
    echo $request->getHeaderLine('host') . PHP_EOL;

    $request2 = $request
        ->withHeader('X-Test', 'a')
        ->withAddedHeader('X-Test', 'b')
        ->withBody($streamFactory->createStream('payload'))
        ->withProtocolVersion('2');
    echo $request->hasHeader('x-test') ? "orig-has\n" : "orig-miss\n";
    echo $request2->getHeaderLine('x-test') . PHP_EOL;
    echo (string) $request2->getBody() . '|' . $request2->getProtocolVersion() . PHP_EOL;

    $request3 = $request2
        ->withRequestTarget('*')
        ->withMethod('PATCH');
    echo $request3->getMethod() . '|' . $request3->getRequestTarget() . PHP_EOL;

    $newUri = $uriFactory->createUri('http://other.test/v2?ok=1');
    $request4 = $request3->withUri($newUri);
    $request5 = $request3->withUri($newUri, true);
    echo $request4->getHeaderLine('host') . '|' . (string) $request4->getUri() . '|' . $request4->getRequestTarget() . PHP_EOL;
    echo $request5->getHeaderLine('host') . '|' . (string) $request5->getUri() . '|' . $request5->getRequestTarget() . PHP_EOL;

    $request6 = $requestFactory->createRequest('GET', $uriFactory->createUri('/local?q=2'));
    echo $request6->getRequestTarget() . PHP_EOL;
    echo $request6->hasHeader('host') ? "host-set\n" : "host-miss\n";
}
?>
--EXPECT--
rqf-yes
VSlim\Psr7\Request
req-yes
POST|/items?trace=1
VSlim\Psr7\Uri|https://api.example.com:8443/items?trace=1
api.example.com:8443
orig-miss
a, b
payload|2
PATCH|*
other.test|http://other.test/v2?ok=1|*
api.example.com:8443|http://other.test/v2?ok=1|*
/local?q=2
host-miss
