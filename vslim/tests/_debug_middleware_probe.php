<?php
if (!interface_exists('Psr\\Http\\Message\\ResponseInterface')) {
    eval('namespace Psr\\Http\\Message {
        interface StreamInterface { public function __toString(): string; }
        interface UriInterface { public function getPath(): string; }
        interface MessageInterface { public function getBody(); }
        interface ResponseInterface extends MessageInterface {}
        interface ServerRequestInterface extends MessageInterface { public function getUri(); }
    }');
}
if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
    eval('namespace Psr\\Http\\Server {
        interface RequestHandlerInterface {}
        interface MiddlewareInterface {
            public function process(\\Psr\\Http\\Message\\ServerRequestInterface $request, RequestHandlerInterface $handler): \\Psr\\Http\\Message\\ResponseInterface;
        }
    }');
}

$mw = new class implements Psr\Http\Server\MiddlewareInterface {
    public function process(
        Psr\Http\Message\ServerRequestInterface $request,
        Psr\Http\Server\RequestHandlerInterface $handler
    ): Psr\Http\Message\ResponseInterface {
        throw new RuntimeException('nope');
    }
};

var_dump($mw instanceof Psr\Http\Server\MiddlewareInterface);
var_dump(method_exists($mw, 'process'));

$app = new VSlim\App();
try {
    $ret = $app->middleware($mw);
    var_dump($ret instanceof VSlim\App);
    echo "registered\n";
} catch (Throwable $e) {
    echo get_class($e), ':', $e->getMessage(), PHP_EOL;
}

$app->get('/hello', function () {
    return new VSlim\VHttpd\Response(200, 'ok');
});

try {
    $res = $app->dispatch('GET', '/hello');
    var_dump($res->status);
    var_dump($res->body);
} catch (Throwable $e) {
    echo 'dispatch:', get_class($e), ':', $e->getMessage(), PHP_EOL;
}
