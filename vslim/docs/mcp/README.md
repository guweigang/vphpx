# VSlim MCP

`VSlim\Mcp\App` 是 `vslim.so` 提供的扩展原生 MCP handler。

它的定位是：

- 不把 MCP 的协议细节强塞进路由 DSL
- 但允许你直接把原生 MCP handler 挂到 `VSlim\App`
- bootstrap 现在可以只返回一个 `VSlim\App`

最小结构：

```php
<?php

$app = new VSlim\App();
$app->get('/', static fn () => ['name' => 'demo']);

$app->mcp()
    ->server_info(['name' => 'vslim-native-mcp-demo', 'version' => '0.1.0'])
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
    );

return $app;
```

如果你已经自己创建了 `VSlim\Mcp\App`，也可以显式挂载：

```php
$app = new VSlim\App();
$mcp = new VSlim\Mcp\App();
$app->set_mcp($mcp);
```

当前原生 API 已支持：

- `server_info(...)`
- `capability(...)`
- `capabilities(...)`
- `register(...)`
- `tool(...)`
- `resource(...)`
- `prompt(...)`
- `handle_mcp_dispatch(...)`

`handle_mcp_dispatch(...)` 收到的 `$frame` 当前可直接读取这些关键字段：

- `protocol_version`
- `session_id`
- `client_capabilities_json`
- `jsonrpc_raw`

这意味着 capability negotiation 已经可以直接在原生 handler 里使用。最常见的场景就是按 client capability 决定是否允许 `sampling`：

```php
$app->mcp()->register('debug/sample', static function (array $request, array $frame): array {
    $caps = (string) ($frame['client_capabilities_json'] ?? '');
    if ($caps !== '' && !VSlim\Mcp\App::client_supports($frame, 'sampling')) {
        return VSlim\Mcp\App::capability_error($frame, 'Sampling capability required by app', 409);
    }

    return VSlim\Mcp\App::queue_sampling(
        $request['id'] ?? null,
        'sample-' . (string) ($request['id'] ?? '1'),
        [[
            'role' => 'user',
            'content' => [
                ['type' => 'text', 'text' => 'Summarize topic: VSlim native MCP'],
            ],
        ]],
        (string) ($frame['session_id'] ?? ''),
        (string) ($frame['protocol_version'] ?? '2025-11-05'),
        ['hints' => [['name' => 'qwen2.5']]],
        'You are a concise assistant.',
        128,
    );
});
```

如果你只想判断当前 client 是否声明了某个 capability，也可以直接：

```php
$supported = VSlim\Mcp\App::client_supports($frame, 'sampling');
```

如果你想直接拿到解析后的 capability 数组，也可以：

```php
$caps = VSlim\Mcp\App::client_capabilities($frame);
```

如果你只是想做一个 guard，直接用更短的糖衣即可：

```php
if ($resp = VSlim\Mcp\App::require_capability($frame, 'sampling', 'Sampling capability required by app', 409)) {
    return $resp;
}
```

静态 helper 已支持：

- `client_supports(...)`
- `client_capabilities(...)`
- `capability_error(...)`
- `require_capability(...)`
- `notification(...)`
- `request(...)`
- `sampling_request(...)`
- `queued_result(...)`
- `queue_messages(...)`
- `notify(...)`
- `queue_notification(...)`
- `queue_request(...)`
- `queue_progress(...)`
- `queue_log(...)`
- `queue_sampling(...)`

现成示例：

- [`/Users/guweigang/Source/vphpx/vslim/examples/mcp_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/mcp_app.php)
- [`/Users/guweigang/Source/vphpx/vslim/examples/mcp.toml`](/Users/guweigang/Source/vphpx/vslim/examples/mcp.toml)
- [`/Users/guweigang/Source/vphpx/vslim/docs/mcp/runbook.md`](/Users/guweigang/Source/vphpx/vslim/docs/mcp/runbook.md)
