# VSlim WebSocket

`VSlim\WebSocket\App` 是扩展侧的原生 WebSocket handler。
它通常通过 `VSlim\App::websocket('/ws', $handler)` 挂到同一个 app 上。

它的职责很简单：

- 注册 `on_open()`、`on_message()`、`on_close()` 回调
- 对接 `vhttpd -> php-worker` 的 websocket frame 协议
- 提供扩展侧最小 websocket handler 组件

最小示例：

```php
$app = new VSlim\App();
$app->get('/health', fn () => (new VSlim\Vhttpd\Response(200, 'OK', 'text/plain; charset=utf-8'))->text('OK'));

$ws = (new VSlim\WebSocket\App())
    ->on_open(static fn ($conn, array $frame): string => 'connected')
    ->on_message(static function ($conn, string $message, array $frame): ?string {
        if ($message === 'bye') {
            $conn->close(1000, 'bye');
            return null;
        }
        return 'echo:' . $message;
    });

$app->websocket('/ws', $ws);
return $app;
```

group 里也可以直接挂：

```php
$group = $app->group('/chat');
$group->websocket('/room', $ws);
```

说明：

- `VSlim\App::websocket('/ws', ...)` 会按路径匹配 upgrade 请求
- `VSlim\RouteGroup::websocket('/room', ...)` 会自动拼上 group 前缀
- `on_open()` 返回字符串时，worker 会自动先 `accept`，再发送这段文本
- `on_message()` 返回字符串时，worker 会发送 text frame
- 如果你要主动关闭连接，可以直接调用 `$conn->close(...)`
- 传给 `on_open()` / `on_message()` / `on_close()` 的 `$frame` 现在会附带 `rooms`、`metadata`、`room_members`、`member_metadata`、`room_counts`、`presence_users` 快照
- `vhttpd` 侧的握手、ping/pong、frame 编解码由 V 的 `net.websocket` 处理

最小房间广播（推荐多 worker 场景）：

```php
$ws = new VSlim\WebSocket\App();

$ws->on_open(function ($conn, array $frame): string {
    $conn->join('lobby');
    return 'joined:lobby';
});

$ws->on_message(function ($conn, string $message, array $frame): ?string {
    $conn->broadcast('lobby', 'room:' . $message, 'text', $conn->id());
    return 'self:' . $message;
});
```

`Connection` 可用的本机 hub 方法：

- `join($room)`
- `leave($room)`
- `broadcast($room, $data, $opcode = 'text', $exceptId = '')`
- `sendTo($targetId, $data, $opcode = 'text')`
- `setMeta($key, $value)`
- `clearMeta($key)`
- `setPresence($value)`

`VSlim\WebSocket\App` 仍然保留这些进程内辅助方法：

- `remember($conn)`
- `forget($connOrId)`
- `join($room, $connOrId)`
- `leave($room, $connOrId)`
- `members($room)`
- `connection_ids()`
- `rooms_for($connOrId)`
- `send_to($connOrId, $data)`
- `broadcast($data, $room = '', $exceptId = '')`

这些方法更适合单 worker 或测试场景；如果你要走 `vhttpd` 的多 worker websocket 部署，优先使用 `$conn->join()` / `$conn->broadcast()` 这一组连接级 helper。

可运行示例：

- `examples/websocket_app.php`
- `examples/websocket.toml`
- `examples/public/websocket_app.js`

当前 demo 页面已经是一个最小房间聊天页：

- 连接时通过 query string 传 `room` / `user`
- `on_open()` 会把 `user` 写进连接 metadata，并标记 `presence=online`
- `on_open()` 里自动调用 `$conn->join($room)`
- `on_message()` 里通过 `$conn->broadcast(...)` 对同房间 fanout
- 如果消息体里没显式带 `user`，示例会直接从 `$frame['metadata']['user']` 取回
- 如果消息体是 `/who`，示例会直接读取 `$frame['room_counts']` 和 `$frame['presence_users']` 返回在线人数和成员列表
- 运行 demo 时建议使用 worker pool；单个 WebSocket 会话会占住一个 worker
- 当所有 worker 都被长连接占满时，`vhttpd` 会优先快速返回容量不足，而不是把新请求无期限挂住
