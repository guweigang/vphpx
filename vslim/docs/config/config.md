# VSlim\Config

`VSlim\Config` 已经不只是“读一个 TOML 文件”的薄对象了。
现在它更像 VSlim 的配置仓库：

- 可以加载单个 `.toml`
- 也可以直接加载整个 `config/` 目录
- 支持 shell 风格的环境占位符
- 支持按 dot path 读取 typed 值
- 会被 `VSlim\App` 自动同步进容器里的 `config` service

真理之源：

- [`src/config_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/config_runtime.v)
- [`tests/test_vslim_config_toml.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_config_toml.phpt)
- [`tests/test_vslim_app_config.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_config.phpt)
- [`examples/config_usage.php`](/Users/guweigang/Source/vphpx/vslim/examples/config_usage.php)

## 基本用法

```php
use VSlim\Config;

$cfg = new Config();
$cfg->load(__DIR__ . '/config');

echo $cfg->getString('app.name', 'n/a') . PHP_EOL;
echo $cfg->getInt('http.max_body_bytes', 0) . PHP_EOL;
```

也支持直接加载单个文件或直接加载文本：

```php
$cfg->load(__DIR__ . '/config/app.toml');

$cfg->loadText(<<<TOML
[app]
name = "demo"
debug = true
TOML);
```

## `config/` 目录加载

当 `load()` 传入目录时，会自动合并该目录下的 `.toml` 文件。

推荐目录：

```text
config/
  app.toml
  http.toml
  cli.toml
  cache.toml
  database.toml
  logging.toml
  stream.toml
```

VSlim 会优先按这些常见域文件加载：

- `app.toml`
- `http.toml`
- `logging.toml`
- `cache.toml`
- `database.toml`
- `stream.toml`
- `vhttpd.toml`

其余 `.toml` 文件再按文件名排序合并。

这样做的目的，是把配置从“一个大文件”升级成“按领域拆分的配置仓库”。

## 环境变量占位符

TOML 字符串里支持 shell 风格的环境占位符：

```toml
[app]
name = "${env.APP_NAME:-VSlim}"
debug = "${env.bool.APP_DEBUG:-true}"

[http]
max_body_bytes = "${env.int.VSLIM_MAX_BODY_BYTES:-1048576}"

[stream.ollama]
chat_url = "${env.OLLAMA_CHAT_URL:-http://127.0.0.1:11434/api/chat}"
temperature = "${env.float.OLLAMA_TEMPERATURE:-0.2}"
```

当前支持：

- `${env.KEY}`
- `${env.KEY:-default}`
- `${env.bool.KEY:-true}`
- `${env.int.KEY:-8080}`
- `${env.float.KEY:-1.5}`

注意：

- 这是单层占位符，不支持嵌套默认值
- 解析发生在配置加载阶段，不是在业务运行期动态求值

## 状态 API

- `isLoaded()`
- `path()`
- `has($key)`
- `allJson()`

## typed getter

- `getString($key, $default)`
- `getInt($key, $default)`
- `getBool($key, $default)`
- `getFloat($key, $default)`
- `getStringList($key)`

示例：

```php
echo $cfg->getBool('app.debug', false) ? 'on' : 'off';
```

## mixed getter

### `get($key, $default = null)`

返回更接近 PHP 值的结果：

```php
$flags = $cfg->get('feature.flags');
```

### `getMap($key, $default = [])`

只在目标节点真的是 map 时返回 map，否则回退默认值或空数组。

### `getList($key, $default = [])`

只在目标节点真的是 list 时返回 list，否则回退默认值或空数组。

### `getJson($key, $defaultJson)`

把指定配置节点序列化成 JSON 字符串。

## key 路径规则

使用 dot path：

```php
$cfg->getString('app.name', 'x');
$cfg->getList('db.hosts');
```

如果 key 为空字符串，内部会把整个根节点视作目标。

## 与 `VSlim\App` 整合

`App` 提供：

- `config()`
- `setConfig()`
- `loadConfig()`
- `loadConfigText()`
- `hasConfig()`

示例：

```php
$app = new VSlim\App();
$app->loadConfig(__DIR__ . '/config');

echo $app->config()->getString('app.name', 'x');
```

当 `App` 同时持有 container 和 config 时，会自动把 config 同步到容器中的 `config` 条目：

```php
$cfg = $app->container()->get('config');
```

拿到的是 `VSlim\Config` 对象。

## 配置驱动的默认服务

现在这层配置已经不只是“业务代码自己读配置”。
VSlim 的一些默认 service 也会优先吃配置：

- `view.cache`
- `http.max_body_bytes`
- `app.trace.memory`
- `app.trace.memory_every`
- `logging.channel`
- `logging.level`
- `logging.target`
- `logging.output_file`
- `http.client.timeout_seconds`
- `cache.prefix`
- `cache.default_ttl_seconds`
- `cache.pool.prefix`
- `cache.pool.default_ttl_seconds`
- `database.driver`
- `database.pool_size`
- `database.mysql.host`
- `database.mysql.port`
- `database.mysql.username`
- `database.mysql.password`
- `database.mysql.database`
- `stream.ollama.chat_url`
- `stream.ollama.model`
- `stream.ollama.api_key`
- `stream.ollama.fixture`
- `cli.debug`
- `cli.debug_file`

也就是说，环境变量现在更像 fallback；
真正推荐的主路径是 `config/*.toml`。

## 什么时候用它

适合：

- 读取项目 `config/*.toml`
- 给容器和业务服务提供只读配置
- 作为 logger / cache / http client / stream 等默认 service 的配置来源
- 作为 database manager、连接池和事务默认值的配置来源
- 在 worker / demo app 里统一接住环境变量和静态配置

不适合：

- 复杂动态配置中心
- 高频热更新配置
