--TEST--
php-worker mcp handles initialize, builtin helpers, queue notifications, sampling, progress, log, and request builders
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
?>
--FILE--
<?php
$autoload = dirname(__DIR__, 3) . '/vhttpd/php/package/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = dirname(__DIR__) . '/vendor/autoload.php';
}
if (!is_file($autoload)) {
    echo "autoload_missing\n";
    exit;
}
require_once $autoload;

$fixture = dirname(__DIR__, 3) . '/vhttpd/examples/mcp-app.php';
$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_mcp_test.sock', $fixture);

$initialize = $server->dispatchRequest([
    'id' => 'req-init',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}',
]);

$toolsList = $server->dispatchRequest([
    'id' => 'req-tools',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}',
]);

$toolsCall = $server->dispatchRequest([
    'id' => 'req-call',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"echo","arguments":{"text":"hello helper"}}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"echo","arguments":{"text":"hello helper"}}}',
]);

$resourcesList = $server->dispatchRequest([
    'id' => 'req-resources',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":4,"method":"resources/list","params":{}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":4,"method":"resources/list","params":{}}',
]);

$resourcesRead = $server->dispatchRequest([
    'id' => 'req-resource-read',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":5,"method":"resources/read","params":{"uri":"resource://demo/readme"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":5,"method":"resources/read","params":{"uri":"resource://demo/readme"}}',
]);

$promptsList = $server->dispatchRequest([
    'id' => 'req-prompts',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":6,"method":"prompts/list","params":{}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":6,"method":"prompts/list","params":{}}',
]);

$promptsGet = $server->dispatchRequest([
    'id' => 'req-prompt-get',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":7,"method":"prompts/get","params":{"name":"welcome","arguments":{"name":"codex"}}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":7,"method":"prompts/get","params":{"name":"welcome","arguments":{"name":"codex"}}}',
]);

$notify = $server->dispatchRequest([
    'id' => 'req-notify',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":8,"method":"debug/notify","params":{"text":"queued hello"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":8,"method":"debug/notify","params":{"text":"queued hello"}}',
]);

$sample = $server->dispatchRequest([
    'id' => 'req-sample',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":9,"method":"debug/sample","params":{"topic":"runtime contract"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":9,"method":"debug/sample","params":{"topic":"runtime contract"}}',
]);

$progress = $server->dispatchRequest([
    'id' => 'req-progress',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":10,"method":"debug/progress","params":{}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":10,"method":"debug/progress","params":{}}',
]);

$log = $server->dispatchRequest([
    'id' => 'req-log',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":11,"method":"debug/log","params":{"message":"hello log"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":11,"method":"debug/log","params":{"message":"hello log"}}',
]);

$queuedRequest = $server->dispatchRequest([
    'id' => 'req-request',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":12,"method":"debug/request","params":{"method":"ping"}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":12,"method":"debug/request","params":{"method":"ping"}}',
]);

$inlineFixture = sys_get_temp_dir() . '/vhttpd_mcp_caps_fixture.php';
file_put_contents($inlineFixture, <<<'PHP'
<?php
declare(strict_types=1);
use VPhp\VSlim\Mcp\App;
return (new App(['name' => 'caps-fixture', 'version' => '0.1.0'], []))
    ->register('debug/caps', static function (array $request, array $frame): array {
        return [
            'client_capabilities_json' => (string) ($frame['client_capabilities_json'] ?? ''),
        ];
    });
PHP);
$previousAppBootstrap = getenv('VHTTPD_APP');
putenv('VHTTPD_APP');
$capsServer = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_mcp_caps_test.sock', $inlineFixture);
$capsResult = $capsServer->dispatchRequest([
    'id' => 'req-caps',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-session',
    'client_capabilities_json' => '{"sampling":{},"roots":{"listChanged":true}}',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":13,"method":"debug/caps","params":{}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":13,"method":"debug/caps","params":{}}',
]);
if ($previousAppBootstrap !== false && is_string($previousAppBootstrap) && $previousAppBootstrap !== '') {
    putenv('VHTTPD_APP=' . $previousAppBootstrap);
} else {
    putenv('VHTTPD_APP');
}
@unlink($inlineFixture);

echo ($initialize['status'] ?? 0), "\n";
echo (($initialize['headers']['content-type'] ?? '') === 'application/json; charset=utf-8' ? "init_json\n" : "init_bad\n");
$initBody = json_decode((string) ($initialize['body'] ?? ''), true);
echo ($initBody['result']['serverInfo']['name'] ?? ''), "\n";
echo ($initBody['result']['protocolVersion'] ?? ''), "\n";
echo (array_key_exists('logging', $initBody['result']['capabilities'] ?? []) ? "logging_declared\n" : "logging_missing\n");
echo (array_key_exists('sampling', $initBody['result']['capabilities'] ?? []) ? "sampling_declared\n" : "sampling_missing\n");

echo ($toolsList['status'] ?? 0), "\n";
$toolsBody = json_decode((string) ($toolsList['body'] ?? ''), true);
echo ($toolsBody['result']['tools'][0]['name'] ?? ''), "\n";
echo ($toolsBody['result']['tools'][0]['inputSchema']['required'][0] ?? ''), "\n";

