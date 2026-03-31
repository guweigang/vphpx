--TEST--
VSlim PSR-18 client and exception contracts preserve request identity and reflection metadata
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
    if (!interface_exists(RequestFactoryInterface::class, false)) {
        interface RequestFactoryInterface {
            public function createRequest(string $method, $uri): RequestInterface;
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
    $describeType = static function (?ReflectionType $type): ?string {
        if ($type === null) {
            return null;
        }
        if ($type instanceof ReflectionNamedType) {
            return $type->getName();
        }
        if ($type instanceof ReflectionUnionType) {
            $names = array_map(
                static fn (ReflectionNamedType $named): string => $named->getName(),
                $type->getTypes(),
            );
            sort($names, SORT_STRING);
            return implode('|', $names);
        }
        return get_class($type);
    };

    $client = new VSlim\Psr18\Client();
    $requestFactory = new VSlim\Psr17\RequestFactory();
    $request = $requestFactory->createRequest('GET', 'https://example.com/demo');

    var_dump($client->timeout(5) === $client);

    $requestException = new VSlim\Psr18\RequestException('bad request', 0);
    $requestException->attachRequest($request);
    var_dump($requestException->getRequest() === $request);

    $networkException = new VSlim\Psr18\NetworkException('network down', 0);
    $networkException->attachRequest($request);
    var_dump($networkException->getRequest() === $request);

    $sendRequest = new ReflectionMethod(VSlim\Psr18\Client::class, 'sendRequest');
    $requestExGetRequest = new ReflectionMethod(VSlim\Psr18\RequestException::class, 'getRequest');
    $networkExGetRequest = new ReflectionMethod(VSlim\Psr18\NetworkException::class, 'getRequest');

    var_dump($describeType($sendRequest->getParameters()[0]->getType()));
    var_dump($describeType($sendRequest->getReturnType()));
    var_dump($describeType($requestExGetRequest->getReturnType()));
    var_dump($describeType($networkExGetRequest->getReturnType()));

    $badRequest = $requestFactory->createRequest('GET', 'ftp://example.com/file.txt');
    try {
        $client->sendRequest($badRequest);
        echo "bad-request-missed\n";
    } catch (\Throwable $e) {
        echo get_class($e) . '|' . ($e instanceof Psr\Http\Client\RequestExceptionInterface ? 'rq' : 'no') . '|' . ($e->getRequest() === $badRequest ? 'same' : 'diff') . PHP_EOL;
    }
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
string(33) "Psr\Http\Message\RequestInterface"
string(34) "Psr\Http\Message\ResponseInterface"
string(33) "Psr\Http\Message\RequestInterface"
string(33) "Psr\Http\Message\RequestInterface"
VSlim\Psr18\RequestException|rq|same
