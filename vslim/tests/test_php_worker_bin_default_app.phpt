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

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (!is_file($autoload)) { echo "autoload_missing\n"; exit; }
require_once $autoload;

$root = dirname(__DIR__);
$workerBin = $root . '/../../vhttpd/php/package/bin/php-worker';
$extSo = $root . '/vslim.so';
$sock = sys_get_temp_dir() . '/vslim_php_worker_bin_default_' . getmypid() . '.sock';
$log = sys_get_temp_dir() . '/vslim_php_worker_bin_default_' . getmypid() . '.log';
@unlink($sock);
@unlink($log);

$cmd = sprintf(
    'php -d extension=%s %s --socket %s > %s 2>&1 & echo $!',
    escapeshellarg($extSo),
    escapeshellarg($workerBin),
    escapeshellarg($sock),
    escapeshellarg($log),
);
$out = [];
exec($cmd, $out, $code);
$pid = isset($out[0]) ? (int) trim((string) $out[0]) : 0;

$ready = false;
$deadline = microtime(true) + 5.0;
while (microtime(true) < $deadline) {
    if (is_file($sock)) {
        $ready = true;
        break;
    }
    usleep(50_000);
}
echo $ready ? "worker_ready\n" : "worker_not_ready\n";
if (!$ready) {
    if ($pid > 0) {
        exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    }
    exit;
}

$client = new \VPhp\VHttpd\PhpWorker\Client($sock);
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

if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
?>
--EXPECT--
worker_ready
200|OK
200|meta_ok
200|{"user":"9","trace":"bin-worker"}
