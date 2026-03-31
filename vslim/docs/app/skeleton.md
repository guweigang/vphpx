# VSlim App Skeleton

这页只讲一件事：

- 如果你想把 `VSlim\App` 当成一个真正的项目骨架入口，目录应该怎么摆，职责应该怎么分。

它不解释底层 kernel 执行细节，那部分看：

- [kernel.md](/Users/guweigang/Source/vphpx/vslim/docs/app/kernel.md)

也不重复所有 builder API 说明，那部分看：

- [README.md](/Users/guweigang/Source/vphpx/vslim/docs/app/README.md)

## 推荐入口

当前推荐直接从项目根目录启动：

```php
$app = (new VSlim\App())->bootstrapDir(__DIR__);
```

`bootstrapDir()` 的收敛顺序是：

1. 先找 `bootstrap/app.php`
2. 再找 `app.php`
3. 如果都没有，就进入 convention assembly

这意味着你可以有两种项目风格：

- 显式总装配
  - `bootstrap/app.php` 作为唯一入口
- 约定优于配置
  - 直接靠目录约定自动收骨架

## 两层骨架

当前 `bootstrapDir()` 会收两层目录：

### Project Bootstrap Layer

这一层偏“项目级总装配”：

- `config/app.toml`
- `app.toml`
- `bootstrap/runtime.php`
- `bootstrap/services.php`
- `bootstrap/errors.php`
- `bootstrap/providers.php`
- `bootstrap/modules.php`
- `bootstrap/middleware.php`
- `routes/*.php`
- `views/`

推荐职责：

- `bootstrap/runtime.php`
  - `base_path`、`assets_prefix`、`view_cache`、`error_response_json`
- `bootstrap/services.php`
  - `logger`、`clock`、`dispatcher`、`cache`、`http_client`
- `bootstrap/errors.php`
  - `not_found` / `error` handler
- `bootstrap/providers.php`
  - 业务 service provider
- `bootstrap/modules.php`
  - 更高层 bundle/module
- `bootstrap/middleware.php`
  - 全局 HTTP middleware 装配
- `routes/*.php`
  - 路由拆分

### App HTTP Layer

这一层偏“应用目录结构”：

- `app/Providers/*.php`
- `app/Modules/*.php`
- `app/Http/controllers.php`
- `app/Http/errors.php`
- `app/Http/routes/*.php`
- `app/Http/middleware.php`
- `app/Http/Controllers/*.php`
- `app/Http/Middleware/*.php`
- `resources/views`

推荐职责：

- `app/Providers/*.php`
  - 注册 service provider class
- `app/Modules/*.php`
  - 注册 module class
- `app/Http/controllers.php`
  - 显式绑定复杂 controller
  - 顺手收 HTTP 层 container entry
- `app/Http/errors.php`
  - 应用级 `not_found` / `error` handler
- `app/Http/routes/*.php`
  - web/api/admin 等语义拆分
- `app/Http/middleware.php`
  - 真正把 middleware 挂到 app / group
- `app/Http/Controllers/*.php`
  - 简单 `VSlim\Controller` 子类
- `app/Http/Middleware/*.php`
  - 只负责提供 middleware class，供 `middleware.php` 使用
- `resources/views`
  - `views/` 的 fallback

## 推荐分工

最容易把目录做乱的地方，通常是 controller / middleware / error handler。

当前推荐这样分：

- 简单 controller
  - 放 `app/Http/Controllers/*.php`
  - 如果继承 `VSlim\Controller` 且只需要 `app`，让框架自动绑定
- 复杂 controller
  - 放 class 到 `app/Http/Controllers/*.php`
  - 在 `app/Http/controllers.php` 里显式构造并放进 container
- middleware class
  - 放 `app/Http/Middleware/*.php`
  - 真正注册动作留给 `app/Http/middleware.php`
- 错误处理
  - 项目级统一策略放 `bootstrap/errors.php`
  - HTTP 层、应用层错误语义放 `app/Http/errors.php`

这样做的好处是：

- “发现类文件”和“真正装配”不会混在一起
- provider/module 和 HTTP layer 各有边界
- 项目从小到大扩展时，不需要把所有东西都塞回 `bootstrap/app.php`

## 最小目录

一个比较均衡的目录大致可以长这样：

```text
app/
  Providers/
    AppServiceProvider.php
  Modules/
    StatusModule.php
  Http/
    controllers.php
    errors.php
    middleware.php
    routes/
      web.php
      api.php
    Controllers/
      HomeController.php
      CatalogController.php
    Middleware/
      TraceMiddleware.php
bootstrap/
  runtime.php
config/
  app.toml
resources/
  views/
    home.html
public/
```

## 参考实现

当前最完整的参考例子就是：

- [`examples/skeleton_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton_app.php)
- [`examples/skeleton/README.md`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/README.md)
- [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)

这个例子已经覆盖：

- provider
- module
- 简单 controller 自动绑定
- 复杂 controller 显式绑定
- middleware 装配
- error convention
- views fallback

如果你只想要一个更短的起点，而不是完整例子，直接从：

- [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)

开始就够了。

## 什么时候还需要 `bootstrap/app.php`

如果你出现这些情况，继续保留 `bootstrap/app.php` 是合理的：

- 启动顺序有强依赖
- 有环境分支装配逻辑
- 需要在 very-early bootstrap 阶段做条件判断
- 你想把整个 app 装配压成单文件入口

否则，优先直接让 `bootstrapDir()` 去收约定目录，通常会更清晰。
