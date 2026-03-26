# VSlim\Response

`VSlim\Response` 是 VSlim 的轻量响应对象，适合在 route、middleware、error handler 里直接返回。

真理之源：

- [`src/response.v`](/Users/guweigang/Source/vphpx/vslim/src/response.v)
- [`tests/test_demo_dispatch.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_demo_dispatch.phpt)
- [`tests/test_vslim_request_trace_ids.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_request_trace_ids.phpt)

## 构造

```php
$res = new VSlim\Response(200, 'ok', 'text/plain; charset=utf-8');
```

构造后会自动设置：

- `status`
- `body`
- `content_type`
- `content-type` header

## 常用字段

- `status`
- `body`
- `content_type`

## Header API

- `header($name)`
- `headers()`
- `headers_all()`
- `has_header($name)`
- `set_header($name, $value)`

示例：

```php
$res->set_header('x-demo', 'yes');
echo $res->header('x-demo');
```

## Content-Type helpers

- `set_content_type($contentType)`
- `text($body)`
- `json($body)`
- `html($body)`

示例：

```php
$res->json('{"ok":true}');
```

会把：

- `body` 改为你的 JSON 文本
- `content_type` 改为 `application/json; charset=utf-8`
- `content-type` header 同步更新

## 状态码

- `set_status($status)`
- `with_status($status)`

两者当前都是可变式 setter。

## Cookie

支持：

- `cookie_header()`
- `set_cookie($name, $value)`
- `set_cookie_opts($name, $value, $path)`
- `set_cookie_full($name, $value, $path, $domain, $maxAge, $secure, $httpOnly, $sameSite)`
- `delete_cookie($name)`

示例：

```php
$res->set_cookie_full('sid', 'abc', '/', '', 3600, true, true, 'Lax');
```

## Redirect

- `redirect($location)`
- `redirect_with_status($location, $status)`

示例：

```php
$res = new VSlim\Response(200, 'ignored', 'text/plain; charset=utf-8');
$res->redirect_with_status('/moved', 307);
```

行为：

- `status` 改成指定值
- `location` header 被设置
- `body` 清空

## trace / request id

- `with_request_id($id)`
- `with_trace_id($id)`

示例：

```php
$res->with_request_id('rid-7')->with_trace_id('trace-7');
```

`with_trace_id()` 还会在没有显式设置时自动补：

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
    return new VSlim\Response(200, 'hello', 'text/plain; charset=utf-8');
});
```

### 先构造后修改

```php
$res = new VSlim\Response(200, '', 'text/plain; charset=utf-8');
$res->text('ok')->set_header('x-demo', 'yes');
return $res;
```

### 在 `after()` 里修改响应

```php
$app->after(function (VSlim\Request $req, VSlim\Response $res) {
    $res->set_header('x-after', '1');
    return $res;
});
```

