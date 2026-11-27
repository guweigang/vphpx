--TEST--
php-worker failure responses include stable error class headers
--SKIPIF--
<?php
if (!extension_loaded("vslim")) {
    print "skip";
    return;
}
if (!is_file(dirname(__DIR__) . '/examples/vendor/autoload.php')) {
    print "skip vendor autoload missing";
    return;
}
?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';
$worker = new WorkerWireFixture(__DIR__ . '/fixtures/throwing_app_fixture.php', '\VSlim\Worker\Adapter::http');
$panic = $worker->request([
    'id' => 'req-panic',
    'method' => 'GET',
    'path' => '/any',
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
echo $panic['status'] . '|' . $panic['headers']['x-worker-error-class'] . PHP_EOL;

$worker2 = new WorkerWireFixture(__DIR__ . '/fixtures/invalid_app_fixture.php', '\VSlim\Worker\Adapter::http');
$bad = $worker2->request([
    'id' => 'req-contract',
    'method' => 'GET',
    'path' => '/anything',
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
echo $bad['status'] . '|' . $bad['headers']['x-worker-error-class'] . PHP_EOL;
?>
--EXPECT--
500|worker_runtime_error
500|app_contract_error
