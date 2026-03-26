--TEST--
PhpWorker Connection emits local hub control frames
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/../../vhttpd/php/package/src/legacy_aliases.php';

$stream = fopen('php://temp', 'w+');
$conn = new VPhp\VHttpd\PhpWorker\WebSocket\Connection($stream, 'ws-1');
$conn->join('lobby');
$conn->setMeta('user', 'alice');
$conn->setPresence('online');
$conn->broadcast('lobby', '{"text":"hello"}', 'text', 'ws-1');
$conn->sendTo('ws-2', '{"text":"dm"}');
$conn->clearMeta('presence');
$conn->leave('lobby');
$conn->done();

rewind($stream);
while (true) {
    $raw = VPhp\VHttpd\PhpWorker\Client::readFrame($stream);
    if (!is_string($raw) || $raw === '') {
        break;
    }
    $frame = json_decode($raw, true);
    if (!is_array($frame)) {
        break;
    }
    echo ($frame['event'] ?? ''), '|';
    echo ($frame['room'] ?? $frame['target_id'] ?? $frame['key'] ?? ''), '|';
    echo ($frame['data'] ?? $frame['value'] ?? ''), '|';
    echo ($frame['except_id'] ?? ''), PHP_EOL;
    if (($frame['event'] ?? '') === 'done') {
        break;
    }
}

fclose($stream);
?>
--EXPECT--
join|lobby||
set_meta|user|alice|
set_meta|presence|online|
broadcast|lobby|{"text":"hello"}|ws-1
send_to|ws-2|{"text":"dm"}|
clear_meta|presence||
leave|lobby||
done|||
