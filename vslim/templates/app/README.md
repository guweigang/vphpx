# VSlim App Template

这是 `VSlim\App` 的最小项目模板。

目标不是展示所有能力，而是给一个可以直接作为新项目起点的目录：

- `bin/vslim`
- `composer.json`
- `Makefile`
- `public/index.php`
- `public/worker.php`
- `bootstrap/app.php`
- `bootstrap/http.php`
- `config/app.toml`
- `config/http.toml`
- `config/cli.toml`
- `config/cache.toml`
- `config/database.toml`
- `config/logging.toml`
- `config/stream.toml`
- `vhttpd.example.toml`
- `bootstrap/runtime.php`
- `bootstrap/cli.php`
- `app/Providers/AppServiceProvider.php`
- `app/Commands/AboutCommand.php`
- `app/Http/errors.php`
- `app/Http/controllers.php`
- `app/Http/middleware.php`
- `app/Http/Middleware/TraceMiddleware.php`
- `app/Http/routes/web.php`
- `app/Modules/StatusModule.php`
- `app/Http/Controllers/HomeController.php`
- `resources/views/home.html`

## 3 分钟上手

最短路径通常是：

1. 复制这个目录到新项目
2. 运行 `composer install`
3. 用 `make serve EXT=./vslim.so` 启 HTTP 入口
4. 用 `make vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd` 启 worker 入口
5. 用 `make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd` 跑一次最薄的 worker 验收
6. 用 `make cli-help EXT=./vslim.so` 看 CLI 入口
7. 从 `app/Http/routes/web.php`、`app/Http/middleware.php`、`app/Modules/StatusModule.php`、`app/Commands/AboutCommand.php` 开始改自己的业务

如果你准备同时把数据库也接起来，推荐在这一步顺手决定 transport：

- 本地开发最省事
  - 保持 `config/database.toml` 里的 `transport = "direct"`
- 已经接 `vhttpd` worker，想让数据库连接池也由 `vhttpd` 托管
  - 改成 `transport = "vhttpd_upstream"`
  - 并让 worker 环境里有 `VHTTPD_DB_SOCKET`

模板里的 `config/database.toml` 已经把这两条路径都预留好了。

模板自带的项目级入口有：

- `make serve EXT=./vslim.so`
- `make vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd`
- `make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd`
- `make cli EXT=./vslim.so`
- `make cli-help EXT=./vslim.so`
- `make health EXT=./vslim.so`
- `make module EXT=./vslim.so`

如果你不想走 `Makefile`，也可以直接用原始命令：

```bash
php -d extension=./vslim.so -S 127.0.0.1:8080 public/index.php
VHTTPD_APP=$(pwd)/public/worker.php /path/to/vhttpd/vhttpd \
  --host 127.0.0.1 \
  --port 19888 \
  --pid-file /tmp/vslim_template_vhttpd.pid \
  --event-log /tmp/vslim_template_vhttpd.events.ndjson \
  --admin-host 127.0.0.1 \
  --admin-port 19988 \
  --worker-socket /tmp/vslim_template_worker.sock \
  --worker-autostart 1 \
  --worker-cmd 'php -d extension=./vslim.so /path/to/vhttpd/php/package/bin/php-worker'
php -d extension=./vslim.so bin/vslim about --help
```

默认推荐的 app 入口是：

```php
$app = (new VSlim\App())->bootstrapDir(__DIR__);
```

如果你更喜欢显式装配，模板也提供了 [`bootstrap/app.php`](/Users/guweigang/Source/vphpx/vslim/templates/app/bootstrap/app.php)。
它返回一份 bootstrap spec，把 `config_path`、`providers`、`modules`、`middleware_setup`、`routes`、
`not_found` / `error` 和 `boot` 集中到一处。为了让“刚复制模板、还没跑 composer install”的场景也能先工作，
这个文件和 `bootstrap/cli.php` 还会显式 `require_once` 模板里自己的类文件。

## 同一个 app，两条 HTTP transport

模板把 transport 适配和应用装配刻意拆开了：

- `public/index.php`
  给 `php -S` 这类“从 PHP globals 构造请求”的入口使用
- `public/worker.php`
  给 `php-worker` / `vhttpd` 这类“直接收 envelope”的入口使用
- `bootstrap/http.php`
  放两边共用的 request/response 适配 helper，确保它们最终都 dispatch 到同一个 `VSlim\App`

推荐先把这两个命令都跑通，再开始改业务：

```bash
make serve EXT=./vslim.so
make vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd
make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd
```

本地验证可以分别打：

```bash
curl --noproxy '*' http://127.0.0.1:8080/health
curl --noproxy '*' http://127.0.0.1:19888/health
```

