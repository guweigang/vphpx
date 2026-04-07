# VSlim Capability Map

这页是 `VSlim` 当前能力的一张总表。

目标不是讲每个 API 细节，而是快速回答：

- 现在已经有哪些核心能力？
- 哪些已经可以作为主路径使用？
- 哪些还是第一版、适合继续打磨？

## 当前状态

如果按“轻量但成熟的扩展级框架”来评估，当前可以粗略理解成：

- HTTP / CLI / runtime integration：已成型
- config / db / validate / session / auth / testing：已可用
- 文档 / 模板 / 诊断 / 发布路径：正在持续收口

一句话：

- 现在已经不是 demo，也不只是技术预研
- 已经可以写真实项目
- 但还有一层产品化和成熟度打磨在继续推进

## 核心能力表

| 能力 | 当前状态 | 推荐用法 | 说明 |
| --- | --- | --- | --- |
| HTTP App | 稳定主路径 | `VSlim\App` | route / middleware / controller / module / provider |
| CLI App | 稳定主路径 | `VSlim\Cli\App` | 命令注册、发现、模板生成、诊断命令 |
| PSR HTTP | 稳定主路径 | `Psr\Http\Message\*` / `VSlim\Psr7\*` | 内核响应链已基本 PSR-first |
| `vhttpd` worker 集成 | 稳定主路径 | `dispatch_envelope*()` / `Psr7Adapter` | worker/runtime 入口已成型 |
| Stream | 稳定主路径 | `VSlim\Stream\*` | SSE / text stream / Ollama helper |
| WebSocket | 稳定主路径 | `VSlim\WebSocket\App` | room / presence / handler model |
| MCP | 稳定主路径 | `VSlim\Mcp\App` | tool / resource / prompt / streamable HTTP runtime |
| Config | 稳定主路径 | `config/*.toml` | typed env placeholder、多文件 merge、config-first defaults |
| Database Manager | 稳定主路径 | `app()->database()` / `app()->db()` | direct mysql + `vhttpd_upstream` |
| Query Builder | 稳定主路径 | `app()->db()->table(...)` | 轻量 DBAL 风格 |
| Model | 第一版可用 | `VSlim\Database\Model` | 最小 active-record 风格，不是完整 ORM |
| Migration / Seed | 第一版可用 | `app()->migrator()` / `db:migrate` / `db:seed` | SQL-first，带轻量 schema helper |
| Validate | 第一版可用 | `VSlim\Validate\Validator` / `app()->validate(...)` | 轻量规则集，适合请求输入校验 |
| Session | 第一版可用 | `app()->session($request)` | cookie-backed session，天然适合多进程 |
| Auth | 第一版可用 | `app()->auth(...)` / `authMiddleware()` / `guestMiddleware()` / `abilityMiddleware()` | provider / gate 已有，仍可继续补 guard 体验 |
| Testing | 第一版可用 | `app()->testing()` | service/config override、cookie jar、session/auth helper、response 断言 |
| Error helpers | 第一版可用 | `validationError()` / `unauthorized()` / `exceptionResponse()` | 常见异常和响应 helper 已统一一轮 |
| Diagnostics | 第一版可用 | `config:check` / `app:doctor` | 模板 readiness / config / transport / session secret 检查 |

## 推荐主路径

如果你要按“简单但成熟”的方式起一个项目，当前推荐是：

1. `config/*.toml`
2. `VSlim\App`
3. `app()->database()` / `app()->migrator()`
4. `app()->validate(...)`
5. `app()->startSessionMiddleware()` + `app()->authMiddleware()`
6. `app()->testing()`
7. `config:check` + `app:doctor`

对应文档：

- [README.md](/Users/guweigang/Source/vphpx/vslim/README.md)
- [docs/OVERVIEW.md](/Users/guweigang/Source/vphpx/vslim/docs/OVERVIEW.md)
- [docs/config/config.md](/Users/guweigang/Source/vphpx/vslim/docs/config/config.md)
- [docs/database/README.md](/Users/guweigang/Source/vphpx/vslim/docs/database/README.md)
- [docs/testing/README.md](/Users/guweigang/Source/vphpx/vslim/docs/testing/README.md)
- [docs/operations/README.md](/Users/guweigang/Source/vphpx/vslim/docs/operations/README.md)

## 数据库两条主路径

数据库是当前最需要明确心智的一层：

- `database.transport = "direct"`
  - 适合本地开发、最短链路
  - 需要应用进程自己处理 mysql / mariadb 原生运行库
- `database.transport = "vhttpd_upstream"`
  - 适合 worker/runtime 主部署
  - 连接池、事务会话和原生依赖收敛到 `vhttpd`

推荐：

- 开发环境：先 `direct`
- worker / 多进程 / 发版：优先 `vhttpd_upstream`

## 当前边界

虽然已经可用，但这些点仍然属于“第一版”：

- `Model`
  - 不是完整 ORM
- `Migration / Seed`
  - 已够用，但 schema builder 仍偏轻
- `Validate`
  - 规则集还偏轻量
- `Auth`
  - provider / gate 已有，但还没走到完整 guard / policy 生态
- `Testing`
  - 已有 harness，但还不是特别重的测试生态

## 现在最值得继续补的方向

如果继续打磨成熟度，优先级建议是：

1. 发布和安装体验继续磨平
2. auth 再补半层
3. schema / migration 体验继续增强
4. 异常与错误输出再统一
5. 文档和模板继续收口
