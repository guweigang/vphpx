--TEST--
vhttpd executes upstream plan fixtures for Ollama text and SSE without locking php-worker
--SKIPIF--
<?php
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) {
    echo "skip vhttpd binary missing";
    return;
}
$probeSock = sys_get_temp_dir() . '/vhttpd_upstream_probe_' . getmypid() . '.sock';
@unlink($probeSock);
$errno = 0;
$errstr = '';
$probe = @stream_socket_server('unix://' . $probeSock, $errno, $errstr);
if (!is_resource($probe)) {
    echo 'skip';
    return;
}
fclose($probe);
@unlink($probeSock);
?>
--FILE--
<?php
declare(strict_types=1);

function free_port(): int {
    $server = stream_socket_server('tcp://127.0.0.1:0', $errno, $errstr);
    if (!is_resource($server)) {
        throw new RuntimeException("port_probe_failed: {$errstr}");
    }
    $name = stream_socket_get_name($server, false);
    fclose($server);
    $parts = explode(':', (string) $name);
    return (int) end($parts);
}

function last_response_headers(): array {
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($GLOBALS['http_response_header'] ?? []);
    return is_array($headers) ? $headers : [];
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$vhttpdBin = $repoRoot . '/vhttpd/vhttpd';
$workerPhp = $repoRoot . '/vhttpd/php/package/bin/php-worker';
$app = $repoRoot . '/vhttpd/examples/ollama-proxy-app.php';
$fixture = __DIR__ . '/fixtures/ollama_stream_fixture.ndjson';
$serverPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_ollama_upstream_' . getmypid();
@mkdir($tmp, 0777, true);
$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$workerSock = $tmp . '/worker.sock';
$config = $tmp . '/ollama-upstream.toml';

$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$serverPort}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
read_timeout_ms = 60000
socket = "{$workerSock}"
cmd = "php {$workerPhp}"

[worker.env]
VHTTPD_APP = "{$app}"
OLLAMA_CHAT_URL = "http://127.0.0.1:11434/api/chat"
OLLAMA_MODEL = "qwen2.5:7b-instruct"
OLLAMA_STREAM_FIXTURE = "{$fixture}"

[admin]
host = "127.0.0.1"
port = {$adminPort}
token = ""
TOML;

file_put_contents($config, $toml);
$cmd = sprintf('%s --config %s > %s 2>&1 & echo $!', escapeshellarg($vhttpdBin), escapeshellarg($config), escapeshellarg($stdoutLog));
$out = [];
exec($cmd, $out, $code);
$pid = isset($out[0]) ? (int) trim((string) $out[0]) : 0;

$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.5]]);
    $health = @file_get_contents("http://127.0.0.1:{$serverPort}/ollama/health", false, $ctx);
    if (is_string($health) && trim($health) === 'OK') {
        $ready = true;
        break;
    }
    usleep(100_000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    if ($pid > 0) {
        exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    }
    exit;
}

$meta = @file_get_contents("http://127.0.0.1:{$serverPort}/ollama/health");
echo trim((string) $meta), PHP_EOL;

$txtCtx = stream_context_create(['http' => ['timeout' => 3.0, 'ignore_errors' => true]]);
$txtBody = @file_get_contents("http://127.0.0.1:{$serverPort}/ollama/text?prompt=hello", false, $txtCtx);
$txtHeaders = last_response_headers();
$txtStatus = $txtHeaders[0] ?? '';
$txtHeaderLines = implode("\n", $txtHeaders);
echo (str_contains($txtStatus, '200') ? "txt_200\n" : "txt_bad\n");
echo (stripos($txtHeaderLines, 'x-vhttpd-stream-mode: upstream_plan') !== false ? "txt_upstream\n" : "txt_no_upstream\n");
echo (trim((string) $txtBody) === 'Hello from VSlim' ? "txt_ok\n" : "txt_bad_body\n");

$sseCtx = stream_context_create(['http' => ['timeout' => 3.0, 'ignore_errors' => true]]);
$sseBody = @file_get_contents("http://127.0.0.1:{$serverPort}/ollama/sse?prompt=hello", false, $sseCtx);
$sseHeaders = last_response_headers();
$sseStatus = $sseHeaders[0] ?? '';
echo (str_contains($sseStatus, '200') ? "sse_200\n" : "sse_bad\n");
echo ((is_string($sseBody) && str_contains($sseBody, "event: token\n")) ? "sse_token\n" : "sse_no_token\n");
echo ((is_string($sseBody) && str_contains($sseBody, "event: done\n")) ? "sse_done\n" : "sse_no_done\n");

if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
?>
--EXPECT--
ready
OK
txt_200
txt_upstream
txt_ok
sse_200
sse_token
sse_done