如果你只想做一次最薄的 worker 验收，不想自己起进程再手动 `curl`，可以直接跑：

```bash
make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd
```

它会临时启动一份 `vhttpd`，自动检查 `/health`、`/module/ping`、`/missing`，然后清理进程和临时文件。

如果你更喜欢 TOML 配置，而不是在命令行上把参数全部展开，可以从 `vhttpd.example.toml` 开始。
把里面的 `__PROJECT_ROOT__` 和 `__VHTTPD_ROOT__` 换成真实绝对路径后运行：

```bash
/path/to/vhttpd/vhttpd --config ./vhttpd.example.toml
```

如果你还要一起验证数据库 upstream，可以再跑：

```bash
php -d extension=./vslim.so examples/db_upstream_probe.php
```

只要 `php-worker` 环境里已经注入了 `VHTTPD_DB_SOCKET`，这个 probe 就不用再手传 socket。

## 扩展点速查

| 你要改什么 | 先看哪里 | 作用 |
| --- | --- | --- |
| HTTP 入口 | `public/index.php` / `public/worker.php` / `bootstrap/http.php` / `Makefile` | built-in server、worker 入口和 transport 适配 |
| CLI 入口 | `bin/vslim` / `bootstrap/cli.php` | CLI 启动脚本和命令装配 |
| 显式总装配 | `bootstrap/app.php` | 把 config、provider、module、middleware、routes 收进一份 spec |
| 配置 | `config/*.toml` | app / logging / stream / session 等分域配置 |
| 数据库 | `config/database.toml` / `app()->database()` / `app()->migrator()` | 默认数据库 manager、连接池、migration 和 seed 入口 |
| Session / Auth | `config/session.toml` / `app()->session($request)` / `app()->auth($request)` / `app()->authMiddleware()` / `app()->guestMiddleware()` / `app()->abilityMiddleware('admin')` | cookie session、session guard、auth/guest/ability middleware |
| Testing | `app()->testing()` | 轻量测试 harness，支持 service/config override、quick dispatch、JSON 请求、response 断言、cookie jar、`withSession()`、`actingAs()` 和 PSR request handle |
| 服务注册 | `app/Providers/AppServiceProvider.php` | container 里的基础 service |
| 模块 | `app/Modules/StatusModule.php` | 一组 service + routes 的独立装配单元 |
| 简单 controller | `app/Http/Controllers/HomeController.php` | 直接处理页面/接口请求 |
| 复杂 controller 绑定 | `app/Http/controllers.php` | 需要显式构造参数时，在这里绑进 container |
| HTTP middleware | `app/Http/middleware.php` / `app/Http/Middleware/TraceMiddleware.php` | PSR-15 middleware 注册和类实现 |
| 路由 | `app/Http/routes/web.php` | 页面 / HTTP 路由 |
| 错误处理 | `app/Http/errors.php` | not_found / runtime error 响应 |
| CLI command | `app/Commands/AboutCommand.php` | command schema、help、handle |
| 数据库命令 | `app/Commands/DbMigrateCommand.php` / `DbRollbackCommand.php` / `DbSeedCommand.php` | migrate、rollback、seed 入口 |
| 诊断命令 | `app/Commands/RouteListCommand.php` / `ConfigCheckCommand.php` / `AppDoctorCommand.php` | route 清单、config 检查、app 健康检查 |
| 生成命令 | `app/Commands/MakeCommandCommand.php` / `MakeControllerCommand.php` / `MakeMiddlewareCommand.php` / `MakeProviderCommand.php` / `MakeMigrationCommand.php` / `MakeSeedCommand.php` / `MakeTestCommand.php` | command / controller / middleware / provider / migration / seeder / test 脚手架 |
| 视图 | `resources/views/home.html` | 模板页面 |

## 深入阅读

模板默认是按 PSR 约定来组织的：

- `composer.json` 声明了 `App\\ => app/` 的 PSR-4 autoload
- 也预先列出了模板会直接接到的 contract，比如 `psr/http-message`、`psr/http-server-*`、`psr/container`、`psr/log`、`psr/clock`
- 当前 controller / error handler 示例优先使用 `VSlim\Psr7\ServerRequest` 这个原生 PSR-7 concrete class，与 runtime 当前分发对象保持一致

HTTP 侧的最小样板包括：

- `bootstrap/http.php`
  展示怎样把 built-in server globals 和 worker envelope 收到同一份 app dispatch
- `app/Http/middleware.php`
  展示如何注册 `Psr\Http\Server\MiddlewareInterface`
- `app/Http/controllers.php`
  展示需要显式构造参数时，怎样把 controller 绑进 container
