--TEST--
VSlim resource_opts supports shallow member routes for nested resources
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

final class NestedCommentsController {
    public function index(ServerRequestInterface $req): string { return 'index'; }
    public function show(ServerRequestInterface $req): string {
        return 'show:' . $req->getAttribute('comment_id') . '|photo:' . $req->getAttribute('photo_id');
    }
}

$app = new VSlim\App();
$app->container()->set(NestedCommentsController::class, new NestedCommentsController());
$app->resourceOpts('/photos/:photo_id/comments', NestedCommentsController::class, [
    'only' => ['index', 'show'],
    'param' => 'comment_id',
    'shallow' => true,
]);

echo $app->dispatch('GET', '/photos/7/comments')->body . PHP_EOL;
echo $app->dispatch('GET', '/photos/7/comments/99')->status . PHP_EOL;
echo $app->dispatch('GET', '/comments/99')->body . PHP_EOL;
echo $app->urlFor('photos.:photo_id.comments.show', ['comment_id' => '88']) . PHP_EOL;
?>
--EXPECT--
index
404
show:99|photo:
/comments/88
