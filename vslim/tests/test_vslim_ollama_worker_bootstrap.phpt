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

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (!is_file($autoload)) { echo "autoload_missing\n"; exit; }
require_once $autoload;

putenv('VHTTPD_APP=' . dirname(__DIR__) . '/examples/ollama_stream_app.php');
putenv('OLLAMA_MODEL=qwen-test');

$worker = new \VPhp\VHttpd\PhpWorker\Server('/tmp/vslim_worker_test.sock');

$meta = $worker->dispatchRequest([
    'method' => 'GET',
    'path' => '/meta',
    'query' => [],
]);
echo $meta['status'] . "\n";
echo (str_contains((string) $meta['body'], '"name":"vslim-ollama-stream-demo"') ? "meta_ok\n" : "meta_bad\n");

$home = $worker->dispatchRequest([
    'method' => 'GET',
    'path' => '/',
    'query' => [],
]);
echo $home['status'] . "\n";
echo ((string) ($home['content_type'] ?? '') === 'text/html; charset=utf-8' ? "home_html\n" : "home_not_html\n");
echo (str_contains((string) $home['body'], 'VSlim Ollama Stream Demo') ? "home_ok\n" : "home_bad\n");
?>
--EXPECT--
200
meta_ok
200
home_html
home_ok