- `app/Modules/StatusModule.php`
  展示 provider 之外，怎样把一组 service + route 收进独立 module

CLI 侧的最小样板包括：

- `bin/vslim`
  现成的命令行入口脚本
- `app/Commands/AboutCommand.php`
  一个完整 command 示例，已经包含 `definition()`、help、examples、notes
- `app/Commands/RouteListCommand.php`
  route 清单和冲突检查示例
- `app/Commands/ConfigCheckCommand.php`
  config-first 项目的快速自检入口
- `app/Commands/AppDoctorCommand.php`
  `app()->doctor()` 的轻量健康检查示例
- `app/Commands/Make*Command.php`
  模板级脚手架命令示例

模板默认已经带上这些常用命令：

- `route:list`
- `config:check`
- `app:doctor`
- `db:migrate`
- `db:rollback`
- `db:seed`
- `make:command`
- `make:migration`
- `make:provider`
- `make:seed`
- `make:test`

## Auth Best Practice

模板当前推荐的 auth 写法是：

- `config/session.toml`
  默认 `session.secret` 给了 `change-me` 占位值，初始化项目后应尽快换成真实随机密钥
- `app()->startSessionMiddleware()`
  先挂上 session middleware
- `app()->setAuthUserProvider($provider)`
  注册按用户 ID 解析用户对象/数组的 provider
- `app()->setAuthGateResolver(fn (string $ability, $user, $request) => ...)`
  注册能力判断
- `app()->authMiddleware()`
  保护需要登录的路由
- `app()->guestMiddleware()`
  保护登录页/注册页这类“只允许游客访问”的路由
- `app()->abilityMiddleware('admin')`
  保护需要特定能力的路由

如果你只需要拿当前登录用户：

- `app()->authId($request)`
- `app()->authUser($request)`

如果你想在业务里手动根据 user id 解析用户：

- `app()->resolveAuthUser($id)`

推荐的 provider 形态是一个有 `findById(string $id)` 方法的对象：

```php
$app->setAuthUserProvider(new class {
    public function findById(string $id): array
    {
        return ['id' => $id, 'role' => 'admin'];
    }
});
```

如果你只是想快速接一条闭包，也可以继续用：

```php
$app->setAuthUserProvider(fn (string $id): array => ['id' => $id]);
```

## 上线前 Checklist

在把模板应用推到长期环境前，至少确认这几件事：

- 把 `config/session.toml` 里的 `session.secret` 从 `change-me` 换成真实随机密钥
- 如果你走 `database.transport = "direct"`，确认 PHP 运行时能找到 `extension/runtime/` 里的 mysql / mariadb client 库
- 如果你走 `database.transport = "vhttpd_upstream"`，确认 worker 环境里有 `VHTTPD_DB_SOCKET`
- 跑一次：
  - `bin/vslim config:check`
  - `bin/vslim app:doctor`
- 至少补一条：
  - `app()->testing()` 的 HTTP/JSON 集成测试
  - `db:migrate` / `db:seed` 的 smoke

如果你想要一份更完整、可直接照着执行的版本，继续看：

- [`docs/operations/README.md`](/Users/guweigang/Source/vphpx/vslim/docs/operations/README.md)

CLI schema 当前支持这些常用字段：

- `name`
- `type: string|bool|int|float`
- `required`
- `multiple`
- `default`
- `short`
- `description`
- `aliases`
- `hidden`
- `env`
- `placeholder`
- `value_hint`
- `examples`
- `epilog`
- `choices` / `enum`

如果参数解析失败，比如缺少 required argument、option 值类型不合法、choice 不匹配，
`runArgv()` 会直接输出错误信息，并自动附带该 command 的 usage。

## Testing Best Practice

模板当前推荐的测试写法是：

- `app()->testing()`
- `withConfigText(...)`
- `withService(...)`
- `get()/post()/postJson()`
- `assertStatus()/assertBodyContains()`
- 需要登录态时优先用：
  - `withSession([...])`
  - `actingAs('42')`

最小示例：

```php
$test = $app->testing()
    ->withConfigText("[testing]\nmessage = 'from-config'\n");

$res = $test->get('/hello');

$test->assertStatus($res, 200)
     ->assertBodyContains($res, 'from-config');
```

如果你的路由依赖 session/auth：

```php
$test->withSession(['name' => 'alice']);
$test->actingAs('42');
```

如果你需要更完整的目录骨架，可以继续参考：

- [`examples/skeleton_app.php`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton_app.php)
- [`examples/skeleton/README.md`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/README.md)
- [`docs/app/skeleton.md`](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)
