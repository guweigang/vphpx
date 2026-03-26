# VSlim\Container

`VSlim\Container` 是 VSlim 内置的 PSR-11 容器实现。它来自 `vslim.so`，不是用户态 PHP 写出来的 mock。

真理之源：

- [`src/container.v`](/Users/guweigang/Source/vphpx/vslim/src/container.v)
- [`src/bridge.v`](/Users/guweigang/Source/vphpx/vslim/src/bridge.v)
- [`tests/test_vslim_container_psr11_ext.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_container_psr11_ext.phpt)
- [`tests/test_vslim_container_route_handler.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_container_route_handler.phpt)

## 依赖

`VSlim\Container` 本身不要求额外的 `psr` 扩展。

如果运行时已经通过 Composer 或其他方式提供了 `Psr\Container\*` 接口，
`VSlim\Container` 与相关异常类会在首次实例化 / 抛出时自动完成运行时晚绑定。
真理之源见：

- [`src/container.v`](/Users/guweigang/Source/vphpx/vslim/src/container.v)
- [`src/bridge.v`](/Users/guweigang/Source/vphpx/vslim/src/bridge.v)
- [`tests/test_vslim_container_psr11_ext.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_container_psr11_ext.phpt)

实现方式：

- `VSlim\Container` 通过 `@[php_implements: 'Psr\\Container\\ContainerInterface']` 声明 PSR-11 关系
- `VSlim\Container\ContainerException` 通过 `@[php_implements: 'Psr\\Container\\ContainerExceptionInterface']` 声明容器异常关系
- `VSlim\Container\NotFoundException` 通过 `@[php_implements: 'Psr\\Container\\NotFoundExceptionInterface']` 声明 not-found 异常关系
- 这些 userland 接口绑定会由编译器自动生成到 `vphp_ext_auto_startup()`，不需要再手写 `vphp_ext_startup()`

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
- `set_container()`

最常见：

```php
$app = new VSlim\App();
$container = $app->container();
```

`App` 第一次调用 `container()` 时会自动创建一个容器实例。

## Route handler 如何从容器解析

VSlim 路由不仅接受闭包，也接受容器服务 id 或数组形式的 handler。

### 1. 字符串 service id

```php
$container->set('hello.handler', function (VSlim\Request $req) {
    return 'hello:' . $req->param('id');
});

$app->get('/hello/:id', 'hello.handler');
```

### 2. `[service, method]`

```php
$container->set('users.controller', new UserController());
$app->get('/users/:id', ['users.controller', 'show']);
```

### 3. `[service]`

如果 service 对象可调用或带 `__invoke()`，可以省略方法名：

```php
$container->set('invoke.controller', new InvokableController());
$app->get('/inv/:id', ['invoke.controller']);
```

### 4. 自动类名解析

如果容器里没有这个 service id，但这个字符串本身是一个存在的类名，VSlim 会尝试自动实例化并放入容器：

```php
$app->get('/auto/:id', AutoController::class);
$app->get('/auto-show/:id', [AutoController::class, 'show']);
```

这要求类可无参构造。

## 注意事项

- `factory()` 参数必须是 callable，否则抛 `ContainerException`
- 自动类名解析只在路由 handler 解析阶段触发
- 对路由来说，字符串和数组 handler 都依赖容器
