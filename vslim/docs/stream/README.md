# Stream

`VSlim\Stream` 是安装了 `vslim.so` 之后可直接使用的扩展流式命名空间。

推荐这样理解：

- `VSlim\Stream\Response`
  流式响应对象；和 `VSlim\Response` 并列
- `VSlim\Stream\Factory`
  更短的 text/sse/ollama 快捷入口
- `VSlim\Stream\OllamaClient`
  Ollama 协议对接层
- `VSlim\Stream\NdjsonDecoder`
  NDJSON 解码
- `VSlim\Stream\SseEncoder`
  SSE 事件编码

## 最简单的 text stream

```php
<?php

$app = new VSlim\App();

$app->get('/text', function () {
    return VSlim\Stream\Factory::text((function (): iterable {
        yield "hello\n";
        yield "world\n";
    })());
});
```

## 最简单的 SSE stream

```php
<?php

$app = new VSlim\App();

$app->get('/events', function () {
    return VSlim\Stream\Factory::sse((function (): iterable {
        yield [
            'event' => 'token',
            'data' => '{"token":"hello"}',
        ];
        yield [
            'event' => 'done',
            'data' => '{"done":true}',
        ];
    })());
});
```

## Ollama 快捷入口

```php
<?php

$app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Request $req) {
    return VSlim\Stream\Factory::ollama_text($req);
});

$app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\Request $req) {
    return VSlim\Stream\Factory::ollama_sse($req);
});
```

默认读取这些环境变量：

- `OLLAMA_CHAT_URL`
- `OLLAMA_MODEL`
- `OLLAMA_API_KEY`
- `OLLAMA_STREAM_FIXTURE`

## 和 PHP package 的关系

如果安装了 `vslim.so`，优先使用：

- `VSlim\Stream\Response`
- `VSlim\Stream\Factory`
- `VSlim\Stream\OllamaClient`
- `VSlim\Stream\NdjsonDecoder`
- `VSlim\Stream\SseEncoder`

如果是不装扩展、只走 PHP package 的场景，再使用：

- `VPhp\VSlim\Stream\Response`
- `VPhp\VSlim\Stream\Factory`
- `VPhp\VSlim\Stream\OllamaClient`
- `VPhp\VSlim\Stream\NdjsonDecoder`
- `VPhp\VSlim\Stream\SseEncoder`

也就是说：

- `vslim/` 目录下的 demo、测试、文档，默认按扩展模式写
- `vhttpd/php/package/` 目录下的类，才是纯 PHP package 模式
