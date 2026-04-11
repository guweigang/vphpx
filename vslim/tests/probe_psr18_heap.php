<?php
// Minimal probe: does PSR-18 exception + getRequest alone trigger heap corruption?

// Register PSR interfaces (minimal stubs)
namespace Psr\Http\Message {
    if (!interface_exists(RequestInterface::class, false)) {
        interface StreamInterface { public function __toString(): string; public function close(): void; public function detach(); public function getSize(): ?int; public function tell(): int; public function eof(): bool; public function isSeekable(): bool; public function seek(int $offset, int $whence = SEEK_SET): void; public function rewind(): void; public function isWritable(): bool; public function write(string $string): int; public function isReadable(): bool; public function read(int $length): string; public function getContents(): string; public function getMetadata($key = null); }
        interface UriInterface { public function getScheme(): string; public function getAuthority(): string; public function getUserInfo(): string; public function getHost(): string; public function getPort(): ?int; public function getPath(): string; public function getQuery(): string; public function getFragment(): string; public function withScheme(string $scheme); public function withUserInfo(string $user, ?string $password = null); public function withHost(string $host); public function withPort(?int $port); public function withPath(string $path); public function withQuery(string $query); public function withFragment(string $fragment); public function __toString(): string; }
        interface MessageInterface { public function getProtocolVersion(): string; public function withProtocolVersion(string $version); public function getHeaders(): array; public function hasHeader(string $name): bool; public function getHeader($name): array; public function getHeaderLine($name): string; public function withHeader($name, $value); public function withAddedHeader($name, $value); public function withoutHeader($name); public function getBody(): StreamInterface; public function withBody(StreamInterface $body); }
        interface RequestInterface extends MessageInterface { public function getRequestTarget(): string; public function withRequestTarget(string $requestTarget); public function getMethod(): string; public function withMethod(string $method); public function getUri(): UriInterface; public function withUri(UriInterface $uri, bool $preserveHost = false); }
        interface ResponseInterface extends MessageInterface { public function getStatusCode(): int; public function withStatus(int $code, string $reasonPhrase = ''); public function getReasonPhrase(): string; }
        interface RequestFactoryInterface { public function createRequest(string $method, $uri): RequestInterface; }
    }
}
namespace Psr\Http\Client {
    if (!interface_exists(ClientExceptionInterface::class, false)) {
        interface ClientExceptionInterface extends \Throwable {}
        interface RequestExceptionInterface extends ClientExceptionInterface { public function getRequest(): \Psr\Http\Message\RequestInterface; }
        interface NetworkExceptionInterface extends ClientExceptionInterface { public function getRequest(): \Psr\Http\Message\RequestInterface; }
        interface ClientInterface { public function sendRequest(\Psr\Http\Message\RequestInterface $request): \Psr\Http\Message\ResponseInterface; }
    }
}
namespace {
    echo "probe1: create request\n";
    $factory = new VSlim\Psr17\RequestFactory();
    $request = $factory->createRequest('GET', 'ftp://example.com/file.txt');
    echo "probe2: request created, refcount should be 1\n";
    
    $client = new VSlim\Psr18\Client();
    echo "probe3: about to sendRequest (expect exception)\n";
    try {
        $client->sendRequest($request);
        echo "probe4: NO exception thrown\n";
    } catch (\Throwable $e) {
        echo "probe5: caught " . get_class($e) . "\n";
        $got = $e->getRequest();
        echo "probe6: getRequest() class=" . get_class($got) . " same=" . ($got === $request ? 'yes' : 'no') . "\n";
        unset($got);
        echo "probe7: unset got\n";
    }
    unset($request);
    echo "probe8: unset request\n";
    unset($client);
    echo "probe9: unset client\n";
    echo "probe10: about to exit\n";
}
?>
