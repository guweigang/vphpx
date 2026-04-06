# VSlim Database

`VSlim` 现在已经有一层 mysql-first 的数据库基础设施，但还不是 ORM。

当前目标很明确：

- 先提供可配置的 database manager
- 先把连接池、查询、事务这些基础设施做稳
- API 心智尽量贴近 PHP 开发者熟悉的 DBAL / PDO 用法
- 底层实现先吃 V 的 `db.mysql`，把 worker 常驻和连接池优势保留下来

真理之源：

- [types.v](/Users/guweigang/Source/vphpx/vslim/src/types.v)
- [database_runtime.v](/Users/guweigang/Source/vphpx/vslim/src/database_runtime.v)
- [app_services.v](/Users/guweigang/Source/vphpx/vslim/src/app_services.v)
- [container.v](/Users/guweigang/Source/vphpx/vslim/src/container.v)
- [test_vslim_database_config.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_database_config.phpt)

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
pool_size = "${env.int.DB_POOL_SIZE:-5}"

[database.mysql]
host = "${env.DB_HOST:-127.0.0.1}"
port = "${env.int.DB_PORT:-3306}"
username = "${env.DB_USERNAME:-root}"
password = "${env.DB_PASSWORD:-}"
database = "${env.DB_NAME:-app}"
```

当前默认读取：

- `database.driver`
- `database.pool_size`
- `database.mysql.host`
- `database.mysql.port`
- `database.mysql.username`
- `database.mysql.password`
- `database.mysql.database`

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
- `queryOne($sql)`
- `queryParams($sql, array $params)`
- `queryOneParams($sql, array $params)`
- `execute($sql)`
- `executeParams($sql, array $params)`
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

## 事务语义

这里不是“假的 begin/commit 包装”。

当进入事务后：

- manager 会固定持有一条 pool 里的连接
- 后续 `query()/execute()` 都复用这条连接
- `commit()/rollback()` 后才把连接放回池子

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

- migration / seed
- schema abstraction
- 完整 ORM / active record
- 多数据库驱动统一实现

所以现在更适合把它理解成：

- `VSlim` 的 database manager / DBAL 起点
- 不是完整 ORM

## 下一步适合做什么

- prepared statement / statement facade
- 更稳定的结果对象
- `lastInsertId()` 行为回归
- migration / seed
- 然后再考虑 ORM
