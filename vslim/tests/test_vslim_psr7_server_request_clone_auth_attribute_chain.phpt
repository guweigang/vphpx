--TEST--
VSlim PSR-7 request clones survive auth-derived chained attributes across repeated dispatches
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

    $app = new VSlim\App();
    $app->set_view_base_path(dirname(__DIR__, 2) . '/knowledge-studio/resources/views');
    $app->load_config_text(<<<'TOML'
[session]
cookie_name = "ks_session"
secret = "demo-secret"
TOML);
    $app->setAuthUserResolver(static fn (string $id): array => [
        'id' => $id,
        'name' => 'Mira Chen',
        'role' => 'tenant_owner',
    ]);

    $app->middleware($app->startSessionMiddleware());
    $app->middleware(new class($app) implements MiddlewareInterface {
        public function __construct(private VSlim\App $app) {}

        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $workspace = null;
            if ($workspace === null && $this->app->authCheck($request)) {
                $workspace = [
                    'id' => 'ws-acme',
                    'name' => 'Acme Research',
                    'slug' => 'acme-research',
                ];
            }
            $user = $this->app->authCheck($request) ? $this->app->authUser($request) : null;
            $request = $request
                ->withAttribute('studio.workspace', $workspace)
                ->withAttribute('studio.viewer', $user);

            return $handler->handle($request);
        }
    });

    $payload = [
        'title' => 'Knowledge Studio Console',
        'viewer_name' => 'Mira Chen',
        'viewer_role' => 'tenant_owner',
        'workspace_name' => 'Acme Research',
        'workspace_slug' => 'acme-research',
        'workspace_brand' => 'Acme Advisor',
        'workspace_plan' => 'pro',
        'workspace_members' => '2',
        'member_count' => 1,
        'memberships' => [['workspace_slug' => 'acme-research', 'role' => 'tenant_owner']],
        'documents_total' => '2',
        'entries_total' => '2',
        'jobs_total' => '2',
        'published_documents' => '1',
        'assistant_status' => 'published',
        'documents_url' => '/console/knowledge/documents',
        'faqs_url' => '/console/knowledge/faqs',
        'ops_url' => '/console/ops',
        'documents' => [
            ['title' => 'Refund Operations Handbook', 'status' => 'published', 'chunks' => 18],
            ['title' => 'Chargeback Escalation Playbook', 'status' => 'processing', 'chunks' => 9],
        ],
        'entries' => [
            ['title' => 'Refund workflow', 'kind' => 'faq', 'status' => 'published'],
            ['title' => 'Chargeback appeal SLA', 'kind' => 'topic', 'status' => 'draft'],
        ],
        'jobs' => [
            ['name' => 'demo-index-20260408', 'status' => 'done'],
            ['name' => 'sync-release-20260408', 'status' => 'failed'],
        ],
        'public_url' => '/brand/acme-research',
        'page_section' => 'Workspace Console',
        'nav_label' => 'acme-research',
        'footer_note' => 'Next milestone wires real documents, entries, jobs, and audit logs',
    ];

    $app->get('/console', function (ServerRequestInterface $request) use ($app, $payload): VSlim\Vhttpd\Response {
        $viewer = $app->authUser($request);
        $controller = new VSlim\Controller($app);
        $data = $payload;
        $data['viewer_name'] = is_array($viewer) ? (string) ($viewer['name'] ?? '') : '';
        $data['viewer_role'] = is_array($viewer) ? (string) ($viewer['role'] ?? '') : '';
        return $controller->render_with_layout('console.html', 'layout.html', $data);
    });

    $test = $app->testing()->clearCookies()->actingAs('u-1');
    $cookies = $test->cookies();
    $sessionCookieName = array_key_exists('ks_session', $cookies) ? 'ks_session' : 'vslim_session';
    $sessionValue = (string) ($cookies[$sessionCookieName] ?? '');

    foreach ([0, 1] as $i) {
        $request = new VSlim\Vhttpd\Request('GET', '/console', '');
        $request->set_cookies([$sessionCookieName => $sessionValue]);
        $response = $app->dispatch_request($request);
        echo $i . '|' . $response->status . '|' . (str_contains($response->body, 'Mira Chen') ? 'viewer' : 'miss') . PHP_EOL;
    }
}
?>
--EXPECT--
0|200|viewer
1|200|viewer
