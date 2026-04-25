# VSlim PSR Roadmap

这份文档定义 `vslim` 在 `V1` 之后的长期方向：

> `vslim` 以“覆盖全部 PSR 规范”为北极星；
> 一旦实现某个 PSR 所需的底层能力超出当前边界，优先升级 `vphp`，再继续推进 `vslim`。

这里的“实现”不等于所有规范都塞进一个类里，而是要把和 PHP framework/runtime 相关的 PSR 面系统化落地，并且给出清晰的层次分工。

## 总原则

### 1. `vslim` 负责框架面，`vphp` 负责能力面

- `vslim` 负责对 PHP userland 暴露 PSR 风格 API、对象和运行时约定
- `vphp` 负责这些 API 背后的 Zend binding、对象模型、接口绑定、调用桥和性能基线
- 如果 `vslim` 做到一半发现语义不对、性能太差、桥接太脆，就先补 `vphp`

### 2. 先把高频运行时 PSR 做深，再扩展外围 PSR

优先级不是按编号，而是按对 `vslim + vhttpd + php-worker` 主链路的重要性排序：

1. `PSR-7`
2. `PSR-17`
3. `PSR-15`
4. `PSR-11`
5. `PSR-3`
6. `PSR-14`
7. `PSR-18`
8. `PSR-16 / PSR-6`
9. `PSR-20`

其中 `PSR-11` 已经有基础实现，后续主要是补齐生态一致性。

### 3. 兼容层可以先落地，但不能永远停在 adapter

现阶段 `PSR-7 bridge`、`PSR-15 worker dispatch` 已经证明方向是对的，但它们更像“接入能力”。后续目标要逐步升级成“本体能力”：

- 不只是能接 PSR 请求
- 而是 `vslim` 自己就能稳定提供对应 PSR 语义

## 当前状态

仓库里已经有这些基础：

- `PSR-11`
  - `VSlim\Container` 已声明并测试 `Psr\Container\ContainerInterface`
- `PSR-7`
  - 已有 worker bridge 和 `Psr7Adapter`
- `PSR-15`
  - 已有 worker 侧 `RequestHandlerInterface` / middleware stack dispatch

这说明项目已经不是“是否进入 PSR 生态”的阶段，而是“如何从 bridge 走向完整实现”的阶段。

## PSR 分层目标

### `PSR-7` HTTP message

目标：

- 让 `vslim` 原生提供稳定的 request / response / stream / uri / uploaded file 语义
- 既能服务 `vslim` 自己的路由内核，也能直接进入标准 PSR middleware / framework 生态

当前状态：

- 有 bridge
- `VSlim\VHttpd\Request` / `VSlim\VHttpd\Response` 还不是完整 PSR-7 对象

后续目标：

- 补齐 `ServerRequestInterface`
- 补齐 `ResponseInterface`
- 补齐 `StreamInterface`
- 补齐 `UriInterface`
- 明确 immutable `with*()` 语义

### `PSR-17` HTTP factories

目标：

- 不再只依赖用户态安装第三方 PSR-17 工厂
- `vslim` 自己提供标准 factory，作为 `PSR-7` 实现的构造入口

后续目标：

- `RequestFactoryInterface`
- `ResponseFactoryInterface`
- `ServerRequestFactoryInterface`
- `StreamFactoryInterface`
- `UriFactoryInterface`

### `PSR-15` HTTP server handlers / middleware

目标：

- 不只是 worker 能 dispatch 到 `PSR-15`
- 而是 `vslim` 内核自身就能把 middleware pipeline 和 route handler pipeline 标准化

后续目标：

- `VSlim\App` 可直接作为 `RequestHandlerInterface` 暴露
- route / group / global middleware 统一收敛为 `MiddlewareInterface` 语义
- 原生错误处理与短路行为对齐 `PSR-15`

### `PSR-11` container

当前状态：

- 已有 `VSlim\Container`

后续目标：

- 补强异常层次与 first-touch/autoload 场景
- 保证与 Composer / userland interface 的绑定长期稳定
- 让容器解析、route handler 自动装配、middleware 装配都走统一契约

### `PSR-3` logger

目标：

- 把现有 logger 能力收敛到 `Psr\Log\LoggerInterface`
- 让 `vslim` 中间件、worker、应用代码都能共享一套标准日志接口

后续目标：

- `VSlim\Logger` 或等价对象实现 `LoggerInterface`
- 为 request id / trace id / upstream metadata 提供一致 context

