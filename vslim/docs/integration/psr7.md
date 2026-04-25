# PSR-7 适配

VSlim 本身不是完整 PSR-7 实现，但当前扩展已经内建了一个桥接类，把 PSR-7 风格 request 转成 `VSlim\Vhttpd\Request`。

这层适配的定位要先说清楚：

- 它不是为了让 `VSlim` 变成“另一个 PSR-7 package”
- 它是为了把
  - `vhttpd/php-worker`
  - 现有 PSR-7 request 来源
  - 以及 `VSlim` 原生 app model
  接在一起

所以它更像：

- runtime / ecosystem bridge

而不是：

- 框架核心 API 的唯一入口

真理之源：

- [`vslim/src/psr7_adapter_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/psr7_adapter_runtime.v)
- [`tests/test_vslim_psr7_adapter.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_psr7_adapter.phpt)
- [`tests/test_psr7_worker_app.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_psr7_worker_app.phpt)

## 类名

当前主类是扩展内建的：

```php
VSlim\Psr7Adapter
```

## 核心方法

- `toVSlimRequest(object $request): VSlim\Vhttpd\Request`
- `toVSlimResponse(ResponseInterface $response): VSlim\Vhttpd\Response`
- `toWorkerEnvelope(object $request): array`

## 最简单示例

```php
use VSlim\Psr7Adapter;
use Psr\Http\Message\ServerRequestInterface;

$app = new VSlim\App();
$app->get('/users/:id', function (ServerRequestInterface $req) {
    return $req->getMethod() . '|' . $req->getUri()->getPath() . '|' . $req->getHeaderLine('x-trace-id');
});

$psrResponse = $app->handle($psrRequest);
$res = Psr7Adapter::toVSlimResponse($psrResponse);
```

## 它会读取哪些信息

适配器会尽量从请求对象读取：

- method
- request target / URI path + query
- body
- scheme / host / port
- protocol version
- headers
- cookies
- query params
- attributes
- server params
- uploaded files

它做的是“宽松兼容读取”，也就是说：

- 优先读常见 getter，例如 `getMethod()`、`getHeaders()`
- 如果没有 getter，再尝试读同名属性

所以它不要求请求对象一定是某个固定实现，只要形状足够接近即可。

## `toVSlimRequest()`

这个方法适合你只想复用 request 适配逻辑，但后续还想继续手动加工 `VSlim\Vhttpd\Request`：

```php
$vRequest = Psr7Adapter::toVSlimRequest($psrRequest);
$vRequest->setAttributes(['extra' => 'demo']);
$res = $app->dispatchRequest($vRequest);
```

如果你需要一条明确的 `VSlim\Vhttpd\Request -> VSlim\Vhttpd\Response` 入口，这条组合就是当前最直接的 facade 路径。

## `toVSlimResponse()`

这个方法适合在测试、调试或 bridge 层，把 `handle()` 拿到的 PSR response 显式转回 `VSlim\Vhttpd\Response`：

```php
$psrResponse = $app->handle($psrRequest);
$response = Psr7Adapter::toVSlimResponse($psrResponse);

echo $response->status;
echo $response->body;
```

## `toWorkerEnvelope()`

如果你的 worker 边界最终还是想走 envelope，可以先把 PSR-7 request 变成数组：

```php
$envelope = Psr7Adapter::toWorkerEnvelope($psrRequest);
$map = $app->dispatchEnvelopeMap($envelope);
```

## 适合什么场景

适合：

- `vhttpd` / PHP worker 想接入 PSR-7 request
- 现有 middleware / bridge 产出的是 PSR-7 风格 request
- 想把 PHP 生态边界和 VSlim runtime 接起来

这也正好对应两条不同产品线：

- `vhttpd + php package`
  更强调“承载现有 PHP 生态”
- `VSlim`
  更强调“把这些能力原生做进框架”

`Psr7Adapter` 站在这两条线的交界处，更适合承担“转换”职责，而不是框架主入口职责。

不适合：

- 把 VSlim 当完整 PSR-7 message implementation 使用

因为当前 VSlim 的 request/response 核心仍然是自己的轻量模型。
