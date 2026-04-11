<?php
namespace Psr\Http\Message {
    if (!interface_exists(RequestInterface::class, false)) {
        interface StreamInterface { public function __toString(): string; public function close(): void; public function detach(); public function getSize(): ?int; public function tell(): int; public function eof(): bool; public function isSeekable(): bool; public function seek(int $offset, int $whence = SEEK_SET): void; public function rewind(): void; public function isWritable(): bool; public function write(string $string): int; public function isReadable(): bool; public function read(int $length): string; public function getContents(): string; public function getMetadata($key = null); }
        interface UriInterface { public function getScheme(): string; public function getAuthority(): string; public function getUserInfo(): string; public function getHost(): string; public function getPort(): ?int; public function getPath(): string; public function getQuery(): string; public function getFragment(): string; public function withScheme(string $scheme); public function withUserInfo(string $user, ?string $password = null); public function withHost(string $host); public function withPort(?int $port); public function withPath(string $path); public function withQuery(string $query); public function withFragment(string $fragment); public function __toString(): string; }
        interface MessageInterface { public function getProtocolVersion(): string; public function withProtocolVersion(string $version); public function getHeaders(): array; public function hasHeader(string $name): bool; public function getHeader($name): array; public function getHeaderLine($name): string; public function withHeader($name, $value); public function withAddedHeader($name, $value); public function withoutHeader($name); public function getBody(): StreamInterface; public function withBody(StreamInterface $body); }
        interface RequestInterface extends MessageInterface { public function getRequestTarget(): string; public function withRequestTarget(string $requestTarget); public function getMethod(): string; public function withMethod(string $method); public function getUri(): UriInterface; public function withUri(UriInterface $uri, bool $preserveHost = false); }
        interface RequestFactoryInterface { public function createRequest(string $method, $uri): RequestInterface; }
    }
}
namespace Psr\Http\Client {
    if (!interface_exists(ClientExceptionInterface::class, false)) {
        interface ClientExceptionInterface extends \Throwable {}
        interface RequestExceptionInterface extends ClientExceptionInterface { public function getRequest(): \Psr\Http\Message\RequestInterface; }
    }
}
namespace {
    // PROBE: only attach, no getRequest
    $f = new VSlim\Psr17\RequestFactory();
    $r = $f->createRequest('GET', 'https://example.com/x');
    $ex = new VSlim\Psr18\RequestException('t', 0);
    $ex->attachRequest($r);
    unset($ex);
    unset($r);
    echo "ok\n";
}
?>
