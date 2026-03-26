# VSlim MCP Runbook

这页是 `VSlim\Mcp\App` 的手工验证 runbook。

目标是确认：

- `VSlim\App->mcp()` 组合入口正常
- `initialize`
- `Mcp-Session-Id`
- `GET /mcp` SSE session
- queued notification
- queued `sampling/createMessage`
- `/admin/runtime/mcp`

## Start

启动示例：

```bash
cd /Users/guweigang/Source/vhttpd
./vhttpd --config /Users/guweigang/Source/vphpx/vslim/examples/mcp.toml
```

默认端口：

- data plane: `http://127.0.0.1:19896`
- admin plane: `http://127.0.0.1:19996`

## Step 1: Check HTTP Side

```bash
curl --noproxy '*' http://127.0.0.1:19896/meta | jq .
```

预期包含：

- `name = "vslim-native-mcp-demo"`
- `mcp = "/mcp"`
- `native = true`

## Step 2: Initialize

```bash
curl --noproxy '*' -s \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -D /tmp/vslim_mcp_headers.txt \
  --data-binary '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-05","capabilities":{"sampling":{},"roots":{"listChanged":true}}}}' \
  http://127.0.0.1:19896/mcp | jq .
```

预期：

- `serverInfo.name = "vslim-native-mcp-demo"`
- `capabilities` 至少包含：
  - `logging`
  - `sampling`
  - `tools`
  - `resources`
  - `prompts`

## Step 3: Extract Session Id

```bash
SESSION_ID=$(awk '/^mcp-session-id:/ {print $2}' /tmp/vslim_mcp_headers.txt | tr -d '\r')
echo "$SESSION_ID"
```

## Step 4: Inspect Runtime Session

```bash
curl --noproxy '*' \
  "http://127.0.0.1:19996/admin/runtime/mcp?details=1&session_id=${SESSION_ID}" | jq .
```

只看 client capability 快照：

```bash
curl --noproxy '*' \
  "http://127.0.0.1:19996/admin/runtime/mcp?details=1&session_id=${SESSION_ID}" \
  | jq -r '.sessions[0].client_capabilities_json'
```

## Step 5: Open SSE Session

另开一个终端：

```bash
curl --noproxy '*' -N \
  -H 'Origin: http://127.0.0.1:19896' \
  -H "Mcp-Session-Id: ${SESSION_ID}" \
  http://127.0.0.1:19896/mcp
```

## Step 6: Verify Queued Notification

```bash
curl --noproxy '*' -s \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -H "Mcp-Session-Id: ${SESSION_ID}" \
  --data-binary '{"jsonrpc":"2.0","id":2,"method":"debug/notify","params":{"text":"hello native mcp"}}' \
  http://127.0.0.1:19896/mcp | jq .
```

预期：

- `POST /mcp` 立即返回 `{ "queued": true }`
- SSE 收到：

```text
event: message
data: {"jsonrpc":"2.0","method":"notifications/message",...}
```

## Step 7: Verify Queued Sampling

```bash
curl --noproxy '*' -s \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -H "Mcp-Session-Id: ${SESSION_ID}" \
  --data-binary '{"jsonrpc":"2.0","id":3,"method":"debug/sample","params":{"topic":"native runtime contract"}}' \
  http://127.0.0.1:19896/mcp | jq .
```

预期 SSE 收到：

```text
event: message
data: {"jsonrpc":"2.0","id":"sample-3","method":"sampling/createMessage",...}
```

## Step 8: Verify Native Capability Gating

当前示例里的 `debug/sample` 已经使用：

- `VSlim\Mcp\App::client_supports($frame, 'sampling')`
- `VSlim\Mcp\App::capability_error(...)`

所以缺少 `sampling` capability 时，会由原生 handler 自己返回 `409`。

先创建一个不声明 `sampling` 的 session：

```bash
curl --noproxy '*' -s \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -D /tmp/vslim_mcp_headers_no_sampling.txt \
  --data-binary '{"jsonrpc":"2.0","id":11,"method":"initialize","params":{"protocolVersion":"2025-11-05","capabilities":{"roots":{"listChanged":true}}}}' \
  http://127.0.0.1:19896/mcp | jq .
```

```bash
SESSION_ID_NO_SAMPLING=$(awk '/^mcp-session-id:/ {print $2}' /tmp/vslim_mcp_headers_no_sampling.txt | tr -d '\r')
echo "$SESSION_ID_NO_SAMPLING"
```

然后触发：

```bash
curl --noproxy '*' -i \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-05' \
  -H 'Origin: http://127.0.0.1:19896' \
  -H "Mcp-Session-Id: ${SESSION_ID_NO_SAMPLING}" \
  --data-binary '{"jsonrpc":"2.0","id":12,"method":"debug/sample","params":{"topic":"native gate"}}' \
  http://127.0.0.1:19896/mcp
```

预期：

- 状态码 `409`
- body:

```json
{"error":"Sampling capability required by app"}
```
