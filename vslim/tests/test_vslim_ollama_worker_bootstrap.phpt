--TEST--
PhpWorker Server recognizes VSlim App bootstrap for ollama stream demo
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (!is_file(dirname(__DIR__) . '/examples/vendor/autoload.php')) {
    echo "skip vendor autoload missing";
    return;
}
?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';
putenv('OLLAMA_MODEL=qwen-test');
$worker = new WorkerWireFixture(dirname(__DIR__) . '/examples/ollama_stream_app.php', '\VSlim\Worker\Adapter::app');
$meta = $worker->request([
    'method' => 'GET',
    'path' => '/meta',
    'query' => [],
]);
echo $meta['status'] . "\n";
echo (str_contains((string) $meta['body'], '"name":"vslim-ollama-stream-demo"') ? "meta_ok\n" : "meta_bad\n");

$home = $worker->request([
    'method' => 'GET',
    'path' => '/',
    'query' => [],
]);
echo $home['status'] . "\n";
echo ((string) ($home['headers']['content-type'] ?? '') === 'text/html; charset=utf-8' ? "home_html\n" : "home_not_html\n");
echo (str_contains((string) $home['body'], 'VSlim Ollama Stream Demo') ? "home_ok\n" : "home_bad\n");
?>
--EXPECT--
200
meta_ok
200
home_html
home_ok
