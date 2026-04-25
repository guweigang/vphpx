--TEST--
VSlim skeleton example assembles an app-directory project with bootstrapDir
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
            public function getHeaderLine(string $name);
            public function getQueryParams(): array;
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
require __DIR__ . '/../examples/skeleton_app.php';

$app = build_skeleton_app();

$home = $app->dispatch("GET", "/?trace_id=example-home");
echo $home->status . "|" . (str_contains($home->body, "VSlim Skeleton Home") ? "home-ok" : "home-miss") . "|" . $home->header("x-skeleton-after") . PHP_EOL;

$catalog = $app->dispatch("GET", "/catalog/books?trace_id=example-catalog");
echo $catalog->status . "|" . $catalog->body . PHP_EOL;

$module = $app->dispatch("GET", "/module/ping");
echo $module->status . "|" . $module->body . PHP_EOL;

$api = $app->dispatch("GET", "/api/status?trace_id=example-api");
echo $api->status . "|" . $api->body . PHP_EOL;

$links = $app->dispatch("GET", "/links");
echo $links->status . "|" . $links->body . PHP_EOL;

$missing = $app->dispatch("GET", "/missing");
echo $missing->status . "|" . $missing->body . PHP_EOL;

$broken = $app->dispatch("GET", "/broken");
echo $broken->status . "|" . $broken->body . PHP_EOL;
?>
--EXPECT--
200|home-ok|http-middleware
200|{"ok":true,"item":{"slug":"books","title":"BOOKS","source":"catalog-service"},"mw":"http-middleware","trace":"example-catalog"}
200|module|module-ready|yes
200|{"ok":true,"app":"vslim-skeleton","module":"yes","mw":"http-middleware","trace":"example-api"}
200|/skeleton/catalog/links
404|{"ok":false,"error":"skeleton-not-found","path":"\/missing"}
500|{"ok":false,"error":"skeleton-runtime","status":500,"message":"container service not found","path":"\/broken"}
