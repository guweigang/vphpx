--TEST--
VSlim PSR-7 interface_exists autoload chain stays stable
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (extension_loaded('psr')) {
    echo "skip psr extension already loaded; runtime autoload binding needs a clean environment";
    return;
}
?>
--FILE--
<?php
$defs = [
    'Psr\\Http\\Message\\MessageInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface MessageInterface {
    public function getProtocolVersion(): string;
    public function withProtocolVersion(string $version): MessageInterface;
    public function getHeaders(): array;
    public function hasHeader(string $name): bool;
    public function getHeader(string $name): array;
    public function getHeaderLine(string $name): string;
    public function withHeader(string $name, $value): MessageInterface;
    public function withAddedHeader(string $name, $value): MessageInterface;
    public function withoutHeader(string $name): MessageInterface;
    public function getBody(): StreamInterface;
    public function withBody(StreamInterface $body): MessageInterface;
}
PHP,
    'Psr\\Http\\Message\\StreamInterface' => <<<'PHP'
namespace Psr\Http\Message;
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
    public function getMetadata(?string $key = null);
}
PHP,
    'Psr\\Http\\Message\\UriInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface UriInterface {
    public function getScheme(): string;
    public function getAuthority(): string;
    public function getUserInfo(): string;
    public function getHost(): string;
    public function getPort(): ?int;
    public function getPath(): string;
    public function getQuery(): string;
    public function getFragment(): string;
    public function withScheme(string $scheme): UriInterface;
    public function withUserInfo(string $user, ?string $password = null): UriInterface;
    public function withHost(string $host): UriInterface;
    public function withPort(?int $port): UriInterface;
    public function withPath(string $path): UriInterface;
    public function withQuery(string $query): UriInterface;
    public function withFragment(string $fragment): UriInterface;
    public function __toString(): string;
}
PHP,
    'Psr\\Http\\Message\\RequestInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface RequestInterface extends MessageInterface {
    public function getRequestTarget(): string;
    public function withRequestTarget(string $requestTarget): RequestInterface;
    public function getMethod(): string;
    public function withMethod(string $method): RequestInterface;
    public function getUri(): UriInterface;
    public function withUri(UriInterface $uri, bool $preserveHost = false): RequestInterface;
}
PHP,
    'Psr\\Http\\Message\\UploadedFileInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface UploadedFileInterface {
    public function getStream(): StreamInterface;
    public function moveTo(string $targetPath): void;
    public function getSize(): ?int;
    public function getError(): int;
    public function getClientFilename(): ?string;
    public function getClientMediaType(): ?string;
}
PHP,
    'Psr\\Http\\Message\\ServerRequestInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface ServerRequestInterface extends RequestInterface {
    public function getServerParams(): array;
    public function getCookieParams(): array;
    public function withCookieParams(array $cookies): ServerRequestInterface;
    public function getQueryParams(): array;
    public function withQueryParams(array $query): ServerRequestInterface;
    public function getUploadedFiles(): array;
    public function withUploadedFiles(array $uploadedFiles): ServerRequestInterface;
    public function getParsedBody();
    public function withParsedBody($data): ServerRequestInterface;
    public function getAttributes(): array;
    public function getAttribute(string $name, $default = null);
    public function withAttribute(string $name, $value): ServerRequestInterface;
    public function withoutAttribute(string $name): ServerRequestInterface;
}
PHP,
    'Psr\\Http\\Message\\ResponseInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface ResponseInterface extends MessageInterface {
    public function getStatusCode(): int;
    public function withStatus(int $code, string $reasonPhrase = ''): ResponseInterface;
    public function getReasonPhrase(): string;
}
PHP,
];

spl_autoload_register(static function (string $class) use ($defs): void {
    if (!isset($defs[$class])) {
        return;
    }
    eval($defs[$class]);
});

var_dump(interface_exists('Psr\\Http\\Message\\MessageInterface', true));
var_dump(interface_exists('Psr\\Http\\Message\\RequestInterface', true));
var_dump(interface_exists('Psr\\Http\\Message\\ServerRequestInterface', true));
var_dump(interface_exists('Psr\\Http\\Message\\ResponseInterface', true));

$serverRequest = new VSlim\Psr7\ServerRequest();
$request = new VSlim\Psr7\Request();
$response = new VSlim\Psr7\Response();

var_dump($serverRequest instanceof Psr\Http\Message\ServerRequestInterface);
var_dump($request instanceof Psr\Http\Message\RequestInterface);
var_dump($response instanceof Psr\Http\Message\ResponseInterface);

$implements = class_implements(VSlim\Psr7\ServerRequest::class);
var_dump(isset($implements['Psr\\Http\\Message\\ServerRequestInterface']));
var_dump(isset($implements['Psr\\Http\\Message\\RequestInterface']));
var_dump(isset($implements['Psr\\Http\\Message\\MessageInterface']));
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
bool(true)
bool(true)
