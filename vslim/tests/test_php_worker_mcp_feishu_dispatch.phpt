--TEST--
php-worker mcp can expose Feishu MCP tools only when explicitly enabled
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
$probe = sys_get_temp_dir() . '/vphp_worker_mcp_feishu_probe_' . getmypid() . '.sock';
@unlink($probe);
$errno = 0;
$errstr = '';
$server = @stream_socket_server('unix://' . $probe, $errno, $errstr);
if (!is_resource($server)) {
    print 'skip';
}
if (is_resource($server)) {
    fclose($server);
}
if (is_file($probe)) {
    @unlink($probe);
}
?>
--FILE--
<?php
$autoload = dirname(__DIR__, 3) . '/vhttpd/php/package/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = dirname(__DIR__) . '/vendor/autoload.php';
}
if (!is_file($autoload)) {
    echo "autoload_missing\n";
    exit;
}
require_once $autoload;

$fixture = dirname(__DIR__, 3) . '/vhttpd/examples/mcp-feishu-app.php';
$adminSocket = '/tmp/vhttpd_mcp_feishu_admin_' . getmypid() . '.sock';
@unlink($adminSocket);
putenv('VHTTPD_INTERNAL_ADMIN_SOCKET=' . $adminSocket);
$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_mcp_feishu_dispatch_test.sock', $fixture);
$responder = static function (string $path): void {
    @unlink($path);
    $server = stream_socket_server('unix://' . $path, $errno, $errstr);
    if (!is_resource($server)) {
        exit(1);
    }
    $conn = stream_socket_accept($server, 5);
    if (!is_resource($conn)) {
        fclose($server);
        @unlink($path);
        exit(2);
    }
    $readExactly = static function ($conn, int $len): ?string {
        $buf = '';
        while (strlen($buf) < $len) {
            $chunk = fread($conn, $len - strlen($buf));
            if ($chunk === '' || $chunk === false) {
                return null;
            }
            $buf .= $chunk;
        }
        return $buf;
    };
    $header = $readExactly($conn, 4);
    $size = unpack('Nlen', (string) $header)['len'] ?? 0;
    $payload = $size > 0 ? $readExactly($conn, (int) $size) : '';
    $request = is_string($payload) ? json_decode($payload, true) : null;
    $instance = trim((string) (($request['query']['instance'] ?? '')));
    $chatType = trim((string) (($request['query']['chat_type'] ?? '')));
    $rows = [
        [
            'instance' => 'main',
            'chat_id' => 'oc_demo',
            'chat_type' => 'p2p',
            'target_type' => 'chat_id',
            'target' => 'oc_demo',
            'last_message_id' => 'om_1',
            'last_message_type' => 'text',
            'last_event_type' => 'im.message.receive_v1',
            'last_sender_id' => 'ou_1',
            'last_create_time' => '1710000001',
            'last_received_at' => 1710000001,
            'seen_count' => 2,
        ],
        [
            'instance' => 'mac',
            'chat_id' => 'oc_group',
            'chat_type' => 'group',
            'target_type' => 'chat_id',
            'target' => 'oc_group',
            'last_message_id' => 'om_2',
            'last_message_type' => 'post',
            'last_event_type' => 'im.message.receive_v1',
            'last_sender_id' => 'ou_2',
            'last_create_time' => '1710000002',
            'last_received_at' => 1710000002,
            'seen_count' => 1,
        ],
    ];
    $rows = array_values(array_filter($rows, static function (array $row) use ($instance, $chatType): bool {
        if ($instance !== '' && $row['instance'] !== $instance) {
            return false;
        }
        if ($chatType !== '' && $row['chat_type'] !== $chatType) {
            return false;
        }
        return true;
    }));
    $body = json_encode(['chats' => $rows, 'count' => count($rows)], JSON_UNESCAPED_UNICODE);
    $response = json_encode([
        'status' => 200,
        'headers' => ['content-type' => 'application/json; charset=utf-8'],
        'body' => $body,
    ], JSON_UNESCAPED_UNICODE);
    fwrite($conn, pack('N', strlen((string) $response)) . $response);
    fclose($conn);
    fclose($server);
    @unlink($path);
    exit(0);
};

$childPid = 0;
if (function_exists('pcntl_fork')) {
    $childPid = pcntl_fork();
    if ($childPid === 0) {
        $responder($adminSocket);
    }
} else {
    echo "pcntl_missing\n";
    exit;
}

$deadline = microtime(true) + 2.0;
while (microtime(true) < $deadline) {
    clearstatcache(true, $adminSocket);
    if (is_file($adminSocket)) {
        break;
    }
    usleep(10_000);
}

$feishuListChats = $server->dispatchRequest([
    'id' => 'req-feishu-list-chats',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":32,"method":"tools/call","params":{"name":"feishu.list_chats","arguments":{"instance":"main"}}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":32,"method":"tools/call","params":{"name":"feishu.list_chats","arguments":{"instance":"main"}}}',
]);
if ($childPid > 0 && function_exists('pcntl_waitpid')) {
    pcntl_waitpid($childPid, $status);
}

$feishuSend = $server->dispatchRequest([
    'id' => 'req-feishu-send',
    'mode' => 'mcp',
    'event' => 'message',
    'http_method' => 'POST',
    'path' => '/mcp',
    'protocol_version' => '2025-11-05',
    'headers' => ['mcp-protocol-version' => '2025-11-05', 'content-type' => 'application/json'],
    'body' => '{"jsonrpc":"2.0","id":31,"method":"tools/call","params":{"name":"feishu.send_text","arguments":{"chat_id":"oc_demo","text":"hello feishu","instance":"main"}}}',
    'jsonrpc_raw' => '{"jsonrpc":"2.0","id":31,"method":"tools/call","params":{"name":"feishu.send_text","arguments":{"chat_id":"oc_demo","text":"hello feishu","instance":"main"}}}',
]);

echo ($feishuListChats['status'] ?? 0), "\n";
$feishuListChatsBody = json_decode((string) ($feishuListChats['body'] ?? ''), true);
echo ($feishuListChatsBody['result']['content'][0]['text'] ?? ''), "\n";
echo ($feishuListChatsBody['result']['count'] ?? 0), "\n";
echo ($feishuListChatsBody['result']['chats'][0]['instance'] ?? ''), "\n";
echo ($feishuListChatsBody['result']['chats'][0]['chat_id'] ?? ''), "\n";
echo ($feishuListChatsBody['result']['chats'][0]['chat_type'] ?? ''), "\n";

echo ($feishuSend['status'] ?? 0), "\n";
$feishuSendBody = json_decode((string) ($feishuSend['body'] ?? ''), true);
echo ($feishuSendBody['result']['content'][0]['text'] ?? ''), "\n";
$feishuCommands = is_array($feishuSend['commands'] ?? null) ? $feishuSend['commands'] : [];
echo (count($feishuCommands) > 0 ? "commands_present\n" : "commands_missing\n");
echo ($feishuCommands[0]['provider'] ?? ''), "\n";
echo ($feishuCommands[0]['target_type'] ?? ''), "\n";
echo ($feishuCommands[0]['target'] ?? ''), "\n";
echo ($feishuCommands[0]['text'] ?? ''), "\n";
putenv('VHTTPD_INTERNAL_ADMIN_SOCKET');
?>
--EXPECT--
200
found 1 feishu chat(s)
1
main
oc_demo
p2p
200
queued feishu text message
commands_present
feishu
chat_id
oc_demo
hello feishu
