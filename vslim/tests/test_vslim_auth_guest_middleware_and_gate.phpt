--TEST--
VSlim guest middleware can redirect authenticated users and app gate helpers use resolver
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\Http\Message {
    if (!interface_exists(ServerRequestInterface::class, false)) {
        interface ServerRequestInterface {
            public function getAttribute($name, $default = null);
            public function withAttribute($name, $value);
            public function withCookieParams(array $cookies);
        }
    }
    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface {
            public function getStatusCode();
            public function getHeaderLine($name);
        }
    }
}
namespace Psr\Http\Server {
    if (!interface_exists(RequestHandlerInterface::class, false)) {
        interface RequestHandlerInterface {
            public function handle(\Psr\Http\Message\ServerRequestInterface $request): \Psr\Http\Message\ResponseInterface;
        }
    }
    if (!interface_exists(MiddlewareInterface::class, false)) {
        interface MiddlewareInterface {
            public function process(\Psr\Http\Message\ServerRequestInterface $request, RequestHandlerInterface $handler): \Psr\Http\Message\ResponseInterface;
        }
    }
}
namespace {
    $app = VSlim\App::demo();
    $app->load_config_text(<<<'TOML'
[app]
key = "auth-secret"

[session]
cookie = "sid"

[auth]
redirect_to = "/home"
TOML);

    $requestFactory = new VSlim\Psr17\ServerRequestFactory();
    $responseFactory = new VSlim\Psr17\ResponseFactory();
    $middleware = $app->guestMiddleware();

    $guestHandler = new class($responseFactory) implements Psr\Http\Server\RequestHandlerInterface {
        public function __construct(private VSlim\Psr17\ResponseFactory $responses) {}
        public function handle(Psr\Http\Message\ServerRequestInterface $request): Psr\Http\Message\ResponseInterface {
            return $this->responses->createResponse(204);
        }
    };

    $guestResponse = $middleware->process(
        $requestFactory->createServerRequest('GET', 'https://example.com/login'),
        $guestHandler
    );
    echo $guestResponse->getStatusCode() . PHP_EOL;

    $seedRequest = new VSlim\Vhttpd\Request('GET', '/', '');
    $guard = $app->auth($seedRequest);
    $guard->login('7');
    $seedResponse = new VSlim\Vhttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
    $guard->store()->commit($seedResponse);
    $cookieValue = explode(';', $seedResponse->cookie_header(), 2)[0];
    $cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

    $authRequest = $requestFactory
        ->createServerRequest('GET', 'https://example.com/login')
        ->withCookieParams(['sid' => $cookieValue]);

    $authResponse = $middleware->process($authRequest, $guestHandler);
    echo $authResponse->getStatusCode() . PHP_EOL;
    echo $authResponse->getHeaderLine('location') . PHP_EOL;

    $app->setAuthGateResolver(function (string $ability, $user, $request): bool {
        return $ability === 'view-admin' && is_array($user) && ($user['role'] ?? '') === 'admin';
    });
    $app->setAuthUserResolver(function (string $id): array {
        return ['id' => $id, 'role' => 'admin'];
    });

    echo ($app->can('view-admin', $authRequest) ? 'can_yes' : 'can_no') . PHP_EOL;
    echo ($app->cannot('view-admin', $requestFactory->createServerRequest('GET', 'https://example.com/login')) ? 'cannot_yes' : 'cannot_no') . PHP_EOL;
}
?>
--EXPECT--
204
302
/home
can_yes
cannot_yes
