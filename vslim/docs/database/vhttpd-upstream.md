# VSlim Database over vhttpd Upstream

这份文档描述的是一个目标架构：

- `vhttpd` 托管数据库连接池和数据库会话
- `VSlim` / PHP worker 不再直接连数据库
- `VSlim\Database\Manager / Query / Model` 对上层 API 尽量保持不变
- `VSlim` 只是把数据库请求通过 unix socket 发送给 `vhttpd`

一句话：

- `VSlim` 继续负责“怎么写数据库代码”
- `vhttpd` 负责“怎么托管数据库连接和会话”

## 目标

我们想解决的是：

- PHP worker 是多进程，数据库连接池天然是每进程一份
- 即使 `VSlim\Database\Manager` 里有 pool，也只是 worker 内 pool
- 对高并发、多 worker、长驻进程场景，更理想的是：
  - 让 `vhttpd` 统一托管 DB pool
  - 所有 PHP worker 通过 unix socket 复用这层能力

同时，希望业务代码几乎无感：

```php
$rows = $app->db()->table('users')->where('status', 'active')->get();
$user = (new VSlim\Database\Model())->setManager($app->db())->setTable('users')->find(7);
```

这条路的第一步不是先做 DB transport，而是先在扩展里提供一个通用协议 client：

- `VSlim\VHttpd\Client`

它会直接复用 `vhttpd/php-worker` 现有的 unix socket framed JSON 协议，只是实现放在扩展里，而不是直接依赖 PHP 包里的 `VHttpd\PhpWorker\Client`。

## 边界

### `VSlim` 负责

- DBAL / Query / Model API
- query builder
- 参数归一化
- 结果转换成 PHP 值
- 与 container / app services 对接

### `vhttpd` 负责

- 真实数据库连接池
- prepared statement 执行
- transaction session 粘连
- 超时、连接失败、重试、熔断
- 数据库 executor 生命周期
- unix socket 协议端点

两边之间应该只共享一套很小的 RPC 协议。

## 传输层

第一版只考虑 unix socket。

建议：

- socket path:
  - `tmp/vhttpd-db.sock`
  - 或挂到 `socket_prefix`
- 编码：
  - 请求和响应都用 JSON
  - 一次请求一条 JSON message
- 第一版不用流式结果，不做 chunked row stream
- framing 直接复用 `PhpWorker/Client`：
  - 4-byte big-endian length prefix
  - JSON request / JSON response
  - 可选后续 frame 列表

## 配置建议

`VSlim` 侧建议新增：

```toml
[database]
driver = "mysql"
transport = "${env.DB_TRANSPORT:-direct}"
pool_name = "${env.DB_POOL:-default}"
timeout_ms = "${env.int.DB_TIMEOUT_MS:-1000}"

[database.mysql]
host = "${env.DB_HOST:-127.0.0.1}"
port = "${env.int.DB_PORT:-3306}"
username = "${env.DB_USERNAME:-root}"
password = "${env.DB_PASSWORD:-}"
database = "${env.DB_NAME:-app}"

[database.upstream]
socket = "${env.DB_UPSTREAM_SOCKET:-tmp/vhttpd-db.sock}"
```

关键点：

- `driver`
  - 描述真实数据库类型
- `transport`
  - `direct`
  - `vhttpd_upstream`
- `pool_name`
  - 让 `vhttpd` 侧可区分不同 DB 池
- `timeout_ms`
  - transport 级超时

## VSlim 侧抽象

当前 `VSlim\Database\Manager` 直接内嵌 mysql 实现。

下一步建议把它拆成：

- `VSlimDatabaseTransport`
  - `connect()`
  - `disconnect()`
  - `ping()`
  - `query(sql, params)`
  - `execute(sql, params)`
  - `begin_transaction()`
  - `commit()`
  - `rollback()`
  - `last_insert_id()`
  - `affected_rows()`
  - `last_error()`

两套实现：

- `VSlimDirectMysqlTransport`
- `VSlimVhttpdDbTransport`

然后 `VSlim\Database\Manager` 只做：

- 配置解析
- 上层 API facade
- transaction 状态协调
- Query / Model 入口

## RPC 协议草案

### 请求

```json
{
  "version": 1,
  "pool": "default",
  "session_id": "tx_123",
  "op": "query",
  "sql": "SELECT * FROM users WHERE id = ?",
  "params": ["7"],
  "timeout_ms": 1000
}
```

### 响应

查询：

```json
{
  "ok": true,
  "rows": [
    {"id": "7", "name": "alice"}
  ],
  "affected_rows": 0,
  "last_insert_id": 0,
  "session_id": "tx_123"
}
```

执行：

```json
{
  "ok": true,
  "affected_rows": 1,
  "last_insert_id": 42,
  "session_id": "tx_123"
}
```

错误：

```json
{
  "ok": false,
  "error": {
    "code": "db.query_failed",
    "message": "duplicate key",
    "sql_state": "23000",
    "retryable": false
  },
  "session_id": "tx_123"
}
```

## 第一版 operation 集

只支持这些：

- `ping`
- `query`
- `execute`
- `begin_transaction`
- `commit`
- `rollback`

## 事务设计

事务不能只靠请求顺序猜，必须显式 session 化。

建议：

- `begin_transaction`
  - `vhttpd` 分配一个 `session_id`
  - 内部把这个 session 绑定到一条真实数据库连接
- 后续 `query/execute`
  - 带上这个 `session_id`
  - `vhttpd` 保证请求落到同一条 DB 连接
- `commit/rollback`
  - 完成后释放 session 和底层连接

第一版建议：

- transport 连接断开时，未提交事务自动 rollback

## 返回结果形态

为了保持 `VSlim` 上层 API 无感，`vhttpd` upstream 返回的结果建议直接对齐当前 DBAL：

- `query/queryParams`
  - `[]map[string]string`
- `queryOne/queryOneParams`
  - `map[string]string | null`
- `execute/executeParams`
  - `affected_rows`
  - `last_insert_id`

## 与当前代码的最小接法

建议顺序：

1. 给 `VSlimDatabaseConfig` 增加：
   - `transport`
   - `pool_name`
   - `timeout_ms`
   - `upstream_socket`
2. 把 `VSlimDatabaseManager` 抽出 transport 接口
3. 先保留现有 direct mysql transport
4. 再加 `vhttpd_upstream` transport

## 第一版明确不做

- 分布式事务
- 多数据库路由
- ORM relation 自动加载
- migration over upstream

## 结论

这条路是可行的，而且很有价值。

但关键不是“把 SQL 发给 vhttpd”这么简单，而是：

- 要把 `vhttpd` 做成真正的 DB upstream
- 要把事务 session 做正确
- 要把 `VSlim` 里的数据库层收成 transport facade

真正做对后，可以得到一个很强的效果：

- 对 `VSlim` 用户几乎无感
- 对 `vhttpd` 来说，数据库也进入了统一 runtime 托管能力
