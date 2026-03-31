--TEST--
VSlim route handlers can be resolved from VSlim\Container by service id
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
        interface ResponseInterface extends MessageInterface {
            public function getStatusCode(): int;
            public function withStatus(int $code, string $reasonPhrase = "");
            public function getReasonPhrase(): string;
        }
    }');
}
if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
    eval('namespace Psr\\Http\\Server {
        interface RequestHandlerInterface { public function handle(\\Psr\\Http\\Message\\ServerRequestInterface $request): \\Psr\\Http\\Message\\ResponseInterface; }
    }');
}

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\RequestHandlerInterface;

class VslimTestAutoController implements RequestHandlerInterface {
    public function handle(ServerRequestInterface $req): ResponseInterface {
        return (new VSlim\Psr7\Response(200, ''))->withBody(
            new VSlim\Psr7\Stream('auto:' . $req->getAttribute('id'))
        );
    }
    public function show(ServerRequestInterface $req): string {
        return 'auto-show:' . $req->getAttribute('id');
    }
}

class VslimTestLegacyAutoController {
    public function handle(ServerRequestInterface $req): ResponseInterface {
        return (new VSlim\Psr7\Response(200, ''))->withBody(
            new VSlim\Psr7\Stream('legacy-auto:' . $req->getAttribute('id'))
        );
    }
}

$app = new VSlim\App();
$container = $app->container();

$container->set('hello.handler', new class implements RequestHandlerInterface {
    public function handle(ServerRequestInterface $req): ResponseInterface {
        return (new VSlim\Psr7\Response(200, ''))->withBody(
            new VSlim\Psr7\Stream('hello:' . $req->getAttribute('id'))
        );
    }
});
$container->set('json.handler', new class implements RequestHandlerInterface {
    public function handle(ServerRequestInterface $req): ResponseInterface {
        return (new VSlim\Psr7\Response(200, ''))
            ->withHeader('content-type', 'application/json; charset=utf-8')
            ->withBody(new VSlim\Psr7\Stream(json_encode([
                'id' => $req->getAttribute('id'),
                'method' => $req->getMethod(),
            ])));
    }
});
$container->set('invoke.controller', new class {
    public function __invoke(ServerRequestInterface $req): string {
        return 'inv:' . $req->getAttribute('id');
    }
});
$container->set('users.controller', new class {
    public function show(ServerRequestInterface $req): string {
        return 'ctrl:' . $req->getAttribute('id');
    }
});
$container->set('legacy.callable', function ($req) {
    return 'legacy:' . $req->getAttribute('id');
});

$app->set_error_handler(function ($req, string $message, int $status) {
    return [
        'status' => $status,
        'content_type' => 'text/plain; charset=utf-8',
        'body' => "ERR:$status:$message",
    ];
});

$app->get('/hello/:id', 'hello.handler');
$app->get('/json/:id', 'json.handler');
$app->get('/ctrl/:id', ['users.controller', 'show']);
$app->get('/inv/:id', ['invoke.controller', '__invoke']);
$app->get('/auto/:id', 'VslimTestAutoController');
$app->get('/auto-legacy/:id', 'VslimTestLegacyAutoController');
$app->get('/auto-show/:id', ['VslimTestAutoController', 'show']);
$app->get('/legacy/:id', 'legacy.callable');
$app->get('/implicit-invoke/:id', 'invoke.controller');
$app->get('/implicit-array/:id', ['invoke.controller']);
$app->get('/bad-method/:id', ['users.controller', 'missing']);
$app->get('/missing/:id', 'missing.handler');

echo $app->dispatch('GET', '/hello/7')->status . '|' . $app->dispatch('GET', '/hello/7')->body . PHP_EOL;
echo $app->dispatch('GET', '/json/8')->status . '|' . $app->dispatch('GET', '/json/8')->body . PHP_EOL;
echo $app->dispatch('GET', '/ctrl/11')->status . '|' . $app->dispatch('GET', '/ctrl/11')->body . PHP_EOL;
echo $app->dispatch('GET', '/inv/12')->status . '|' . $app->dispatch('GET', '/inv/12')->body . PHP_EOL;
echo $app->dispatch('GET', '/auto/20')->status . '|' . $app->dispatch('GET', '/auto/20')->body . PHP_EOL;
echo $app->dispatch('GET', '/auto-legacy/22')->status . '|' . $app->dispatch('GET', '/auto-legacy/22')->body . PHP_EOL;
echo $app->dispatch('GET', '/auto-show/21')->status . '|' . $app->dispatch('GET', '/auto-show/21')->body . PHP_EOL;
echo $app->dispatch('GET', '/legacy/30')->status . '|' . $app->dispatch('GET', '/legacy/30')->body . PHP_EOL;
echo $app->dispatch('GET', '/implicit-invoke/31')->status . '|' . $app->dispatch('GET', '/implicit-invoke/31')->body . PHP_EOL;
echo $app->dispatch('GET', '/implicit-array/32')->status . '|' . $app->dispatch('GET', '/implicit-array/32')->body . PHP_EOL;
echo $app->dispatch('GET', '/bad-method/14')->status . '|' . $app->dispatch('GET', '/bad-method/14')->body . PHP_EOL;
echo $app->dispatch('GET', '/missing/15')->status . '|' . $app->dispatch('GET', '/missing/15')->body . PHP_EOL;
?>
--EXPECT--
200|hello:7
200|{"id":"8","method":"GET"}
200|ctrl:11
200|inv:12
200|auto:20
500|ERR:500:Route handler service "VslimTestLegacyAutoController" must implement Psr\Http\Server\RequestHandlerInterface
200|auto-show:21
500|ERR:500:Route handler service "legacy.callable" must implement Psr\Http\Server\RequestHandlerInterface
500|ERR:500:Route handler service "invoke.controller" must implement Psr\Http\Server\RequestHandlerInterface
500|ERR:500:Route handler array must be ["service", "method"]
500|ERR:500:Container service "users.controller" has no method "missing"
500|ERR:500:container service not found
