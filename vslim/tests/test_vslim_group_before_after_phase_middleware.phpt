--TEST--
VSlim group before/after phase middleware supports class-string and container registrations
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

    final class AppBeforePhaseMiddleware implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle($request->withAttribute('global_meta', ['scope' => 'app']));
        }
    }

    final class GroupBeforePhaseMiddleware implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            if ($request->getUri()->getPath() === '/api/blocked') {
                $response = new VSlim\Psr7\Response(230, '');
                return $response->withBody(new VSlim\Psr7\Stream('group-blocked'));
            }
            return $handler->handle(
                $request
                    ->withAttribute('group_count', 2)
                    ->withAttribute('group_flag', true)
            );
        }
    }

    $app = new VSlim\App();
    $app->before(AppBeforePhaseMiddleware::class);
    $container = $app->container();

    $container->set('phase.after', new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $response = $handler->handle($request);
            return $response->withBody(new VSlim\Psr7\Stream((string) $response->getBody() . '|group-after'));
        }
    });

    $api = $app->group('/api');
    $api->before(GroupBeforePhaseMiddleware::class);
    $api->after(['phase.after', 'process']);
    $api->get('/users/:id', new class implements RequestHandlerInterface {
        public function handle(ServerRequestInterface $request): ResponseInterface
        {
            $response = new VSlim\Psr7\Response(200, '');
            return $response->withBody(new VSlim\Psr7\Stream(
                'api:' . $request->getAttribute('id')
                . ':' . $request->getAttribute('group_count')
                . ':' . ($request->getAttribute('group_flag') ? 'yes' : 'no')
                . ':' . json_encode($request->getAttribute('global_meta'))
            ));
        }
    });

    $web = $app->group('/web');
    $web->get('/users/:id', new class implements RequestHandlerInterface {
        public function handle(ServerRequestInterface $request): ResponseInterface
        {
            $response = new VSlim\Psr7\Response(200, '');
            return $response->withBody(new VSlim\Psr7\Stream('web:' . $request->getAttribute('id')));
        }
    });

    $apiOk = $app->dispatch('GET', '/api/users/9');
    $apiBlocked = $app->dispatch('GET', '/api/blocked');
    $webOk = $app->dispatch('GET', '/web/users/9');

    echo $apiOk->status . '|' . $apiOk->body . PHP_EOL;
    echo $apiBlocked->status . '|' . $apiBlocked->body . PHP_EOL;
    echo $webOk->status . '|' . $webOk->body . PHP_EOL;
}
?>
--EXPECT--
200|api:9:2:yes:{"scope":"app"}|group-after
230|group-blocked|group-after
200|web:9
