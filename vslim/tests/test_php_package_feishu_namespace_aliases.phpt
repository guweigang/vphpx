--TEST--
vhttpd php package exposes Feishu app and provider classes under the new namespaces
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/legacy_aliases.php';

echo class_exists(\VPhp\VSlim\App\Feishu\BotApp::class) ? "bot_app\n" : "missing_bot_app\n";
echo interface_exists(\VPhp\VSlim\App\Feishu\BotHandler::class) ? "bot_handler\n" : "missing_bot_handler\n";
echo class_exists(\VPhp\VSlim\App\Feishu\BotAdapter::class) ? "bot_adapter\n" : "missing_bot_adapter\n";
echo class_exists(\VPhp\VSlim\App\Feishu\AbstractBotHandler::class) ? "abstract_bot_handler\n" : "missing_abstract_bot_handler\n";
echo class_exists(\VPhp\VHttpd\Upstream\WebSocket\Feishu\Command::class) ? "provider_command\n" : "missing_provider_command\n";
echo class_exists(\VPhp\VHttpd\Upstream\WebSocket\Feishu\Message::class) ? "provider_message\n" : "missing_provider_message\n";
echo class_exists(\VPhp\VHttpd\Upstream\WebSocket\Feishu\Event::class) ? "provider_event\n" : "missing_provider_event\n";
echo class_exists(\VPhp\VHttpd\Upstream\WebSocket\Feishu\Content\InteractiveCard::class) ? "provider_content\n" : "missing_provider_content\n";
?>
--EXPECT--
bot_app
bot_handler
bot_adapter
abstract_bot_handler
provider_command
provider_message
provider_event
provider_content
