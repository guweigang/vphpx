# VSlim\VHttpd\Response

`VSlim\VHttpd\Response` 是 VSlim 的轻量响应对象，适合在 route、middleware、error handler 里直接返回。

真理之源：

- [`src/response.v`](/Users/guweigang/Source/vphpx/vslim/src/response.v)
- [`tests/test_demo_dispatch.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_demo_dispatch.phpt)
- [`tests/test_vslim_request_trace_ids.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_request_trace_ids.phpt)

## 构造

```php
$res = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
```

构造后会自动设置：

- `status`
- `body`
- `contentType`
- `content-type` header

## 常用字段

- `status`
- `body`
- `contentType`

## Header API

- `header($name)`
- `headers()`
- `headersAll()`
- `hasHeader($name)`
- `setHeader($name, $value)`

示例：

```php
$res->setHeader('x-demo', 'yes');
echo $res->header('x-demo');
```

## Content-Type helpers

- `setContentType($contentType)`
- `text($body)`
- `json($body)`
- `html($body)`

示例：

```php
$res->json('{"ok":true}');
```

会把：

- `body` 改为你的 JSON 文本
- `contentType` 改为 `application/json; charset=utf-8`
- `content-type` header 同步更新

## 状态码

- `setStatus($status)`
- `withStatus($status)`

两者当前都是可变式 setter。

## Cookie

支持：

- `cookieHeader()`
- `setCookie($name, $value)`
- `setCookieOpts($name, $value, $path)`
- `setCookieFull($name, $value, $path, $domain, $maxAge, $secure, $httpOnly, $sameSite)`
- `deleteCookie($name)`

示例：

```php
$res->setCookieFull('sid', 'abc', '/', '', 3600, true, true, 'Lax');
```

## Redirect

- `redirect($location)`
- `redirectWithStatus($location, $status)`

示例：

```php
$res = new VSlim\VHttpd\Response(200, 'ignored', 'text/plain; charset=utf-8');
$res->redirectWithStatus('/moved', 307);
```

行为：

- `status` 改成指定值
- `location` header 被设置
- `body` 清空

## trace / request id

- `withRequestId($id)`
- `withTraceId($id)`

示例：

```php
$res->withRequestId('rid-7')->withTraceId('trace-7');
```

`withTraceId()` 还会在没有显式设置时自动补：

- `x-trace-id`
- `x-vhttpd-trace-id`

另外，`App` 在 dispatch 完成后也会把请求里的 trace/request id 自动传播到响应头。

## 其它工具方法

- `as_array()`
- `str()`
- `content_length()`

## 推荐用法

### 直接返回 `Response`

```php
$app->get('/hello', function () {
    return new VSlim\VHttpd\Response(200, 'hello', 'text/plain; charset=utf-8');
});
```

### 先构造后修改

```php
$res = new VSlim\VHttpd\Response(200, '', 'text/plain; charset=utf-8');
$res->text('ok')->setHeader('x-demo', 'yes');
return $res;
```

### 在 `after()` 里修改响应

```php
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

$app->after(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        return $handler->handle($request)->withHeader('x-after', '1');
    }
});
```
