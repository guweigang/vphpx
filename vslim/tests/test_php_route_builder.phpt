--TEST--
VSlim\App can register PHP route handlers and dispatch them
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
        interface MiddlewareInterface { public function process(\\Psr\\Http\\Message\\ServerRequestInterface $request, RequestHandlerInterface $handler): \\Psr\\Http\\Message\\ResponseInterface; }
    }');
}

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

$app = new VSlim\App();
$app->before(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        if ($request->getUri()->getPath() === '/before-only') {
            return (new VSlim\Psr7\Response(200, ''))->withBody(new VSlim\Psr7\Stream('before-only'));
        }
        return $handler->handle($request);
    }
});
$app->middleware(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        if ($request->getUri()->getPath() === '/blocked') {
            return (new VSlim\Psr7\Response(403, ''))->withBody(new VSlim\Psr7\Stream('blocked'));
        }
        return $handler->handle($request);
    }
});
$app->middleware(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $query = $request->getQueryParams();
        if ($request->getUri()->getPath() === '/submit' && ($query['trace_id'] ?? '') === 'mw') {
            return (new VSlim\Psr7\Response(202, ''))->withBody(new VSlim\Psr7\Stream('middleware:' . (string) $request->getBody()));
        }
        return $handler->handle($request);
    }
});
$app->get('/hello/:name', function (ServerRequestInterface $req) {
    return new VSlim\Vhttpd\Response(200, 'Hello, ' . $req->getAttribute('name'), 'text/plain; charset=utf-8');
});
$app->get_named('hello.show', '/hello/:name', function (ServerRequestInterface $req) {
    return new VSlim\Vhttpd\Response(200, 'Named Hello, ' . $req->getAttribute('name'), 'text/plain; charset=utf-8');
});
$app->post('/submit', function (ServerRequestInterface $req) {
    $query = $req->getQueryParams();
    return [
        'status' => 201,
        'content_type' => 'application/json; charset=utf-8',
        'headers' => ['x-mode' => 'builder'],
        'body' => json_encode(['body' => (string) $req->getBody(), 'trace' => $query['trace_id'] ?? 'none']),
    ];
});
$app->after(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $response = $handler->handle($request);
        if ($request->getUri()->getPath() !== '/hello/codex') {
            return $response;
        }
        return $response->withHeader('x-after', 'app');
    }
});
$api = $app->group('/api');
$api->middleware(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        if ($request->getUri()->getPath() === '/api/blocked') {
            return (new VSlim\Psr7\Response(200, ''))->withBody(new VSlim\Psr7\Stream('group-blocked'));
        }
        return $handler->handle($request);
    }
});
$api->get('/users/:id', function (ServerRequestInterface $req) {
    return 'user:' . $req->getAttribute('id');
});
$api->after(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $response = $handler->handle($request);
        if ($request->getUri()->getPath() !== '/api/users/9') {
            return $response;
        }
        return $response->withBody(new VSlim\Psr7\Stream('after:' . (string) $response->getBody()));
    }
});
$api->get_named('api.users.show', '/members/:id', function (ServerRequestInterface $req) {
    return 'member:' . $req->getAttribute('id');
});
$api->get('/blocked', function (ServerRequestInterface $req) {
    return 'route-blocked';
});
$api->put_named('api.users.update', '/users/:id', function (ServerRequestInterface $req) {
    return 'put:' . $req->getAttribute('id');
});
$api->delete('/users/:id', function (ServerRequestInterface $req) {
    return 'delete:' . $req->getAttribute('id');
});
$api->patch('/users/:id', function (ServerRequestInterface $req) {
    return 'patch:' . $req->getAttribute('id');
});
$api->any_named('api.echo.any', '/echo/:id', function (ServerRequestInterface $req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});
$v1 = $api->group('/v1');
$v1->middleware(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $query = $request->getQueryParams();
        if ($request->getUri()->getPath() === '/api/v1/ping' && ($query['trace_id'] ?? '') === 'group') {
            return (new VSlim\Psr7\Response(206, ''))->withBody(new VSlim\Psr7\Stream('group-middleware'));
        }
        return $handler->handle($request);
    }
});
$v1->get('/ping', function (ServerRequestInterface $req) {
    return [
        'status' => 200,
        'content_type' => 'application/json; charset=utf-8',
        'body' => json_encode(['pong' => true, 'path' => $req->getUri()->getPath()]),
    ];
});
$app->set_base_path('/v1');

echo $app->dispatch('GET', '/hello/codex')->body . '|' . $app->dispatch('GET', '/hello/codex')->header('x-after') . PHP_EOL;
echo $app->url_for('hello.show', ['name' => 'nova']) . PHP_EOL;
echo $app->url_for_query('api.users.show', ['id' => '12'], ['tab' => 'profile', 'trace' => '1']) . PHP_EOL;
echo $app->url_for_abs('hello.show', ['name' => 'nova'], 'https', 'demo.local') . PHP_EOL;
$app->set_base_path('');
$redirect = $app->redirect_to('hello.show', ['name' => 'jump']);
echo $redirect->status . '|' . $redirect->header('location') . '|' . $redirect->body . PHP_EOL;
$manual = new VSlim\Vhttpd\Response(200, 'ignored', 'text/plain; charset=utf-8');
$manual->redirect_with_status('/moved', 307);
echo $manual->status . '|' . $manual->header('location') . '|' . $manual->contentType . PHP_EOL;
$res = $app->dispatch_body('POST', '/submit?trace_id=builder', 'payload');
echo $res->status . '|' . $res->body . '|' . $res->header('x-mode') . PHP_EOL;
echo $app->dispatch('GET', '/api/users/9')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/members/12')->body . PHP_EOL;
echo $app->url_for('api.users.update', ['id' => '33']) . PHP_EOL;
echo $app->dispatch('PUT', '/api/users/33')->body . PHP_EOL;
echo $app->dispatch('PATCH', '/api/users/34')->body . PHP_EOL;
echo $app->dispatch('DELETE', '/api/users/35')->body . PHP_EOL;
echo $app->dispatch('POST', '/api/echo/44')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/v1/ping')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/blocked')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/v1/ping?trace_id=group')->status . '|' . $app->dispatch('GET', '/api/v1/ping?trace_id=group')->body . PHP_EOL;
echo $app->dispatch('GET', '/blocked')->status . '|' . $app->dispatch('GET', '/blocked')->body . PHP_EOL;
echo $app->dispatch('POST', '/submit?trace_id=mw')->status . '|' . $app->dispatch('POST', '/submit?trace_id=mw')->body . PHP_EOL;
echo $app->dispatch('GET', '/before-only')->status . '|' . $app->dispatch('GET', '/before-only')->body . PHP_EOL;
?>
--EXPECT--
Hello, codex|app
/v1/hello/nova
/v1/api/members/12?tab=profile&trace=1
https://demo.local/v1/hello/nova
302|/hello/jump|
307|/moved|text/plain; charset=utf-8
201|{"body":"payload","trace":"builder"}|builder
after:user:9
member:12
/api/users/33
put:33
patch:34
delete:35
POST:44
{"pong":true,"path":"\/api\/v1\/ping"}
group-blocked
206|group-middleware
403|blocked
202|middleware:
200|before-only
