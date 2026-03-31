--TEST--
VSlim PSR-18 classes satisfy client and exception interface bindings
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
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
    $client = new VSlim\Psr18\Client();
    $requestEx = new VSlim\Psr18\RequestException('bad request', 0);
    $networkEx = new VSlim\Psr18\NetworkException('network down', 0);

    var_dump($client instanceof Psr\Http\Client\ClientInterface);
    var_dump($requestEx instanceof Psr\Http\Client\RequestExceptionInterface);
    var_dump($requestEx instanceof Psr\Http\Client\ClientExceptionInterface);
    var_dump($networkEx instanceof Psr\Http\Client\NetworkExceptionInterface);
    var_dump($networkEx instanceof Psr\Http\Client\ClientExceptionInterface);
    var_dump(method_exists($requestEx, 'getRequest'));
    var_dump(method_exists($networkEx, 'getRequest'));

    $implements = class_implements(VSlim\Psr18\Client::class);
    var_dump(isset($implements['Psr\\Http\\Client\\ClientInterface']));
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
