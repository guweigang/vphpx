--TEST--
php-worker keeps Feishu, HTTP and MCP dispatch independent after a handler exception
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo 'skip vslim extension missing';
}
?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';

$entry = tempnam(sys_get_temp_dir(), 'vslim-feishu-worker-');
file_put_contents($entry, <<<'PHP'
<?php
use VHttpd\Upstream\WebSocket\Feishu\Command;
use VHttpd\Upstream\WebSocket\Feishu\Message\TextMessage;
use VSlim\App\Feishu\AbstractBotHandler;
use VSlim\App\Feishu\BotApp;

$http = new VSlim\App();
$http->get('/health', static fn () => 'http ok');

return [
    'http' => $http,
    'mcp' => new VSlim\Mcp\App(serverInfo: ['name' => 'feishu-worker']),
    'websocket_upstream' => new BotApp(handler: new class extends AbstractBotHandler {
        public function onTextMessage(TextMessage $message): ?Command
        {
            return match ($message->text()) {
                'ignore' => null,
                'explode' => throw new DomainException('feishu callback failed'),
                default => Command::replyText($message, 'feishu ok'),
            };
        }
    }),
];
PHP);

try {
    $worker = new WorkerWireFixture($entry);
    $feishu = static fn (string $text): array => $worker->request([
        'id' => $text,
        'mode' => 'websocket_upstream',
        'provider' => 'feishu',
        'event' => 'message',
        'event_type' => 'im.message.receive_v1',
        'payload' => json_encode([
            'event' => [
                'message' => [
                    'chat_id' => 'oc_worker',
                    'message_type' => 'text',
                    'content' => json_encode(['text' => $text], JSON_THROW_ON_ERROR),
                ],
            ],
        ], JSON_THROW_ON_ERROR),
    ]);

    $ignored = $feishu('ignore');
    echo $ignored['event'], '|', (int) $ignored['handled'], '|', count($ignored['commands']), "\n";

    $error = $feishu('explode');
    echo $error['mode'], '|', $error['event'], '|', $error['id'], '|',
        $error['status'], '|', $error['error_class'], '|', $error['error'], "\n";

    $http = $worker->request(['id' => 'health', 'mode' => 'http', 'method' => 'GET', 'path' => '/health']);
    echo $http['id'], '|', $http['status'], '|', $http['body'], "\n";

    $mcp = $worker->request([
        'id' => 'mcp-init',
        'mode' => 'mcp',
        'protocol_version' => '2025-11-05',
        'jsonrpc_raw' => '{"jsonrpc":"2.0","id":1,"method":"initialize"}',
    ]);
    $mcpResult = json_decode($mcp['body'], true, flags: JSON_THROW_ON_ERROR);
    echo $mcp['mode'], '|', $mcp['id'], '|', $mcp['status'], '|', $mcpResult['result']['serverInfo']['name'], "\n";

    $reply = $feishu('ping');
    echo $reply['mode'], '|', $reply['id'], '|', $reply['commands'][0]['target'], '|', $reply['commands'][0]['text'], "\n";
} finally {
    unset($worker);
    unlink($entry);
}
?>
--EXPECT--
result|0|0
websocket_upstream|error|explode|500|DomainException|feishu callback failed
health|200|http ok
mcp|mcp-init|200|feishu-worker
websocket_upstream|ping|oc_worker|feishu ok
