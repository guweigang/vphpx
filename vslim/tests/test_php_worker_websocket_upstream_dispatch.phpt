--TEST--
php-worker websocket_upstream normalizes feishu text messages into send commands
--SKIPIF--
<?php
$fixture = sys_get_temp_dir() . '/vhttpd_websocket_upstream_fixture_' . getmypid() . '.php';
$ok = @file_put_contents($fixture, '<?php return [];');
if ($ok === false) {
    print 'skip';
}
@unlink($fixture);
?>
--FILE--
<?php
declare(strict_types=1);

$autoload = dirname(__DIR__, 3) . '/vhttpd/php/package/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = dirname(__DIR__) . '/vendor/autoload.php';
}
if (!is_file($autoload)) {
    echo "autoload_missing\n";
    exit;
}
require_once $autoload;

$fixture = sys_get_temp_dir() . '/vhttpd_websocket_upstream_fixture_' . getmypid() . '.php';
file_put_contents($fixture, <<<'PHP'
<?php
declare(strict_types=1);
use VPhp\VSlim\App\Feishu\BotAdapter;
return [
    'websocket_upstream' => static function (array $frame): array {
        $message = BotAdapter::parseTextMessage($frame);
        if ($message !== null) {
            $text = trim((string) ($message['text'] ?? ''));
            if ($text === '' || $text === 'hello') {
                return ['handled' => false, 'commands' => []];
            }

            if ($text === 'ping' || $text === '/ping') {
                $command = BotAdapter::replyTextCommand($frame, 'pong');
            } elseif (str_starts_with($text, '/vhttpd ')) {
                $command = BotAdapter::replyTextCommand(
                    $frame,
                    sprintf(
                        'vhttpd websocket upstream demo (%s): %s',
                        (string) ($message['instance'] ?? 'main'),
                        trim(substr($text, strlen('/vhttpd '))),
                    ),
                );
            } elseif ($text === '/card') {
                $command = BotAdapter::buildInteractiveCommand($frame, [
                    'config' => ['wide_screen_mode' => true],
                    'header' => [
                        'title' => [
                            'tag' => 'plain_text',
                            'content' => sprintf(
                                'vhttpd demo card (%s)',
                                (string) ($message['instance'] ?? 'main'),
                            ),
                        ],
                    ],
                    'elements' => [
                        [
                            'tag' => 'markdown',
                            'content' => 'Click the button to trigger a callback update.',
                        ],
                        [
                            'tag' => 'action',
                            'actions' => [
                                [
                                    'tag' => 'button',
                                    'text' => [
                                        'tag' => 'plain_text',
                                        'content' => 'Approve',
                                    ],
                                    'type' => 'primary',
                                    'value' => [
                                        'action' => 'approve',
                                    ],
                                ],
                            ],
                        ],
                    ],
                ]);
            } else {
                return ['handled' => false, 'commands' => []];
            }
            if ($command === null) {
                return ['handled' => false, 'commands' => []];
            }
            return [
                'handled' => true,
                'commands' => [$command],
            ];
        }

        $action = BotAdapter::parseCardAction($frame);
        if ($action === null) {
            return ['handled' => false, 'commands' => []];
        }

        $actionTag = (string) ($action['action_tag'] ?? '');
        if ($actionTag === '') {
            return ['handled' => false, 'commands' => []];
        }
        $actionValue = $action['action_value'] ?? null;
        $actionName = '';
        if (is_array($actionValue)) {
            $actionName = trim((string) ($actionValue['action'] ?? $actionValue['value'] ?? ''));
        } elseif (is_string($actionValue)) {
            $actionName = trim($actionValue);
        }
        if ($actionName === '') {
            $actionName = $actionTag;
        }
        $command = BotAdapter::buildUpdateInteractiveCommand($frame, [
            'config' => ['wide_screen_mode' => true],
            'header' => [
                'title' => [
                    'tag' => 'plain_text',
                    'content' => 'vhttpd card action',
                ],
            ],
            'elements' => [
                [
                    'tag' => 'markdown',
                    'content' => sprintf(
                        'vhttpd card action (%s): %s',
                        (string) ($action['instance'] ?? 'main'),
                        $actionName,
                    ),
                ],
            ],
        ]);
        if ($command === null) {
            return ['handled' => false, 'commands' => []];
        }
        return [
            'handled' => true,
            'commands' => [$command],
        ];
    },
];
PHP);
$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_websocket_upstream_test.sock', $fixture);

