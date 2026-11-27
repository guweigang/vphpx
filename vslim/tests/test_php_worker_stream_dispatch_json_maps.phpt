--TEST--
php-worker stream dispatch preserves nonempty maps and decodes empty headers/state as empty maps
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';

$worker = new WorkerWireFixture(__DIR__ . '/fixtures/stream_dispatch_fixture.php');
$open = $worker->request([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'open',
    'id' => 'req-1',
    'path' => '/events/sse',
    'state' => [],
]);
$next = $worker->request([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'next',
    'id' => 'req-1',
    'state' => $open['state'],
]);
$close = $worker->request([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'close',
    'id' => 'req-1',
    'state' => [],
]);

echo json_encode($open['headers'], JSON_UNESCAPED_UNICODE), PHP_EOL;
echo json_encode($next['state'], JSON_UNESCAPED_UNICODE), PHP_EOL;
echo json_encode($close['headers'], JSON_UNESCAPED_UNICODE), PHP_EOL;
echo json_encode($close['state'], JSON_UNESCAPED_UNICODE), PHP_EOL;
?>
--EXPECT--
{"cache-control":"no-cache"}
{"cursor":"1","limit":"2"}
[]
[]
