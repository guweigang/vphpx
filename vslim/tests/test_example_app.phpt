--TEST--
VSlim example app shows named routes and redirects
--SKIPIF--
<?php
if (!extension_loaded("vslim")) {
    print "skip";
    return;
}
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
if (!is_file($vhttpdRoot . '/examples/hello-app.php')) {
    print "skip vhttpd hello-app fixture missing";
    return;
}
?>
--FILE--
<?php
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
$app = require $vhttpdRoot . '/examples/hello-app.php';

$hello = $app->dispatchEnvelopeWorker([
    'id' => 'hello',
    'method' => 'GET',
    'path' => '/hello/codex',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'demo.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $hello->status . '|' . $hello->body . '|' . $hello->header('x-runtime') . PHP_EOL;

$go = $app->dispatchEnvelopeWorker([
    'id' => 'go',
    'method' => 'GET',
    'path' => '/go/nova',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'demo.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $go->status . '|' . $go->header('location') . '|' . $go->header('x-runtime') . PHP_EOL;

$meta = $app->dispatchEnvelopeWorker([
    'id' => 'meta',
    'method' => 'GET',
    'path' => '/api/meta',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'https',
    'host' => 'demo.local',
    'port' => '443',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);
echo $meta->status . '|' . $meta->body . '|' . $meta->header('x-runtime') . PHP_EOL;
?>
--EXPECT--
200|Hello, codex|vslim
302|/hello/nova|vslim
200|{"path":"\/api\/meta","secure":true,"host":"demo.local","hello_url":"\/hello\/codex"}|vslim
