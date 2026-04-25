--TEST--
VSlim ability middleware can deny and allow requests through app gate resolver
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
    $app->loadConfigText(<<<'TOML'
[app]
key = "auth-secret"

[session]
cookie = "sid"
TOML);

    $app->setAuthUserResolver(function (string $id): array {
        return ['id' => $id, 'role' => $id === '42' ? 'admin' : 'member'];
    });
    $app->setAuthGateResolver(function (string $ability, $user): bool {
        return $ability === 'admin' && is_array($user) && ($user['role'] ?? '') === 'admin';
    });

    $requestFactory = new VSlim\Psr17\ServerRequestFactory();
    $responseFactory = new VSlim\Psr17\ResponseFactory();
    $middleware = $app->abilityMiddleware('admin');

    $handler = new class($responseFactory) implements Psr\Http\Server\RequestHandlerInterface {
        public function __construct(private VSlim\Psr17\ResponseFactory $responses) {}
        public function handle(Psr\Http\Message\ServerRequestInterface $request): Psr\Http\Message\ResponseInterface {
            return $this->responses->createResponse(204);
        }
    };

    $guestResponse = $middleware->process(
        $requestFactory->createServerRequest('GET', 'https://example.com/admin'),
        $handler
    );
    echo $guestResponse->getStatusCode() . PHP_EOL;

    $seedRequest = new VSlim\VHttpd\Request('GET', '/', '');
    $guard = $app->auth($seedRequest);
    $guard->login('42');
    $seedResponse = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
    $guard->store()->commit($seedResponse);
    $cookieValue = explode(';', $seedResponse->cookieHeader(), 2)[0];
    $cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

    $authRequest = $requestFactory
        ->createServerRequest('GET', 'https://example.com/admin')
        ->withCookieParams(['sid' => $cookieValue]);
    $authResponse = $middleware->process($authRequest, $handler);
    echo $authResponse->getStatusCode() . PHP_EOL;
}
?>
--EXPECT--
403
204
