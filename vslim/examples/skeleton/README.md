# VSlim Skeleton Example

这是当前最贴近“真实项目目录”的 `VSlim\App` 示例。

入口：

- [`skeleton_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton_app.php)

## 3 分钟上手

最短路径通常是：

1. 先跑一遍 self-test，确认示例能完整启动
2. 从 `app/Http/routes/web.php`、`app/Http/controllers.php`、`app/Http/middleware.php` 开始看 HTTP 装配
3. 再看 `app/Providers/AppServiceProvider.php`、`app/Modules/StatusModule.php` 理解 provider / module 分工
4. 最后回到 [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)，把这套目录换成自己的项目模板

```bash
php -d extension=./vslim.so vslim/examples/skeleton_app.php --self-test
```

它直接执行：

```php
(new VSlim\App())->bootstrapDir(__DIR__ . '/skeleton')
```

这个例子主要用来说明：`bootstrapDir(__DIR__ . '/skeleton')` 已经足够承接一个按 PSR 风格拆分的应用目录。

## 扩展点速查

| 你要改什么 | 先看哪里 | 作用 |
| --- | --- | --- |
| 项目入口 | `skeleton_app.php` | transport 适配和 `bootstrapDir()` 入口 |
| 基础配置 | `config/app.toml` | app 级配置 |
| runtime flag | `bootstrap/runtime.php` | base path、view path、assets 等 runtime 设置 |
| provider | `app/Providers/AppServiceProvider.php` | container service 注册 |
| module | `app/Modules/StatusModule.php` | 独立 module 生命周期示例 |
| 简单 controller | `app/Http/Controllers/HomeController.php` | 直接处理页面请求 |
| 复杂 controller | `app/Http/Controllers/CatalogController.php` | 带 service 构造参数的 controller |
| controller 绑定 | `app/Http/controllers.php` | 显式绑定复杂 controller |
| HTTP middleware | `app/Http/middleware.php` / `app/Http/Middleware/TraceMiddleware.php` | PSR-15 middleware 注册和类实现 |
| 错误处理 | `app/Http/errors.php` | not_found / runtime error 响应 |
| 页面路由 | `app/Http/routes/web.php` | 页面路由 |
| API 路由 | `app/Http/routes/api.php` | API 路由 |
| 视图 | `resources/views/home.html` | 页面模板 |

## 深入阅读

这个例子重点覆盖的是：

- `bootstrapDir()` 不只是测试能力，而是可以直接承接项目骨架
- `app/Http/Controllers/*.php` 和 `app/Http/controllers.php` 可以分担简单 / 复杂 controller
- `app/Http/errors.php` 可以把应用级错误处理收进 HTTP 层目录
- `app/Modules/*.php`、`app/Providers/*.php`、`resources/views` 可以自然拼起来
- `app/Http/middleware.php` + `app/Http/Middleware/*.php` 演示了 PSR-15 middleware 的推荐分工

如果你下一步是要复制真实项目起点，优先看：

- [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)

如果你想继续理解目录职责和骨架分层，再看：

- [docs/app/skeleton.md](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)
- [docs/app/README.md](/Users/guweigang/Source/vphpx/vslim/docs/app/README.md)
