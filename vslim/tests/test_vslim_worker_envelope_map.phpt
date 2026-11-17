--TEST--
VHTTPD worker preserves map envelope headers for request and trace ids
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';
$worker = new WorkerWireFixture(__DIR__ . '/fixtures/vslim_envelope_map_fixture.php');
$res = $worker->request([
    'id' => 'map-req-1',
    'method' => 'GET',
    'path' => '/hello/codex',
    'query' => [],
    'headers' => [
        'x-request-id' => 'rid-map-1',
        'x-trace-id' => 'trace-map-1',
    ],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'demo.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $res['id'] . PHP_EOL;
echo $res['status'] . '|' . $res['headers']['content-type'] . '|' . $res['body'] . PHP_EOL;
echo $res['headers']['x-app'] . '|' . $res['headers']['x-route-trace'] . '|' . $res['headers']['x-request-id'] . '|' . $res['headers']['x-trace-id'] . '|' . $res['headers']['x-vhttpd-trace-id'] . PHP_EOL;
?>
--EXPECT--
map-req-1
200|text/plain; charset=utf-8|Hello, codex|phase-map|trace_id=phase-map
map-fixture|phase-map|rid-map-1|phase-map|phase-map
