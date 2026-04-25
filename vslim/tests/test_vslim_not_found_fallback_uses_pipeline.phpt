--TEST--
VSlim not_found fallback preserves before and middleware pipeline semantics even without a matched route
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace {
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
}

namespace {
    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    $beforeOnly = new VSlim\App();
    $beforeOnly->before(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle(
                $request
                    ->withAttribute('mw', 'before')
                    ->withHeader('x-trace-id', 'phase-before')
                    ->withUri(new VSlim\Psr7\Uri('https://phase.local/missing?trace_id=phase-before'))
            );
        }
    });
    $beforeOnly->setNotFoundHandler(function (ServerRequestInterface $request) {
        return new VSlim\VHttpd\Response(
            404,
            implode('|', [
                'nf',
                (string) $request->getAttribute('mw', ''),
                $request->getHeaderLine('x-trace-id'),
                $request->getUri()->getQuery(),
            ]),
            'text/plain; charset=utf-8'
        );
    });
    $beforeOnly->get('/ok', new class implements RequestHandlerInterface {
        public function handle(ServerRequestInterface $request): ResponseInterface
        {
            return new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
        }
    });

    $missingA = $beforeOnly->dispatch('GET', '/missing');
    echo $missingA->status . '|' . $missingA->body . PHP_EOL;

    $noRoutes = new VSlim\App();
    $noRoutes->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle(
                $request
                    ->withAttribute('mw', 'global')
                    ->withHeader('x-trace-id', 'global-trace')
            );
        }
    });
    $api = $noRoutes->group('/api');
    $api->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle(
                $request
                    ->withAttribute('mw', (string) $request->getAttribute('mw', '') . '>group')
                    ->withHeader('x-trace-id', 'group-trace')
                    ->withUri(new VSlim\Psr7\Uri('https://phase.local' . $request->getUri()->getPath() . '?trace_id=group-query'))
            );
        }
    });
    $noRoutes->setNotFoundHandler(function (ServerRequestInterface $request) {
        return new VSlim\VHttpd\Response(
            404,
            implode('|', [
                'nf',
                (string) $request->getAttribute('mw', ''),
                $request->getHeaderLine('x-trace-id'),
                $request->getUri()->getQuery(),
            ]),
            'text/plain; charset=utf-8'
        );
    });

    $missingB = $noRoutes->dispatch('GET', '/api/missing');
    echo $missingB->status . '|' . $missingB->body . PHP_EOL;

    $request = (new VSlim\Psr7\ServerRequest())
        ->withMethod('GET')
        ->withUri(new VSlim\Psr7\Uri('https://example.com/api/missing?trace_id=outer'));
    $response = $noRoutes->handle($request);
    echo $response->getStatusCode() . '|' . (string) $response->getBody() . PHP_EOL;
}
?>
--EXPECT--
404|nf|before|phase-before|trace_id=phase-before
404|nf|global>group|group-trace|trace_id=group-query
404|nf|global>group|group-trace|trace_id=group-query
