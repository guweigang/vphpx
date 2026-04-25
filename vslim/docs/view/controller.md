# VSlim\Controller

`VSlim\Controller` 是给 MVC 用的轻量基类，帮助你在控制器里访问 `App`、`View`，并直接使用 render / redirect helper。

真理之源：

- [`src/mvc.v`](/Users/guweigang/Source/vphpx/vslim/src/mvc.v)
- [`tests/test_vslim_mvc_view_controller.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_mvc_view_controller.phpt)
- [`tests/test_vslim_view_layout_include.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_layout_include.phpt)

## 初始化

最常见的方式是把 `App` 传进去：

```php
final class PageController extends VSlim\Controller
{
    public function __construct(VSlim\App $app)
    {
        parent::__construct($app);
    }
}
```

很多时候你会把 controller 先放进 `Container`：

```php
$app->container()->set(PageController::class, new PageController($app));
```

## 主要能力

控制器常用 helper：

- `app()`
- `view()`
- `render()`
- `renderWithLayout()`
- `redirectTo()`
- `redirectToQuery()`

## render

```php
use Psr\Http\Message\ServerRequestInterface;

final class PageController extends VSlim\Controller
{
    public function home(ServerRequestInterface $req): VSlim\Vhttpd\Response
    {
        return $this->render('home.html', [
            'title' => 'Controller Demo',
            'name' => $req->getAttribute('name') ?: 'guest',
        ]);
    }
}
```

这里会复用 `App` 当前的 view 配置：

- `viewBasePath`
- `assetsPrefix`

## renderWithLayout

```php
final class PageController extends VSlim\Controller
{
    public function page(): VSlim\Vhttpd\Response
    {
        return $this->renderWithLayout('home.html', 'layout.html', [
            'title' => 'Layout Demo',
        ]);
    }
}
```

## redirectTo

```php
final class PageController extends VSlim\Controller
{
    public function jump(string $name): VSlim\Vhttpd\Response
    {
        return $this->redirectTo('users.show', ['name' => $name], 302);
    }
}
```

也支持带 query：

```php
return $this->redirectToQuery(
    'users.show',
    ['name' => $name],
    ['from' => 'controller'],
    302
);
```

## 和普通 controller 的区别

VSlim 不强制你继承 `VSlim\Controller`。普通 PHP 类只要方法签名对，照样能当 route handler。

继承它的主要价值是：

- 少写 `App` / `View` 注入样板
- 统一使用 render / redirect helper
- 做简单页面控制器更方便

## 推荐场景

适合：

- 页面型 route
- 需要渲染模板的 controller
- 需要频繁 redirect 的 controller

不一定适合：

- 极简 API route
- 只是一个简单闭包就够的场景
