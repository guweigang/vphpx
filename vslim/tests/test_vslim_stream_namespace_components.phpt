--TEST--
VSlim Stream namespace components provide reusable Ollama and SSE helpers
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

final class FakeWsConn {
    public array $sent = [];
    public function __construct(private string $id) {}
    public function id(): string { return $this->id; }
    public function send(string $data, string $opcode = 'text'): void { $this->sent[] = $data; }
}

putenv('OLLAMA_STREAM_FIXTURE=' . __DIR__ . '/fixtures/ollama_stream_fixture.ndjson');
putenv('OLLAMA_MODEL=qwen-test');

$req = new VSlim\VHttpd\Request('GET', '/ollama/text?prompt=demo', '');
$text = VSlim\Stream\Factory::ollama_text($req);
echo ($text instanceof VSlim\Stream\Response ? "text_response\n" : "text_not_response\n");
echo $text->streamType . "\n";
echo implode('', iterator_to_array($text->chunks(), false)) . "\n";

$client = VSlim\Stream\OllamaClient::from_env();
$payload = $client->payload(['query' => ['prompt' => 'demo'], 'body' => '']);
echo $payload['model'] . "\n";

$rows = VSlim\Stream\NdjsonDecoder::decode(fopen(__DIR__ . '/fixtures/ollama_stream_fixture.ndjson', 'r'));
echo count($rows) . "\n";

$events = VSlim\Stream\SseEncoder::from_ollama($rows, 'qwen-test');
echo ($events[0]['event'] ?? '') . "\n";
echo ($events[3]['event'] ?? '') . "\n";

$requestFactory = new VSlim\Psr17\ServerRequestFactory();
$streamFactory = new VSlim\Psr17\StreamFactory();
$psrReq = $requestFactory
    ->createServerRequest('POST', 'https://demo.local/ollama/sse?prompt=psr-demo')
    ->withHeader('x-trace-id', 'psr-trace')
    ->withBody($streamFactory->createStream('{"model":"psr-body-model"}'));
$psrPayload = $client->payload_from_request($psrReq);
echo $psrPayload['model'] . "\n";
echo $psrPayload['messages'][0]['content'] . "\n";

$psrText = VSlim\Stream\Factory::ollama_text($psrReq);
echo ($psrText instanceof VSlim\Stream\Response ? "psr_text_response\n" : "psr_text_not_response\n");
echo $psrText->header('x-trace-id') . "\n";
echo $psrText->header('x-vhttpd-trace-id') . "\n";
echo implode('', iterator_to_array($psrText->chunks(), false)) . "\n";

$psrSse = VSlim\Stream\Factory::ollama_sse($psrReq);
$psrEvents = iterator_to_array($psrSse->chunks(), false);
echo ($psrSse instanceof VSlim\Stream\Response ? "psr_sse_response\n" : "psr_sse_not_response\n");
echo $psrSse->header('x-trace-id') . "\n";
echo ($psrEvents[0]['event'] ?? '') . "\n";
echo ($psrEvents[3]['event'] ?? '') . "\n";

$ws = (new VSlim\WebSocket\App())
    ->on_open(static fn ($conn, array $frame): string => 'connected')
    ->on_message(static fn ($conn, string $message, array $frame): string => 'echo:' . $message)
    ->on_close(static function ($conn, int $code, string $reason, array $frame): void {
    });
echo ($ws->has_on_open() ? "ws_open\n" : "ws_open_missing\n");
echo ($ws->has_on_message() ? "ws_message\n" : "ws_message_missing\n");
echo ($ws->has_on_close() ? "ws_close\n" : "ws_close_missing\n");
echo $ws->handle_websocket(['event' => 'open'], new stdClass()) . "\n";
echo $ws->handle_websocket(['event' => 'message', 'data' => 'demo'], new stdClass()) . "\n";

$app = new VSlim\App();
$app->websocket('/ws', $ws);
echo $app->handle_websocket(['event' => 'open', 'id' => 'route-1', 'path' => '/ws'], new stdClass()) . "\n";
echo $app->handle_websocket(['event' => 'message', 'id' => 'route-1', 'data' => 'route-demo'], new stdClass()) . "\n";

$grouped = new VSlim\App();
$group = $grouped->group('/chat');
$group->websocket('/room', $ws);
echo $grouped->handle_websocket(['event' => 'open', 'id' => 'group-1', 'path' => '/chat/room'], new stdClass()) . "\n";
echo $grouped->handle_websocket(['event' => 'message', 'id' => 'group-1', 'data' => 'group-demo'], new stdClass()) . "\n";

$hub = new VSlim\WebSocket\App();
$a = new FakeWsConn('a');
$b = new FakeWsConn('b');
$hub->remember($a)->remember($b);
$hub->join('room-1', $a)->join('room-1', $b);
echo implode(',', $hub->connection_ids()) . "\n";
echo implode(',', $hub->members('room-1')) . "\n";
echo $hub->broadcast('hello-room', 'room-1', 'a') . "\n";
echo implode(',', $b->sent) . "\n";
$hub->leave('room-1', 'b');
echo count($hub->members('room-1')) . "\n";
?>
--EXPECT--
text_response
text
Hello from VSlim
qwen-test
4
token
done
psr-body-model
psr-demo
psr_text_response
psr-trace
psr-trace
Hello from VSlim
psr_sse_response
psr-trace
token
done
ws_open
ws_message
ws_close
connected
echo:demo
connected
echo:route-demo
connected
echo:group-demo
a,b
a,b
1
hello-room
1
