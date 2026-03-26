--TEST--
BotAdapter normalizes multiple feishu message types
--SKIPIF--
<?php
$fixture = sys_get_temp_dir() . '/vhttpd_feishu_adapter_fixture_' . getmypid() . '.php';
$ok = @file_put_contents($fixture, '<?php return [];');
if ($ok === false) {
    print 'skip';
}
@unlink($fixture);
?>
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VSlim/App/Feishu/BotAdapter.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/JsonShape.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Event.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Command.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Command/AbstractCommand.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Command/Factory.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Command/SendCommand.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Command/UpdateCommand.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/InteractiveCard.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/PostContent.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/CardActionValue.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/CardButton.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/CardMarkdown.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/CardActionBlock.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/PlainText.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Content/CardHeader.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Event/AbstractEvent.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Event/Factory.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Event/CardActionEvent.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/AbstractMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/Factory.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/TextMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/ImageMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/PostMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/FileMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/AudioMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/MediaMessage.php';
require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/VHttpd/Upstream/WebSocket/Feishu/Message/StickerMessage.php';

use VPhp\VHttpd\Upstream\WebSocket\Feishu\Command;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\CardActionValue;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\CardButton;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\CardActionBlock;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\CardMarkdown;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\CardHeader;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\InteractiveCard;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\PlainText;
use VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\PostContent;
use VPhp\VSlim\App\Feishu\BotAdapter;

