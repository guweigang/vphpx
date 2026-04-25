--TEST--
VSlim auth middleware can redirect guests and attach resolved auth attributes
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
redirect_to = "/login"
TOML);

    $requestFactory = new VSlim\Psr17\ServerRequestFactory();
    $responseFactory = new VSlim\Psr17\ResponseFactory();
    $middleware = $app->authMiddleware();

    $guestHandler = new class($responseFactory) implements Psr\Http\Server\RequestHandlerInterface {
        public function __construct(private VSlim\Psr17\ResponseFactory $responses) {}
        public function handle(Psr\Http\Message\ServerRequestInterface $request): Psr\Http\Message\ResponseInterface {
            return $this->responses->createResponse(204);
        }
    };

    $guestResponse = $middleware->process(
        $requestFactory->createServerRequest('GET', 'https://example.com/private'),
        $guestHandler
    );
    echo $guestResponse->getStatusCode() . PHP_EOL;
    echo $guestResponse->getHeaderLine('location') . PHP_EOL;

    $seedRequest = new VSlim\VHttpd\Request('GET', '/', '');
    $guard = $app->auth($seedRequest);
    $guard->login('42');
    $seedResponse = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
    $guard->store()->commit($seedResponse);
    $cookieValue = explode(';', $seedResponse->cookieHeader(), 2)[0];
    $cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

    $app->setAuthUserResolver(function (string $id): array {
        return ['id' => $id, 'role' => 'admin'];
    });

    $seen = [];
    $userHandler = new class($responseFactory, $seen) implements Psr\Http\Server\RequestHandlerInterface {
        public array $seen = [];
        public function __construct(private VSlim\Psr17\ResponseFactory $responses, array $seed) {
            $this->seen = $seed;
        }
        public function handle(Psr\Http\Message\ServerRequestInterface $request): Psr\Http\Message\ResponseInterface {
            $this->seen = [
                $request->getAttribute('auth.user_id'),
                $request->getAttribute('auth.user'),
            ];
            return $this->responses->createResponse(204);
        }
    };

    $authRequest = $requestFactory
        ->createServerRequest('GET', 'https://example.com/private')
        ->withCookieParams(['sid' => $cookieValue]);
    $authResponse = $middleware->process($authRequest, $userHandler);
    echo $authResponse->getStatusCode() . PHP_EOL;
    echo $userHandler->seen[0] . PHP_EOL;
    echo json_encode($userHandler->seen[1], JSON_UNESCAPED_SLASHES) . PHP_EOL;
}
?>
--EXPECT--
302
/login
204
42
{"id":"42","role":"admin"}
