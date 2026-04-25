--TEST--
VSlim dispatch_request survives login then protected layout requests when trace middleware is resolved from class-string
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

    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    final class TraceByClassString implements MiddlewareInterface
    {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $trace = trim((string) $request->getHeaderLine('x-trace-id'));
            if ($trace === '') {
                $trace = 'trace-demo';
            }
            $response = $handler->handle($request->withHeader('x-trace-id', $trace));
            return $response->withHeader('x-trace', $trace);
        }
    }

    final class LoginFlowCatalogClassString
    {
        public function findUserByEmail(string $email, string $password): ?array
        {
            if ($email === 'owner@example.test' && $password === 'demo123') {
                return ['id' => 'u-1', 'name' => 'Owner', 'role' => 'tenant_owner'];
            }
            return null;
        }

        public function workspace(): array
        {
            return ['slug' => 'acme', 'name' => 'Acme'];
        }
    }

    final class LoginFlowControllerClassString extends VSlim\Controller
    {
        public function __construct(VSlim\App $app)
        {
            parent::__construct($app);
        }

        public function console(ServerRequestInterface $request): VSlim\VHttpd\Response
        {
            $viewer = $request->getAttribute('studio.viewer');
            $workspace = $request->getAttribute('studio.workspace');
            return $this->renderWithLayout('view_home.html', 'view_layout.html', [
                'title' => 'Console',
                'subtitle' => 'Console Header',
                'name' => is_array($viewer) ? (string) ($viewer['id'] ?? '') : 'guest',
                'trace' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'none',
            ]);
        }

        public function documents(ServerRequestInterface $request): VSlim\VHttpd\Response
        {
            $viewer = $request->getAttribute('studio.viewer');
            $workspace = $request->getAttribute('studio.workspace');
            return $this->renderWithLayout('view_home.html', 'view_layout.html', [
                'title' => 'Docs',
                'subtitle' => 'Docs Header',
                'name' => is_array($viewer) ? (string) ($viewer['id'] ?? '') : 'guest',
                'trace' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'none',
            ]);
        }
    }

    $app = new VSlim\App();
    $app->setViewBasePath(__DIR__ . '/fixtures');
    $app->load_config_text(<<<'TOML'
[session]
cookie_name = "ks_session"
secret = "demo-secret"
TOML);
    $catalog = new LoginFlowCatalogClassString();
    $app->setAuthUserProvider(new class {
        public function findById(string $id): array
        {
            return ['id' => $id, 'name' => 'Owner', 'role' => 'tenant_owner'];
        }
    });

    $app->middleware($app->startSessionMiddleware());
    $app->middleware(TraceByClassString::class);
    $app->middleware(new class($app) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $path = $request->getUri()->getPath();
            if (str_starts_with($path, '/console') && !$this->app->authCheck($request)) {
                return (new VSlim\Psr7\Response(302, ''))->withHeader('location', '/login');
            }
            return $handler->handle($request);
        }
    });
    $app->middleware(new class($app, $catalog) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app, private LoginFlowCatalogClassString $catalog) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $viewer = $this->app->authCheck($request) ? $this->app->authUser($request) : null;
            $workspace = $this->app->authCheck($request) ? $this->catalog->workspace() : null;
            $request = $request
                ->withAttribute('studio.workspace', $workspace)
                ->withAttribute('studio.viewer', $viewer);
            return $handler->handle($request);
        }
    });

    $app->container()->set(LoginFlowControllerClassString::class, new LoginFlowControllerClassString($app));
    $app->post('/login', function (ServerRequestInterface $request) use ($app, $catalog): VSlim\VHttpd\Response {
        $parsed = $request->getParsedBody();
        if (!is_array($parsed)) {
            parse_str((string) $request->getBody(), $parsed);
        }
        $email = trim((string) ($parsed['email'] ?? ''));
        $password = trim((string) ($parsed['password'] ?? ''));
        $user = $catalog->findUserByEmail($email, $password);
        $response = new VSlim\VHttpd\Response(302, '', 'text/plain; charset=utf-8');
        if (!is_array($user)) {
            $response->redirectWithStatus('/login', 302);
            return $response;
        }
        $response->redirectWithStatus('/console', 302);
        $app->login($request, $response, (string) $user['id']);
        return $response;
    });
    $app->get('/console', [LoginFlowControllerClassString::class, 'console']);
    $app->get('/console/knowledge/documents', [LoginFlowControllerClassString::class, 'documents']);

    $loginRequest = new VSlim\VHttpd\Request('POST', '/login', 'email=owner%40example.test&password=demo123');
    $loginRequest->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
    $loginResponse = $app->dispatchRequest($loginRequest);
    $cookiePair = explode(';', $loginResponse->cookieHeader(), 2)[0] ?? '';
    [$cookieName, $cookieValue] = array_pad(explode('=', $cookiePair, 2), 2, '');
    $cookieName = trim((string) $cookieName);
    $cookieValue = trim((string) $cookieValue);
    echo ($cookieName !== '' && $cookieValue !== '' ? 'cookie' : 'missing') . PHP_EOL;

    foreach (['/console', '/console/knowledge/documents'] as $path) {
        $request = new VSlim\VHttpd\Request('GET', $path, '');
        $request->setCookies([$cookieName => $cookieValue]);
        $response = $app->dispatchRequest($request);
        echo $path . '|' . $response->status . '|' . (str_contains($response->body, 'u-1') ? 'viewer' : 'miss') . PHP_EOL;
    }
}
?>
--EXPECT--
cookie
/console|200|viewer
/console/knowledge/documents|200|viewer
