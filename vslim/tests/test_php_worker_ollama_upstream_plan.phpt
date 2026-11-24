--TEST--
VSlim Ollama upstream plan builders expose generic phase-3 transport metadata
--FILE--
<?php
declare(strict_types=1);

putenv('OLLAMA_CHAT_URL=http://127.0.0.1:11434/api/chat');
putenv('OLLAMA_MODEL=qwen2.5:7b-instruct');
putenv('OLLAMA_API_KEY=test-key');

$client = VSlim\Stream\OllamaClient::fromEnv();
if (!class_exists(VHttpd\Upstream\Plan::class, false)) {
    $expected = new DomainException('upstream plan autoload failed');
    $loader = static function (string $class) use ($expected): void {
        if ($class === VHttpd\Upstream\Plan::class) {
            throw $expected;
        }
    };
    spl_autoload_register($loader, true, true);
    try {
        $client->upstreamPlan([]);
        throw new RuntimeException('VSlim accepted an unresolved upstream plan');
    } catch (DomainException $error) {
        if ($error !== $expected) {
            throw $error;
        }
    } finally {
        spl_autoload_unregister($loader);
    }
}
require_once __DIR__ . '/php_worker_package_bootstrap.php';

$payload = $client->payload([
    'query' => [
        'prompt' => 'hello',
        'model' => 'demo-model',
    ],
    'body' => '',
]);
$textPlan = $client->upstreamPlan(outputMode: 'text', payload: $payload)->toArray();
$ssePlan = $client->upstreamPlan($payload)->toArray();
$request = ['query' => ['prompt' => 'hello'], 'body' => ''];
$requestSse = $client->upstreamPlanFromRequest(requestPayload: $request)->toArray();
$requestText = $client->upstreamPlanFromRequest(outputMode: 'text', requestPayload: $request)->toArray();

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
foreach (['upstreamPlan', 'upstreamPlanFromRequest'] as $name) {
    $method = new ReflectionMethod($client, $name);
    $mode = $method->getParameters()[1];
    echo $method->getNumberOfRequiredParameters(), '|', $mode->getName(), '|', $mode->getType(), '|',
        $mode->getDefaultValue(), PHP_EOL;
}
echo $requestSse['output_stream_type'], '|', $requestText['output_stream_type'], PHP_EOL;
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
1|outputMode|string|sse
1|outputMode|string|sse
sse|text
