<?php

declare(strict_types=1);

$app = new VSlim\App();
$app->get('/', static fn () => [
    'name' => 'vslim-native-mcp-demo',
    'mcp' => '/mcp',
    'http' => '/',
]);
$app->get('/health', static fn () => 'OK');
$app->get('/meta', static fn () => [
    'name' => 'vslim-native-mcp-demo',
    'http' => '/',
    'mcp' => '/mcp',
    'native' => true,
]);

$app->mcp()
    ->serverInfo(['name' => 'vslim-native-mcp-demo', 'version' => '0.1.0'])
    ->capabilities([
        'logging' => [],
        'sampling' => [],
    ])
    ->tool(
        'echo',
        'Echo text back to the caller',
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
        'Read the native MCP demo resource payload',
        'text/plain',
        static function (): string {
            return "vslim native mcp resource\n";
        }
    )
    ->prompt(
        'welcome',
        'Build a welcome prompt for a named user',
        [
            [
                'name' => 'name',
                'description' => 'Display name for the user',
                'required' => true,
            ],
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
            ['text' => 'hello from native VSlim MCP'],
            (string) ($frame['session_id'] ?? ''),
            (string) ($frame['protocol_version'] ?? '2025-11-05'),
        );
    })
    ->register('debug/sample', static function (array $request, array $frame): array {
        $params = is_array($request['params'] ?? null) ? $request['params'] : [];
        $topic = (string) ($params['topic'] ?? 'VSlim native MCP');
        if ($resp = VSlim\Mcp\App::require_capability($frame, 'sampling', 'Sampling capability required by app', 409)) {
            return $resp;
        }
        return VSlim\Mcp\App::queue_sampling(
            $request['id'] ?? null,
            'sample-' . (string) ($request['id'] ?? '1'),
            [[
                'role' => 'user',
                'content' => [
                    ['type' => 'text', 'text' => 'Summarize topic: ' . $topic],
                ],
            ]],
            (string) ($frame['session_id'] ?? ''),
            (string) ($frame['protocol_version'] ?? '2025-11-05'),
            ['hints' => [['name' => 'qwen2.5']]],
            'You are a concise assistant.',
            128,
        );
    })
    ->register('debug/caps', static function (array $request, array $frame): array {
        $caps = VSlim\Mcp\App::clientCapabilities($frame);
        return [
            'client_capabilities_json' => (string) ($frame['client_capabilities_json'] ?? ''),
            'sampling_supported' => VSlim\Mcp\App::clientSupports($frame, 'sampling'),
            'has_roots' => isset($caps['roots']),
        ];
    });

return $app;
