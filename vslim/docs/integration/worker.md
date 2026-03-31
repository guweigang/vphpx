# Worker / Envelope 集成

这一页描述 VSlim 和 worker / transport 的稳定边界。这里的“真理之源”不是旧设计文档，而是当前代码和测试：

- [`src/php_app.v`](/Users/guweigang/Source/vphpx/vslim/src/php_app.v)
- [`src/request.v`](/Users/guweigang/Source/vphpx/vslim/src/request.v)
- [`tests/test_demo_dispatch.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_demo_dispatch.phpt)
- [`tests/test_vslim_dispatch_envelope_map_headers.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_dispatch_envelope_map_headers.phpt)
- [`examples/demo_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo_app.php)

## 入口

VSlim 当前有三种 worker 相关入口：

- `vslim_handle_request(...)`
- `VSlim\App->dispatch_envelope($envelope)`
- `VSlim\App->dispatch_envelope_map($envelope)`

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

## `dispatch_envelope()`

会把 envelope 转成 `VSlim\Vhttpd\Request`，然后走正常的 app dispatch 流程：

```php
$res = $app->dispatch_envelope($envelope);
```

返回值是 `VSlim\Vhttpd\Response`。

## `dispatch_envelope_map()`

适合 worker 边界，因为返回的是简单 map：

- `status`
- `body`
- `content_type`
- `headers_<lowercase-name>`

示例：

```php
$map = $app->dispatch_envelope_map($envelope);

echo $map['status'];
echo $map['headers_x-request-id'];
```

## `vslim_handle_request(...)`

它是 extension 暴露出来的全局函数，可接受：

1. 一个 envelope
2. 或 `method, path, body`

返回一个 map，最基本字段是：

- `status`
- `body`
- `content_type`

## header 透传

dispatch 完成后，VSlim 会自动把请求里的 tracing 信息补到响应头：

- `x-request-id`
- `x-trace-id`
- `x-vhttpd-trace-id`

优先规则来自 `VSlim\Vhttpd\Request::request_id()` 和 `trace_id()`。

## worker 场景下的 handler 返回值

route / middleware / error handler 最终都要归一化成 `VSlim\Vhttpd\Response`。当前支持：

- `VSlim\Vhttpd\Response`
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
