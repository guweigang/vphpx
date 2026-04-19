# VSlim Database

`VSlim` 现在已经有一层 mysql-first 的数据库基础设施，但还不是 ORM。

当前目标很明确：

- 先提供可配置的 database manager
- 先把连接池、查询、事务这些基础设施做稳
- API 心智尽量贴近 PHP 开发者熟悉的 DBAL / PDO 用法
- 底层实现先吃 V 的 `db.mysql`，把 worker 常驻和连接池优势保留下来
- migration / seed / 轻量 schema helper 先补到“够顺手”

真理之源：

- [types.v](/Users/guweigang/Source/vphpx/vslim/src/types.v)
- [database_runtime.v](/Users/guweigang/Source/vphpx/vslim/src/database_runtime.v)
- [app_services.v](/Users/guweigang/Source/vphpx/vslim/src/app_services.v)
- [container.v](/Users/guweigang/Source/vphpx/vslim/src/container.v)
- [test_vslim_database_config.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_database_config.phpt)
- [vhttpd-upstream.md](/Users/guweigang/Source/vphpx/vslim/docs/database/vhttpd-upstream.md)

## 当前提供的对象

- `VSlim\Database\Config`
- `VSlim\Database\Manager`
- `VSlim\Database\Query`
- `VSlim\Database\Model`

`App` 和 container 里默认也已经接好了：

- `$app->database()`
- `$app->db()`
- `$app->container()->get('database')`
- `$app->container()->get('db')`
- `$app->container()->get(VSlim\Database\Manager::class)`

## 配置

推荐放在 `config/database.toml`：

```toml
[database]
driver = "${env.DB_DRIVER:-mysql}"
transport = "${env.DB_TRANSPORT:-direct}"
pool_size = "${env.int.DB_POOL_SIZE:-5}"
pool_name = "${env.DB_POOL_NAME:-default}"
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

当前默认读取：

- `database.driver`
- `database.transport`
- `database.pool_size`
- `database.pool_name`
- `database.timeout_ms`
- `database.mysql.host`
- `database.mysql.port`
- `database.mysql.username`
- `database.mysql.password`
- `database.mysql.database`
- `database.upstream.socket`

## direct 和 upstream 怎么选

第一版可以直接按这条经验法则：

- `direct`
  - 本地开发更顺手
  - 调试最直接
  - 适合单机、最短链路、先把业务写起来
- `vhttpd_upstream`
  - 更适合 worker/runtime 主部署路径
  - 连接池和事务会话由 `vhttpd` 托管
  - `VSlim` 侧基本无感，只改配置

推荐：

- 开发环境：先 `direct`
- 接到 `vhttpd`、多 worker、准备发版：优先 `vhttpd_upstream`

## 原生运行库说明

当你使用 `database.transport = "direct"` 时，`vslim` 扩展会直接依赖 mysql / mariadb client 运行库。

release bundle 现在会把这些库一并打进：

- `extension/vslim/runtime/`

运行时需要让 PHP loader 能找到它们：

- macOS：`DYLD_LIBRARY_PATH=./extension/vslim/runtime`
- Linux：`LD_LIBRARY_PATH=./extension/vslim/runtime`
- Windows：把 `extension\\vslim` 或 `extension\\vslim\\runtime` 加到 `PATH`

推荐安装结构是：

- `extension_dir/vslim/vslim.so`
- `extension_dir/vslim/runtime/...`

然后在 `php.ini` 里加载：

```ini
extension=vslim/vslim.so
```

如果你不想在应用进程里处理这层原生依赖，改用 `vhttpd_upstream` 会更省心。

## 基本用法

```php
$app = new VSlim\App();
$db = $app->database();

$db->connect();
$rows = $db->query('select 1 as ok');

$users = $db->table('users')
    ->select(['id', 'name'])
    ->where('status', 'active')
    ->orderBy('id', 'desc')
    ->limit(20)
    ->get();
```

## 当前 API

- `connect()`
- `disconnect()`
- `ping()`
- `table($name)`
- `query($sql)`
- `queryAsync($sql)`
- `queryOne($sql)`
- `queryParams($sql, array $params)`
- `queryParamsAsync($sql, array $params)`
- `queryOneParams($sql, array $params)`
- `execute($sql)`
- `executeAsync($sql)`
- `executeParams($sql, array $params)`
- `executeParamsAsync($sql, array $params)`
- `beginTransaction()`
- `commit()`
- `rollback()`
- `affectedRows()`
- `lastInsertId()`
- `lastError()`

`VSlim\Database\Query` 当前支持：

- `table($name)`
- `select($columns)`
- `where($column, $value)`
- `whereOp($column, $op, $value)`
- `orderBy($column, $direction = 'ASC')`
- `limit($n)`
- `offset($n)`
- `insert(array $values)`
- `update(array $values)`
- `delete()`
- `toSql()`
- `params()`
- `get()`
- `first()`
- `run()`
- `insertGetId()`

`VSlim\Database\Model` 当前只提供最小 active-record 风格能力：

- `setManager()`
- `setTable()`
- `setPrimaryKey()`
- `fill()`
- `attributes()`
- `get()/set()`
- `exists()`
- `newQuery()/allQuery()/findQuery()/saveQuery()/deleteQuery()`
- `all()/find()/save()/delete()`

这里先把边界说清楚：

- 它是最小 model 层，不是完整 ORM
- 还没有 relation、scope、cast、hook、eager loading
- 当前更适合做轻量表模型和简单 CRUD 封装

## 结果形态

当前返回值优先走 `ZBox` / PHP 原生值，而不是额外引入 statement/result 对象。

- `query()` / `queryParams()`
  - 返回数组结果
- `queryOne()` / `queryOneParams()`
  - 返回单行或 `null`
- `execute()` / `executeParams()`
  - 返回带 `affected_rows` 的结果 map

这是第一阶段的选择：先把 manager 做稳，再决定要不要加独立 statement / result facade。

## Async Query / Execute

`VSlim` 现在提供了一版最小可用的数据库异步接口：

- `queryAsync($sql)`
- `queryParamsAsync($sql, array $params)`
- `executeAsync($sql)`
- `executeParamsAsync($sql, array $params)`

这些方法都会返回：

- `VSlim\Database\PendingResult`

`PendingResult` 当前支持：

- `wait()`
- `resolved()`
- `affectedRows()`
- `lastInsertId()`
- `lastError()`

最小例子：

```php
$db = app()->database();

