## VSlim Demo App Skeleton

如果你想直接看一套更接近应用目录的骨架入口，最短路径是：

1. 先跑 `skeleton_app.php --self-test`
2. 再读 [`examples/skeleton/README.md`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/README.md) 的扩展点速查
3. 如果目标是复制一个项目起点，继续读 [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)

```bash
php -d extension=./vslim.so vslim/examples/skeleton_app.php --self-test
```

这个例子直接用 `bootstrapDir(__DIR__ . '/skeleton')` 启动，并刻意演示：

- `app/Http/Controllers/*.php` 的简单 controller 自动绑定
- `app/Http/controllers.php` 的复杂 controller 显式绑定
- `app/Http/errors.php` 的应用级错误处理
- `app/Http/middleware.php` 的 HTTP middleware 装配
- `app/Modules/*.php` / `app/Providers/*.php` / `resources/views` 的组合

相关入口按用途分三层看最省时间：

- 示例骨架说明：
  [`examples/skeleton/README.md`](/Users/guweigang/Source/vphpx/vslim/examples/skeleton/README.md)
- 模板项目起点：
  [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)
- 骨架设计说明：
  [`docs/app/skeleton.md`](/Users/guweigang/Source/vphpx/vslim/docs/app/skeleton.md)

如果你不是想看示例，而是想直接复制一个最小项目起点，就不用先读这一页，直接去模板 README 即可。
模板现在已经把 `php -S` 的 `public/index.php` 和 `vhttpd/php-worker` 的 `public/worker.php` 都配好；
如果你要看“同一个 app 在两种 transport 下怎么跑”，优先读 [`templates/app/README.md`](/Users/guweigang/Source/vphpx/vslim/templates/app/README.md)。

`demo_app.php` 现在不再自己堆所有定义，而是作为一个薄入口去加载：

- `demo/bootstrap/app.php`
- `demo/bootstrap/providers.php`
- `demo/routes/web.php`
- `demo/routes/api.php`
- `demo/routes/debug.php`
- `demo/support.php`

推荐直接把这套结构当成项目骨架起点，然后在入口里这样启动：

```php
$app = (new VSlim\App())->bootstrapDir(__DIR__ . '/demo');
```

这样 `bootstrap/app.php` 负责总装配，provider 收服务绑定，routes 按语义拆分，入口文件只保留 worker / built-in server 的 transport 适配。

如果你不想写 `bootstrap/app.php`，现在也可以直接只保留 convention 文件：

- `config/app.toml`
- `bootstrap/runtime.php`
- `bootstrap/services.php`
- `bootstrap/errors.php`
- `bootstrap/providers.php`
- `bootstrap/modules.php`
- `bootstrap/middleware.php`
- `routes/*.php`
- `views/`

`bootstrapDir()` 会自动把这层骨架收起来。

如果你更喜欢应用层目录布局，现在也可以直接用：

- `app/Providers/*.php`
- `app/Modules/*.php`
- `app/Http/controllers.php`
- `app/Http/errors.php`
- `app/Http/routes/*.php`
- `app/Http/middleware.php`
- `app/Http/Controllers/*.php`
- `app/Http/Middleware/*.php`
- `resources/views`

`bootstrapDir()` 会把这层也当成默认 conventions。

推荐分工：

- `app/Http/Controllers/*.php` 放简单 `VSlim\Controller` 子类
- `app/Http/controllers.php` 放需要构造参数的 controller 绑定
- `app/Http/errors.php` 放应用级 not_found / error handler
- `app/Http/middleware.php` 负责真正注册 middleware

## VSlim LiveView Demo

如果想先看最短入门路径，可以先读 [docs/liveview/GETTING_STARTED.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/GETTING_STARTED.md)。

文件：

- `liveview_app.php`
- `views/live_counter_demo.html`
- `public/vphp_live.js`

这个 demo 展示的是当前最小 LiveView 闭环：

