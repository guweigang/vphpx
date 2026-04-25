# VSlim HTTP Kernel

这页只讲 `VSlim\App` 的内部执行骨架，不讲路由 DSL 细节。

如果一句话概括现在的分层：

- `VSlim\App` 是 public facade
- HTTP kernel 负责一次请求的执行编排
- route runtime 负责匹配和 route terminal 决策
- PSR bridge 负责 `VSlim\VHttpd\*` 和 PSR-7/15 互转
- `vhttpd` 只保留 transport 边界

## Internal Layers

### Public Facade

文件：

- [`src/app_dispatch_api.v`](/Users/guweigang/Source/vphpx/vslim/src/app_dispatch_api.v)
- [`src/app_assembly.v`](/Users/guweigang/Source/vphpx/vslim/src/app_assembly.v)
- [`src/app_pipeline.v`](/Users/guweigang/Source/vphpx/vslim/src/app_pipeline.v)
- [`src/app_bootstrap.v`](/Users/guweigang/Source/vphpx/vslim/src/app_bootstrap.v)
- [`src/app_modules.v`](/Users/guweigang/Source/vphpx/vslim/src/app_modules.v)
- [`src/app_services.v`](/Users/guweigang/Source/vphpx/vslim/src/app_services.v)

这一层对 PHP userland 暴露：

- `dispatch*()`
- `handle()`
- `bootstrap()`
- `bootstrapFile()`
- `before()/middleware()/after()`
- `register()/boot()/module()`
- container / logger / clock / cache / event service graph

### HTTP Kernel

文件：

- [`src/app_kernel.v`](/Users/guweigang/Source/vphpx/vslim/src/app_kernel.v)
- [`src/app_execution_kernel.v`](/Users/guweigang/Source/vphpx/vslim/src/app_execution_kernel.v)
- [`src/app_terminal.v`](/Users/guweigang/Source/vphpx/vslim/src/app_terminal.v)
- [`src/app_middleware_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/app_middleware_runtime.v)

这里处理的是一次请求的通用骨架：

- request scope
- app boot ensure
- trace / request snapshot sync
- before phase
- middleware chain
- route or terminal execution
- after phase
- normalize / finalize / error fallback

### Route Runtime

文件：

- [`src/route.v`](/Users/guweigang/Source/vphpx/vslim/src/route.v)
- [`src/route_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/route_runtime.v)
- [`src/route_builder.v`](/Users/guweigang/Source/vphpx/vslim/src/route_builder.v)
- [`src/route_resource.v`](/Users/guweigang/Source/vphpx/vslim/src/route_resource.v)
- [`src/app_route_dispatch.v`](/Users/guweigang/Source/vphpx/vslim/src/app_route_dispatch.v)

这里处理：

- route match
- route param capture
- method semantics
- `resource()/singleton()` 扩展
- route terminal meta

### PSR Bridge

文件：

- [`src/app_psr_bridge.v`](/Users/guweigang/Source/vphpx/vslim/src/app_psr_bridge.v)
- [`src/psr_http.v`](/Users/guweigang/Source/vphpx/vslim/src/psr_http.v)

这里处理：

- PSR-7 request/response object
- PSR-15 middleware / request handler surface
- `VSlim\VHttpd\Request` 和 `ServerRequestInterface` 的互转

## Request Flow

一次 `dispatchRequest()` 的大致路径：

1. public facade 进入 request scope，并确保 app 已 boot
2. kernel 建立 trace / request context
3. route runtime 做匹配，产出 route handler 或 terminal meta
4. phase runtime 依次执行 before / standard middleware / after
5. terminal 层统一收敛 not found / method not allowed / error / fixed response
6. kernel finalize response，并把最终 request snapshot 同步回 `VSlim\VHttpd\Request`

## Boundary Rule

`VSlim` 目前对 legacy 语义的态度很明确：

- transport 边界保留 `VSlim\VHttpd\Request` / `VSlim\VHttpd\Response`
- 只要进入 PSR 世界，就按 PSR-7 / PSR-15 语义推进
- 不再为了旧逻辑保留额外 middleware / request 兼容分支

这也是为什么现在会把 kernel、route runtime、PSR bridge 分开：这样 transport 兼容层不会继续污染上层框架语义。
