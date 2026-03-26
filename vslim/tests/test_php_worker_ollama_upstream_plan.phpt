--TEST--
VSlim Ollama upstream plan builders expose generic phase-3 transport metadata
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/Plan.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VSlim/Stream/OllamaClient.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VSlim/Stream/Factory.php';

putenv('OLLAMA_CHAT_URL=http://127.0.0.1:11434/api/chat');
putenv('OLLAMA_MODEL=qwen2.5:7b-instruct');
putenv('OLLAMA_API_KEY=test-key');

$client = VPhp\VSlim\Stream\OllamaClient::fromEnv();
$payload = $client->payload([
    'query' => [
        'prompt' => 'hello',
        'model' => 'demo-model',
    ],
    'body' => '',
]);
$textPlan = $client->upstreamPlan($payload, 'text')->toArray();
$ssePlan = $client->upstreamPlan($payload, 'sse')->toArray();

echo $textPlan['transport'], PHP_EOL;
echo $textPlan['method'], PHP_EOL;
echo $textPlan['codec'], PHP_EOL;
echo $textPlan['mapper'], PHP_EOL;
echo $textPlan['output_stream_type'], PHP_EOL;
echo $textPlan['request_headers']['accept'], PHP_EOL;
echo $textPlan['response_headers']['x-ollama-model'], PHP_EOL;
echo $textPlan['meta']['field_path'], PHP_EOL;
echo $textPlan['meta']['fallback_field_path'], PHP_EOL;
echo ($ssePlan['mapper'] ?? ''), PHP_EOL;
echo ($ssePlan['output_stream_type'] ?? ''), PHP_EOL;
echo ($ssePlan['meta']['sse_event'] ?? ''), PHP_EOL;
echo ($ssePlan['meta']['provider'] ?? ''), PHP_EOL;
?>
--EXPECT--
http
POST
ndjson
ndjson_text_field
text
application/x-ndjson
demo-model
message.content
response
ndjson_sse_field
sse
token
ollama
