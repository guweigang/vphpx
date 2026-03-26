--TEST--
VSlim stream factory demo app exposes plain and ollama stream routes
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

$app = require __DIR__ . '/../examples/stream_factory_app.php';

$meta = $app->dispatch_envelope([
    'method' => 'GET',
    'path' => '/meta',
    'query' => [],
]);
echo $meta->status . "\n";
echo (str_contains($meta->body, '"name":"vslim-stream-factory-demo"') ? "meta_ok\n" : "meta_bad\n");

$plainText = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/stream/text?topic=demo',
    'query' => ['topic' => 'demo'],
]);
echo ($plainText instanceof \VSlim\Stream\Response ? "plain_text_stream\n" : "plain_text_not_stream\n");
echo implode('', iterator_to_array($plainText->chunks(), false));

$plainSse = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/stream/sse?topic=demo',
    'query' => ['topic' => 'demo'],
]);
$plainEvents = iterator_to_array($plainSse->chunks(), false);
echo ($plainSse instanceof \VSlim\Stream\Response ? "plain_sse_stream\n" : "plain_sse_not_stream\n");
echo ($plainEvents[0]['event'] ?? '') . "\n";
echo ($plainEvents[2]['event'] ?? '') . "\n";

$ollamaText = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/ollama/text?prompt=demo',
    'query' => ['prompt' => 'demo'],
]);
echo ($ollamaText instanceof \VSlim\Stream\Response ? "ollama_text_stream\n" : "ollama_text_not_stream\n");
echo implode('', iterator_to_array($ollamaText->chunks(), false)) . "\n";

$ollamaSse = $app->dispatch_envelope_worker([
    'method' => 'GET',
    'path' => '/ollama/sse?prompt=demo',
    'query' => ['prompt' => 'demo'],
]);
$ollamaEvents = iterator_to_array($ollamaSse->chunks(), false);
echo ($ollamaSse instanceof \VSlim\Stream\Response ? "ollama_sse_stream\n" : "ollama_sse_not_stream\n");
echo ($ollamaEvents[0]['event'] ?? '') . "\n";
echo ($ollamaEvents[3]['event'] ?? '') . "\n";
?>
--EXPECT--
200
meta_ok
plain_text_stream
demo: demo
mode: text
status: ok
plain_sse_stream
token
done
ollama_text_stream
Hello from VSlim
ollama_sse_stream
token
done