- HTTP 首屏 SSR
- `/live` websocket join / event / patch
- 浏览器端只识别 `vphp-click`、`vphp-submit`、`vphp-change`、`vphp-value-*`
- 浏览器端会自动 heartbeat，并在 websocket 断开后自动重连
- 浏览器 runtime 还支持 `vphp-debounce`、`vphp-disable-with` 和基础 loading 状态
- 服务端现在主推 `form('profile')->fill(...)->validate(...)` 这组 helper，用来把表单回显、校验和错误提示都留在服务端
- `VSlim\\Live\\Form` 还提供 `input()` / `error()` / `valid()` / `invalid()` / `reset()`，业务代码不用再手动拼 `error_` key
- 如果提交成功后要清掉表单回显，可以继续用 `forget_input()` / `forget_inputs()`，或者直接 `form(...)->forget(...)`
- `vhttpd` 配置已经启用 `websocket_dispatch = true`，LiveView 状态通过 `_vslim_live_session` metadata envelope 在 worker 之间传递，不再依赖 sticky worker websocket 会话

页面里有一个服务端计数器和一个表单标签输入框，所有更新都通过服务端重新渲染 fragment。
现在还额外展示了：

- 两个标签页之间通过 room/pubsub 同步计数
- `Sync Summary` 会把 room info 直接派发到 summary component，不经过整页 LiveView patch
- `Flash` 按钮触发服务端 `flash()`
- `Navigate` 按钮触发 LiveView 软导航
- `VSlim\Live\Component` 驱动的摘要卡片局部 patch
- profile 状态条现在也是一个独立的 `VSlim\Live\Component`
- 标签输入框会通过 `form('profile')->fill(...)->validate(...)` 做服务端回显和即时校验
- 现在 demo 的 profile 表单会同时校验 `label + notify_email`，并展示 chained form helper 与 `reset()` 的实际效果
- 保存成功后页面会保留输入值，同时把 profile 状态切到 `Saved` 并显示保存时间
- 组件现在同时支持 targeted event 和 targeted info，推荐主路径就是在工厂里直接返回已绑定组件，然后 `component(...)->patch_bound()`

如果用 `vhttpd + php-worker` 跑：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/liveview.toml
```

如果想顺手把 `vhttpd` 和 `php-worker` 的 stdout/stderr 一起落盘，建议这样启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/liveview.toml >> /tmp/vhttpd_vslim_liveview.stdout.log 2>&1
```

LiveView demo 入口本身也会往 `php://stderr` 打关键日志，同时还会旁路写入：

- `/tmp/vslim_liveview.worker.log`

所以如果 worker 再出问题，可以一起看：

```bash
tail -n 120 /tmp/vslim_liveview.worker.log
tail -n 120 /tmp/vhttpd_vslim_liveview.stdout.log
tail -n 120 /tmp/vhttpd_vslim_liveview.events.ndjson
ls -1t ~/Library/Logs/DiagnosticReports/php-*.ips | head -n 3
```

打开页面：

```text
http://127.0.0.1:19892/
```

元信息：

```bash
curl --noproxy '*' -s http://127.0.0.1:19892/meta
```

如果只想快速用 PHP 内建 server 看 HTTP 首屏入口：

```bash
php -d extension=/Users/guweigang/Source/vphpx/vslim/vslim.so -S 127.0.0.1:8092 /Users/guweigang/Source/vphpx/vslim/examples/liveview_app.php
```

页面地址：

```text
http://127.0.0.1:8092/
```

## k6 压测示例

脚本：`k6_demo.js`

```bash
k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js
```

可选环境变量：

```bash
BASE_URL=http://127.0.0.1:19888 API_TOKEN=demo-token k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js
```

单路由压测（定位内存增长）：

```bash
# 仅 hello
BASE_URL=http://127.0.0.1:19888 ROUTE_MODE=hello k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js

# 仅 api
BASE_URL=http://127.0.0.1:19888 API_TOKEN=demo-token ROUTE_MODE=api k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js

# 仅 forms
BASE_URL=http://127.0.0.1:19888 ROUTE_MODE=forms k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js

# 仅 health
BASE_URL=http://127.0.0.1:19888 ROUTE_MODE=health k6 run /Users/guweigang/Source/vphpx/vslim/examples/k6_demo.js
```

## 性能基线（本地实测）

测试环境：

- 机器：MacBook Air M2（16 GB）
- worker：4 进程（`worker.pool_size = 4`）
- 时长：50 秒
- 脚本：`k6_demo.js`（mixed_routes 场景，30 VUs 峰值）

结果（关闭 `VSLIM_TRACE_MEM` 后）：

- `http_reqs`: `3998.71 req/s`
- `http_req_duration`: `avg 3.89ms`, `p95 7.42ms`, `p99 11.47ms`
- `http_req_failed`: `0.00%`
- `server_error_rate`: `0.00%`

说明：

