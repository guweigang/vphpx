# VSlim\App

`VSlim\App` 是整个框架的入口。代码真理之源主要在：

- [`src/php_app.v`](/Users/guweigang/Source/vphpx/vslim/src/php_app.v)
- [`tests/test_php_route_builder.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_php_route_builder.phpt)

## 它负责什么

- 注册路由：`get/post/put/patch/delete/head/options/any/map`
- 注册命名路由：`get_named()`、`map_named()` 等
- 创建分组：`group()`
- 运行前后钩子：`before()`、`after()`、`middleware()`
- 资源路由：`resource()`、`api_resource()`、`singleton()`、`api_singleton()`
- 分发请求：`dispatch()`、`dispatch_request()`、`dispatch_envelope()`
- 生成 URL：`url_for()`、`url_for_abs()`、`redirect_to()`
- 错误处理：`set_not_found_handler()`、`set_error_handler()`
- 暴露 metadata：`route_manifest()`、`allowed_methods_for()` 等

## 最小示例

```php
<?php

$app = new VSlim\App();

$app->get('/hello/:name', function (VSlim\Request $req) {
    return 'hello:' . $req->param('name');
});

$res = $app->dispatch('GET', '/hello/codex');
echo $res->status . PHP_EOL; // 200
echo $res->body . PHP_EOL;   // hello:codex
```

## 1. 注册普通路由

支持的方法：

- `get()`
- `post()`
- `put()`
- `patch()`
- `delete()`
- `head()`
- `options()`
- `any()`
- `map()`

示例：

```php
$app->map(['GET', 'POST'], '/multi/:id', function (VSlim\Request $req) {
    return $req->method . ':' . $req->param('id');
});

$app->map('PUT|PATCH', '/edit/:id', function (VSlim\Request $req) {
    return $req->method . ':' . $req->param('id');
});
```

路由参数用 `:name` 形式声明，例如 `/users/:id`。

## 2. handler 可以返回什么

根据 [`src/php_app.v`](/Users/guweigang/Source/vphpx/vslim/src/php_app.v) 的归一化逻辑，常用返回值有：

- `VSlim\Response`
- `string`
- `array`
- `null`

`array` 形状推荐：

```php
[
    'status' => 200,
    'content_type' => 'application/json; charset=utf-8',
    'headers' => ['x-demo' => 'yes'],
    'body' => '{"ok":true}',
]
```

注意：

- 返回 `string` 会被归一化为 `200 text/plain; charset=utf-8`
- 返回无效类型时会进入 error handler；没有 handler 时默认返回 500
- 对普通路由而言，返回 `null` 会得到空 `200` 响应

## 3. dispatch 入口

### `dispatch(method, rawPath)`

最简单，body 为空字符串。

```php
$res = $app->dispatch('GET', '/health');
```

### `dispatch_body(method, rawPath, body)`

适合 form / JSON body 测试。

```php
$res = $app->dispatch_body('POST', '/submit?trace_id=demo', 'name=neo');
```

### `dispatch_request(VSlim\Request $req)`

适合手动构造 request 对象。

```php
$req = new VSlim\Request('POST', '/submit', '{"ok":true}');
$req->set_headers(['content-type' => 'application/json']);
$res = $app->dispatch_request($req);
```

### `dispatch_envelope(array $envelope)`

用于 worker / transport 集成。

```php
$res = $app->dispatch_envelope([
    'method' => 'GET',
    'path' => '/hello/codex',
    'headers' => ['x-request-id' => 'req-1'],
]);
```

### `dispatch_envelope_map(array $envelope)`

返回 `map<string,string>` 风格结果，适合 worker 边界：

- `status`
- `body`
- `content_type`
- `headers_<lowercase-name>`

## 4. hooks 与 middleware

### `before(callable $fn)`

签名：

```php
function (VSlim\Request $req) { ... }
```

规则：

- 按注册顺序执行
- 返回 `null` 表示继续
- 返回非空值会直接短路为响应

### `middleware(callable $fn)`

签名：

```php
function (VSlim\Request $req, callable $next) { ... }
```

规则：

- 先 app 级 middleware，再 group 级 middleware
- 必须返回一个有效响应
- 可以提前拦截，也可以 `return $next($req);`

### `after(callable $fn)`

签名：

```php
function (VSlim\Request $req, VSlim\Response $res) { ... }
```

规则：

- 会在 route / not-found / error 之后执行
- 可以返回 `null`，表示保留当前响应
- 也可以返回新的响应，替换当前响应

## 5. 命名路由与反向生成

对应方法：

- `get_named()`
- `post_named()`
- `put_named()`
- `patch_named()`
- `delete_named()`
- `head_named()`
- `options_named()`
- `any_named()`
- `map_named()`

示例：

```php
$app->get_named('users.show', '/users/:id', function (VSlim\Request $req) {
    return 'user:' . $req->param('id');
});

echo $app->url_for('users.show', ['id' => '42']) . PHP_EOL;
echo $app->url_for_query('users.show', ['id' => '42'], ['tab' => 'profile']) . PHP_EOL;
echo $app->url_for_abs('users.show', ['id' => '42'], 'https', 'example.local') . PHP_EOL;
```

还支持：

- `url_for_query_abs()`
- `redirect_to()`
- `redirect_to_query()`

## 6. `base_path`

`set_base_path()` 只影响 URL 生成，不改变实际匹配路径。

```php
$app->set_base_path('/demo');
echo $app->url_for('users.show', ['id' => '42']); // /demo/users/42
```

## 7. 资源路由

### `resource()`

默认会尝试注册：

- `GET /items` -> `index`
- `GET /items/create` -> `create`
- `POST /items` -> `store`
- `GET /items/:id` -> `show`
- `GET /items/:id/edit` -> `edit`
- `PUT/PATCH /items/:id` -> `update`
- `DELETE /items/:id` -> `destroy`

### `api_resource()`

不包含页面路由 `create/edit`。

### `singleton()` / `api_singleton()`

和 `resource` 类似，但没有 `:id`，用于单例资源，例如 `/profile`。

### `resource_opts()` / `singleton_opts()`

当前支持这些选项：

- `only`
- `except`
- `names`
- `name_prefix`
- `name_<action>`
- `param`
- `shallow`
- `missing`

示例：

```php
$app->resource_opts('/books', BookController::class, [
    'only' => ['index', 'show'],
    'name_prefix' => 'library.books',
    'param' => 'book_id',
]);
```

### `missing` 回调

如果某个资源 action 没实现，但你提供了 `missing` 回调，那么 action 缺失时不会直接 404，而会交给这个回调：

```php
$app->resource_opts('/users', UserController::class, [
    'missing' => function (VSlim\Request $req, string $action, array $params) {
        return new VSlim\Response(501, 'missing:' . $action, 'text/plain; charset=utf-8');
    },
]);
```

## 8. 错误处理

### `set_not_found_handler()`

签名：

```php
function (VSlim\Request $req) { ... }
```

### `set_error_handler()`

签名：

```php
function (VSlim\Request $req, string $message, int $status) { ... }
```

### `set_error_response_json(true)`

当没有自定义 handler 时，默认错误响应可以切换成 JSON：

```php
$app->set_error_response_json(true);
```

## 9. HTTP 语义

当前实现里这些行为已经由测试覆盖：

- `HEAD` 没有显式 route 时，会回退到 `GET`，但 body 为空
- `OPTIONS` 会返回 `204`，并带 `Allow` 头
- `POST` 支持 method override：
  - `x-http-method-override`
  - `?_method=DELETE`
  - body 里的 `_method=DELETE`

## 10. Route metadata

可用于调试和生成文档：

- `route_count()`
- `route_names()`
- `has_route_name()`
- `route_manifest_lines()`
- `route_conflict_keys()`
- `route_manifest()`
- `route_conflicts()`
- `allowed_methods_for()`

示例：

```php
print_r($app->route_manifest());
print_r($app->allowed_methods_for('/users/7'));
```

## 11. 和 Container / Config / View 的关系

`VSlim\App` 还负责这些协作入口：

- `container()` / `set_container()`
- `config()` / `set_config()` / `load_config()` / `load_config_text()`
- `set_view_base_path()` / `set_assets_prefix()`
- `make_view()` / `view()` / `view_with_layout()`

这里的 View 已经不只是简单模板替换。当前建议把它理解成：

- 指令：`include` / `if` / `for` / `slot` / `fill` / `call:` / `asset:`
- 表达式：变量、函数调用、pipe 链、对象方法调用
- 共享路径：`title`、`user.name`、`tags[0]`

对应详细文档：

- [`../container/container.md`](/Users/guweigang/Source/vphpx/vslim/docs/container/container.md)
- [`../config/config.md`](/Users/guweigang/Source/vphpx/vslim/docs/config/config.md)
- [`../view/view.md`](/Users/guweigang/Source/vphpx/vslim/docs/view/view.md)
