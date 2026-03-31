# PSR-7 适配

VSlim 本身不是完整 PSR-7 实现，但当前项目已经提供了一个 PHP 侧桥接类，把 PSR-7 风格 request 转成 `VSlim\Vhttpd\Request`。

真理之源：

- [`vhttpd/php/package/src/VSlim/Psr7Adapter.php`](/Users/guweigang/Source/vhttpd/php/package/src/VSlim/Psr7Adapter.php)
- [`tests/test_vslim_psr7_adapter.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_psr7_adapter.phpt)
- [`tests/test_psr7_worker_app.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_psr7_worker_app.phpt)

## 类名

当前主类是：

```php
VPhp\VSlim\Psr7Adapter
```

项目里也保留了一些 legacy alias，但新文档建议统一使用这个类名。

## 核心方法

- `dispatch(VSlim\App $app, object $request): VSlim\Vhttpd\Response`
- `toVSlimRequest(object $request): VSlim\Vhttpd\Request`
- `toWorkerEnvelope(object $request): array`

## 最简单示例

```php
use VPhp\VSlim\Psr7Adapter;
use Psr\Http\Message\ServerRequestInterface;

$app = new VSlim\App();
$app->get('/users/:id', function (ServerRequestInterface $req) {
    return $req->getMethod() . '|' . $req->getUri()->getPath() . '|' . $req->getHeaderLine('x-trace-id');
});

$res = Psr7Adapter::dispatch($app, $psrRequest);
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

这个方法适合你只想复用适配逻辑，但后续还想继续手动加工 `VSlim\Vhttpd\Request`：

```php
$vRequest = Psr7Adapter::toVSlimRequest($psrRequest);
$vRequest->set_attributes(['extra' => 'demo']);
$res = $app->dispatch_request($vRequest);
```

## `toWorkerEnvelope()`

如果你的 worker 边界最终还是想走 envelope，可以先把 PSR-7 request 变成数组：

```php
$envelope = Psr7Adapter::toWorkerEnvelope($psrRequest);
$map = $app->dispatch_envelope_map($envelope);
```

## 适合什么场景

适合：

- `vhttpd` / PHP worker 想接入 PSR-7 request
- 现有 middleware / bridge 产出的是 PSR-7 风格 request
- 想把 PHP 生态边界和 VSlim runtime 接起来

不适合：

- 把 VSlim 当完整 PSR-7 message implementation 使用

因为当前 VSlim 的 request/response 核心仍然是自己的轻量模型。