- 开启 `VSLIM_TRACE_MEM` 会带来可观开销，QPS 与延迟都会变差。
- 建议线上默认关闭 trace，仅在诊断时按需打开（并设置较大的采样间隔）。

## 静态资源（Assets）验证

`vslim-demo.toml` 已启用：

- `prefix = /assets`
- `root = /Users/guweigang/Source/vphpx/vslim/examples/public`

快速验证：

```bash
curl --noproxy '*' -i http://127.0.0.1:19888/assets/hello.txt
curl --noproxy '*' -I http://127.0.0.1:19888/assets/app.js
```

## Demo 一键验收

脚本：`verify_demo.sh`

用途：

- 端到端验证 demo app 的关键链路
- 覆盖 `health / hello / api / forms / debug(routes/conflicts)`

运行前先确保 `vhttpd` 已按 `vslim-demo.toml` 启动并监听 `127.0.0.1:19888`。

```bash
/Users/guweigang/Source/vphpx/vslim/examples/verify_demo.sh
```

或指定目标地址：

```bash
BASE_URL=http://127.0.0.1:19888 /Users/guweigang/Source/vphpx/vslim/examples/verify_demo.sh
```

也可以使用 `vslim/Makefile` 的快捷目标：

```bash
make -C /Users/guweigang/Source/vphpx/vslim demo-self-test
make -C /Users/guweigang/Source/vphpx/vslim demo-verify
```

## Config 用法示例

文件：

- `config_usage.php`
- `config_usage.toml`
- `config_usage.toml` 里的配置值现在支持 shell 风格环境占位符，例如 `${env.VSLIM_EXAMPLE_APP_NAME:-vslim-demo}`、`${env.bool.VSLIM_EXAMPLE_APP_DEBUG:-true}`、`${env.int.VSLIM_EXAMPLE_APP_PORT:-19888}`

运行：

```bash
php -d extension=/Users/guweigang/Source/vphpx/vslim/vslim.so /Users/guweigang/Source/vphpx/vslim/examples/config_usage.php
```

## VSlim Ollama Stream Demo

文件：

- `ollama_stream_app.php`
- `ollama.toml`

这个 demo 的特点是：

- 放在 `vslim/examples/` 下
- `ollama_stream_app.php` 只做入口和路由注册
- `VSlim\Stream\OllamaClient` / `VSlim\Stream\NdjsonDecoder` / `VSlim\Stream\SseEncoder` 是正式的扩展侧流式组件
- `ollama_stream_app.php` 里的 route 现在优先走 `VSlim\Stream\Factory`
- `ollama.toml` 现在继续使用通用 `vhttpd/php/package/bin/php-worker`
- `PhpWorker\\Server` 已修复对 `\\VSlim\\App` bootstrap 的识别，不再 fallback 到内置 demo app
- `/health`、`/meta`、`/` 页面都走 `VSlim\App`
- `/ollama/text` 和 `/ollama/sse` 由 VSlim route 直接返回 `VSlim\Stream\Response`
- 默认连本地 Ollama，也支持通过环境变量切到远端兼容端点

启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/ollama.toml
```

打开最小前端页面：

```bash
open http://127.0.0.1:19889/
```

或直接在浏览器访问：

```text
http://127.0.0.1:19889/
```

查看元信息：

```bash
curl --noproxy '*' -s http://127.0.0.1:19889/meta
```

文本流：

```bash
curl --noproxy '*' -N "http://127.0.0.1:19889/ollama/text?prompt=Explain%20VSlim%20streaming"
```

SSE：

```bash
curl --noproxy '*' -N "http://127.0.0.1:19889/ollama/sse?prompt=Explain%20VSlim%20streaming"
```

## VSlim Stream Factory Demo

文件：

- `stream_factory_app.php`
- `stream_factory.toml`
- `views/stream_factory.html`
- `public/stream_factory_app.js`

这个 demo 把四个入口放在同一个页面里：

- `/stream/text`
- `/stream/sse`
- `/ollama/text`
- `/ollama/sse`

启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/stream_factory.toml
```

打开页面：

```text
http://127.0.0.1:19890/
```

## vhttpd Stream Dispatch MVP

文件：

- `/Users/guweigang/Source/vhttpd/examples/stream-dispatch-app.php`
- `/Users/guweigang/Source/vhttpd/examples/config/stream-dispatch.toml`

这个示例用来验证 Stream phase 2：

