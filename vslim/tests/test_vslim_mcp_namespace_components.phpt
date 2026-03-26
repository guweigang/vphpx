--TEST--
VSlim native MCP app provides MCP helpers and builtin handlers
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
}
?>
--FILE--
<?php
declare(strict_types=1);

$mcp = (new VSlim\Mcp\App())
    ->server_info(['name' => 'vslim-mcp-demo', 'version' => '0.1.0'])
    ->capabilities([
        'logging' => [],
        'sampling' => [],
    ])
    ->tool(
        'echo',
        'Echo text',
        [
            'type' => 'object',
            'properties' => [
                'text' => ['type' => 'string'],
            ],
            'required' => ['text'],
        ],
        static function (array $arguments): array {
            return [
                'content' => [
                    ['type' => 'text', 'text' => (string) ($arguments['text'] ?? '')],
                ],
                'isError' => false,
            ];
        }
    )
    ->resource(
        'resource://demo/readme',
        'demo-readme',
        'Read demo text',
        'text/plain',
        static function (): string {
            return "native mcp resource\n";
        }
    )
    ->prompt(
        'welcome',
        'Build a welcome prompt',
        [
            ['name' => 'name', 'required' => true],
        ],
        static function (array $arguments): array {
            $name = (string) ($arguments['name'] ?? 'guest');
            return [
                'description' => 'Welcome prompt',
                'messages' => [
                    [
                        'role' => 'user',
                        'content' => [
                            ['type' => 'text', 'text' => 'Welcome, ' . $name . '!'],
                        ],
                    ],
                ],
            ];
        }
    )
    ->register('debug/notify', static function (array $request, array $frame): array {
        return VSlim\Mcp\App::notify(
            $request['id'] ?? null,
            'notifications/message',
            ['text' => 'hello native mcp'],
            (string) ($frame['session_id'] ?? ''),
            (string) ($frame['protocol_version'] ?? '2025-11-05'),
        );
    })
    ->register('debug/sample', static function (array $request, array $frame): array {
        return VSlim\Mcp\App::queue_sampling(
            $request['id'] ?? null,
            'sample-' . (string) ($request['id'] ?? '1'),
            [[
                'role' => 'user',
                'content' => [
                    ['type' => 'text', 'text' => 'Summarize topic: native mcp'],
                ],
            ]],
            (string) ($frame['session_id'] ?? ''),
            (string) ($frame['protocol_version'] ?? '2025-11-05'),
            ['hints' => [['name' => 'qwen2.5']]],
            'You are concise.',
            64,
        );
    })
    ->register('debug/caps', static function (array $request, array $frame): array {
        $caps = VSlim\Mcp\App::client_capabilities($frame);
        return [
            'client_capabilities_json' => (string) ($frame['client_capabilities_json'] ?? ''),
            'sampling_supported' => VSlim\Mcp\App::client_supports($frame, 'sampling'),
            'has_roots' => isset($caps['roots']),
        ];
    });

$init = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 1,
        'method' => 'initialize',
        'params' => [
            'protocolVersion' => '2025-11-05',
        ],
    ], JSON_UNESCAPED_UNICODE),
]);
$initBody = json_decode($init['body'], true);
echo $initBody['result']['serverInfo']['name'] . "\n";
echo (isset($initBody['result']['capabilities']['logging']) ? "logging\n" : "logging_missing\n");
echo (isset($initBody['result']['capabilities']['sampling']) ? "sampling\n" : "sampling_missing\n");
echo (isset($initBody['result']['capabilities']['tools']) ? "tools\n" : "tools_missing\n");
echo (isset($initBody['result']['capabilities']['resources']) ? "resources\n" : "resources_missing\n");
echo (isset($initBody['result']['capabilities']['prompts']) ? "prompts\n" : "prompts_missing\n");

$tools = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 2,
        'method' => 'tools/list',
    ], JSON_UNESCAPED_UNICODE),
]);
$toolsBody = json_decode($tools['body'], true);
echo $toolsBody['result']['tools'][0]['name'] . "\n";

$toolCall = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 3,
        'method' => 'tools/call',
        'params' => [
            'name' => 'echo',
            'arguments' => ['text' => 'hello'],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);
$toolBody = json_decode($toolCall['body'], true);
echo $toolBody['result']['content'][0]['text'] . "\n";

$resourceRead = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 4,
        'method' => 'resources/read',
        'params' => [
            'uri' => 'resource://demo/readme',
        ],
    ], JSON_UNESCAPED_UNICODE),
]);
$resourceBody = json_decode($resourceRead['body'], true);
echo trim($resourceBody['result']['contents'][0]['text']) . "\n";

