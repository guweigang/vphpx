--TEST--
package bin php-worker serves the default fallback app without VHTTPD_APP
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
$probe = sys_get_temp_dir() . '/vphp_worker_bin_default_probe_' . getmypid() . '.sock';
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

$client = new WorkerWireFixture();
echo "worker_ready\n";

$health = $client->request([
    'id' => 'health',
    'method' => 'GET',
    'path' => '/health',
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
echo $health['status'] . '|' . $health['body'] . PHP_EOL;

$meta = $client->request([
    'id' => 'meta',
    'method' => 'GET',
    'path' => '/meta',
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
echo $meta['status'] . '|' . (str_contains((string) $meta['body'], '"runtime":"vslim"') ? 'meta_ok' : 'meta_bad') . PHP_EOL;

$user = $client->request([
    'id' => 'user',
    'method' => 'GET',
    'path' => '/users/9?trace_id=bin-worker',
    'query' => ['trace_id' => 'bin-worker'],
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
echo $user['status'] . '|' . $user['body'] . PHP_EOL;

?>
--EXPECT--
worker_ready
200|OK
200|meta_ok
200|{"user":"9","trace":"bin-worker"}
