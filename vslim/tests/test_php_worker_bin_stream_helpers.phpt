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

define('VSLIM_HTTPD_WORKER_NOAUTO', true);
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (!is_file($autoload)) { echo "autoload_missing\n"; exit; }
require_once $autoload;

$root = dirname(__DIR__);
$workerBin = $root . '/../../vhttpd/php/package/bin/php-worker';
$extSo = $root . '/vslim.so';
$app = $root . '/tests/fixtures/worker_helper_stream_app_fixture.php';
$sock = sys_get_temp_dir() . '/vslim_php_worker_bin_stream_' . getmypid() . '.sock';
$log = sys_get_temp_dir() . '/vslim_php_worker_bin_stream_' . getmypid() . '.log';
@unlink($sock);
@unlink($log);

$cmd = sprintf(
    'VHTTPD_APP=%s php -d extension=%s %s --socket %s > %s 2>&1 & echo $!',
    escapeshellarg($app),
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

$connect = static function (string $sockPath) {
    $errno = 0;
    $errstr = '';
    $conn = @stream_socket_client('unix://' . $sockPath, $errno, $errstr, 2.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    return $conn;
};

$readStreamFrames = static function ($conn, array $request): array {
    \VPhp\VHttpd\PhpWorker\Client::writeFrame(
        $conn,
        (string) json_encode($request, JSON_UNESCAPED_UNICODE),
    );
    $frames = [];
    while (true) {
        $raw = \VPhp\VHttpd\PhpWorker\Client::readFrame($conn);
        if (!is_string($raw) || $raw === '') {
            break;
        }
        $frame = json_decode($raw, true);
        if (!is_array($frame)) {
            break;
        }
        $frames[] = $frame;
        if (($frame['event'] ?? '') === 'end') {
            break;
        }
    }
    return $frames;
};

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

$conn = $connect($sock);
$textFrames = $readStreamFrames($conn, $baseReq + ['id' => 'text', 'path' => '/helper/text']);
fclose($conn);
echo ($textFrames[0]['event'] ?? '') . '|' . ($textFrames[0]['stream_type'] ?? '') . PHP_EOL;
echo ($textFrames[0]['headers']['x-helper-source'] ?? '') . PHP_EOL;
echo ($textFrames[1]['data'] ?? '') . ($textFrames[2]['data'] ?? '');
echo ($textFrames[3]['event'] ?? '') . PHP_EOL;

$conn = $connect($sock);
$sseFrames = $readStreamFrames($conn, $baseReq + ['id' => 'sse', 'path' => '/helper/sse']);
fclose($conn);
echo ($sseFrames[0]['event'] ?? '') . '|' . ($sseFrames[0]['stream_type'] ?? '') . PHP_EOL;
echo ($sseFrames[0]['headers']['x-helper-source'] ?? '') . PHP_EOL;
echo ($sseFrames[1]['sse_event'] ?? '') . '|' . ($sseFrames[1]['data'] ?? '') . PHP_EOL;
echo ($sseFrames[2]['sse_event'] ?? '') . '|' . ($sseFrames[2]['data'] ?? '') . PHP_EOL;
echo ($sseFrames[3]['event'] ?? '') . PHP_EOL;

if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
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
