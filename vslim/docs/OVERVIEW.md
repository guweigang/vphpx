# VSlim Overview

这页是 `VSlim` 面向官网和文档首页的总览页。

如果只想先回答这几个问题：

- `VSlim` 是什么？
- 它和 `vphp`、`vhttpd` 的关系是什么？
- 它支持哪些应用形态？
- 先看哪几页最有效？

先看这页就够了。

## Product Definition

`VSlim` 是一个运行在 `vphp` 之上的极简 PHP 框架，重点不是传统 MVC 大而全，而是：

- 保持小而直接的 app model
- 给 HTTP / stream / WebSocket / MCP 提供统一应用入口
- 让 PHP 更自然地承接 AI / agent / streaming 场景

一句话定义：

- `VSlim` = 一个受 Slim 启发、面向 AI 场景的极简 PHP 框架

## Stack Position

在整套技术栈里，它位于中间层：

- `vphp`
  - 语言桥和 Zend Binding
- `vslim`
  - 应用框架层
- `vhttpd`
  - transport / runtime 层

也就是说：

- `vphp` 解决“V 和 PHP 怎么互通”
- `vslim` 解决“应用怎么写”
- `vhttpd` 解决“应用怎么跑”

这里要特别注意一层边界：

- `VSlim` 不是 web server
- `VSlim` 也不要求必须跑在 `vhttpd` 上

你可以把它接在不同上游之下：

- PHP built-in server
  - 适合本地开发 / demo
- `vhttpd` + php-worker
  - 适合当前主线 runtime / worker 集成
- nginx / Apache / Caddy + PHP-FPM
  - 适合传统部署

区别主要在 transport/runtime，不在框架内核：

- 上游负责：
  - socket
  - TLS
  - keep-alive
  - process / worker model
  - static files / reverse proxy
- `VSlim` 负责：
  - route
  - middleware
  - controller
  - PSR bridge
  - response normalization

当前推荐的 HTTP 语义理解是：

- `VSlim\Vhttpd\Request/Response`
  - transport-friendly facade
  - 适合 worker / built-in server / demo 边界
- `Psr\Http\Message\ServerRequestInterface` / `ResponseInterface`
  - 框架内部更标准的 request/response 契约

## Core App Shapes

`VSlim` 当前最重要的应用形态有：

- `VSlim\App`
  - 普通 HTTP app
- `VSlim\Stream\Response` / `VSlim\Stream\Factory`
  - stream app / SSE / text stream
- `VSlim\WebSocket\App`
  - websocket app
- `VSlim\Mcp\App`
  - MCP app

如果不装扩展、只走 Composer package，对应 pure PHP 入口是：

- `VPhp\VSlim\App`
- `VPhp\VSlim\Stream\*`
- `VPhp\VSlim\WebSocket\App`
- `VPhp\VSlim\Mcp\App`

## Main Capabilities

### HTTP App

`VSlim\App` 负责：

- 路由注册
- middleware / before / after phase middleware
- route group
- resource route
- dispatch / dispatch_envelope
- URL generation
- provider / module bootstrap
- HTTP kernel orchestration
- PSR-7 / PSR-15 bridge

入口文档：

- [app/README.md](/Users/guweigang/Source/vphpx/vslim/docs/app/README.md)
- [app/kernel.md](/Users/guweigang/Source/vphpx/vslim/docs/app/kernel.md)
- [app/skeleton.md](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)

### Stream

`VSlim\Stream` 负责：

- text stream
- SSE stream
- Ollama helper
- 和 `vhttpd` stream runtime 对接

入口文档：

- [stream/README.md](/Users/guweigang/Source/vphpx/vslim/docs/stream/README.md)
- [stream/factory.md](/Users/guweigang/Source/vphpx/vslim/docs/stream/factory.md)
- [stream/ollama.md](/Users/guweigang/Source/vphpx/vslim/docs/stream/ollama.md)

### WebSocket

`VSlim\WebSocket\App` 负责：