echo ($toolsCall['status'] ?? 0), "\n";
$callBody = json_decode((string) ($toolsCall['body'] ?? ''), true);
echo ($callBody['result']['content'][0]['text'] ?? ''), "\n";

echo ($resourcesList['status'] ?? 0), "\n";
$resourcesListBody = json_decode((string) ($resourcesList['body'] ?? ''), true);
echo ($resourcesListBody['result']['resources'][0]['uri'] ?? ''), "\n";

echo ($resourcesRead['status'] ?? 0), "\n";
$resourcesReadBody = json_decode((string) ($resourcesRead['body'] ?? ''), true);
echo trim((string) ($resourcesReadBody['result']['contents'][0]['text'] ?? '')), "\n";

echo ($promptsList['status'] ?? 0), "\n";
$promptsListBody = json_decode((string) ($promptsList['body'] ?? ''), true);
echo ($promptsListBody['result']['prompts'][0]['name'] ?? ''), "\n";

echo ($promptsGet['status'] ?? 0), "\n";
$promptsGetBody = json_decode((string) ($promptsGet['body'] ?? ''), true);
echo ($promptsGetBody['result']['messages'][0]['content'][0]['text'] ?? ''), "\n";

echo ($notify['status'] ?? 0), "\n";
$notifyBody = json_decode((string) ($notify['body'] ?? ''), true);
echo (($notifyBody['result']['queued'] ?? false) ? "queued\n" : "not_queued\n");
echo ($notify['session_id'] ?? ''), "\n";
$notifyMessages = is_array($notify['messages'] ?? null) ? $notify['messages'] : [];
$firstMessage = json_decode((string) ($notifyMessages[0] ?? ''), true);
echo ($firstMessage['method'] ?? ''), "\n";
echo ($firstMessage['params']['text'] ?? ''), "\n";

echo ($sample['status'] ?? 0), "\n";
$sampleBody = json_decode((string) ($sample['body'] ?? ''), true);
echo (($sampleBody['result']['queued'] ?? false) ? "sample_queued\n" : "sample_not_queued\n");
$sampleMessages = is_array($sample['messages'] ?? null) ? $sample['messages'] : [];
$sampleFirst = json_decode((string) ($sampleMessages[0] ?? ''), true);
echo ($sampleFirst['method'] ?? ''), "\n";
echo ($sampleFirst['params']['messages'][0]['content'][0]['text'] ?? ''), "\n";
echo ($sampleFirst['params']['systemPrompt'] ?? ''), "\n";
echo ($sampleFirst['params']['maxTokens'] ?? 0), "\n";

echo ($progress['status'] ?? 0), "\n";
$progressBody = json_decode((string) ($progress['body'] ?? ''), true);
echo (($progressBody['result']['queued'] ?? false) ? "progress_queued\n" : "progress_not_queued\n");
$progressMessages = is_array($progress['messages'] ?? null) ? $progress['messages'] : [];
$progressFirst = json_decode((string) ($progressMessages[0] ?? ''), true);
echo ($progressFirst['method'] ?? ''), "\n";
echo ($progressFirst['params']['progressToken'] ?? ''), "\n";
echo ($progressFirst['params']['message'] ?? ''), "\n";

echo ($log['status'] ?? 0), "\n";
$logBody = json_decode((string) ($log['body'] ?? ''), true);
echo (($logBody['result']['queued'] ?? false) ? "log_queued\n" : "log_not_queued\n");
$logMessages = is_array($log['messages'] ?? null) ? $log['messages'] : [];
$logFirst = json_decode((string) ($logMessages[0] ?? ''), true);
echo ($logFirst['method'] ?? ''), "\n";
echo ($logFirst['params']['logger'] ?? ''), "\n";
echo ($logFirst['params']['data']['message'] ?? ''), "\n";

echo ($queuedRequest['status'] ?? 0), "\n";
$queuedRequestBody = json_decode((string) ($queuedRequest['body'] ?? ''), true);
echo (($queuedRequestBody['result']['queued'] ?? false) ? "request_queued\n" : "request_not_queued\n");
$queuedRequestMessages = is_array($queuedRequest['messages'] ?? null) ? $queuedRequest['messages'] : [];
$queuedRequestFirst = json_decode((string) ($queuedRequestMessages[0] ?? ''), true);
echo ($queuedRequestFirst['method'] ?? ''), "\n";
echo ($queuedRequestFirst['params']['from'] ?? ''), "\n";

echo ($capsResult['status'] ?? 0), "\n";
$capsBody = json_decode((string) ($capsResult['body'] ?? ''), true);
echo ($capsBody['result']['client_capabilities_json'] ?? ''), "\n";
?>
--EXPECT--
200
init_json
vhttpd-mcp-demo
2025-11-05
logging_declared
sampling_declared
200
echo
text
200
hello helper
200
resource://demo/readme
200
vhttpd mcp demo resource
200
welcome
200
Welcome, codex!
200
queued
mcp-test-session
notifications/message
queued hello
200
sample_queued
sampling/createMessage
Summarize topic: runtime contract
You are a concise assistant.
128
200
progress_queued
notifications/progress
demo-progress
Half way there
200
log_queued
notifications/message
vhttpd-mcp-demo
hello log
200
request_queued
ping
server
200
{"sampling":{},"roots":{"listChanged":true}}
