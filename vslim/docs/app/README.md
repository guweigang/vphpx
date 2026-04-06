# VSlim\App

`VSlim\App` 是整个框架的入口。当前代码真理之源主要在：

- [`src/app_dispatch_api.v`](/Users/guweigang/Source/vphpx/vslim/src/app_dispatch_api.v)
- [`src/app_kernel.v`](/Users/guweigang/Source/vphpx/vslim/src/app_kernel.v)
- [`src/app_execution_kernel.v`](/Users/guweigang/Source/vphpx/vslim/src/app_execution_kernel.v)
- [`src/app_route_dispatch.v`](/Users/guweigang/Source/vphpx/vslim/src/app_route_dispatch.v)
- [`src/app_psr_bridge.v`](/Users/guweigang/Source/vphpx/vslim/src/app_psr_bridge.v)
- [`tests/test_php_route_builder.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_php_route_builder.phpt)

先定一个产品边界：

- `VSlim\App`
  面向“直接用 VSlim 写应用”
- `vhttpd + php package`
  面向“让现有 PHP 应用接入新的 runtime”

所以这一页讲的是 `VSlim` 作为原生框架时的应用入口，不是现有框架兼容层。

## 它负责什么

- 注册路由：`get/post/put/patch/delete/head/options/any/map`
- 注册命名路由：`get_named()`、`map_named()` 等
- 创建分组：`group()`
- 运行 middleware：`before()`、`middleware()`、`after()`
- 资源路由：`resource()`、`api_resource()`、`singleton()`、`api_singleton()`
- 分发请求：`dispatch()`、`dispatch_request()`、`dispatch_envelope()`
- 生成 URL：`url_for()`、`url_for_abs()`、`redirect_to()`
- 错误处理：`set_not_found_handler()`、`set_error_handler()`
- 暴露 metadata：`route_manifest()`、`allowed_methods_for()` 等
- 组织框架骨架：`register()`、`boot()`、标准 PSR service graph
- `VSlim\Cli\App` 会直接复用这层 shared service graph，并在此之上挂命令系统

## 内部骨架

`VSlim\App` 现在不再把所有 HTTP 逻辑都塞进一个文件里，而是分成几层：

- public facade
  - `dispatch*()`、`handle()`、`register()`、`module()`、service graph
- HTTP kernel
  - request scope、boot ensure、trace、request snapshot sync、统一 finalize
- route runtime
  - 路由匹配、参数解析、method semantics、resource terminal
- PSR bridge
  - `VSlim\Vhttpd\Request` 和 PSR-7/15 对接
- transport edge
  - 只在 `vhttpd` 边界保留 `VSlim\Vhttpd\Request/Response`

## 它和 web server 的边界

`VSlim\App` 是框架入口，不是 server runtime。

所以要把两层分开看：

- 上游 web server / runtime
  - PHP built-in server
  - `vhttpd` + php-worker
  - nginx / Apache / Caddy + PHP-FPM
- `VSlim\App`
  - 统一处理 app kernel、route、middleware、PSR bridge

当前几种常见入口分别是：

- `dispatch(method, rawPath)`
  - 最轻量的本地 facade
  - 适合 demo / 自测 / 小工具
- `dispatch_request(VSlim\Vhttpd\Request $req)`
  - 适合 built-in server 或自己拼装 request 的传统入口
- `dispatch_envelope(array $envelope)`
  - 适合 worker / transport 集成
- `handle(ServerRequestInterface $request)`
  - 适合 PSR-7 / PSR-15 主通道

建议理解成：

- `VSlim\Vhttpd\Request/Response` 偏 adapter / facade
- `handle()` 对应的 PSR request/response 更接近框架内部 canonical HTTP 通道

对应产品定位也可以这样看：

- 你要兼容现有 PHP 生态
  - 优先想 `vhttpd + php package`
- 你要围绕 route / middleware / stream / websocket / mcp 原生写应用
  - 优先想 `VSlim\App`

详细说明见：

- [kernel.md](/Users/guweigang/Source/vphpx/vslim/docs/app/kernel.md)
- [skeleton.md](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)

## 最小示例

```php
<?php

use Psr\Http\Message\ServerRequestInterface;

$app = new VSlim\App();

$app->get('/hello/:name', function (ServerRequestInterface $req) {
    return 'hello:' . $req->getAttribute('name');
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
$app->map(['GET', 'POST'], '/multi/:id', function (ServerRequestInterface $req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});

$app->map('PUT|PATCH', '/edit/:id', function (ServerRequestInterface $req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});
```

路由参数用 `:name` 形式声明，例如 `/users/:id`。

## 2. handler 可以返回什么

根据 kernel/terminal 的归一化逻辑，常用返回值有：

- `VSlim\Vhttpd\Response`
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

### `dispatch_request(VSlim\Vhttpd\Request $req)`

适合手动构造 request 对象。

```php
$req = new VSlim\Vhttpd\Request('POST', '/submit', '{"ok":true}');
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

## 3.1 service provider / boot 骨架

`VSlim\App` 现在可以直接承载一层 framework bootstrap：

- `register(object|class-string $provider)`
- `registerMany(iterable $providers)`
- `boot()`
- `booted(): bool`
- `providerCount(): int`
- `hasProvider(string $class): bool`

推荐继承 `VSlim\Support\ServiceProvider`：

```php
final class DemoProvider extends VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $this->app()->container()->set('demo.message', 'hello');
    }

    public function boot(): void
    {
        $this->app()->events()->listenAny(function (object $event): void {
            // ...
        });
    }
}

$app = new VSlim\App();
$app->register(DemoProvider::class)->boot();

$app->registerMany([
    DemoProvider::class,
    new AnotherProvider(),
]);
```

规则：

- `register()` 支持 provider object 和 class-string
- provider 如果有 `setApp()`，会先自动绑定当前 app
- provider 的 `register()` / `boot()` 支持 `0` 参数，也支持接收一个 `VSlim\App $app`
- `boot()` 是幂等的
- app 已经 boot 后再 `register()` 的 provider，会立即执行自己的 `boot()`
- `dispatch*()` / `handle()` 会在第一次真实处理请求前自动 `boot()`

## 3.2 module / bundle 骨架

`VSlim\App` 也支持更上层的一层 module 组织：

- `module(object|class-string $module)`
- `moduleMany(iterable $modules)`
- `moduleCount(): int`
- `hasModule(string $class): bool`

推荐继承 `VSlim\Support\Module`：

```php
final class BlogModule extends VSlim\Support\Module
{
    public function register(): void
    {
        $this->app()->container()->set('blog.enabled', true);
    }

    public function providers(): iterable
    {
        return [
            BlogServiceProvider::class,
        ];
    }

    public function middleware(): void
    {
        $this->app()->middleware(new BlogTraceMiddleware());
    }

    public function routes(): void
    {
        $this->app()->group('/blog')->get('/ping', fn () => 'pong');
    }

    public function boot(): void
    {
        // 预留给事件订阅、warmup、额外收尾逻辑
    }
}

$app = new VSlim\App();
$app->module(BlogModule::class);
```

规则：

- `module()` 支持 module object 和 class-string
- module 如果有 `setApp()`，会先自动绑定当前 app
- `register()` / `middleware()` / `routes()` / `boot()` 支持 `0` 参数，也支持接收一个 `VSlim\App $app`
- `providers(): iterable` 会在 module 注册阶段立即展开，并复用 app 的 provider 生命周期

## 3.3 bootstrap spec

如果你希望把 app 装配过程收成一个稳定的 framework skeleton，可以直接用：

- `bootstrap(iterable $spec)`

当前比较实用的 key 有：

- `container`
- `config`
- `config_path`
- `config_text`
- `base_path`
- `view_base_path`
- `assets_prefix`
- `view_cache`
- `error_response_json`
- `clock`
- `not_found`
- `error`
- `helpers`
- `before`
- `middleware`
- `after`
- `middleware_setup`
- `providers`
- `modules`
- `routes`
- `mcp`
- `boot`
- `bootstrapFile(string $path)`

示例：

```php
$app = (new VSlim\App())->bootstrap([
    'config_path' => __DIR__ . '/app.toml',
    'providers' => [
        AppServiceProvider::class,
    ],
    'middleware' => [
        new AppTraceMiddleware(),
    ],
    'modules' => [
        BlogModule::class,
    ],
    'routes' => function (VSlim\App $app): void {
        $app->get('/health', fn () => 'ok');
    },
    'boot' => true,
]);
```

语义：

- `providers` / `modules` 复用原有生命周期，不是另一套机制
- `before` / `middleware` / `after` 直接对应 app 的三层 middleware 注册，可传单个 registration，也可传 registration 列表
- `middleware_setup` / `routes` 可以是单个 callable，也可以是 callable 列表，适合 bootstrap 文件最后收口
- `not_found` / `error` 直接复用现有 terminal handler 入口
- `helpers` 是一个 `name => callable` 的 map，会直接注册成 view helper
- `mcp` 既可以直接给 `VSlim\Mcp\App` 对象，也可以给一个 callable 来装配 `$app->mcp()`
- `base_path` 只影响 `url_for()` / `url_for_abs()`，不改变真实匹配路径

## 3.4 bootstrap file

如果你希望把项目入口继续收成单独文件，可以直接用：

- `bootstrapFile(string $path)`
- `bootstrapDir(string $path)`

这个文件当前支持返回：

- iterable spec
- `callable(VSlim\App $app)`
- `VSlim\App`

示例：

```php
// bootstrap/app.php
<?php

return [
    'providers' => [
        AppServiceProvider::class,
    ],
    'routes' => function (VSlim\App $app): void {
        $app->get('/health', fn () => 'ok');
    },
    'boot' => true,
];
```

```php
$app = new VSlim\App();
$app->bootstrapFile(__DIR__ . '/bootstrap/app.php');
```

约定：

- `bootstrapFile()` 使用普通 `include`，不是 `include_once`
- 这样同一个 bootstrap 文件可以在同一个请求里装配多个 app 实例
- 如果 bootstrap 文件内部需要声明类，推荐它自己用 `class_exists()` 或 `require_once` 保护
- app 已经 boot 后再 `module()` 的 module，会立即执行自己的 middleware/routes/boot
- `dispatch*()` / `handle()` 首次真实请求前，也会自动把已注册 module boot 完

### 推荐入口：`bootstrapDir()`

如果你想把“项目根目录 -> `bootstrap/app.php`”这条路径固定下来，可以直接用：

```php
$app = (new VSlim\App())->bootstrapDir(__DIR__);
```

当前约定是：

- 先找 `<dir>/bootstrap/app.php`
- 找不到时，再尝试 `<dir>/app.php`
- 如果这两个都不存在，就继续按 conventions 收：
  `config/app.toml`、`app.toml`、`bootstrap/runtime.php`、`bootstrap/services.php`、
  `bootstrap/errors.php`、
  `bootstrap/providers.php`、`bootstrap/modules.php`、
  `bootstrap/middleware.php`、`routes/*.php`、`views/`
- 也可以直接把 `bootstrap/app.php` 文件路径传给 `bootstrapDir()`

推荐目录结构：

```text
app/
  config/
    app.toml
  bootstrap/
    app.php
    runtime.php
    services.php
    providers.php
    modules.php
    middleware.php
  routes/
    web.php
    api.php
  views/
```

如果你想要显式总装配文件，就保留 `bootstrap/app.php`。

如果你更想走“约定优于配置”，也可以完全不写它，让 `bootstrapDir(__DIR__)` 直接按这些 convention 文件自动收骨架；对应回归见：

- [`test_vslim_app_bootstrap_dir_conventions.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_bootstrap_dir_conventions.phpt)
- [`vslim_bootstrap_conventions/support.php`](/Users/guweigang/Source/vphpx/vslim/tests/fixtures/vslim_bootstrap_conventions/support.php)
- [`test_vslim_app_bootstrap_app_dirs.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_bootstrap_app_dirs.phpt)

推荐职责：

- `bootstrap/runtime.php`
  放 `base_path`、`assets_prefix`、`view_cache`、`error_response_json` 这一类 runtime flag
- `bootstrap/services.php`
  放 `logger`、`clock`、`dispatcher`、`listener_provider`、`cache`、`cache_pool`、`http_client`
  这一类标准 service graph 对象
- `bootstrap/errors.php`
  放 `not_found` / `error` handler；直接复用 bootstrap spec 的 key，不需要另一套错误 DSL
- `bootstrap/providers.php`
  放业务级 service provider
- `bootstrap/modules.php`
  放更高一层 bundle / module

另外现在还支持一组更偏应用层的目录约定：

- `app/Providers/*.php`
  自动按 `App\\Providers\\<FileName>` 注册 service provider
- `app/Modules/*.php`
  自动按 `App\\Modules\\<FileName>` 挂载 module
- `app/Http/controllers.php`
  自动作为 HTTP container/bootstrap 文件加载；适合绑定需要构造参数的 controller，
  也适合顺手收 HTTP 侧的小型 container entry
- `app/Http/errors.php`
  自动作为 HTTP 错误层 bootstrap 文件加载；适合把应用级 `not_found` / `error` handler
  明确收在 `app/Http` 目录，而不是回塞到 `bootstrap/app.php`
- `app/Http/routes/*.php`
  自动作为 routes bootstrap 文件加载
- `app/Http/middleware.php`
  自动作为 HTTP middleware bootstrap 文件加载
- `app/Http/Controllers/*.php`
  会先 `include_once` 预加载；其中继承 `VSlim\\Controller` 的类会自动按
  `App\\Http\\Controllers\\<FileName>` 放进 container，适合直接在 routes 里写
  `[App\\Http\\Controllers\\PageController::class, 'home']`
- `app/Http/Middleware/*.php`
  会先 `include_once` 预加载，方便 `app/Http/middleware.php` 里直接用 middleware class-string
- `resources/views`
  当根目录没有 `views/` 时，自动作为 view base path fallback

这层更适合上层框架骨架；如果你已经有 Composer/PSR-4 autoload，直接按默认 `App\\...` 命名空间摆文件就可以了。
推荐分工是：

- 简单 `VSlim\\Controller` 子类放 `app/Http/Controllers/*.php`
- 需要业务 service / config / repository 构造参数的 controller 放 `app/Http/controllers.php`
- middleware class 的挂载继续放 `app/Http/middleware.php`
- `app/Http/Middleware/*.php` 继续只负责预加载 class，避免把“发现文件”和“挂 middleware”混成一层

现在 [`examples/demo_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo_app.php) 已经按这套方式启动，真正的装配逻辑则收在：

- [`examples/demo/bootstrap/app.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo/bootstrap/app.php)
- [`examples/demo/bootstrap/providers.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo/bootstrap/providers.php)
- [`examples/demo/routes/web.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo/routes/web.php)
- [`examples/demo/routes/api.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo/routes/api.php)
- [`examples/demo/routes/debug.php`](/Users/guweigang/Source/vphpx/vslim/examples/demo/routes/debug.php)

如果你更想看纯 `app/Http` 目录风格的骨架，可以直接看：

- [`examples/skeleton_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton_app.php)
- [`examples/skeleton/app/Http/controllers.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/app/Http/controllers.php)
- [`examples/skeleton/app/Http/Controllers/HomeController.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/app/Http/Controllers/HomeController.php)
- [`examples/skeleton/app/Http/Controllers/CatalogController.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/app/Http/Controllers/CatalogController.php)

## 4. phase middleware 与 middleware

### `before(MiddlewareInterface|string|array $middleware)`

签名：

```php
function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface { ... }
```

规则：

- 这是 pre-route phase middleware，不是 legacy hook
- 按注册顺序执行，先 app 级，再匹配 prefix 的 group 级
- 非法注册会立即抛 `InvalidArgumentException`
- 可以直接返回响应来短路
- 也可以 `return $handler->handle($request);`
- 继续链路里对内建 PSR request 做的修改会继续传给后续 route / middleware；当前已验证 `withAttribute()` 的 `string/int/bool/array`，以及 `withMethod()` / `withUri()` / `withHeader()` / `withQueryParams()` / `withParsedBody()` / `withBody()`

### `middleware(MiddlewareInterface|string|array $mw)`

签名：

```php
function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface { ... }
```

规则：

- 先 app 级 middleware，再 group 级 middleware
- 只支持 PSR-15 middleware、container service id、`['service', 'method']`、class-string
- 非法注册会立即抛 `InvalidArgumentException`
- 必须返回一个有效 `ResponseInterface`
- 可以提前拦截，也可以 `return $handler->handle($request);`

### `after(MiddlewareInterface|string|array $middleware)`

签名：

```php
function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface { ... }
```

规则：

- 这是 post-response phase middleware，不是 legacy hook
- 会在 route / not-found / 405 / OPTIONS / error 之后执行
- 非法注册会立即抛 `InvalidArgumentException`
- 通过 `$response = $handler->handle($request)` 拿到当前响应
- 返回值必须是有效 `ResponseInterface`

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
$app->get_named('users.show', '/users/:id', function (ServerRequestInterface $req) {
    return 'user:' . $req->getAttribute('id');
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
    'missing' => function (Psr\Http\Message\ServerRequestInterface $req, string $action, array $params) {
        return new VSlim\Vhttpd\Response(501, 'missing:' . $action, 'text/plain; charset=utf-8');
    },
]);
```

## 8. 错误处理

### `set_not_found_handler()`

签名：

```php
function (Psr\Http\Message\ServerRequestInterface $req) { ... }
```

### `set_error_handler()`

签名：

```php
function (Psr\Http\Message\ServerRequestInterface $req, string $message, int $status) { ... }
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
