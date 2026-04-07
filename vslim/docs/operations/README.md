# VSlim Operations Checklist

这份清单面向两类场景：

- 你刚把模板项目复制出来，准备第一次跑通
- 你已经写完业务，准备把项目切到长期运行环境

它不重复讲 API 细节，只强调最短落地路径。

## 本地起步

1. 准备扩展和依赖
   - 确认 `vslim.so` 能被 PHP 正常加载
   - 如果数据库走 `direct`，确认 mysql / mariadb client 运行库可被 PHP loader 找到
2. 安装模板依赖
   - `composer install`
3. 检查配置
   - `bin/vslim config:check`
4. 检查框架健康状态
   - `bin/vslim app:doctor`
5. 跑 HTTP 最小链路
   - `make serve EXT=./vslim.so`
6. 跑 worker 最小链路
   - `make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd`

## 数据库上线前

先决定 transport：

- `database.transport = "direct"`
  - 本地开发最直接
  - 要保证 PHP 进程能找到 mysql / mariadb client 运行库
- `database.transport = "vhttpd_upstream"`
  - 更适合 worker/runtime 主部署
  - 要保证 worker 环境里有 `VHTTPD_DB_SOCKET`

最少做这几步：

1. `bin/vslim config:check`
   - 确认 `database.transport`
   - 确认 `database.driver`
   - 如果是 upstream，确认 `database.upstream.socket`
2. `bin/vslim db:migrate`
3. 如果项目依赖初始数据：
   - `bin/vslim db:seed`
4. 如果走 upstream：
   - 用 `examples/db_upstream_probe.php` 或真实业务查询跑一次 smoke

## Session / Auth 上线前

1. 把 `config/session.toml` 里的 `session.secret` 从 `change-me` 换成真实随机密钥
2. 跑一次：
   - `bin/vslim app:doctor`
3. 如果路由依赖登录态，确认：
   - `app()->startSessionMiddleware()`
   - `app()->setAuthUserProvider(...)`
   - `app()->authMiddleware()` / `guestMiddleware()` / `abilityMiddleware(...)`

## 测试最小集

上线前至少跑其中一组：

- `make test`
  - 轻量 PHPT 回归
- `make runtime-check`
  - 包含 `vhttpd` / worker / runtime 链路

如果你用的是模板项目，至少补一条你自己的：

- `app()->testing()` HTTP / JSON 集成测试
- 或数据库 migration / seed / query smoke

## 推荐的发布前命令顺序

```bash
bin/vslim config:check
bin/vslim app:doctor
bin/vslim db:migrate
bin/vslim db:seed
make test
make smoke-vhttpd EXT=./vslim.so VHTTPD_ROOT=/path/to/vhttpd
```

如果 `app:doctor` 仍然报这些问题，不建议直接上线：

- `config_not_loaded`
- `session_not_configured`
- `session_secret_placeholder`
- `database_upstream_socket_missing`
- `auth_user_provider_missing`