$promptGet = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 5,
        'method' => 'prompts/get',
        'params' => [
            'name' => 'welcome',
            'arguments' => ['name' => 'Alice'],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);
$promptBody = json_decode($promptGet['body'], true);
echo $promptBody['result']['messages'][0]['content'][0]['text'] . "\n";

$notify = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-1',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 6,
        'method' => 'debug/notify',
    ], JSON_UNESCAPED_UNICODE),
]);
$notifyBody = json_decode($notify['body'], true);
$notifyMsg = json_decode($notify['messages'][0] ?? 'null', true);
echo $notifyBody['result']['queued'] ? "queued\n" : "not_queued\n";
echo $notify['session_id'] . "\n";
echo (($notifyMsg['method'] ?? '') === 'notifications/message') ? "notify_msg\n" : "notify_missing\n";

$sample = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-1',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 7,
        'method' => 'debug/sample',
    ], JSON_UNESCAPED_UNICODE),
]);
$sampleMsg = json_decode($sample['messages'][0] ?? 'null', true);
echo (($sampleMsg['method'] ?? '') === 'sampling/createMessage') ? "sampling_msg\n" : "sampling_missing\n";

$caps = $mcp->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-1',
    'client_capabilities_json' => '{"sampling":{},"roots":{"listChanged":true}}',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 8,
        'method' => 'debug/caps',
    ], JSON_UNESCAPED_UNICODE),
]);
$capsBody = json_decode($caps['body'], true);
echo $capsBody['result']['client_capabilities_json'] . "\n";
echo (($capsBody['result']['sampling_supported'] ?? false) ? "sampling_supported\n" : "sampling_not_supported\n");
echo (($capsBody['result']['has_roots'] ?? false) ? "has_roots\n" : "missing_roots\n");

$gated = (new VSlim\Mcp\App())
    ->register('debug/sample', static function (array $request, array $frame): array {
        if ($resp = VSlim\Mcp\App::require_capability($frame, 'sampling', 'Sampling capability required by app', 409)) {
            return $resp;
        }
        return VSlim\Mcp\App::queue_sampling(
            $request['id'] ?? null,
            'sample-' . (string) ($request['id'] ?? '1'),
            [[
                'role' => 'user',
                'content' => [
                    ['type' => 'text', 'text' => 'Summarize topic: gated sample'],
                ],
            ]],
            (string) ($frame['session_id'] ?? ''),
            (string) ($frame['protocol_version'] ?? '2025-11-05'),
            ['hints' => [['name' => 'qwen2.5']]],
            'You are concise.',
            64,
        );
    });
$gatedMissing = $gated->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'session_id' => 'mcp-test-1',
    'client_capabilities_json' => '{"roots":{"listChanged":true}}',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 9,
        'method' => 'debug/sample',
    ], JSON_UNESCAPED_UNICODE),
]);
echo ($gatedMissing['status'] ?? 0) . "\n";
echo (string) ($gatedMissing['body'] ?? '') . "\n";

$requireNoCaps = VSlim\Mcp\App::require_capability([
    'protocol_version' => '2025-11-05',
], 'sampling', 'Sampling capability required by app', 409);
echo ($requireNoCaps === null ? "require_skipped\n" : "require_unexpected\n");

$app = new VSlim\App();
$app->get('/', static fn () => ['ok' => true]);
$app->mcp()
    ->server_info(['name' => 'attached-mcp', 'version' => '0.1.0'])
    ->tool(
        'echo',
        'Echo text',
        ['type' => 'object'],
        static function (array $arguments): array {
            return [
                'content' => [
                    ['type' => 'text', 'text' => (string) ($arguments['text'] ?? '')],
                ],
                'isError' => false,
            ];
        }
    );
echo ($app->has_mcp() ? "app_has_mcp\n" : "app_missing_mcp\n");
$attached = $app->handle_mcp_dispatch([
    'protocol_version' => '2025-11-05',
    'jsonrpc_raw' => json_encode([
        'jsonrpc' => '2.0',
        'id' => 10,
        'method' => 'tools/list',
    ], JSON_UNESCAPED_UNICODE),
]);
$attachedBody = json_decode($attached['body'], true);
echo $attachedBody['result']['tools'][0]['name'] . "\n";
?>
--EXPECT--
vslim-mcp-demo
logging
sampling
tools
resources
prompts
echo
hello
native mcp resource
Welcome, Alice!
queued
mcp-test-1
notify_msg
sampling_msg
{"sampling":{},"roots":{"listChanged":true}}
sampling_supported
has_roots
409
{"error":"Sampling capability required by app"}
require_skipped
app_has_mcp
echo
