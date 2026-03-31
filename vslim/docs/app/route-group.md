# VSlim\RouteGroup

`VSlim\RouteGroup` 是 `VSlim\App` 的路由前缀分组器。它不是独立 runtime，只是把一组路由和 phase middleware 挂到同一个 prefix 下。

真理之源：

- [`src/php_app.v`](/Users/guweigang/Source/vphpx/vslim/src/php_app.v)
- [`src/route.v`](/Users/guweigang/Source/vphpx/vslim/src/route.v)
- [`tests/test_php_route_builder.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_php_route_builder.phpt)

## 创建分组

```php
$app = new VSlim\App();
$api = $app->group('/api');
```

之后在这个 group 上注册的路由，都会带上 `/api` 前缀：

```php
use Psr\Http\Message\ServerRequestInterface;

$api->get('/users/:id', function (ServerRequestInterface $req) {
    return 'user:' . $req->getAttribute('id');
});
```

实际匹配路径是 `/api/users/:id`。

## 支持的方法

和 `App` 基本一致：

- `group()`
- `middleware()`
- `before()`
- `after()`
- `get/post/put/patch/delete/head/options/any/map`
- `resource/api_resource`
- `singleton/api_singleton`
- `resource_opts/api_resource_opts`
- `singleton_opts/api_singleton_opts`
- `get_named/.../map_named`

## 嵌套 group

```php
$api = $app->group('/api');
$v1 = $api->group('/v1');

$v1->get('/ping', fn () => 'pong');
```

最终路由是 `/api/v1/ping`。

## 组级 middleware / before / after

这些 middleware 只会作用在当前 prefix 下：

```php
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

$api->middleware(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        if ($request->getUri()->getPath() === '/api/blocked') {
            return (new VSlim\Psr7\Response(200, ''))->withBody(new VSlim\Psr7\Stream('group-blocked'));
        }
        return $handler->handle($request);
    }
});

$api->after(new class implements MiddlewareInterface {
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $response = $handler->handle($request);
        if ($request->getUri()->getPath() !== '/api/users/9') {
            return $response;
        }
        return $response->withBody(new VSlim\Psr7\Stream('after:' . (string) $response->getBody()));
    }
});
```

执行顺序：

- app 级 `before` phase middleware
- 匹配 prefix 的 group `before` phase middleware
- app 级 middleware
- 匹配 prefix 的 group middleware
- route handler
- app 级 `after` phase middleware
- 匹配 prefix 的 group `after` phase middleware

这里的 group 匹配规则是“路径前缀匹配”，也就是：

- `/api` 会匹配 `/api`
- `/api` 会匹配 `/api/users`
- `/api` 不会匹配 `/api2`

## group 中的命名路由

命名路由仍然注册在全局 `App` 上，所以 `url_for()` 依然从 `App` 调：

```php
$api->get_named('api.users.show', '/users/:id', fn (ServerRequestInterface $req) => 'ok');

echo $app->url_for('api.users.show', ['id' => '42']);
```

## group 中的 resource

```php
$api = $app->group('/api');
$api->resource('/users', UserController::class);
```

生成的路径会自动带前缀：

- `/api/users`
- `/api/users/:id`
- ...

## 什么时候用 group

推荐用在这些场景：

- API 分版本：`/api/v1`
- 后台管理：`/admin`
- 统一鉴权前缀：`/api/private`
- 给一批路由共享 middleware / phase middleware