$ping = $server->dispatchRequest([
    'id' => 'upstream-1',
    'mode' => 'websocket_upstream',
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'trace_id' => 'trace-1',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_ping',
    'target_type' => 'chat_id',
    'target' => 'oc_ping',
    'metadata' => ['source' => 'phpt'],
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_ping',
                'chat_id' => 'oc_ping',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'ping'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$demo = $server->dispatchRequest([
    'id' => 'upstream-2',
    'mode' => 'websocket_upstream',
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'openclaw',
    'trace_id' => 'trace-2',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_demo',
    'target_type' => 'chat_id',
    'target' => 'oc_demo',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_demo',
                'chat_id' => 'oc_demo',
                'message_type' => 'text',
                'content' => json_encode(['text' => '/vhttpd hello'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$ignored = $server->dispatchRequest([
    'id' => 'upstream-3',
    'mode' => 'websocket_upstream',
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'trace_id' => 'trace-3',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_ignore',
    'target_type' => 'chat_id',
    'target' => 'oc_ignore',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_ignore',
                'chat_id' => 'oc_ignore',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'hello'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$card = $server->dispatchRequest([
    'id' => 'upstream-3b',
    'mode' => 'websocket_upstream',
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'trace_id' => 'trace-3b',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_card_send',
    'target_type' => 'chat_id',
    'target' => 'oc_card_send',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_card_send',
                'chat_id' => 'oc_card_send',
                'message_type' => 'text',
                'content' => json_encode(['text' => '/card'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$action = $server->dispatchRequest([
    'id' => 'upstream-4',
    'mode' => 'websocket_upstream',
    'event' => 'action',
    'provider' => 'feishu',
    'instance' => 'main',
    'trace_id' => 'trace-4',
    'event_type' => 'card.action.trigger',
    'message_id' => '',
    'target_type' => 'open_message_id',
    'target' => 'om_card_1',
    'metadata' => [
        'event_kind' => 'action',
        'open_message_id' => 'om_card_1',
        'action_tag' => 'button',
    ],
    'payload' => json_encode([
        'schema' => '2.0',
        'header' => [
            'event_id' => 'evt_card_1',
            'event_type' => 'card.action.trigger',
        ],
        'event' => [
            'open_message_id' => 'om_card_1',
            'action' => [
                'tag' => 'button',
                'value' => [
                    'action' => 'approve',
                ],
            ],
        ],
        'token' => 'verification_token',
    ], JSON_UNESCAPED_UNICODE),
]);

echo ($ping['mode'] ?? ''), "\n";
echo (($ping['handled'] ?? false) ? 'handled' : 'ignored'), "\n";
echo ($ping['commands'][0]['event'] ?? ''), "\n";
echo ($ping['commands'][0]['text'] ?? ''), "\n";
echo ($ping['commands'][0]['target'] ?? ''), "\n";
echo ($ping['commands'][0]['metadata']['source'] ?? ''), "\n";

echo ($demo['commands'][0]['instance'] ?? ''), "\n";
echo ($demo['commands'][0]['text'] ?? ''), "\n";

echo (($ignored['handled'] ?? false) ? 'handled' : 'ignored'), "\n";
echo count($ignored['commands'] ?? []), "\n";
echo (($card['handled'] ?? false) ? 'handled' : 'ignored'), "\n";
echo ($card['commands'][0]['event'] ?? ''), "\n";
echo ($card['commands'][0]['message_type'] ?? ''), "\n";
echo (str_contains((string) ($card['commands'][0]['content'] ?? ''), 'Approve') ? 'card_send_ok' : 'card_send_bad'), "\n";
echo (($action['handled'] ?? false) ? 'handled' : 'ignored'), "\n";
echo ($action['commands'][0]['event'] ?? ''), "\n";
echo ($action['commands'][0]['target_type'] ?? ''), "\n";
echo ($action['commands'][0]['target'] ?? ''), "\n";
echo (str_contains((string) ($action['commands'][0]['content'] ?? ''), 'approve') ? 'card_update_ok' : 'card_update_bad'), "\n";
@unlink($fixture);
?>
--EXPECT--
websocket_upstream
handled
send
pong
oc_ping
phpt
openclaw
vhttpd websocket upstream demo (openclaw): hello
ignored
0
handled
send
interactive
card_send_ok
handled
update
token
verification_token
card_update_ok
