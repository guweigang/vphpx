--TEST--
The vhttpd package exposes VSlim Feishu adapters and the vhttpd 0.9 WebSocket event and command API
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/php_worker_package_bootstrap.php';

use VHttpd\Upstream\WebSocket\CommandFactory;
use VHttpd\Upstream\WebSocket\Event;

echo class_exists(VSlim\App\Feishu\BotApp::class) ? "bot_app\n" : "missing_bot_app\n";
echo interface_exists(VSlim\App\Feishu\BotHandler::class) ? "bot_handler\n" : "missing_bot_handler\n";
echo class_exists(VSlim\App\Feishu\BotAdapter::class) ? "bot_adapter\n" : "missing_bot_adapter\n";
echo class_exists(VSlim\App\Feishu\AbstractBotHandler::class) ? "abstract_bot_handler\n" : "missing_abstract_bot_handler\n";
echo class_exists(VHttpd\Feishu\CreationClient::class) ? "feishu_creation\n" : "missing_feishu_creation\n";

$event = Event::fromDispatchRequest([
    'provider' => 'feishu',
    'event_type' => 'im.message.receive_v1',
    'payload' => '{"event":{"message":{"chat_id":"oc_demo"}}}',
]);
echo ($event->matches('feishu', 'im.message.receive_v1') ? 'feishu' : 'unknown'), '|',
    $event->payloadArray()['event']['message']['chat_id'], PHP_EOL;
$command = CommandFactory::providerMessageSend('feishu', ['target' => 'oc_demo'])->toArray();
echo $command['type'], '|', $command['provider'], '|', $command['target'], PHP_EOL;
?>
--EXPECT--
bot_app
bot_handler
bot_adapter
abstract_bot_handler
feishu_creation
feishu|oc_demo
provider.message.send|feishu|oc_demo
