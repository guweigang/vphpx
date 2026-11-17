--TEST--
php-worker recognizes VSlim StreamResponse objects
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
--FILE--
<?php
declare(strict_types=1);

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
require_once __DIR__ . '/php_worker_package_bootstrap.php';

$app = new VSlim\App();
$app->get('/stream/text', function (mixed $req) {
    $query = method_exists($req, 'getQueryParams') ? $req->getQueryParams() : [];
    return VSlim\Stream\Response::text((function () use ($query): iterable {
        yield "hello:";
        yield $query['name'] ?? 'world';
    })())->setHeader('x-app', 'vslim-stream');
});

require_once dirname(__DIR__) . '/templates/app/bootstrap/worker.php';
if (defined('VSLIM_TEST_WORKER_ENTRY')) {
    return VSlim\Worker\Adapter::app($app);
}

$raw = $app->dispatchEnvelopeWorker([
    'method' => 'GET',
    'path' => '/stream/text?request_id=req-7',
    'query' => ['request_id' => 'req-7'],
]);

echo (is_object($raw) && $raw instanceof VSlim\Stream\Response ? "raw_stream\n" : "raw_not_stream\n");
echo $raw->streamType . "\n";
echo $raw->header('x-app') . "\n";
echo $raw->header('x-request-id') . "\n";

require_once __DIR__ . '/worker_wire_fixture.php';
$worker = new WorkerWireFixture(__FILE__, '\VSlim\Worker\Adapter::http');
$frames = iterator_to_array($worker->frames([
    'method' => 'GET',
    'path' => '/stream/text?request_id=req-7',
    'query' => ['request_id' => 'req-7'],
]), false);
echo $frames[0]['event'] . "\n";
echo $frames[0]['stream_type'] . "\n";
echo $frames[0]['headers']['x-app'] . '|' . $frames[0]['headers']['x-request-id'] . "\n";
foreach (array_slice($frames, 1, -1) as $frame) {
    echo base64_decode($frame['data_base64'], true);
}
echo "\n";
?>
--EXPECT--
raw_stream
text
vslim-stream
req-7
start
text
vslim-stream|req-7
hello:world
