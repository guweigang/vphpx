--TEST--
VSlim app template directory can bootstrap as a minimal project skeleton
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Http\\Message\\RequestInterface')) {
    eval('namespace Psr\\Http\\Message {
        interface RequestInterface {}
        interface ServerRequestInterface extends RequestInterface {
            public function getAttribute(string $name, $default = null);
            public function withAttribute(string $name, $value);
        }
        interface ResponseInterface {}
    }');
}
if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
    eval('namespace Psr\\Http\\Server {
        interface RequestHandlerInterface {
            public function handle(\\Psr\\Http\\Message\\ServerRequestInterface $request): \\Psr\\Http\\Message\\ResponseInterface;
        }
        interface MiddlewareInterface {
            public function process(
                \\Psr\\Http\\Message\\ServerRequestInterface $request,
                RequestHandlerInterface $handler
            ): \\Psr\\Http\\Message\\ResponseInterface;
        }
    }');
}

$root = __DIR__ . '/../templates/app';

$app = new VSlim\App();
$app->bootstrapDir($root);

$health = $app->dispatch("GET", "/health");
echo $health->status . "|" . $health->body . "|" . $health->header("x-template-app") . PHP_EOL;

$home = $app->dispatch("GET", "/");
echo $home->status . "|" . (str_contains($home->body, "VSlim Template") ? "home-ok" : "home-miss") . PHP_EOL;

$homeReq = new VSlim\VHttpd\Request("GET", "/", "");
$homeReq->setHeaders(["x-trace-id" => "template-home"]);
$homeTrace = $app->dispatchRequest($homeReq);
echo $homeTrace->status . "|" . (str_contains($homeTrace->body, "trace: template-home") ? "trace-ok" : "trace-miss") . PHP_EOL;

$module = $app->dispatch("GET", "/module/ping");
echo $module->status . "|" . $module->body . PHP_EOL;

$missing = $app->dispatch("GET", "/missing");
echo $missing->status . "|" . $missing->body . PHP_EOL;

$broken = $app->dispatch("GET", "/broken");
echo $broken->status . "|" . $broken->body . PHP_EOL;
?>
--EXPECT--
200|ok|vslim-template|provider-ready|vslim-template
200|home-ok
200|trace-ok
200|module|module-ready|yes
404|{"ok":false,"error":"template-not-found","path":"\/missing"}
500|{"ok":false,"error":"template-runtime","status":500,"message":"container service not found","path":"\/broken"}
