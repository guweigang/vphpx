--TEST--
VSlim resource and api_resource register RESTful routes
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Http\\Message\\MessageInterface')) {
    eval('namespace Psr\\Http\\Message {
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
        interface RequestInterface extends MessageInterface {
            public function getRequestTarget(): string;
            public function withRequestTarget(string $requestTarget);
            public function getMethod(): string;
            public function withMethod(string $method);
            public function getUri(): UriInterface;
            public function withUri(UriInterface $uri, bool $preserveHost = false);
        }
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
    }');
}

use Psr\Http\Message\ServerRequestInterface;

final class ResourceDemoController {
    public function index(ServerRequestInterface $req): string { return 'index'; }
    public function show(ServerRequestInterface $req): string { return 'show:' . $req->getAttribute('id'); }
    public function store(ServerRequestInterface $req): string { return 'store'; }
    public function update(ServerRequestInterface $req): string { return 'update:' . $req->getAttribute('id'); }
    public function destroy(ServerRequestInterface $req): string { return 'destroy:' . $req->getAttribute('id'); }
    public function create(ServerRequestInterface $req): string { return 'create'; }
    public function edit(ServerRequestInterface $req): string { return 'edit:' . $req->getAttribute('id'); }
}

$app = new VSlim\App();
$app->container()->set(ResourceDemoController::class, new ResourceDemoController());
$app->resource('/items', ResourceDemoController::class);
$app->api_resource('/api/items', ResourceDemoController::class);

echo $app->dispatch('GET', '/items')->body . PHP_EOL;
echo $app->dispatch('GET', '/items/create')->body . PHP_EOL;
echo $app->dispatch('POST', '/items')->body . PHP_EOL;
echo $app->dispatch('GET', '/items/7')->body . PHP_EOL;
echo $app->dispatch('GET', '/items/7/edit')->body . PHP_EOL;
echo $app->dispatch('PUT', '/items/7')->body . PHP_EOL;
echo $app->dispatch('DELETE', '/items/7')->body . PHP_EOL;

echo $app->dispatch('GET', '/api/items')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/items/create')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/items/8/edit')->status . PHP_EOL;
?>
--EXPECT--
index
create
store
show:7
edit:7
update:7
destroy:7
index
show:create
404
