--TEST--
VSlim ollama stream demo app exposes stable text and sse stream shapes
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
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (!is_file($autoload)) { echo "autoload_missing\n"; exit; }
require_once $autoload;

putenv('OLLAMA_STREAM_FIXTURE=' . __DIR__ . '/fixtures/ollama_stream_fixture.ndjson');
putenv('OLLAMA_MODEL=qwen-test');

$app = require __DIR__ . '/../examples/ollama_stream_app.php';

$meta = $app->dispatch_envelope([
    'method' => 'GET',
    'path' => '/meta?prompt=demo',
    'query' => ['prompt' => 'demo'],
]);
echo $meta->status . "\n";
echo (str_contains($meta->body, '"name":"vslim-ollama-stream-demo"') ? "meta_ok\n" : "meta_bad\n");

$text = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/ollama/text?prompt=demo',
    'query' => ['prompt' => 'demo'],
]);
echo ($text instanceof \VSlim\Stream\Response ? "text_stream\n" : "text_not_stream\n");
echo $text->stream_type . "\n";
echo $text->header('x-ollama-model') . "\n";
echo implode('', iterator_to_array($text->chunks(), false)) . "\n";

$sse = $app->dispatch_envelope_worker([
    'method' => 'POST',
    'path' => '/ollama/sse',
    'query' => [],
    'body' => json_encode(['prompt' => 'demo'], JSON_UNESCAPED_UNICODE),
]);
echo ($sse instanceof \VSlim\Stream\Response ? "sse_stream\n" : "sse_not_stream\n");
echo $sse->stream_type . "\n";
$events = iterator_to_array($sse->chunks(), false);
echo ($events[0]['event'] ?? '') . "\n";
echo (str_contains((string) ($events[0]['data'] ?? ''), '"token":"Hello"') ? "sse_first_ok\n" : "sse_first_bad\n");
echo ($events[3]['event'] ?? '') . "\n";

$notFound = $app->dispatch_envelope([
    'method' => 'GET',
    'path' => '/missing',
    'query' => [],
]);
echo $notFound->status . "\n";
?>
--EXPECT--
200
meta_ok
text_stream
text
qwen-test
Hello from VSlim
sse_stream
sse
token
sse_first_ok
done
404
