--TEST--
VSlim controller app helper and standard middleware both see resolved route params
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
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    $app = new VSlim\App();
    $app->load_config_text(<<<'TOML'
[app]
name = "controller-app"
TOML);

    $app->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): \Psr\Http\Message\ResponseInterface
        {
            return $handler->handle(
                $request
                    ->withAttribute('mw', 'global')
                    ->withAttribute('mw_seen_tenant', (string) $request->getAttribute('tenant', ''))
                    ->withAttribute('mw_seen_id', (string) $request->getAttribute('id', ''))
            );
        }
    });

    final class ControllerProbe extends VSlim\Controller {
        public function __construct(VSlim\App $app)
        {
            parent::__construct($app);
        }

        public function page(ServerRequestInterface $request): VSlim\Vhttpd\Response
        {
            return new VSlim\Vhttpd\Response(
                200,
                implode('|', [
                    $this->app()->config()->get_string('app.name', ''),
                    (string) $request->getAttribute('tenant', ''),
                    (string) $request->getAttribute('id', ''),
                    (string) $request->getAttribute('mw_seen_tenant', ''),
                    (string) $request->getAttribute('mw_seen_id', ''),
                    (string) $request->getAttribute('mw', ''),
                ]),
                'text/plain; charset=utf-8'
            );
        }
    }

    $app->container()->set(ControllerProbe::class, new ControllerProbe($app));
    $app->get('/brand/:tenant/items/:id', [ControllerProbe::class, 'page']);

    $res = $app->dispatch('GET', '/brand/acme/items/42');
    echo $res->status . '|' . $res->body . PHP_EOL;
}
?>
--EXPECT--
200|controller-app|acme|42|acme|42|global