$pending = $db->queryAsync('SELECT 1 AS ok');
$rows = $pending->wait();

echo $rows[0]['ok'];
```

带参数：

```php
$pending = $db->queryParamsAsync(
    'SELECT * FROM users WHERE status = ? LIMIT ?',
    ['active', 10],
);

$rows = $pending->wait();
```

写操作：

```php
$pending = $db->executeParamsAsync(
    'UPDATE users SET active = ? WHERE id = ?',
    [1, 7],
);

$meta = $pending->wait();
echo $pending->affectedRows();
echo $pending->lastInsertId();
```

### 这版 async 的真实语义

这里要特别说明，这不是 mysql client 的原生 nonblocking query。

当前实现是：

- `VSlim` 在后台 V 线程里执行阻塞 mysql 查询
- 每个 async 任务自己建立一条独立连接
- 查询完成后把 detached 结果带回主线程
- `wait()` 时再转成 PHP 值
- direct 连接池借出连接时会先 `ping()`，尽量剔除 stale connection
- query / execute 失败时只会在连接级 / 协议级 mysql errno 上 discard 连接
- 普通 SQL 语法或业务错误不会把连接误判成坏连接

所以它更准确的描述是：

- 线程包装的 async facade

而不是：

- mysql 协议级别的异步 IO

### 当前边界

第一版边界刻意收得很窄：

- 只支持 `database.transport = "direct"`
- `vhttpd_upstream` 当前不支持 async facade
- 事务进行中不允许调用 async 方法
- async 任务不会复用 manager 当前事务连接
- 每个 async 任务独立 `connect -> query/execute -> close`

如果你在事务里调用，会直接抛异常；这不是 bug，而是当前设计的明确限制。

### 什么时候适合用

适合：

- 当前请求里并发发起多个互不依赖的只读查询
- 单次写操作想避免阻塞当前业务编排
- 需要一个轻量 `PendingResult` 句柄统一等待结果

不适合：

- 事务链路
- 强依赖同一连接 session state 的 SQL
- 想把它当成持久 job queue
- 想把它理解成 mysql 原生非阻塞能力

相关源码和测试：

- [database_runtime.v](/Users/guweigang/Source/vphpx/vslim/src/database_runtime.v)
- [types.v](/Users/guweigang/Source/vphpx/vslim/src/types.v)
- [test_vslim_database_async.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_database_async.phpt)
- [test_vslim_database_async_real_db.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_database_async_real_db.phpt)

## 事务语义

这里不是“假的 begin/commit 包装”。

当进入事务后：

- manager 会固定持有一条 pool 里的连接
- 后续 `query()/execute()` 都复用这条连接
- `commit()/rollback()` 后才把连接放回池子
- 如果事务连接遇到连接级 / 协议级 mysql errno，会直接 discard 并清理事务态
- 如果只是普通事务错误，事务态会保留，调用方仍可决定 retry 或 rollback
- 如果 `commit()/rollback()` 已完成但恢复 `autocommit` 失败，连接不会回池

所以事务边界是按真实连接语义工作的，不是每次 query 都重新 `acquire()`。

## 当前边界

已经有：

- mysql-first 配置
- 连接池
- query / execute
- 参数绑定
- 事务
- 轻量 query builder
- 最小 model

还没有：

- 完整 schema builder
- 完整 ORM / active record
- 多数据库驱动统一实现

所以现在更适合把它理解成：

- `VSlim` 的 database manager / DBAL 起点
- 不是完整 ORM

## Migration / Seed

现在已经有：

- `VSlim\Database\Migration`
- `VSlim\Database\Seeder`
- `VSlim\Database\Migrator`
- `app()->migrator()`
- `db:migrate`
- `db:rollback`
- `db:seed`

第一版 migration 仍然是 SQL-first，但已经补了几条最常用的 schema helper：

- `createTableSql($table, array $columns)`
- `dropTableSql($table)`
- `addColumnSql($table, $columnDef)`
- `dropColumnSql($table, $column)`
- `createTable(...)`
- `dropTable(...)`
- `addColumn(...)`
- `dropColumn(...)`

适合做简单表结构演进，但还不是完整 schema builder。

## 下一步适合做什么

- prepared statement / statement facade
- 更稳定的结果对象
- `lastInsertId()` 行为回归
- 更完整的 schema builder
- 然后再考虑 ORM

如果要把数据库连接池进一步交给 `vhttpd` 托管，而不是留在 PHP worker 进程内，设计见：

- [VSlim Database over vhttpd Upstream](/Users/guweigang/Source/vphpx/vslim/docs/database/vhttpd-upstream.md)
