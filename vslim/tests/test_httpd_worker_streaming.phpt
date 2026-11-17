--TEST--
vhttpd worker supports streaming responses for SSE and text modes
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

function last_response_headers(): array {
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($GLOBALS['http_response_header'] ?? []);
    return is_array($headers) ? $headers : [];
}


$port = 19620 + random_int(0, 200);
$tmp = sys_get_temp_dir() . '/vhttpd_stream_' . getmypid() . '_' . $port;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpdx.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$workerSock = $tmp . '/worker.sock';
$workerPhp = $vhttpdRoot . '/php/package/bin/vphp-worker';
$extSo = $root . '/vslim.so';
$streamApp = $root . '/tests/fixtures/streaming_app_fixture.php';

$configPath = $tmp . '/vhttpd.toml';
file_put_contents($configPath, <<<TOML
[server]
host = "127.0.0.1"
port = {$port}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[php]
worker_entry = "{$workerPhp}"
app_entry = "{$streamApp}"
extensions = ["{$extSo}"]

[worker]
autostart = true
socket = "{$workerSock}"
read_timeout_ms = 2000
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

$sseCtx = stream_context_create([
    'http' => [
        'timeout' => 3.0,
        'ignore_errors' => true,
        'header' => "X-Request-Id: sse-rid-7\r\n",
    ],
]);
$sseBody = @file_get_contents($base . '/stream/sse', false, $sseCtx);
$sseHeaders = last_response_headers();
$sseStatus = $sseHeaders[0] ?? '';
echo (str_contains($sseStatus, '200') ? "sse_200\n" : "sse_bad\n");
echo (is_string($sseBody) && str_contains($sseBody, 'event: ping') ? "sse_event\n" : "sse_no_event\n");
echo (is_string($sseBody) && str_contains($sseBody, '"request_id":"sse-rid-7"') ? "sse_rid\n" : "sse_no_rid\n");

$txtCtx = stream_context_create([
    'http' => [
        'timeout' => 3.0,
        'ignore_errors' => true,
    ],
]);
$txtBody = @file_get_contents($base . '/stream/text', false, $txtCtx);
$txtHeaders = last_response_headers();
$txtStatus = $txtHeaders[0] ?? '';
$txtHeaderLines = implode("\n", $txtHeaders);
echo (str_contains($txtStatus, '200') ? "txt_200\n" : "txt_bad\n");
echo (stripos($txtHeaderLines, 'x-stream-source: php-worker') !== false ? "txt_source\n" : "txt_source_missing\n");
echo (stripos($txtHeaderLines, 'content-type: text/plain; charset=utf-8') !== false ? "txt_plain\n" : "txt_not_plain\n");
echo (is_string($txtBody) && !str_contains($txtBody, "event: ") && !str_contains($txtBody, "data: ") ? "txt_not_sse\n" : "txt_looks_sse\n");
echo (trim((string) $txtBody) === "chunk-a\nchunk-b" ? "txt_ok\n" : "txt_bad_body\n");

echo stop_vhttpd($process) ? "stopped\n" : "still_running\n";
?>
--EXPECT--
ready
sse_200
sse_event
sse_rid
txt_200
txt_source
txt_plain
txt_not_sse
txt_ok
stopped
