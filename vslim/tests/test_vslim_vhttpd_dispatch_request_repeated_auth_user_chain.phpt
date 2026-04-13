--TEST--
VSlim dispatch_request survives repeated session auth viewer middleware with class-string controller
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

    final class RepeatedAuthChainController extends VSlim\Controller
    {
        public function __construct(VSlim\App $app)
        {
            parent::__construct($app);
        }

        public function show(ServerRequestInterface $request): VSlim\Vhttpd\Response
        {
            $viewer = $request->getAttribute('studio.viewer');
            $locale = (string) $request->getAttribute('studio.locale', '');
            return new VSlim\Vhttpd\Response(
                200,
                (is_array($viewer) ? (string) ($viewer['id'] ?? 'miss') : 'miss') . '|' . $locale,
                'text/plain; charset=utf-8'
            );
        }
    }

    $app = new VSlim\App();
    $app->load_config_text(<<<'TOML'
[session]
cookie_name = "ks_session"
secret = "demo-secret"
TOML);
    $app->setAuthUserResolver(static fn (string $id): array => ['id' => $id, 'name' => 'owner']);

    $app->middleware($app->startSessionMiddleware());
    $app->middleware(new class($app) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $viewer = $this->app->authCheck($request) ? $this->app->authUser($request) : null;
            $params = $request->getQueryParams();
            $locale = is_array($params) ? (string) ($params['lang'] ?? '') : '';
            if ($locale === '') {
                parse_str((string) $request->getUri()->getQuery(), $fallback);
                $locale = is_array($fallback) ? (string) ($fallback['lang'] ?? '') : '';
            }
            return $handler->handle(
                $request
                    ->withAttribute('studio.viewer', $viewer)
                    ->withAttribute('studio.locale', $locale)
            )->withHeader('content-language', $locale . ':' . (is_array($viewer) ? 'viewer' : 'guest'));
        }
    });

    $app->container()->set(RepeatedAuthChainController::class, new RepeatedAuthChainController($app));
    $app->get('/x', [RepeatedAuthChainController::class, 'show']);

    $test = $app->testing()->clearCookies()->actingAs('u-1');
    $cookies = $test->cookies();
    $cookieName = array_key_exists('ks_session', $cookies) ? 'ks_session' : 'vslim_session';
    $cookieValue = (string) ($cookies[$cookieName] ?? '');

    for ($i = 0; $i < 8; $i++) {
        $request = new VSlim\Vhttpd\Request('GET', '/x?lang=en', '');
        $request->set_cookies([$cookieName => $cookieValue]);
        $response = $app->dispatch_request($request);
        echo $i . '|' . $response->status . '|' . $response->header('content-language') . '|' . $response->body . PHP_EOL;
    }
}
?>
--EXPECT--
0|200|en:viewer|u-1|en
1|200|en:viewer|u-1|en
2|200|en:viewer|u-1|en
3|200|en:viewer|u-1|en
4|200|en:viewer|u-1|en
5|200|en:viewer|u-1|en
6|200|en:viewer|u-1|en
7|200|en:viewer|u-1|en
