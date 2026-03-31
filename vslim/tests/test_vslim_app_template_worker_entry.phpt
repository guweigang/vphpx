--TEST--
VSlim app template worker entry can dispatch requests for php-worker and vhttpd
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

$script = realpath(__DIR__ . '/../templates/app/public/worker.php');
$handler = include $script;

echo (is_callable($handler) ? 'callable' : 'not-callable'), PHP_EOL;

$health = $handler([
    'id' => 'req-a',
    'method' => 'GET',
    'path' => '/health',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'template.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $health['status'] . '|' . $health['body'] . '|' . ($health['headers']['x-template-app'] ?? 'missing'), PHP_EOL;

$missing = $handler([
    'id' => 'req-b',
    'method' => 'GET',
    'path' => '/missing',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'template.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $missing['status'] . '|' . $missing['body'] . PHP_EOL;
?>
--EXPECT--
callable
200|ok|vslim-template|provider-ready|vslim-template
404|{"ok":false,"error":"template-not-found","path":"\/missing"}
