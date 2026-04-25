# Worker / Envelope 集成

这一页描述 VSlim 和 worker / transport 的稳定边界。这里的“真理之源”不是旧设计文档，而是当前代码和测试：

- [`src/php_app.v`](/Users/guweigang/Source/vphpx/vslim/src/php_app.v)
- [`src/request.v`](/Users/guweigang/Source/vphpx/vslim/src/request.v)
- [`tests/test_demo_dispatch.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_demo_dispatch.phpt)
- [`tests/test_vslim_dispatch_envelope_map_headers.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_dispatch_envelope_map_headers.phpt)
- [`examples/demo_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo_app.php)

## 先说清楚边界

这一页描述的是：

- 当上游不是直接把 PHP 全局变量交给应用，而是先经过 worker / transport runtime
- `VSlim` 应该怎样接 request、怎样吐 response

这里的核心结论是：

- `VSlim` 不是 worker runtime
- `VSlim` 也不是 web server
- 它只定义 app 层边界

这页讨论的不是“怎么兼容现有 PHP 框架”，而是：

- 当你已经决定用 `VSlim` 写应用
- 上游再选择什么 transport / worker runtime 把请求交给它

如果你的目标是：

- `wordpress`
- `laravel`
- `symfony`
- 或别的现成 PHP 应用

那更应该先看 `vhttpd + php package` 这条线。  
这页讲的是 `VSlim` 自己作为原生框架时，和 worker/runtime 怎么对接。

上游可以是：

- `vhttpd` + php-worker
- 你自己的 worker 进程
- 任何愿意按 envelope 或 PSR request 把请求交给 `VSlim` 的 transport

如果你不是 worker 场景，而是：

- PHP built-in server
- nginx / Apache / Caddy + PHP-FPM

那通常更适合自己先组一个 `VSlim\Vhttpd\Request`，再走 `dispatchRequest(...)`；或者直接走 PSR-7 adapter。

## 入口

VSlim 当前有三种 worker 相关入口：

- `VSlim\App->dispatchEnvelope($envelope)`
- `VSlim\App->dispatchEnvelopeMap($envelope)`

另外还有一条越来越重要的标准入口：

- `VSlim\App->handle($psrRequest)`

可以把它们理解成：

- `dispatchEnvelope*`
  - transport / worker-friendly facade
- `handle()`
  - PSR-7 / PSR-15 主通道

也就是说：

- `dispatchEnvelope*`
  更像 `VSlim` 暴露给 worker/runtime 的适配面
- `handle()`
  更像框架内部和标准 PHP 生态靠拢的 canonical 通道

## request envelope 形状

当前支持的字段：

- `method`
- `path`
- `body`
- `scheme`
- `host`
- `port`
- `protocol_version`
- `remote_addr`
- `headers`
- `cookies`
- `query`
- `attributes`
- `server`
- `uploaded_files`
- `params`

示例：

```php
[
    'method' => 'GET',
    'path' => '/users/42?trace_id=demo',
    'body' => '',
    'scheme' => 'https',
    'host' => 'example.test',
    'port' => '443',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'headers' => ['x-request-id' => 'req-1'],
    'cookies' => ['sid' => 'cookie-1'],
    'query' => ['trace_id' => 'demo'],
    'attributes' => [],
    'server' => [],
    'uploaded_files' => [],
]
```

## `dispatchEnvelope()`

会把 envelope 转成 `VSlim\Vhttpd\Request`，然后走正常的 app dispatch 流程：

```php
$res = $app->dispatchEnvelope($envelope);
```

返回值是 `VSlim\Vhttpd\Response`。

这里的语义更适合理解成：

- `VSlim\Vhttpd\Request/Response` 是 worker facade
- 它们方便 transport 边界接入
- 但框架内部更标准的 HTTP 契约正在继续收成 PSR request / PSR response

## `dispatchEnvelopeMap()`

适合 worker 边界，因为返回的是简单 map：

- `status`
- `body`
- `content_type`
- `headers_<lowercase-name>`

示例：

```php
$map = $app->dispatchEnvelopeMap($envelope);

echo $map['status'];
echo $map['headers_x-request-id'];
```

## header 透传

dispatch 完成后，VSlim 会自动把请求里的 tracing 信息补到响应头：

- `x-request-id`
- `x-trace-id`
- `x-vhttpd-trace-id`

优先规则来自 `VSlim\Vhttpd\Request::requestId()` 和 `traceId()`。

## worker 场景下的 handler 返回值

worker facade 层最终会把结果归一化成 `VSlim\Vhttpd\Response` 或 map。当前支持：

- `VSlim\Vhttpd\Response`
- `Psr\Http\Message\ResponseInterface`
- `string`
- `array`

推荐 worker 场景多返回数组，因为结构清晰：

```php
return [
    'status' => 200,
    'content_type' => 'application/json; charset=utf-8',
    'headers' => ['x-worker' => 'yes'],
    'body' => '{"ok":true}',
];
```

## 请求校验

在 envelope 进入 app 后，VSlim 还会做两类检查：

- 非法 JSON -> `400`
- body 超过 `VSLIM_MAX_BODY_BYTES` -> `413`

## 推荐边界

推荐把 transport 层和 framework 层分开：

- transport / socket / process supervision 交给 `vhttpd` / worker
- app routing / middleware / response normalization 交给 VSlim

如果要用一句最短的话总结：

- `vhttpd` 负责“怎么跑”
- `VSlim` 负责“怎么写”

如果你在设计系统边界，推荐这样理解：

- ingress
  - envelope 或 `VSlim\Vhttpd\Request`
- framework core
  - 尽量以 `Psr\Http\Message\ServerRequestInterface` / `ResponseInterface` 为主
- egress
  - 再按 worker/runtime 需要适配成 `VSlim\Vhttpd\Response` 或 map
