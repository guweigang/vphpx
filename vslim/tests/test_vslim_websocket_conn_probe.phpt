--TEST--
vslim websocket callback sees userland connection object consistently for method and instance probes
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php

class ProbeConnBase {}

final class ProbeConnSink extends ProbeConnBase
{
    public function accept(): void {}
    public function setMeta(string $key, string $value): void {}
    public function clearMeta(string $key): void {}
}

final class ProbeWsHandler
{
    public array $seen = [];

    public function handle_websocket(array $frame, $conn): ?string
    {
        if (($frame['event'] ?? '') !== 'message') {
            return null;
        }
        $this->seen = VSlim\Debug\ObjectProbe::probe($conn, ProbeConnSink::class, 'setMeta');
        return json_encode($this->seen, JSON_UNESCAPED_UNICODE);
    }
}

$app = new VSlim\App();
$handler = new ProbeWsHandler();
$handlerProbe = VSlim\Debug\ObjectProbe::probe($handler, ProbeWsHandler::class, 'handle_websocket');
$connProbe = VSlim\Debug\ObjectProbe::probe(new ProbeConnSink(), ProbeConnSink::class, 'setMeta');
echo 'handler.method_exists=', $handlerProbe['method_exists'] ?? 'missing', PHP_EOL;
echo 'handler.is_instance_of=', $handlerProbe['is_instance_of'] ?? 'missing', PHP_EOL;
echo 'conn.method_exists=', $connProbe['method_exists'] ?? 'missing', PHP_EOL;
echo 'conn.is_instance_of=', $connProbe['is_instance_of'] ?? 'missing', PHP_EOL;
$app->websocket('/ws', $handler);

$conn = new ProbeConnSink();
$raw = $app->handle_websocket([
    'event' => 'message',
    'id' => 'probe-1',
    'path' => '/ws',
    'data' => '{}',
], $conn);

echo 'raw.type=', gettype($raw), PHP_EOL;
echo 'raw.value=', is_string($raw) ? $raw : var_export($raw, true), PHP_EOL;
echo 'seen.count=', count($handler->seen), PHP_EOL;

$data = json_decode($raw, true);
if (is_array($data)) {
    ksort($data);
    foreach ($data as $k => $v) {
        echo $k . '=' . $v . PHP_EOL;
    }
}
?>
--EXPECT--
handler.method_exists=true
handler.is_instance_of=true
conn.method_exists=true
conn.is_instance_of=true
raw.type=string
raw.value={"is_object":"true","class":"ProbeConnSink","is_instance_of":"true","is_subclass_of":"false","method_exists":"true","php_is_a":"true","php_method_exists":"true"}
seen.count=7
class=ProbeConnSink
is_instance_of=true
is_object=true
is_subclass_of=false
method_exists=true
php_is_a=true
php_method_exists=true
