--TEST--
package bin php-worker exposes vhttpd_stream helper functions to custom apps
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
$probe = sys_get_temp_dir() . '/vphp_worker_bin_stream_probe_' . getmypid() . '.sock';
@unlink($probe);
$errno = 0;
$errstr = '';
$server = @stream_socket_server('unix://' . $probe, $errno, $errstr);
if (!is_resource($server)) {
    print 'skip';
}
if (is_resource($server)) {
    fclose($server);
}
if (is_file($probe)) {
    @unlink($probe);
}
?>
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';

$worker = new WorkerWireFixture(__DIR__ . '/fixtures/worker_helper_stream_app_fixture.php');
echo "worker_ready\n";

$baseReq = [
    'id' => 'stream',
    'method' => 'GET',
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
];

$textFrames = iterator_to_array($worker->frames(['id' => 'text', 'path' => '/helper/text'] + $baseReq), false);
echo ($textFrames[0]['event'] ?? '') . '|' . ($textFrames[0]['stream_type'] ?? '') . PHP_EOL;
echo ($textFrames[0]['headers']['x-helper-source'] ?? '') . PHP_EOL;
echo base64_decode($textFrames[1]['data_base64'], true) . base64_decode($textFrames[2]['data_base64'], true);
echo ($textFrames[3]['event'] ?? '') . PHP_EOL;

$sseFrames = iterator_to_array($worker->frames(['id' => 'sse', 'path' => '/helper/sse'] + $baseReq), false);
echo ($sseFrames[0]['event'] ?? '') . '|' . ($sseFrames[0]['stream_type'] ?? '') . PHP_EOL;
echo ($sseFrames[0]['headers']['x-helper-source'] ?? '') . PHP_EOL;
echo ($sseFrames[1]['sse_event'] ?? '') . '|' . ($sseFrames[1]['data'] ?? '') . PHP_EOL;
echo ($sseFrames[2]['sse_event'] ?? '') . '|' . ($sseFrames[2]['data'] ?? '') . PHP_EOL;
echo ($sseFrames[3]['event'] ?? '') . PHP_EOL;

?>
--EXPECT--
worker_ready
start|text
text
alpha
beta
end
start|sse
sse
token|{"token":"hello"}
done|{"done":true}
end