$text = BotAdapter::parseMessage([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_text',
    'target_type' => 'chat_id',
    'target' => 'oc_text',
    'metadata' => [
        'chat_type' => 'group',
        'root_id' => 'om_root',
        'parent_id' => 'om_parent',
        'create_time' => '1710000000',
        'sender_id' => 'ou_sender',
        'sender_id_type' => 'open_id',
        'sender_tenant_key' => 'tenant_a',
    ],
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_text',
                'chat_id' => 'oc_text',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'ping'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$image = BotAdapter::parseMessage([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_image',
    'target_type' => 'chat_id',
    'target' => 'oc_image',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_image',
                'chat_id' => 'oc_image',
                'message_type' => 'image',
                'content' => json_encode(['image_key' => 'img_v2_123'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$post = BotAdapter::parseMessage([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_post',
    'target_type' => 'chat_id',
    'target' => 'oc_post',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_post',
                'chat_id' => 'oc_post',
                'message_type' => 'post',
                'content' => json_encode([
                    'zh_cn' => [
                        'title' => 'hello',
                        'content' => [
                            [
                                ['tag' => 'text', 'text' => 'world'],
                            ],
                        ],
                    ],
                ], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$cardAction = BotAdapter::parseCardAction([
    'event' => 'action',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'card.action.trigger',
    'target_type' => 'open_message_id',
    'target' => 'om_card_1',
    'metadata' => [
        'event_kind' => 'action',
        'event_id' => 'evt_card_1',
        'open_message_id' => 'om_card_1',
        'action_tag' => 'button',
        'token' => 'verification_token',
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
                    'ticket_id' => 't_1',
                ],
            ],
        ],
        'token' => 'verification_token',
    ], JSON_UNESCAPED_UNICODE),
]);

$textOnly = BotAdapter::parseTextMessage([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_text_only',
    'target_type' => 'chat_id',
    'target' => 'oc_text_only',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_text_only',
                'chat_id' => 'oc_text_only',
                'message_type' => 'text',
                'content' => json_encode(['text' => '/ping'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$imageText = BotAdapter::parseTextMessage([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_image_only',
    'target_type' => 'chat_id',
    'target' => 'oc_image_only',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_image_only',
                'chat_id' => 'oc_image_only',
                'message_type' => 'image',
                'content' => json_encode(['image_key' => 'img_ignore'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$imageCommand = BotAdapter::buildSendCommand([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_image_cmd',
    'target_type' => 'chat_id',
    'target' => 'oc_image_cmd',
    'metadata' => ['trace' => 'adapter-test'],
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_image_cmd',
                'chat_id' => 'oc_image_cmd',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'seed'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
], 'image', ['image_key' => 'img_send_1']);

$postCommand = BotAdapter::buildSendCommand([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_post_cmd',
    'target_type' => 'chat_id',
    'target' => 'oc_post_cmd',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_post_cmd',
                'chat_id' => 'oc_post_cmd',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'seed'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
], 'post', [], json_encode([
    'zh_cn' => [
        'title' => 'reply title',
        'content' => [
            [
                ['tag' => 'text', 'text' => 'reply body'],
            ],
        ],
    ],
], JSON_UNESCAPED_UNICODE));

$postHelperCommand = BotAdapter::buildPostCommand([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_post_helper',
    'target_type' => 'chat_id',
    'target' => 'oc_post_helper',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_post_helper',
                'chat_id' => 'oc_post_helper',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'seed'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
], [
    'zh_cn' => [
        'title' => 'post helper',
        'content' => [
            [
                ['tag' => 'text', 'text' => 'helper body'],
            ],
        ],
    ],
], 'uuid-post-1');

$interactiveHelperCommand = BotAdapter::buildInteractiveCommand([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_card_helper',
    'target_type' => 'chat_id',
    'target' => 'oc_card_helper',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_card_helper',
                'chat_id' => 'oc_card_helper',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'seed'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
], [
    'type' => 'template',
    'data' => [
        'template_id' => 'ctp_demo',
    ],
], 'uuid-card-1');

$interactiveUpdateCommand = BotAdapter::buildUpdateInteractiveCommand([
    'event' => 'action',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'card.action.trigger',
    'message_id' => '',
    'target_type' => 'open_message_id',
    'target' => 'om_card_1',
    'metadata' => [
        'event_kind' => 'action',
        'open_message_id' => 'om_card_1',
        'action_tag' => 'button',
        'token' => 'callback-token-1',
    ],
    'payload' => json_encode([
        'schema' => '2.0',
        'token' => 'callback-token-1',
        'header' => ['event_type' => 'card.action.trigger'],
        'event' => [
            'open_message_id' => 'om_card_1',
            'action' => [
                'tag' => 'button',
                'value' => [
                    'action' => 'approve',
                ],
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
], [
    'type' => 'template',
    'data' => [
        'template_id' => 'ctp_update',
    ],
], 'uuid-card-update-1');

$textObject = BotAdapter::parseTextMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'mac',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_obj_text',
    'target_type' => 'chat_id',
    'target' => 'oc_obj_text',
    'metadata' => [
        'trace' => 'object-message',
        'chat_type' => 'p2p',
        'sender_id' => 'ou_object_sender',
    ],
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_obj_text',
                'chat_id' => 'oc_obj_text',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'hello object'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$actionObject = BotAdapter::parseCardActionObject([
    'event' => 'action',
    'provider' => 'feishu',
    'instance' => 'main',
    'event_type' => 'card.action.trigger',
    'target_type' => 'open_message_id',
    'target' => 'om_card_obj',
    'metadata' => [
        'event_kind' => 'action',
        'open_message_id' => 'om_card_obj',
        'action_tag' => 'button',
        'token' => 'callback-token-2',
    ],
    'payload' => json_encode([
        'schema' => '2.0',
        'token' => 'callback-token-2',
        'header' => ['event_type' => 'card.action.trigger'],
        'event' => [
            'open_message_id' => 'om_card_obj',
            'action' => [
                'tag' => 'button',
                'value' => [
                    'action' => 'approve',
                ],
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedTextObject = BotAdapter::parseTypedTextMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_text',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_text',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_text',
                'chat_id' => 'oc_typed_text',
                'message_type' => 'text',
                'content' => json_encode(['text' => 'typed hello'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedImageObject = BotAdapter::parseImageMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_image',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_image',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_image',
                'chat_id' => 'oc_typed_image',
                'message_type' => 'image',
                'content' => json_encode(['image_key' => 'img_typed_1'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedPostObject = BotAdapter::parsePostMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_post',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_post',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_post',
                'chat_id' => 'oc_typed_post',
                'message_type' => 'post',
                'content' => json_encode([
                    'zh_cn' => [
                        'title' => 'typed post',
                        'content' => [
                            [
                                ['tag' => 'text', 'text' => 'typed body'],
                            ],
                        ],
                    ],
                ], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedCardAction = BotAdapter::parseCardActionEventObject([
    'event' => 'action',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'card.action.trigger',
    'target_type' => 'open_message_id',
    'target' => 'om_typed_card',
    'metadata' => [
        'event_kind' => 'action',
        'open_message_id' => 'om_typed_card',
        'action_tag' => 'button',
        'token' => 'typed-token',
    ],
    'payload' => json_encode([
        'schema' => '2.0',
        'token' => 'typed-token',
        'header' => ['event_type' => 'card.action.trigger'],
        'event' => [
            'open_message_id' => 'om_typed_card',
            'action' => [
                'tag' => 'button',
                'value' => [
                    'action' => 'approve',
                ],
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedFileObject = BotAdapter::parseFileMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_file',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_file',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_file',
                'chat_id' => 'oc_typed_file',
                'message_type' => 'file',
                'content' => json_encode(['file_key' => 'file_typed_1', 'file_name' => 'spec.pdf'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedAudioObject = BotAdapter::parseAudioMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_audio',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_audio',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_audio',
                'chat_id' => 'oc_typed_audio',
                'message_type' => 'audio',
                'content' => json_encode(['file_key' => 'audio_typed_1', 'duration' => '3210'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedMediaObject = BotAdapter::parseMediaMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_media',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_media',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_media',
                'chat_id' => 'oc_typed_media',
                'message_type' => 'media',
                'content' => json_encode([
                    'file_key' => 'media_typed_1',
                    'image_key' => 'img_media_1',
                    'file_name' => 'clip.mp4',
                    'duration' => '6543',
                ], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$typedStickerObject = BotAdapter::parseStickerMessageObject([
    'event' => 'message',
    'provider' => 'feishu',
    'instance' => 'typed',
    'event_type' => 'im.message.receive_v1',
    'message_id' => 'om_typed_sticker',
    'target_type' => 'chat_id',
    'target' => 'oc_typed_sticker',
    'payload' => json_encode([
        'header' => ['event_type' => 'im.message.receive_v1'],
        'event' => [
            'message' => [
                'message_id' => 'om_typed_sticker',
                'chat_id' => 'oc_typed_sticker',
                'message_type' => 'sticker',
                'content' => json_encode(['file_key' => 'sticker_typed_1'], JSON_UNESCAPED_UNICODE),
            ],
        ],
    ], JSON_UNESCAPED_UNICODE),
]);

$replyObjectCommand = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? Command::replyText($textObject, 'object pong')->toArray()
    : [];

$updateObjectCommand = $actionObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event
    ? Command::updateInteractive($actionObject, [
        'type' => 'template',
        'data' => ['template_id' => 'ctp_object'],
    ])->toArray()
    : [];

$sendImageObjectCommand = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? Command::sendImage($textObject, 'img_obj_1', 'uuid-img-1')->toArray()
    : [];

$sendPostObjectCommand = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? Command::sendPost($textObject, [
        'zh_cn' => [
            'title' => 'object post',
            'content' => [
                [
                    ['tag' => 'text', 'text' => 'object body'],
                ],
            ],
        ],
    ], 'uuid-post-2')->toArray()
    : [];

$updateTextObjectCommand = $actionObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event
    ? Command::updateText($actionObject, 'updated text')->toArray()
    : [];
$cardActionValueObject = CardActionValue::action('approve', ['ticket_id' => 't_value']);
$plainTextObject = PlainText::create('Approve');
$cardHeaderObject = CardHeader::create(PlainText::create('object card'));
$cardButtonObject = CardButton::primary($plainTextObject, $cardActionValueObject);
$cardMarkdownObject = CardMarkdown::create('card body');
$cardActionBlockObject = CardActionBlock::create($cardButtonObject);
$interactiveCardObject = InteractiveCard::create('object card')
    ->wideScreen()
    ->header($cardHeaderObject)
    ->element($cardMarkdownObject)
    ->element($cardActionBlockObject);
$postContentObject = PostContent::create('object post builder')
    ->textLine('builder body');
$sendInteractiveValueObjectCommand = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? Command::sendInteractive($textObject, $interactiveCardObject, 'uuid-card-object')->toArray()
    : [];
$sendPostValueObjectCommand = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? Command::sendPost($textObject, $postContentObject, 'uuid-post-object')->toArray()
    : [];
$updateInteractiveValueObjectCommand = $actionObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event
    ? Command::updateInteractive($actionObject, $interactiveCardObject)->toArray()
    : [];

$commandObject = Command::fromArray([
    'event' => 'send',
    'provider' => 'feishu',
    'instance' => 'main',
    'target_type' => 'chat_id',
    'target' => 'oc_cmd_obj',
    'message_type' => 'text',
    'text' => 'hello command',
]);

$sendCommandView = $commandObject->asSend();
$updateCommandView = Command::fromArray([
    'event' => 'update',
    'provider' => 'feishu',
    'instance' => 'main',
    'target_type' => 'message_id',
    'target' => 'om_update_obj',
    'message_type' => 'text',
    'text' => 'updated command',
])->asUpdate();
$messageFactoryView = $textObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message
    ? \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message\Factory::fromMessage($textObject)
    : null;
$eventFactoryView = $actionObject instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event
    ? \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event\Factory::fromEvent($actionObject)
    : null;
$commandFactoryView = \VPhp\VHttpd\Upstream\WebSocket\Feishu\Command\Factory::fromCommand($commandObject);
$jsonMessage = $textObject instanceof \JsonSerializable ? json_encode($textObject, JSON_UNESCAPED_UNICODE) : '';
$jsonEvent = $actionObject instanceof \JsonSerializable ? json_encode($actionObject, JSON_UNESCAPED_UNICODE) : '';
$jsonCommand = $commandObject instanceof \JsonSerializable ? json_encode($commandObject, JSON_UNESCAPED_UNICODE) : '';
$jsonTypedMessage = $messageFactoryView instanceof \JsonSerializable ? json_encode($messageFactoryView, JSON_UNESCAPED_UNICODE) : '';
$jsonTypedEvent = $eventFactoryView instanceof \JsonSerializable ? json_encode($eventFactoryView, JSON_UNESCAPED_UNICODE) : '';
$jsonTypedCommand = $commandFactoryView instanceof \JsonSerializable ? json_encode($commandFactoryView, JSON_UNESCAPED_UNICODE) : '';
$debugMessage = $textObject?->toDebugArray() ?? [];
$debugEvent = $actionObject?->toDebugArray() ?? [];
$debugCommand = $commandObject->toDebugArray();
$debugTypedMessage = method_exists($messageFactoryView, 'toDebugArray') ? $messageFactoryView->toDebugArray() : [];
$debugTypedEvent = method_exists($eventFactoryView, 'toDebugArray') ? $eventFactoryView->toDebugArray() : [];
$debugTypedCommand = method_exists($commandFactoryView, 'toDebugArray') ? $commandFactoryView->toDebugArray() : [];

$invalidEventError = '';
try {
    \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event::fromArray([]);
} catch (\InvalidArgumentException $e) {
    $invalidEventError = $e->getMessage();
}

$invalidCommandError = '';
try {
    Command::fromArray([
        'event' => 'send',
        'message_type' => 'text',
    ]);
} catch (\InvalidArgumentException $e) {
    $invalidCommandError = $e->getMessage();
}

echo ($text['message_type'] ?? ''), "\n";
echo ($text['content']['text'] ?? ''), "\n";
echo ($text['chat_type'] ?? ''), "\n";
echo ($text['sender_id'] ?? ''), "\n";

echo ($image['message_type'] ?? ''), "\n";
echo ($image['content']['image_key'] ?? ''), "\n";

echo ($post['message_type'] ?? ''), "\n";
echo ($post['content']['post']['zh_cn']['title'] ?? ''), "\n";
echo ($cardAction['event_kind'] ?? ''), "\n";
echo ($cardAction['target_type'] ?? ''), "\n";
echo ($cardAction['open_message_id'] ?? ''), "\n";
echo ($cardAction['action_tag'] ?? ''), "\n";
echo (str_contains(json_encode($cardAction['action_value'] ?? null, JSON_UNESCAPED_UNICODE), 'approve') ? 'approve' : 'missing-approve'), "\n";

echo ($textOnly['text'] ?? ''), "\n";
echo ($imageText === null ? 'null' : 'not-null'), "\n";
echo ($imageCommand['message_type'] ?? ''), "\n";
echo ($imageCommand['content_fields']['image_key'] ?? ''), "\n";
echo ($imageCommand['metadata']['trace'] ?? ''), "\n";
echo ($postCommand['message_type'] ?? ''), "\n";
echo (str_contains((string) ($postCommand['content'] ?? ''), 'reply title') ? 'has-title' : 'missing-title'), "\n";
echo ($postHelperCommand['message_type'] ?? ''), "\n";
echo (($postHelperCommand['uuid'] ?? '') === 'uuid-post-1' ? 'post-uuid' : 'post-no-uuid'), "\n";
echo (str_contains((string) ($postHelperCommand['content'] ?? ''), 'post helper') ? 'post-helper-title' : 'post-helper-missing'), "\n";
echo ($interactiveHelperCommand['message_type'] ?? ''), "\n";
echo (($interactiveHelperCommand['uuid'] ?? '') === 'uuid-card-1' ? 'card-uuid' : 'card-no-uuid'), "\n";
echo (str_contains((string) ($interactiveHelperCommand['content'] ?? ''), 'ctp_demo') ? 'card-template' : 'card-missing'), "\n";
echo ($interactiveUpdateCommand['event'] ?? ''), "\n";
echo ($interactiveUpdateCommand['target_type'] ?? ''), "\n";
echo ($interactiveUpdateCommand['target'] ?? ''), "\n";
echo (($interactiveUpdateCommand['uuid'] ?? '') === 'uuid-card-update-1' ? 'card-update-uuid' : 'card-update-no-uuid'), "\n";
echo (str_contains((string) ($interactiveUpdateCommand['content'] ?? ''), 'ctp_update') ? 'card-update-template' : 'card-update-missing'), "\n";
echo ($textObject?->instance() ?? ''), "\n";
echo ($textObject?->text() ?? ''), "\n";
echo ($textObject?->metadata()['trace'] ?? ''), "\n";
echo ($textObject?->chatType() ?? ''), "\n";
echo ($textObject?->senderId() ?? ''), "\n";
echo ($actionObject?->token() ?? ''), "\n";
echo ($replyObjectCommand['text'] ?? ''), "\n";
echo ($updateObjectCommand['target_type'] ?? ''), "\n";
echo ($updateObjectCommand['target'] ?? ''), "\n";
echo (str_contains((string) ($updateObjectCommand['content'] ?? ''), 'ctp_object') ? 'object-update-template' : 'object-update-missing'), "\n";
echo ($sendImageObjectCommand['message_type'] ?? ''), "\n";
echo ($sendImageObjectCommand['content_fields']['image_key'] ?? ''), "\n";
echo ($sendImageObjectCommand['uuid'] ?? ''), "\n";
echo ($sendPostObjectCommand['message_type'] ?? ''), "\n";
echo (str_contains((string) ($sendPostObjectCommand['content'] ?? ''), 'object post') ? 'object-post-title' : 'object-post-missing'), "\n";
echo ($sendPostObjectCommand['uuid'] ?? ''), "\n";
echo ($updateTextObjectCommand['event'] ?? ''), "\n";
echo ($updateTextObjectCommand['target_type'] ?? ''), "\n";
echo ($updateTextObjectCommand['text'] ?? ''), "\n";
echo ($cardActionValueObject->toArray()['action'] ?? ''), "\n";
echo ($cardActionValueObject->toArray()['ticket_id'] ?? ''), "\n";
echo ($plainTextObject->toArray()['content'] ?? ''), "\n";
echo ($cardHeaderObject->toArray()['title']['content'] ?? ''), "\n";
echo ($cardButtonObject->toArray()['type'] ?? ''), "\n";
echo ($cardButtonObject->toArray()['value']['action'] ?? ''), "\n";
echo ($cardMarkdownObject->toArray()['content'] ?? ''), "\n";
echo ($cardActionBlockObject->toArray()['tag'] ?? ''), "\n";
echo ($sendInteractiveValueObjectCommand['message_type'] ?? ''), "\n";
echo (($sendInteractiveValueObjectCommand['uuid'] ?? '') === 'uuid-card-object' ? 'interactive-object-uuid' : 'interactive-object-no-uuid'), "\n";
echo (str_contains((string) ($sendInteractiveValueObjectCommand['content'] ?? ''), 'object card') ? 'interactive-object-title' : 'interactive-object-missing'), "\n";
echo ($sendPostValueObjectCommand['message_type'] ?? ''), "\n";
echo (($sendPostValueObjectCommand['uuid'] ?? '') === 'uuid-post-object' ? 'post-object-uuid' : 'post-object-no-uuid'), "\n";
echo (str_contains((string) ($sendPostValueObjectCommand['content'] ?? ''), 'object post builder') ? 'post-object-title' : 'post-object-missing'), "\n";
echo ($updateInteractiveValueObjectCommand['event'] ?? ''), "\n";
echo ($updateInteractiveValueObjectCommand['target_type'] ?? ''), "\n";
echo (str_contains((string) ($updateInteractiveValueObjectCommand['content'] ?? ''), 'card body') ? 'update-object-body' : 'update-object-missing'), "\n";
echo ($imageObjectKey = $image ? \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message::fromArray($image)->imageKey() : ''), "\n";
echo ($postObjectTitle = $post ? ((\VPhp\VHttpd\Upstream\WebSocket\Feishu\Message::fromArray($post)->postContent()['zh_cn']['title'] ?? '')) : ''), "\n";
echo $commandObject->eventName(), "\n";
echo $commandObject->messageType(), "\n";
echo $commandObject->target(), "\n";
echo ($sendCommandView?->eventName() ?? ''), "\n";
echo ($sendCommandView?->text() ?? ''), "\n";
echo ($sendCommandView?->metadata()['trace'] ?? 'no-trace'), "\n";
echo ($sendCommandView?->uuid() ?? ''), "\n";
echo ($updateCommandView?->eventName() ?? ''), "\n";
echo ($updateCommandView?->target() ?? ''), "\n";
echo ($updateCommandView?->text() ?? ''), "\n";
echo (($updateCommandView?->isMessageIdTarget() ?? false) ? 'update-message-id' : 'update-target-miss'), "\n";
echo ($messageFactoryView instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Message\TextMessage ? 'message-factory-text' : 'message-factory-miss'), "\n";
echo ($eventFactoryView instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Event\CardActionEvent ? 'event-factory-card' : 'event-factory-miss'), "\n";
echo ($commandFactoryView instanceof \VPhp\VHttpd\Upstream\WebSocket\Feishu\Command\SendCommand ? 'command-factory-send' : 'command-factory-miss'), "\n";
echo (str_contains((string) $jsonMessage, '"message_type":"text"') ? 'json-message-ok' : 'json-message-bad'), "\n";
echo (str_contains((string) $jsonEvent, '"event_kind":"action"') ? 'json-event-ok' : 'json-event-bad'), "\n";
echo (str_contains((string) $jsonCommand, '"event":"send"') ? 'json-command-ok' : 'json-command-bad'), "\n";
echo (str_contains((string) $jsonTypedMessage, '"message_type":"text"') ? 'json-typed-message-ok' : 'json-typed-message-bad'), "\n";
echo (str_contains((string) $jsonTypedEvent, '"event_kind":"action"') ? 'json-typed-event-ok' : 'json-typed-event-bad'), "\n";
echo (str_contains((string) $jsonTypedCommand, '"event":"send"') ? 'json-typed-command-ok' : 'json-typed-command-bad'), "\n";
echo (($debugMessage['message_type'] ?? '') === 'text' ? 'debug-message-ok' : 'debug-message-bad'), "\n";
echo (($debugEvent['event_kind'] ?? '') === 'action' ? 'debug-event-ok' : 'debug-event-bad'), "\n";
echo (($debugCommand['event'] ?? '') === 'send' ? 'debug-command-ok' : 'debug-command-bad'), "\n";
echo (($debugTypedMessage['message_type'] ?? '') === 'text' ? 'debug-typed-message-ok' : 'debug-typed-message-bad'), "\n";
echo (($debugTypedEvent['event_kind'] ?? '') === 'action' ? 'debug-typed-event-ok' : 'debug-typed-event-bad'), "\n";
echo (($debugTypedCommand['event'] ?? '') === 'send' ? 'debug-typed-command-ok' : 'debug-typed-command-bad'), "\n";
echo (str_contains($invalidEventError, 'event_type') ? 'invalid-event-ok' : 'invalid-event-bad'), "\n";
echo (str_contains($invalidCommandError, 'target_type') ? 'invalid-command-ok' : 'invalid-command-bad'), "\n";
echo ($typedTextObject?->text() ?? ''), "\n";
echo ($typedImageObject?->imageKey() ?? ''), "\n";
echo ($typedPostObject?->postContent()['zh_cn']['title'] ?? ''), "\n";
echo ($typedCardAction?->token() ?? ''), "\n";
echo ($typedCardAction?->openMessageId() ?? ''), "\n";
echo ($typedFileObject?->fileName() ?? ''), "\n";
echo ($typedAudioObject?->duration() ?? ''), "\n";
echo ($typedMediaObject?->imageKey() ?? ''), "\n";
echo ($typedStickerObject?->fileKey() ?? ''), "\n";
?>
--EXPECT--
text
ping
group
ou_sender
image
img_v2_123
post
hello
action
open_message_id
om_card_1
button
approve
/ping
null
image
img_send_1
adapter-test
post
has-title
post
post-uuid
post-helper-title
interactive
card-uuid
card-template
update
token
callback-token-1
card-update-uuid
card-update-template
mac
hello object
object-message
p2p
ou_object_sender
callback-token-2
object pong
token
callback-token-2
object-update-template
image
img_obj_1
uuid-img-1
post
object-post-title
uuid-post-2
update
token
updated text
approve
t_value
Approve
object card
primary
approve
card body
action
interactive
interactive-object-uuid
interactive-object-title
post
post-object-uuid
post-object-title
update
token
update-object-body
img_v2_123
hello
send
text
oc_cmd_obj
send
hello command
no-trace

update
om_update_obj
updated command
update-message-id
message-factory-text
event-factory-card
command-factory-send
json-message-ok
json-event-ok
json-command-ok
json-typed-message-ok
json-typed-event-ok
json-typed-command-ok
debug-message-ok
debug-event-ok
debug-command-ok
debug-typed-message-ok
debug-typed-event-ok
debug-typed-command-ok
invalid-event-ok
invalid-command-ok
typed hello
img_typed_1
typed post
typed-token
om_typed_card
spec.pdf
3210
img_media_1
sticker_typed_1
