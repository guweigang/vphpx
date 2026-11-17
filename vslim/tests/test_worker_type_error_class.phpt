--TEST--
php-worker maps TypeError to app_contract_error and exposes exception class header
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
$worker = new WorkerWireFixture(__DIR__ . '/fixtures/type_error_app_fixture.php', '\VSlim\Worker\Adapter::http');
$res = $worker->request([
    'id' => 'req-type-error',
    'method' => 'GET',
    'path' => '/type-error',
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
echo $res['status'] . '|' . $res['headers']['x-worker-error-class'] . '|' . $res['headers']['x-worker-exception'] . PHP_EOL;
?>
--EXPECT--
500|app_contract_error|TypeError
