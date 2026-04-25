--TEST--
php-worker recognizes VSlim StreamResponse objects
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (!is_file(dirname(__DIR__) . '/examples/vendor/autoload.php')) {
    echo "skip vendor autoload missing";
    return;
}
?>
--FILE--
<?php
declare(strict_types=1);

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
require_once dirname(__DIR__) . '/examples/vendor/autoload.php';

$app = new VSlim\App();
$app->get('/stream/text', function (VSlim\Vhttpd\Request $req) {
    return VSlim\Stream\Response::text((function () use ($req): iterable {
        yield "hello:";
        yield $req->param('name') ?: 'world';
    })())->setHeader('x-app', 'vslim-stream');
});

$raw = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/stream/text?request_id=req-7',
    'query' => ['request_id' => 'req-7'],
]);

echo (is_object($raw) && $raw instanceof VSlim\Stream\Response ? "raw_stream\n" : "raw_not_stream\n");
echo $raw->streamType . "\n";
echo $raw->header('x-app') . "\n";
echo $raw->header('x-request-id') . "\n";

$server = new \VPhp\VHttpd\PhpWorker\Server('/tmp/vslim_worker_test.sock');
$ref = new ReflectionMethod(\VPhp\VHttpd\PhpWorker\Server::class, 'normalizeStreamResponseObject');
$normalized = $ref->invoke($server, $raw);

echo ($normalized instanceof \VPhp\VHttpd\PhpWorker\StreamResponse ? "normalized\n" : "not_normalized\n");
echo $normalized->streamType . "\n";
echo $normalized->headers['x-app'] . '|' . $normalized->headers['x-request-id'] . "\n";
echo implode('', iterator_to_array($normalized->chunks, false)) . "\n";
?>
--EXPECT--
raw_stream
text
vslim-stream
req-7
normalized
text
vslim-stream|req-7
hello:world
