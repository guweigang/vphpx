# VSlim Testing

`VSlim` 现在内建一套轻量 testing harness，目标不是替代完整测试框架，而是让你在扩展级 app 上更顺手地写集成测试。

核心入口：

- `app()->testing()`

它适合做这些事：

- 覆盖 container service
- 覆盖配置
- 快速发起 HTTP/JSON 请求
- 直接走 `handle()` / PSR request
- 断言 response
- 注入 cookie / session / 登录态

## 最小示例

```php
<?php

$app = VSlim\App::demo();

$app->get('/hello', function (): string {
    return 'world';
});

$test = $app->testing();
$res = $test->get('/hello');

$test->assertStatus($res, 200)
     ->assertBodyContains($res, 'world');
```

## 常用能力

### Service / Config Override

```php
$test = $app->testing()
    ->withService('message', 'from-test')
    ->withConfigText("[testing]\nmessage = 'from-config'\n");
```

### Quick Dispatch

```php
$hello = $test->get('/hello');
$echo = $test->post('/echo', 'payload');
$json = $test->postJson('/json', ['name' => 'codex']);
```

### PSR Handle

```php
$request = $test->request('GET', 'https://example.com/hello');
$response = $test->handle($request);
```

也可以直接走：

```php
$response = $test->handleRequest('GET', 'https://example.com/hello');
$json = $test->handleJson('POST', 'https://example.com/users', ['name' => 'codex']);
```

### Response Helper

```php
$test->responseStatus($res);
$test->responseHeader($res, 'content-type');
$test->responseBody($res);
$test->responseJson($jsonRes);
```

### Response Assert

```php
$test->assertStatus($res, 200);
$test->assertHeader($res, 'content-type', 'application/json; charset=utf-8');
$test->assertBodyContains($res, 'ok');
```

## Session / Auth 测试

testing harness 现在自带 cookie jar。也就是说：

- 响应里如果写了 `Set-Cookie`
- 后续 `get()/post()/handleRequest()/handleJson()` 会自动带上

最常用的两个 helper 是：

- `withSession([...])`
- `actingAs('42')`

```php
$test = $app->testing();

$test->withSession(['name' => 'alice']);
echo $test->responseBody($test->get('/session'));

$test->clearCookies()->actingAs('42');
echo $test->responseBody($test->get('/me'));
```

也可以直接操作 cookie：

- `withCookie($name, $value)`
- `withoutCookie($name)`
- `clearCookies()`
- `cookies()`

## 推荐使用方式

日常推荐顺序：

1. 先用 `app()->testing()`
2. 优先走 `get()/post()/postJson()`
3. 需要更贴近 PSR 时，再用 `request()/handle()`
4. 需要登录态时，优先用 `actingAs()`，不要自己手拼 session cookie

## 相关回归

当前最有代表性的测试有：

- [`test_vslim_testing_harness.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_testing_harness.phpt)
- [`test_vslim_testing_session_auth_helpers.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_testing_session_auth_helpers.phpt)
