--TEST--
VSlim App supports module register boot and auto-boot lifecycle
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
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

    final class ModuleProvider extends VSlim\Support\ServiceProvider
    {
        public function register(): void
        {
            $this->app()->container()->set('module.message', 'hello-module');
        }
    }

    final class DemoModule extends VSlim\Support\Module
    {
        public array $events = [];

        public function register(): void
        {
            $this->events[] = 'register';
            $this->app()->container()->set('module.registered', 'yes');
        }

        public function providers(): iterable
        {
            return [ModuleProvider::class];
        }

        public function middleware(): void
        {
            $this->events[] = 'middleware';
            $message = (string) $this->app()->container()->get('module.message');
            $this->app()->middleware(new class($message) implements MiddlewareInterface {
                public function __construct(private string $message) {}

                public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
                {
                    return $handler->handle(
                        $request
                            ->withAttribute('stage', 'mw')
                            ->withAttribute('from_provider', $this->message)
                    );
                }
            });
        }

        public function routes(): void
        {
            $this->events[] = 'routes';
            $this->app()
                ->group('/blog')
                ->get('/ping', function (ServerRequestInterface $request) {
                    return [
                        'status' => 200,
                        'body' => sprintf(
                            'pong|%s|%s|%s',
                            $request->getAttribute('stage'),
                            $request->getAttribute('from_provider'),
                            $this->app()->container()->get('module.registered')
                        ),
                    ];
                });
        }

        public function boot(): void
        {
            $this->events[] = 'boot';
        }
    }

    final class LateModule extends VSlim\Support\Module
    {
        public array $events = [];

        public function register(VSlim\App $app): void
        {
            $this->events[] = 'register';
            $app->container()->set('late.registered', 'yes');
        }

        public function routes(VSlim\App $app): void
        {
            $this->events[] = 'routes';
            $app->get('/late', fn () => 'late');
        }

        public function boot(VSlim\App $app): void
        {
            $this->events[] = 'boot';
            $app->container()->set('late.booted', 'yes');
        }
    }

    $app = new VSlim\App();
    $module = new DemoModule();

    var_dump($app->module($module) === $app);
    echo implode(',', $module->events) . PHP_EOL;
    var_dump($app->moduleCount());
    var_dump($app->hasModule(DemoModule::class));
    var_dump($app->providerCount());
    var_dump($app->module(DemoModule::class) === $app);
    var_dump($app->moduleCount());
    var_dump($app->booted());

    $response = $app->dispatch('GET', '/blog/ping');
    echo $response->body . PHP_EOL;
    echo implode(',', $module->events) . PHP_EOL;
    var_dump($app->booted());

    $late = new LateModule();
    $app->module($late);
    echo implode(',', $late->events) . PHP_EOL;
    echo $app->dispatch('GET', '/late')->body . '|' . $app->container()->get('late.booted') . PHP_EOL;
    var_dump($app->moduleCount());

    $app2 = new VSlim\App();
    $app2->moduleMany([DemoModule::class, new LateModule()]);
    var_dump($app2->moduleCount());
    var_dump($app2->providerCount());
    $app2->boot();
    echo $app2->dispatch('GET', '/blog/ping')->body . '|' . $app2->dispatch('GET', '/late')->body . PHP_EOL;
}
?>
--EXPECT--
bool(true)
register
int(1)
bool(true)
int(1)
bool(true)
int(1)
bool(false)
pong|mw|hello-module|yes
register,middleware,routes,boot
bool(true)
register,routes,boot
late|yes
int(2)
int(2)
int(1)
pong|mw|hello-module|yes|late
