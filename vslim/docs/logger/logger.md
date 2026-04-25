# Logger

`VSlim` 当前有两层日志对象：

- `VSlim\Log\Logger`
  - 原生、可链式、VSlim 风格 API
- `VSlim\Log\PsrLogger`
  - 面向 `Psr\Log\LoggerInterface` 的标准包装层

这两层共用同一个底层日志实现。

## `VSlim\Log\Logger`

这是 VSlim 原生 logger，适合直接在应用里链式调用：

```php
$logger = new VSlim\Log\Logger();
$logger
    ->setChannel('app')
    ->withContext('trace_id', 'req-1')
    ->info('boot ok');
```

## `VSlim\Log\PsrLogger`

如果你需要把 VSlim logger 暴露给依赖 `PSR-3` 的代码，可以使用：

```php
$psr = new VSlim\Log\PsrLogger();
$psr->setChannel('app');
$psr->info('boot ok', ['trace_id' => 'req-1']);
```

它实现：

- `Psr\Log\LoggerInterface`

并把标准 level 映射到 VSlim 当前的底层 level：

- `warning` -> `warn`
- `notice` -> `info`
- `critical` / `alert` -> `error`
- `emergency` -> `fatal`

## 取回原生 logger

如果你既想走 `PSR-3`，又想访问 VSlim 的原生配置入口：

```php
$inner = $psr->logger();
$inner->setOutputFile('/tmp/app.log');
```
