--TEST--
VSlim dispatch_request keeps container controller service graphs stable across sequential middleware requests
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

    final class ProbeCatalog
    {
        public function viewer(string $id): array
        {
            return ['id' => $id, 'role' => 'owner'];
        }

        public function workspace(): array
        {
            return ['slug' => 'acme', 'name' => 'Acme'];
        }
    }

    final class ProbeConsoleService
    {
        public function resolve(array $viewer, mixed $workspace): array
        {
            return [
                'viewer' => $viewer,
                'workspace' => is_array($workspace) ? $workspace : ['slug' => 'acme', 'name' => 'Acme'],
                'documents' => [
                    ['title' => 'Refunds', 'status' => 'published', 'chunks' => 3],
                    ['title' => 'Playbook', 'status' => 'draft', 'chunks' => 2],
                ],
            ];
        }
    }

    final class ProbeController extends VSlim\Controller
    {
        public function __construct(
            VSlim\App $app,
            private ProbeCatalog $catalog,
            private ProbeConsoleService $console,
        ) {
            parent::__construct($app);
        }

        public function index(ServerRequestInterface $request): VSlim\VHttpd\Response
        {
            $viewer = $request->getAttribute('studio.viewer');
            $workspace = $request->getAttribute('studio.workspace');
            $resolved = $this->console->resolve(is_array($viewer) ? $viewer : $this->catalog->viewer('guest'), $workspace);
            return $this->renderWithLayout('view_home.html', 'view_layout.html', [
                'title' => 'Index',
                'subtitle' => 'Index Header',
                'name' => (string) (($resolved['viewer']['id'] ?? '')),
                'trace' => (string) (($resolved['workspace']['slug'] ?? '')),
            ]);
        }

        public function documents(ServerRequestInterface $request): VSlim\VHttpd\Response
        {
            $viewer = $request->getAttribute('studio.viewer');
            $workspace = $request->getAttribute('studio.workspace');
            $resolved = $this->console->resolve(is_array($viewer) ? $viewer : $this->catalog->viewer('guest'), $workspace);
            return $this->renderWithLayout('view_home.html', 'view_layout.html', [
                'title' => 'Documents',
                'subtitle' => 'Documents Header',
                'name' => (string) (($resolved['viewer']['id'] ?? '')),
                'trace' => (string) (($resolved['workspace']['slug'] ?? '')),
            ]);
        }
    }

    $app = new VSlim\App();
    $app->setViewBasePath(__DIR__ . '/fixtures');
    $app->setAssetsPrefix('/assets');
    $app->load_config_text(<<<'TOML'
[session]
cookie_name = "ks_session"
secret = "demo-secret"
TOML);
    $catalog = new ProbeCatalog();
    $service = new ProbeConsoleService();
    $app->setAuthUserResolver(static fn (string $id): array => ['id' => $id, 'name' => 'owner']);

    $app->middleware($app->startSessionMiddleware());
    $app->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle($request->withHeader('x-trace-id', 'trace-demo'));
        }
    });
    $app->middleware(new class($app) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            if (str_starts_with($request->getUri()->getPath(), '/console') && !$this->app->authCheck($request)) {
                return (new VSlim\Psr7\Response(302, ''))->withHeader('location', '/login');
            }
            return $handler->handle($request);
        }
    });
    $app->middleware(new class($app, $catalog) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app, private ProbeCatalog $catalog) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $viewer = $this->app->authCheck($request) ? $this->app->authUser($request) : $this->catalog->viewer('guest');
            $workspace = $this->catalog->workspace();
            $request = $request
                ->withAttribute('studio.workspace', $workspace)
                ->withAttribute('studio.viewer', $viewer);
            return $handler->handle($request);
        }
    });

    $app->container()->set(ProbeController::class, new ProbeController($app, $catalog, $service));
    $app->get('/console', [ProbeController::class, 'index']);
    $app->get('/console/knowledge/documents', [ProbeController::class, 'documents']);

    $test = $app->testing()->clearCookies()->actingAs('u-1');
    $cookies = $test->cookies();
    $sessionCookieName = array_key_exists('ks_session', $cookies) ? 'ks_session' : 'vslim_session';
    $sessionValue = (string) ($cookies[$sessionCookieName] ?? '');

    foreach (['/console', '/console/knowledge/documents'] as $path) {
        $request = new VSlim\VHttpd\Request('GET', $path, '');
        $request->setCookies([$sessionCookieName => $sessionValue]);
        $response = $app->dispatchRequest($request);
        echo $path . '|' . $response->status . '|' . (str_contains($response->body, 'u-1') ? 'viewer' : 'miss') . PHP_EOL;
    }
}
?>
--EXPECT--
/console|200|viewer
/console/knowledge/documents|200|viewer
