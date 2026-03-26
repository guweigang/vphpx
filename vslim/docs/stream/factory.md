# Factory

这一页只讲 `VSlim\Stream\Factory`。

它的定位是：

- 给 `VSlim\Stream\Response` 提供更短的构造入口
- 给 Ollama 场景提供更高层的快捷方法

## `text()`

最简单的纯文本流：

```php
<?php

$app->get('/stream/text', function () {
    return VSlim\Stream\Factory::text((function (): iterable {
        yield "hello\n";
        yield "world\n";
    })());
});
```

如果你要指定状态码、content type、headers：

```php
<?php

$app->get('/stream/text', function () {
    return VSlim\Stream\Factory::text_with(
        (function (): iterable {
            yield "chunk-a\n";
            yield "chunk-b\n";
        })(),
        200,
        'text/plain; charset=utf-8',
        ['x-demo' => 'stream']
    );
});
```

## `sse()`

最简单的 SSE：

```php
<?php

$app->get('/stream/sse', function () {
    return VSlim\Stream\Factory::sse((function (): iterable {
        yield ['event' => 'token', 'data' => '{"token":"hello"}'];
        yield ['event' => 'done', 'data' => '{"done":true}'];
    })());
});
```

自定义 headers 时，用 `sse_with()`：

```php
<?php

$app->get('/stream/sse', function () {
    return VSlim\Stream\Factory::sse_with(
        (function (): iterable {
            yield ['event' => 'message', 'data' => '{"ok":true}'];
        })(),
        200,
        ['cache-control' => 'no-cache']
    );
});
```

## `ollama_text()` / `ollama_sse()`

这两个方法会直接：

- 从 `VSlim\Request` 取 prompt/model/messages
- 对接 Ollama `/api/chat`
- 把上游 NDJSON 转成 text stream 或 SSE

最短写法：

```php
<?php

$app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Request $req) {
    return VSlim\Stream\Factory::ollama_text($req);
});

$app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\Request $req) {
    return VSlim\Stream\Factory::ollama_sse($req);
});
```

如果你要覆盖默认配置，用 `ollama_text_with()` / `ollama_sse_with()`：

```php
<?php

$app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Request $req) {
    return VSlim\Stream\Factory::ollama_text_with($req, [
        'chat_url' => 'http://127.0.0.1:11434/api/chat',
        'model' => 'qwen2.5:7b-instruct',
        'api_key' => '',
        'fixture' => '',
    ]);
});
```

## 推荐用法

如果只是“我要返回一个 stream”：

- 优先用 `VSlim\Stream\Factory`

如果你要直接控制响应对象细节：

- 用 `VSlim\Stream\Response`

如果你要单独测试或复用 Ollama 协议层：

- 用 `VSlim\Stream\OllamaClient`
- 配合 `VSlim\Stream\NdjsonDecoder`
- 配合 `VSlim\Stream\SseEncoder`
