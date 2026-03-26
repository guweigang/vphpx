--TEST--
php-worker stream dispatch helpers can build replayable phase-2 streams
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/PhpWorker/StreamApp.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VSlim/Stream/Response.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VSlim/Stream/Factory.php';

$sequence = VPhp\VSlim\Stream\Factory::dispatchSse(
    [
        ['event' => 'tick', 'data' => '0'],
        ['event' => 'done', 'data' => 'complete'],
    ],
    200,
    ['x-demo' => 'sequence'],
    1,
);

$open = $sequence->handle([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'open',
    'id' => 'req-seq',
]);
$next = $sequence->handle([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'next',
    'id' => 'req-seq',
    'state' => ['cursor' => '1', 'total' => '2'],
]);

$response = VPhp\VSlim\Stream\Response::sse([
    ['event' => 'token', 'data' => 'A'],
    ['event' => 'done', 'data' => 'B'],
]);
$dispatch = VPhp\VSlim\Stream\Factory::dispatchResponse($response, 1);
$dispatchOpen = $dispatch->handle([
    'mode' => 'stream',
    'strategy' => 'dispatch',
    'event' => 'open',
    'id' => 'req-resp',
]);

echo $open['headers']['x-demo'] ?? '', PHP_EOL;
echo ($open['chunks'][0]['event'] ?? ''), ':', ($open['chunks'][0]['data'] ?? ''), PHP_EOL;
echo ($next['chunks'][0]['event'] ?? ''), ':', ($next['chunks'][0]['data'] ?? ''), ':', ($next['done'] ? '1' : '0'), PHP_EOL;
echo $dispatchOpen['stream_type'] ?? '', PHP_EOL;
echo ($dispatchOpen['chunks'][0]['event'] ?? ''), ':', ($dispatchOpen['chunks'][0]['data'] ?? ''), PHP_EOL;
?>
--EXPECT--
sequence
tick:0
done:complete:1
sse
token:A
