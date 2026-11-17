--TEST--
vhttpd passes [worker.env] from TOML into php-worker getenv
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
if (!is_file(getenv('VHTTPD_BIN') ?: $vhttpdRoot . '/vhttpd')) print "skip";
$probe = sys_get_temp_dir() . '/vhttpd_unix_probe_' . getmypid() . '.sock';
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
require_once __DIR__ . '/vhttpd_process_fixture.php';
$root = dirname(__DIR__);
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname($root, 2) . '/vhttpd';
$src = $vhttpdRoot . '/src';
$bin = getenv('VHTTPD_BIN') ?: $vhttpdRoot . '/vhttpd';


$port = 19890 + random_int(0, 60);
$tmp = sys_get_temp_dir() . '/vhttpd_toml_env_' . getmypid() . '_' . $port;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpdx.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$socket = $tmp . '/worker.sock';
$configPath = $tmp . '/vhttpdx.toml';
$appPath = $tmp . '/app.php';

$appPhp = <<<'PHP'
<?php
return static function (array $envelope): array {
    $path = (string) ($envelope['path'] ?? '/');
    $base = (string) (parse_url($path, PHP_URL_PATH) ?? '/');
    if ($base !== '/env') {
        return ['status' => 404, 'content_type' => 'text/plain; charset=utf-8', 'body' => 'Not Found'];
    }
    return [
        'status' => 200,
        'content_type' => 'text/plain; charset=utf-8',
        'body' => (string) getenv('TEST_FLAG'),
    ];
};
PHP;
file_put_contents($appPath, $appPhp);

$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$port}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[php]
worker_entry = "{$vhttpdRoot}/php/package/bin/vphp-worker"
app_entry = "{$appPath}"
extensions = ["{$root}/vslim.so"]

[worker]
autostart = true
read_timeout_ms = 3000
socket = "{$socket}"

[worker.env]
TEST_FLAG = "from_toml_env"
TOML;
file_put_contents($configPath, $toml);

$process = launch_vhttpd($bin, $configPath, $stdoutLog);


$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $health = @file_get_contents('http://127.0.0.1:' . $port . '/health', false, $ctx);
    if ($health !== false && trim($health) === 'OK') {
        $ready = true;
        break;
    }
    usleep(100000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$body = @file_get_contents('http://127.0.0.1:' . $port . '/env');
echo trim((string) $body) . "\n";

echo stop_vhttpd($process) ? "stopped\n" : "still_running\n";
?>
--EXPECT--
ready
from_toml_env
stopped
