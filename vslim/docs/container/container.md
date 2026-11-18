# VSlim\Container

`VSlim\Container` 是由 VSlim 扩展提供的 PSR-11 容器实现。容器和异常类的声明位于 [`src/containerx/container.v`](../../src/containerx/container.v)。

## 依赖

`VSlim\Container` 本身不要求额外的 `psr` 扩展。

VSlim 在首次使用容器或其异常类时，会通过 Composer 等自动加载机制查找并绑定 PHP 用户态的 `Psr\Container\*` 接口。相关行为由 [容器接口测试](../../tests/test_vslim_container_psr11_ext.phpt) 和 [路由处理器测试](../../tests/test_vslim_container_route_handler.phpt) 覆盖。

- `VSlim\Container` 使用 `@[vphp.PhpImplements(names: 'Psr\\Container\\ContainerInterface')]`
- `VSlim\Container\ContainerException` 使用 `@[vphp.PhpImplements(names: 'Psr\\Container\\ContainerExceptionInterface')]`
- `VSlim\Container\NotFoundException` 使用 `@[vphp.PhpImplements(names: 'Psr\\Container\\NotFoundExceptionInterface')]`

VPHP 把这三项绑定的注册代码生成到 `vphp_ext_auto_startup()`。

## 基本用法

```php
$c = new VSlim\Container();

$c->set('name', 'codex');
$c->factory('hello', fn () => 'hi-' . $c->get('name'));

echo $c->get('name') . PHP_EOL;
echo $c->get('hello') . PHP_EOL;
```

## API

- `set($id, $value)`
- `factory($id, $callable)`
- `has($id)`
- `get($id)`

### `set()`

注册一个固定值：

```php
$c->set(FooService::class, new FooService());
```

### `factory()`

注册一个工厂：

```php
$c->factory('clock', fn () => new DateTimeImmutable('now'));
```

当前实现会缓存 factory 的解析结果，所以同一个 `id` 多次 `get()` 会得到第一次创建出来的对象/值。

## 异常

容器内置两个异常类：

- `VSlim\Container\ContainerException`
- `VSlim\Container\NotFoundException`

找不到条目时会抛：

```php
try {
    $c->get('missing');
} catch (VSlim\Container\NotFoundException $e) {
    // ...
}
```

## 和 `VSlim\App` 的关系

`App` 有两个入口：

- `container()`
- `setContainer()`

最常见：

```php
$app = new VSlim\App();
$container = $app->container();
```

`App` 第一次调用 `container()` 时会自动创建一个容器实例。

## Route handler 如何从容器解析

容器 route handler 现在走显式 PSR/方法契约，不再隐式执行容器里的 closure 或默认 `__invoke()`。

### 1. 字符串 service id

```php
$container->set('hello.handler', new class implements Psr\Http\Server\RequestHandlerInterface {
    public function handle(Psr\Http\Message\ServerRequestInterface $request): Psr\Http\Message\ResponseInterface
    {
        return (new VSlim\Psr7\Response(200, ''))
            ->withBody(new VSlim\Psr7\Stream('hello:' . $request->getAttribute('id')));
    }
});

$app->get('/hello/:id', 'hello.handler');
```

要求 service 实现 `Psr\Http\Server\RequestHandlerInterface`，或者至少暴露 `handle()`。

### 2. `[service, method]`

```php
$container->set('users.controller', new UserController());
$app->get('/users/:id', ['users.controller', 'show']);
```

这里会显式调用 `show(ServerRequestInterface $request)`。

### 3. `[service, '__invoke']`

如果你确实要走 `__invoke()`，也需要显式写出来：

```php
$container->set('invoke.controller', new InvokableController());
$app->get('/inv/:id', ['invoke.controller', '__invoke']);
```

### 4. 自动类名解析

如果容器里没有这个 service id，但这个字符串本身是一个存在的类名，VSlim 会尝试自动实例化并放入容器：

```php
$app->get('/auto/:id', AutoController::class);
$app->get('/auto-show/:id', [AutoController::class, 'show']);
```

这要求类可无参构造；如果直接把类名当字符串 handler 用，这个类同样需要实现 `RequestHandlerInterface` 或提供 `handle()`。

## 注意事项

- `factory()` 参数必须是 callable，否则抛 `ContainerException`
- 自动类名解析只在路由 handler 解析阶段触发
- 对路由来说，字符串和数组 handler 都依赖容器
- `[service]` 这种隐式 `__invoke` 形式已经不再支持
- 容器 route handler 不再把 closure 当成 route handler 自动执行
