--TEST--
php-worker websocket_upstream dispatches Feishu messages and card actions
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

$autoload = (getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd') . '/php/package/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = dirname(__DIR__) . '/vendor/autoload.php';
}
if (!is_file($autoload)) {
    echo "autoload_missing\n";
    exit;
}
require_once $autoload;

use VHttpd\Upstream\WebSocket\Feishu\Command;
use VHttpd\Upstream\WebSocket\Feishu\Event\CardActionEvent;
use VHttpd\Upstream\WebSocket\Feishu\Message\{AudioMessage, FileMessage, ImageMessage, MediaMessage, PostMessage, StickerMessage, TextMessage};
use VSlim\App\Feishu\AbstractBotHandler;
use VSlim\App\Feishu\BotApp;

$fixture = sys_get_temp_dir() . '/vhttpd_websocket_upstream_fixture_' . getmypid() . '.php';
file_put_contents($fixture, <<<'PHP'
<?php
declare(strict_types=1);
use VSlim\App\Feishu\BotAdapter;
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
$server = new VHttpd\PhpWorker\Server('/tmp/vhttpd_websocket_upstream_test.sock', $fixture);

$pingFrame = [
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
];
$ping = $server->dispatchRequest($pingFrame);

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

$actionFrame = [
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
];
$action = $server->dispatchRequest($actionFrame);

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

class FeishuTestHandler extends AbstractBotHandler
{
    public function onTextMessage(TextMessage $message): ?Command
    {
        if ($message->text() === 'explode') {
            throw new DomainException('callback failed');
        }
        return Command::replyText(text: 'received ' . $message->text(), message: $message);
    }

    public function onCardAction(CardActionEvent $event): ?Command
    {
        return Command::updateText(text: 'action ' . $event->actionTag(), event: $event);
    }

    public function onImageMessage(ImageMessage $message): ?Command
    {
        return Command::replyText($message, 'image:' . $message->imageKey());
    }

    public function onPostMessage(PostMessage $message): ?Command
    {
        return Command::replyText($message, 'post:' . $message->postContent()['zh_cn']['title']);
    }

    public function onFileMessage(FileMessage $message): ?Command
    {
        return Command::replyText($message, 'file:' . $message->fileName());
    }

    public function onAudioMessage(AudioMessage $message): ?Command
    {
        return Command::replyText($message, 'audio:' . $message->duration());
    }

    public function onMediaMessage(MediaMessage $message): ?Command
    {
        return Command::replyText($message, 'media:' . $message->imageKey());
    }

    public function onStickerMessage(StickerMessage $message): ?Command
    {
        return Command::replyText($message, 'sticker:' . $message->fileKey());
    }
}

$botFixture = $fixture . '.bot.php';
file_put_contents($botFixture, '<?php return new \\VSlim\\App\\Feishu\\BotApp(handler: new FeishuTestHandler());');

// Some apps explicitly include the package class even when VSlim is loaded.
$botPath = dirname($autoload, 2) . '/src/VSlim/App/Feishu/BotApp.php';
if (is_file($botPath)) {
    require_once $botPath;
}

$bot = require $botFixture;
$class = new ReflectionClass($bot);
echo $class->isInternal() === extension_loaded('vslim') ? "expected implementation\n" : "unexpected implementation\n";
echo $class->isFinal() && !$class->isReadOnly() ? "final class\n" : "unexpected class flags\n";
$property = $class->getProperty('handler');
echo $property->isPrivate() && $property->isReadOnly() ? 'private readonly ' : 'unexpected property flags ',
    $property->getType(), "\n";
if ($class->isInternal()) {
    $dispatch = $class->getAttributes(VHttpd\Attribute\Dispatchable::class)[0]->newInstance();
    if ($dispatch->kind !== 'websocket_upstream') {
        throw new LogicException('unexpected native dispatch kind');
    }
}
$ctor = new ReflectionMethod($bot, '__construct');
$handler = $ctor->getParameters()[0];
echo $handler->getName(), ':', $handler->getType(), "\n";
foreach (['handle', 'handle_websocket_upstream', 'handleWebSocketUpstream'] as $method) {
    $entry = new ReflectionMethod($bot, $method);
    $parameter = $entry->getParameters()[0];
    echo $entry->getName(), ' ', $parameter->getName(), ':', $parameter->getType(), ' -> ', $entry->getReturnType(), ' ',
        $bot->$method(frame: $pingFrame)['commands'][0]['text'], "\n";
}
try {
    new BotApp(handler: new stdClass());
} catch (TypeError) {
    echo "rejects wrong handler\n";
}
$copy = clone $bot;
$restored = unserialize(serialize($bot));
echo $copy->handle(frame: $pingFrame)['commands'][0]['text'], '|',
    $restored->handle(frame: $pingFrame)['commands'][0]['text'], "\n";

$botServer = new VHttpd\PhpWorker\Server('/tmp/vhttpd_feishu_bot_app_test.sock', $botFixture);
$botPing = $botServer->dispatchRequest($pingFrame);
$botAction = $botServer->dispatchRequest($actionFrame);
$unknown = $botServer->dispatchRequest(array_replace($pingFrame, [
    'event_type' => 'unsupported.event',
    'payload' => '{}',
]));
foreach ([$botPing, $botAction] as $reply) {
    echo $reply['mode'], '|', $reply['handled'] ? 'handled' : 'ignored', '|',
        $reply['commands'][0]['event'], '|', $reply['commands'][0]['text'], "\n";
}
echo $unknown['handled'] ? 'handled' : 'ignored', '|', count($unknown['commands']), "\n";
foreach ([
    'image' => ['image_key' => 'img_123'],
    'post' => ['zh_cn' => ['title' => 'notice']],
    'file' => ['file_name' => 'data.txt'],
    'audio' => ['duration' => 42],
    'media' => ['image_key' => 'img_video'],
    'sticker' => ['file_key' => 'sticker_123'],
] as $kind => $content) {
    $payload = json_decode($pingFrame['payload'], true, flags: JSON_THROW_ON_ERROR);
    $payload['event']['message']['message_type'] = $kind;
    $payload['event']['message']['content'] = json_encode($content, JSON_THROW_ON_ERROR);
    $reply = $botServer->dispatchRequest(array_replace($pingFrame, [
        'payload' => json_encode($payload, JSON_THROW_ON_ERROR),
    ]));
    echo $reply['handled'] ? 'handled' : 'ignored', '|', $reply['commands'][0]['text'], "\n";
}
$errorFrame = array_replace($pingFrame, ['payload' => str_replace('ping', 'explode', $pingFrame['payload'])]);
try {
    $bot->handle(frame: $errorFrame);
} catch (DomainException $error) {
    echo $error->getMessage(), "\n";
}
@unlink($botFixture);
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
expected implementation
final class
private readonly VSlim\App\Feishu\BotHandler
handler:VSlim\App\Feishu\BotHandler
handle frame:array -> array received ping
handle_websocket_upstream frame:array -> array received ping
handleWebSocketUpstream frame:array -> array received ping
rejects wrong handler
received ping|received ping
websocket_upstream|handled|send|received ping
websocket_upstream|handled|update|action button
ignored|0
handled|image:img_123
handled|post:notice
handled|file:data.txt
handled|audio:42
handled|media:img_video
handled|sticker:sticker_123
callback failed
