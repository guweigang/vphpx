--TEST--
php-worker accepts custom WebSocket dispatchables marked with VHttpd Dispatchable
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/legacy_aliases.php';

$fixture = sys_get_temp_dir() . '/vhttpd_dispatchable_websocket_fixture.php';
file_put_contents($fixture, <<<'PHP'
<?php
declare(strict_types=1);

use VPhp\VHttpd\Attribute\Dispatchable;
use VPhp\VHttpd\PhpWorker\WebSocket\CommandSink;

#[Dispatchable('websocket')]
final class DispatchableWebSocketFixture
{
    public function handle_websocket(array $frame, CommandSink $conn): ?string
    {
        if (($frame['event'] ?? '') !== 'message') {
            return null;
        }
        return 'echo:' . (string) ($frame['data'] ?? '');
    }
}

return new DispatchableWebSocketFixture();
PHP);

$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_dispatchable_websocket.sock', $fixture);
$res = $server->dispatchRequest([
    'id' => 'req-ws-dispatchable',
    'mode' => 'websocket_dispatch',
    'event' => 'message',
    'data' => 'hello',
]);

echo $res['event'], PHP_EOL;
echo ($res['accepted'] ? 'accepted' : 'not_accepted'), PHP_EOL;
echo ($res['commands'][0]['event'] ?? ''), PHP_EOL;
echo ($res['commands'][0]['data'] ?? ''), PHP_EOL;

@unlink($fixture);
?>
--EXPECT--
result
not_accepted
send
echo:hello
