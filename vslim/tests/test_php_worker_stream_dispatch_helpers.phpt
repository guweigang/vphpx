--TEST--
php-worker stream dispatch helpers can build replayable phase-2 streams
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/php_worker_package_bootstrap.php';

$events = [
    ['event' => 'tick', 'data' => '0'],
    ['event' => 'done', 'data' => 'complete'],
];
foreach (['dispatchSse' => 3, 'dispatchResponse' => 1] as $method => $required) {
    $signature = new ReflectionMethod(VSlim\Stream\Factory::class, $method);
    $parameters = $signature->getParameters();
    $batch = $parameters[$required];
    $delay = $parameters[$required + 1];
    if ($signature->getNumberOfRequiredParameters() !== $required
        || $batch->getName() !== 'batchSize' || (string) $batch->getType() !== 'int' || $batch->getDefaultValue() !== 1
        || $delay->getName() !== 'delayMs' || (string) $delay->getType() !== 'int' || $delay->getDefaultValue() !== 0) {
        throw new RuntimeException("Unexpected stream defaults for $method");
    }
}
$sequence = VSlim\Stream\Factory::dispatchSse(
    delayMs: 0,
    headers: ['x-demo' => 'sequence'],
    status: 200,
    events: $events,
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

$response = VSlim\Stream\Response::sse(events: [
    ['event' => 'token', 'data' => 'A'],
    ['event' => 'done', 'data' => 'B'],
]);
$dispatch = VSlim\Stream\Factory::dispatchResponse(response: $response);
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

$batched = VSlim\Stream\Factory::dispatchSse(batchSize: 2, headers: [], status: 202, events: $events);
$batchOpen = $batched->handle(['mode' => 'stream', 'strategy' => 'dispatch', 'event' => 'open', 'id' => 'req-batch']);
echo implode(',', array_column($batchOpen['chunks'], 'event')), ':', (int) $batchOpen['done'], PHP_EOL;
?>
--EXPECT--
sequence
tick:0
done:complete:1
sse
token:A
tick,done:1
