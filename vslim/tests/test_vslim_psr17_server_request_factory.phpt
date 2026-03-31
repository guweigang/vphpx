--TEST--
VSlim native PSR-17 ServerRequestFactory builds immutable PSR-7 ServerRequest objects
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
    if (!interface_exists(UploadedFileInterface::class, false)) {
        interface UploadedFileInterface {
            public function getStream(): StreamInterface;
            public function moveTo(string $targetPath): void;
            public function getSize(): ?int;
            public function getError(): int;
            public function getClientFilename(): ?string;
            public function getClientMediaType(): ?string;
        }
    }
    if (!interface_exists(StreamFactoryInterface::class, false)) {
        interface StreamFactoryInterface {
            public function createStream(string $content = ''): StreamInterface;
            public function createStreamFromFile(string $filename, string $mode = 'r'): StreamInterface;
            public function createStreamFromResource($resource): StreamInterface;
        }
    }
    if (!interface_exists(UploadedFileFactoryInterface::class, false)) {
        interface UploadedFileFactoryInterface {
            public function createUploadedFile(StreamInterface $stream, ?int $size = null, int $error = UPLOAD_ERR_OK, ?string $clientFilename = null, ?string $clientMediaType = null): UploadedFileInterface;
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
}

namespace {
    $factory = new VSlim\Psr17\ServerRequestFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();
    $uploadedFileFactory = new VSlim\Psr17\UploadedFileFactory();
    $uriFactory = new VSlim\Psr17\UriFactory();

    echo ($factory instanceof Psr\Http\Message\ServerRequestFactoryInterface ? 'srf-yes' : 'srf-no') . PHP_EOL;

    $request = $factory->createServerRequest('POST', 'https://demo.local:8443/items/list?trace=9', ['HTTPS' => 'on', 'meta' => ['tls' => true]]);
    echo get_class($request) . PHP_EOL;
    echo ($request instanceof Psr\Http\Message\ServerRequestInterface ? 'srv-yes' : 'srv-no') . PHP_EOL;
    echo $request->getMethod() . '|' . $request->getRequestTarget() . '|' . $request->getHeaderLine('host') . PHP_EOL;
    echo $request->getServerParams()['HTTPS'] . '|' . $request->getServerParams()['meta']['tls'] . '|' . $request->getQueryParams()['trace'] . PHP_EOL;

    $upload = $uploadedFileFactory->createUploadedFile(
        $streamFactory->createStream('alpha'),
        null,
        UPLOAD_ERR_OK,
        'a.txt',
        'text/plain'
    );
    $nestedUpload = $uploadedFileFactory->createUploadedFile(
        $streamFactory->createStream('beta'),
        null,
        UPLOAD_ERR_OK,
        'b.txt',
        'text/plain'
    );

    $request2 = $request
        ->withCookieParams(['sid' => 'abc', 'flags' => ['secure' => true]])
        ->withQueryParams(['page' => '2', 'filters' => ['tag' => ['a', 'b']]])
        ->withUploadedFiles(['docs' => [$upload, $nestedUpload]])
        ->withParsedBody(['name' => 'neo'])
        ->withAttribute('trace_id', 'srv-1')
        ->withBody($streamFactory->createStream('payload'));
    echo ($request->getCookieParams() === [] ? 'orig-cookies-empty' : 'orig-cookies-set') . PHP_EOL;
    echo $request2->getCookieParams()['sid'] . '|' . $request2->getCookieParams()['flags']['secure'] . '|' . $request2->getQueryParams()['page'] . '|' . $request2->getQueryParams()['filters']['tag'][1] . PHP_EOL;
    echo count($request2->getUploadedFiles()['docs']) . '|' . get_class($request2->getUploadedFiles()['docs'][0]) . '|' . $request2->getUploadedFiles()['docs'][0]->getClientFilename() . PHP_EOL;
    echo $request2->getParsedBody()['name'] . '|' . $request2->getAttribute('trace_id') . '|' . (string) $request2->getBody() . PHP_EOL;

    $request3 = $request2
        ->withoutAttribute('trace_id')
        ->withAttribute('count', 7)
        ->withProtocolVersion('2')
        ->withRequestTarget('*');
    echo ($request3->getAttribute('trace_id', 'missing')) . '|' . $request3->getAttribute('count') . '|' . $request3->getProtocolVersion() . '|' . $request3->getRequestTarget() . PHP_EOL;

    $newUri = $uriFactory->createUri('http://other.test/next?ok=1');
    $request4 = $request3->withUri($newUri);
    $request5 = $request3->withUri($newUri, true);
    echo $request4->getHeaderLine('host') . '|' . (string) $request4->getUri() . PHP_EOL;
    echo $request5->getHeaderLine('host') . '|' . (string) $request5->getUri() . PHP_EOL;
}
?>
--EXPECT--
srf-yes
VSlim\Psr7\ServerRequest
srv-yes
POST|/items/list?trace=9|demo.local:8443
on|1|9
orig-cookies-empty
abc|1|2|b
2|VSlim\Psr7\UploadedFile|a.txt
neo|srv-1|payload
missing|7|2|*
other.test|http://other.test/next?ok=1
demo.local:8443|http://other.test/next?ok=1
