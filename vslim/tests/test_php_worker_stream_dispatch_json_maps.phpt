--TEST--
php-worker stream dispatch keeps empty headers/state as JSON objects
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/legacy_aliases.php';

$fixture = __DIR__ . '/fixtures/stream_dispatch_fixture.php';
$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_stream_strategy_dispatch_test.sock', $fixture);
$ref = new ReflectionClass($server);
$method = $ref->getMethod('handleStream');

$open = $method->invoke($server, [
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'open',
    'id' => 'req-1',
    'path' => '/events/sse',
    'state' => [],
]);
$next = $method->invoke($server, [
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'next',
    'id' => 'req-1',
    'state' => ['cursor' => '0', 'limit' => '2'],
]);
$close = $method->invoke($server, [
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
{}
{}