- HTTP 连接留在 `vhttpd`
- worker 只处理短生命周期的 `open / next / close`
- `worker.pool_size = 1` 也能完整跑完一个 SSE 流
- 当前示例是 synthetic SSE counter，适合先验证 transport 和 state 循环
- 示例现在直接使用 `VPhp\VSlim\Stream\Factory::dispatchSse(...)`

启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vhttpd/examples/config/stream-dispatch.toml
```

验证：

```bash
curl --noproxy '*' http://127.0.0.1:19893/meta
curl --noproxy '*' -N http://127.0.0.1:19893/events/sse
```

## VSlim WebSocket Demo

文件：

- `websocket_app.php`
- `websocket.toml`
- `websocket_dispatch.toml`
- `public/websocket_app.js`

这个 demo 的结构是：

- `VSlim\App` 同时处理 HTTP 和 WebSocket
- `/ws` 通过 `$app->websocket('/ws', $handler)` 注册
- `/` 返回最小前端页面
- `/ws` 由 `vhttpd` 做 upgrade，消息处理走扩展原生 websocket handler
- 页面现在是一个最小房间聊天页，支持 `room` / `user` 参数
- 房间 fanout 不再依赖 worker 进程内状态，而是通过 `$conn->join()` / `$conn->broadcast()` 走 `vhttpd` 本机 websocket hub
- 示例还会把 `user` / `presence` 写进连接 metadata，后续消息不必每次都重复携带完整用户信息
- 在房间里发送 `/who` 时，示例会直接根据 `$frame['room_counts']` 和 `$frame['presence_users']` 返回在线人数与成员列表
- `websocket.toml` 默认用了 `worker.pool_size = 4`，避免单个 WebSocket 会话占满唯一 worker

启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/websocket.toml
```

打开页面：

```text
http://127.0.0.1:19891/
```

如果你要试验 phase 2 的 websocket message-dispatch 模式，用这份配置：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/websocket_dispatch.toml
```

打开页面：

```text
http://127.0.0.1:19892/
```

这份 phase 2 示例默认就是 `worker.pool_size = 1`，目的是直接证明：
连接可以长期留在 `vhttpd`，而消息处理只在需要时短暂占用单个 PHP worker。
这条链路已经实际验证过：两个浏览器客户端在单 worker 下仍然可以同时连接、互发消息并执行 `/who`。

## VSlim Native MCP Demo

文件：

- `mcp_app.php`
- `mcp.toml`
- `../docs/mcp/runbook.md`

这个 demo 的结构是：

- `http => VSlim\App`
- `mcp => VSlim\Mcp\App`
- 不把 MCP 强绑进 `VSlim\App`
- 但直接通过 `vslim.so` 提供原生 MCP handler

启动：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/mcp.toml
```

验证：

```bash
curl --noproxy '*' http://127.0.0.1:19896/meta | jq .
curl --noproxy '*' -s \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05"}}' \
  http://127.0.0.1:19896/mcp | jq .
```

更完整的手工验证步骤见：

- [`/Users/guweigang/Source/vphpx/vslim/docs/mcp/runbook.md`](/Users/guweigang/Source/vphpx/vslim/docs/mcp/runbook.md)

POST JSON：

```bash
curl --noproxy '*' -N \
  -H 'Content-Type: application/json' \
  -d '{"prompt":"Give me three short bullets about VSlim","model":"qwen2.5:7b-instruct"}' \
  http://127.0.0.1:19889/ollama/text
```

离线调试或测试时，可指定 fixture，避免真实访问 Ollama：

```bash
cp /Users/guweigang/Source/vphpx/vslim/examples/ollama.toml /tmp/vslim-ollama-fixture.toml
# 把 /tmp/vslim-ollama-fixture.toml 里的 worker.env.OLLAMA_STREAM_FIXTURE 改成：
# /Users/guweigang/Source/vphpx/vslim/tests/fixtures/ollama_stream_fixture.ndjson
# 然后启动：
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /tmp/vslim-ollama-fixture.toml
```

`ollama_stream_app.php` 和 `stream_factory_app.php` 现在都会优先走
`VSlim\Stream\OllamaClient::fromApp($app)`。
如果应用本身加载了 `config/` 目录，可以直接通过 `stream.ollama.*` 配置驱动；
如果只是像这里一样用独立 demo 入口跑 `vhttpd` worker，则会继续兼容读取
`worker.env` 里的 `OLLAMA_*`。
