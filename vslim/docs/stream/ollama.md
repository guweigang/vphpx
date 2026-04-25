# Ollama

这一页主要回答 3 个问题：

1. JS 请求哪个地址
2. `vhttpd -> VSlim -> Ollama` 链路怎么走
3. 哪一层负责协议转换

## 前端请求地址

如果你使用 VSlim 的 Ollama demo：

- text stream: `/ollama/text`
- SSE: `/ollama/sse`

不是 `/events/stream`。

`/events/stream` 更像本地流式示例或验证端点，不是 Ollama 代理入口。

## 整体链路

```text
Browser
  -> vhttpd
  -> php-worker
  -> VSlim\App route
  -> VSlim\Stream\OllamaClient
  -> Ollama /api/chat
```

## 组件分工

### `VSlim\Stream\OllamaClient`

负责：

- 从 `VSlim\VHttpd\Request` 提取 `prompt / model / messages`
- 请求 `POST /api/chat`
- 打开上游流

它发给 Ollama 的请求核心是：

```json
{
  "model": "qwen2.5:7b-instruct",
  "stream": true,
  "messages": [
    {"role": "user", "content": "hello"}
  ]
}
```

响应假定为 NDJSON。

### `VSlim\Stream\NdjsonDecoder`

负责把上游返回的 NDJSON：

```text
{"message":{"content":"Hello"}}
{"message":{"content":" world"}}
{"done":true}
```

解成一条条数组记录。

### `VSlim\Stream\SseEncoder`

负责把解出来的 token/chunk 编成 SSE event：

```php
[
    'event' => 'token',
    'data' => '{"token":"Hello"}',
]
```

### `VSlim\Stream\Response`

负责把最终流式输出表达成一个 VSlim 可返回的响应对象。

worker 看到它后，会自动进入 stream 模式。

## 路由最简写法

```php
<?php

$app->map(['GET', 'POST'], '/ollama/text', function (VSlim\VHttpd\Request $req) {
    return VSlim\Stream\Factory::ollama_text($req);
});

$app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\VHttpd\Request $req) {
    return VSlim\Stream\Factory::ollama_sse($req);
});
```

这也是当前推荐的 userland 接入方式。

如果你想看 `Factory` 的纯 text / SSE 用法，再看：

- [`factory.md`](/Users/guweigang/Source/vphpx/vslim/docs/stream/factory.md)
