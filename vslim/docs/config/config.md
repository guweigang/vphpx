# VSlim\Config

`VSlim\Config` 是 VSlim 内置的 TOML 配置对象，适合给应用和 worker 读静态配置。

真理之源：

- [`src/config_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/config_runtime.v)
- [`tests/test_vslim_config_toml.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_config_toml.phpt)
- [`tests/test_vslim_app_config.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_config.phpt)
- [`examples/config_usage.php`](/Users/guweigang/Source/vphpx/vslim/examples/config_usage.php)

## 基本用法

```php
use VSlim\Config;

$cfg = new Config();
$cfg->load(__DIR__ . '/app.toml');

echo $cfg->get_string('app.name', 'n/a') . PHP_EOL;
echo $cfg->get_int('app.port', 0) . PHP_EOL;
```

也支持直接加载文本：

```php
$cfg->load_text(<<<TOML
[app]
name = "demo"
debug = true
TOML);
```

## 状态 API

- `is_loaded()`
- `path()`
- `has($key)`
- `all_json()`

## typed getter

- `get_string($key, $default)`
- `get_int($key, $default)`
- `get_bool($key, $default)`
- `get_float($key, $default)`
- `get_string_list($key)`

示例：

```php
echo $cfg->get_bool('app.debug', false) ? 'on' : 'off';
```

## mixed getter

### `get($key, $default = null)`

返回更接近 PHP 值的结果：

```php
$flags = $cfg->get('feature.flags');
```

### `get_map($key, $default = [])`

只在目标节点真的是 map 时返回 map，否则回退默认值或空数组。

### `get_list($key, $default = [])`

只在目标节点真的是 list 时返回 list，否则回退默认值或空数组。

### `get_json($key, $defaultJson)`

把指定配置节点序列化成 JSON 字符串。

## key 路径规则

使用 dot path：

```php
$cfg->get_string('app.name', 'x');
$cfg->get_list('db.hosts');
```

如果 key 为空字符串，内部会把整个根节点视作目标。

## 与 `VSlim\App` 整合

`App` 提供：

- `config()`
- `set_config()`
- `load_config()`
- `load_config_text()`
- `has_config()`

示例：

```php
$app = new VSlim\App();
$app->load_config_text(<<<TOML
[app]
name = "demo"
TOML);

echo $app->config()->get_string('app.name', 'x');
```

当 `App` 同时持有 container 和 config 时，会自动把 config 同步到容器中的 `config` 条目：

```php
$cfg = $app->container()->get('config');
```

拿到的是 `VSlim\Config` 对象。

## 什么时候用它

适合：

- 读取应用 TOML 配置
- 给容器和业务服务提供只读配置
- 在 worker / demo app 里加载启动参数

不适合：

- 复杂动态配置中心
- 高频热更新配置