- `on_open`
- `on_message`
- `on_close`
- room / presence helper
- 和 `vhttpd` websocket transport 对接

入口文档：

- [websocket/README.md](/Users/guweigang/Source/vphpx/vslim/docs/websocket/README.md)

### MCP

`VSlim\Mcp\App` 负责：

- `initialize`
- `tools`
- `resources`
- `prompts`
- notification / queued message helper
- 和 `vhttpd` 的 MCP Streamable HTTP runtime 对接

入口文档：

- [mcp/README.md](/Users/guweigang/Source/vphpx/vslim/docs/mcp/README.md)
- [mcp/runbook.md](/Users/guweigang/Source/vphpx/vslim/docs/mcp/runbook.md)

## Integration Boundary

`VSlim` 和 `vhttpd` 的边界现在很明确：

- `VSlim`
  - 定义开发者写应用的形态
- `vhttpd`
  - 定义 transport/runtime surface

所以：

- `VSlim\App`
  是应用模型
- `vhttpd/php-worker`
  负责识别和调度这些 app

对应 worker / envelope 说明：

- [protocol.md](/Users/guweigang/Source/vphpx/vslim/docs/protocol.md)
- [integration/worker.md](/Users/guweigang/Source/vphpx/vslim/docs/integration/worker.md)

## Other Built-in Areas

除了主 app shape，`VSlim` 当前还有这些补充能力：

- request / response facade
  - [http/request.md](/Users/guweigang/Source/vphpx/vslim/docs/http/request.md)
  - [http/response.md](/Users/guweigang/Source/vphpx/vslim/docs/http/response.md)
- native PSR HTTP objects / factories
  - [http/psr-http.md](/Users/guweigang/Source/vphpx/vslim/docs/http/psr-http.md)
- config
  - [config/config.md](/Users/guweigang/Source/vphpx/vslim/docs/config/config.md)
- logger
  - [logger/logger.md](/Users/guweigang/Source/vphpx/vslim/docs/logger/logger.md)
- container
  - [container/container.md](/Users/guweigang/Source/vphpx/vslim/docs/container/container.md)
- PSR-7 bridge / worker integration
  - [psr7_bridge.md](/Users/guweigang/Source/vphpx/vslim/docs/psr7_bridge.md)
  - [integration/psr7.md](/Users/guweigang/Source/vphpx/vslim/docs/integration/psr7.md)
- PSR long-term roadmap
  - [psr-roadmap.md](/Users/guweigang/Source/vphpx/vslim/docs/psr-roadmap.md)
- ORM / View / Controller
  - [orm.md](/Users/guweigang/Source/vphpx/vslim/docs/orm.md)
  - [view/view.md](/Users/guweigang/Source/vphpx/vslim/docs/view/view.md)
    指令、表达式、变量路径三层语法；layout/include/helper/debug
  - [view/controller.md](/Users/guweigang/Source/vphpx/vslim/docs/view/controller.md)

## Recommended Reading Order

第一次接触 `VSlim`：

1. 先看这页
2. 再看 [README.md](/Users/guweigang/Source/vphpx/vslim/README.md)
3. 再看 [app/README.md](/Users/guweigang/Source/vphpx/vslim/docs/app/README.md)
4. 如果你想直接搭项目骨架，再看 [app/skeleton.md](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)

如果你关注 AI / stream：

1. [stream/README.md](/Users/guweigang/Source/vphpx/vslim/docs/stream/README.md)
2. [mcp/README.md](/Users/guweigang/Source/vphpx/vslim/docs/mcp/README.md)
3. [websocket/README.md](/Users/guweigang/Source/vphpx/vslim/docs/websocket/README.md)

如果你关注 `vhttpd` 集成：

1. [protocol.md](/Users/guweigang/Source/vphpx/vslim/docs/protocol.md)
2. [integration/worker.md](/Users/guweigang/Source/vphpx/vslim/docs/integration/worker.md)
