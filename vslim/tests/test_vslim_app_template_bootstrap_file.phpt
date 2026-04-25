--TEST--
VSlim app template bootstrap spec can be loaded directly from bootstrap/app.php
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

$bootstrapFile = __DIR__ . '/../templates/app/bootstrap/app.php';

$app = new VSlim\App();
$app->bootstrapFile($bootstrapFile);

$health = $app->dispatch('GET', '/health');
echo $health->status . '|' . $health->body . '|' . $health->header('x-template-app') . PHP_EOL;
$module = $app->dispatch('GET', '/module/ping');
echo $module->status . '|' . $module->body . PHP_EOL;
echo $app->viewBasePath() . PHP_EOL;
?>
--EXPECTF--
200|ok|vslim-template|provider-ready|vslim-template
200|module|module-ready|yes
%s/templates/app/resources/views
