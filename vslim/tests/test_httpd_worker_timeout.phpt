--TEST--
vhttpd returns 504 and timeout headers when worker read timeout is exceeded
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
if (!is_file(getenv('VHTTPD_BIN') ?: $vhttpdRoot . '/vhttpd')) print "skip";
?>
--FILE--
<?php
require_once __DIR__ . '/vhttpd_process_fixture.php';
$root = dirname(__DIR__);
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname($root, 2) . '/vhttpd';
$src = $vhttpdRoot . '/src';
$bin = getenv('VHTTPD_BIN') ?: $vhttpdRoot . '/vhttpd';

function last_response_headers(): array {
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($GLOBALS['http_response_header'] ?? []);
    return is_array($headers) ? $headers : [];
}


$port = 19480 + random_int(0, 300);
$tmp = sys_get_temp_dir() . '/vhttpd_timeout_' . getmypid() . '_' . $port;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpdx.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$workerSock = $tmp . '/worker.sock';
$workerPhp = $vhttpdRoot . '/php/package/bin/vphp-worker';
$extSo = $root . '/vslim.so';
$slowApp = $root . '/tests/fixtures/slow_app_fixture.php';

$configPath = $tmp . '/vhttpd.toml';
file_put_contents($configPath, <<<TOML
version = 2

[server]
pid_file = "{$pidFile}"

[observability]
event_log = "{$eventLog}"

[listeners.web]
protocol = "http"
transport = "tcp"
host = "127.0.0.1"
port = {$port}

[engines.php]
kind = "php-worker"
entry = "{$workerPhp}"
app = "{$slowApp}"
extensions = ["{$extSo}"]
autostart = true
socket = "{$workerSock}"
read_timeout_ms = 50

[adapters.http]
kind = "http-handler"
engine = "engine:php"

[[pipelines]]
id = "worker-test"
ingress = "listener:web"
match.paths = ["*"]
egress = "adapter:http"
TOML);

$process = launch_vhttpd($bin, $configPath, $stdoutLog);

$base = 'http://127.0.0.1:' . $port;
$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $health = @file_get_contents($base . '/health', false, $ctx);
    if ($health !== false && trim($health) === 'OK') {
        $ready = true;
        break;
    }
    usleep(100_000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$ctx = stream_context_create(['http' => ['timeout' => 2.0, 'ignore_errors' => true]]);
@file_get_contents($base . '/slow?trace_id=t-out', false, $ctx);
$headers = last_response_headers();

$statusLine = $headers[0] ?? '';
preg_match('/\s(\d{3})\s/', $statusLine, $m);
echo ($m[1] ?? '000') . "\n";

$errClass = '';
$traceId = '';
foreach ($headers as $h) {
    $line = strtolower((string) $h);
    if (str_starts_with($line, 'x-vhttpd-error-class:')) {
        $errClass = trim(substr($h, strlen('x-vhttpd-error-class:')));
    }
    if (str_starts_with($line, 'x-vhttpd-trace-id:')) {
        $traceId = trim(substr($h, strlen('x-vhttpd-trace-id:')));
    }
}
echo $errClass . "\n";
echo ($traceId !== '' ? 'trace' : 'no-trace') . "\n";

echo stop_vhttpd($process) ? "stopped\n" : "still_running\n";
?>
--EXPECT--
ready
504
timeout
trace
stopped