### `PSR-14` event dispatcher

目标：

- 把应用生命周期、可观测性、插件式扩展点从 ad-hoc hook 提升到标准事件面

后续目标：

- request lifecycle event
- worker lifecycle event
- stream / websocket / mcp 事件的可选标准化分发

### `PSR-18` HTTP client

目标：

- 让 `vslim` 侧的 outbound HTTP 不必依赖某个具体 client
- 为 AI upstream、webhook、service-to-service 调用提供标准客户端接口

后续目标：

- 支持 `ClientInterface`
- 明确它与 `vhttpd` / `veb` / 未来 outbound runtime 的边界

### `PSR-16 / PSR-6` cache

目标：

- 给配置、模板、路由元数据、应用缓存一个标准缓存面

说明：

- 这部分重要，但优先级低于 HTTP 主链路
- 可以先从 `PSR-16` 开始，再考虑 `PSR-6`

### `PSR-20` clock

目标：

- 给 cache、event、retry、timeout、middleware 等需要“当前时间”语义的地方提供标准时钟面
- 避免业务代码到处直接 new `DateTimeImmutable('now')`

后续目标：

- 支持 `ClockInterface`
- 先提供稳定 system clock，再考虑测试友好的 frozen / offset clock 能力是否作为扩展 API 提供

当前进展：

- `VSlim\Psr20\Clock` 已实现 `ClockInterface`
- `PSR-16 / PSR-6` 的 TTL / expiration 计算已经能接入注入的 `ClockInterface`，不再只能硬编码系统时间
- `VSlim\App` 的 runtime trace 时间戳也已经能接入 app-level `ClockInterface`

## 需要先升级 `vphp` 的信号

只要出现下面任一情况，就不应该继续在 `vslim` 里硬拧，而应该先增强 `vphp`：

### 1. 接口绑定语义不稳

例如：

- `@[php_implements]` 无法稳定覆盖 Composer/autoload 场景
- internal class 与 userland interface 的绑定有 first-touch 顺序问题
- 标准接口的方法签名在桥接层不能可靠校验

### 2. immutable 对象成本过高

`PSR-7` 的 `withHeader()`、`withBody()`、`withUri()` 都要求返回新对象。

如果当前 `vphp` 无法低成本支持：

- clone-on-write
- request-owned / persistent-owned 的安全转换
- 深浅拷贝边界控制

就先升级 `vphp`，不要在 `vslim` 里做脆弱补丁。

### 3. stream / upload / uri 对象模型不够用

如果要补全：

- `StreamInterface`
- `UploadedFileInterface`
- `UriInterface`

而现有对象桥、资源包装、析构时机、错误传播不够稳定，就先补 `vphp` 的对象与资源模型。

### 4. PHP 标准生态互操作不完整

例如：

- 需要更强的 userland class probing
- 需要更稳的反射/元数据读取
- 需要更准的 callable / interface signature 适配

这些都属于 `vphp` 能力面，不应该让 `vslim` 单独兜底。

## 建议推进顺序

### Phase A: 把现有 bridge 升级成稳定 contract

- 稳定 `PSR-7` request/response adapter 边界
- 稳定 `PSR-15` worker dispatch contract
- 为 `PSR-17` factory 留出统一入口

### Phase B: 原生 `PSR-7 + PSR-17`

- 补齐 message object
- 补齐 factory object
- 建立 request/response/stream/upload 测试矩阵

这是最大的一步，也是最容易暴露 `vphp` 缺口的一步。

### Phase C: 原生 `PSR-15`

- 让 `VSlim\App` / middleware pipeline 直接标准化
- 清理历史 before/after/middleware 的语义重叠

### Phase D: 扩展外围 PSR

- `PSR-3`
- `PSR-14`
- `PSR-18`
- `PSR-16 / PSR-6`

## 完成标准

一个 PSR 不算“完成”，除非同时满足：

1. 有原生实现或官方维护的内置兼容层
2. 有 `phpt` 回归测试
3. 有至少一条真实生态集成测试
4. README 和 docs 已公开说明
5. 不依赖脆弱的调用顺序或临时 bridge hack

## 一句话

`vslim` 后续不是“补一点 PSR 兼容”。

`vslim` 的长期目标是把自己推进成一个系统化覆盖 PSR 生态的运行时框架层；凡是做不到的地方，先升级 `vphp`，再回来继续实现。
