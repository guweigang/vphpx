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
# The next request can arrive before vhttpd releases the streamed connection.
queue_capacity = 1
queue_timeout_ms = 1000
read_timeout_ms = 4500
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

$token = getmypid() . '_' . $port;
$workerContext = static function (string $method) use ($token) {
    return stream_context_create(['http' => [
        'method' => $method,
        'timeout' => 5.0,
        'ignore_errors' => true,
        'header' => "X-Stream-Test-Token: {$token}\r\nX-Request-Id: download-rid\r\n",
    ]]);
};
$streamPid = static function (array $headers): string {
    foreach ($headers as $line) {
        if (stripos($line, 'x-worker-pid:') === 0) {
            return trim(substr($line, strlen('x-worker-pid:')));
        }
    }
    return '';
};

$binary = str_repeat("data\0\xff", 3000);
file_put_contents($tmp . '/input.bin', $binary);
$download = file_get_contents($base . '/psr-stream/file', false, $workerContext('GET'));
$downloadHeaders = last_response_headers();
$pid = $streamPid($downloadHeaders);
if ($download !== $binary || !preg_match('/^\d+$/D', $pid)
    || !str_contains($downloadHeaders[0] ?? '', '202')
    || stripos(implode("\n", $downloadHeaders), 'x-vhttpd-stream-mode: direct') === false
    || stripos(implode("\n", $downloadHeaders), 'content-type: application/octet-stream') === false
    || stripos(implode("\n", $downloadHeaders), 'x-request-id: download-rid') === false) {
    throw new RuntimeException('Unexpected file response: ' . json_encode([
        'body_length' => is_string($download) ? strlen($download) : false,
        'body_matches' => $download === $binary,
        'headers' => $downloadHeaders,
    ], JSON_THROW_ON_ERROR));
}
echo "psr_file_streamed\n";

foreach (['head' => 'HEAD', 'raw-head' => 'HEAD', 'no-content' => 'GET'] as $path => $method) {
    $body = file_get_contents($base . '/psr-stream/' . $path, false, $workerContext($method));
    $headers = last_response_headers();
    if ($body !== '' || $streamPid($headers) !== $pid
        || !str_contains($headers[0] ?? '', $path === 'no-content' ? '204' : '202')
        || file_exists($tmp . '/psr-read') || file_exists($tmp . '/raw-read')) {
        throw new RuntimeException('The worker read a body forbidden by ' . $path);
    }
}
echo "psr_bodyless_unread\n";

foreach (['resource-file', 'factory-resource-file'] as $path) {
    $resourceDownload = file_get_contents($base . '/psr-stream/' . $path, false, $workerContext('GET'));
    $resourceHeaders = last_response_headers();
    if ($resourceDownload !== substr($binary, 3) || $streamPid($resourceHeaders) !== $pid
        || stripos(implode("\n", $resourceHeaders), 'x-vhttpd-stream-mode: direct') === false) {
        throw new RuntimeException('The worker did not stream the resource from its current position for ' . $path);
    }
}
if (file_get_contents($tmp . '/resource-open') !== 'opened') {
    throw new RuntimeException('The worker did not invoke the resource factory for GET');
}
unlink($tmp . '/resource-open');
foreach (['resource-head', 'factory-resource-head'] as $path) {
    $resourceHead = file_get_contents($base . '/psr-stream/' . $path, false, $workerContext('HEAD'));
    if ($resourceHead !== '' || $streamPid(last_response_headers()) !== $pid
        || file_exists($tmp . '/resource-read') || file_exists($tmp . '/resource-open')) {
        throw new RuntimeException('The worker opened a deferred resource or read a resource body for HEAD');
    }
}

$foreignBodyLog = $tmp . '/foreign-body';
$openError = file_get_contents($base . '/psr-stream/foreign-open-error', false, $workerContext('GET'));
if (!str_contains(last_response_headers()[0] ?? '', '500')
    || !str_contains((string) $openError, 'body open failed')
    || file_get_contents($foreignBodyLog) !== "getBody\n") {
    throw new RuntimeException('A PSR-7 getBody failure must fail the request before streaming begins');
}
unlink($foreignBodyLog);
foreach (['foreign-file', 'foreign-promoted', 'foreign-after-read', 'foreign-after-retry', 'foreign-middle-file'] as $path) {
    $foreignDownload = file_get_contents($base . '/psr-stream/' . $path, false, $workerContext('GET'));
    $foreignHeaders = last_response_headers();
    if ($foreignDownload !== $binary || $streamPid($foreignHeaders) !== $pid
        || !str_contains($foreignHeaders[0] ?? '', '202')
        || stripos(implode("\n", $foreignHeaders), 'x-vhttpd-stream-mode: direct') === false
        || file_get_contents($foreignBodyLog) !== str_repeat("getBody\n", $path === 'foreign-after-retry' ? 2 : 1)) {
        throw new RuntimeException('The worker did not stream a foreign PSR-7 body for ' . $path);
    }
    if ($path === 'foreign-middle-file'
        && (stripos(implode("\n", $foreignHeaders), 'x-middle-app: ran') === false
            || stripos(implode("\n", $foreignHeaders), 'x-middle-group: ran') === false)) {
        throw new RuntimeException('The stream did not traverse both PSR-15 middlewares');
    }
    unlink($foreignBodyLog);
}
foreach ([
    'foreign-head' => ['HEAD', '202'],
    'foreign-no-content' => ['GET', '204'],
    'foreign-reset' => ['GET', '205'],
    'foreign-not-modified' => ['GET', '304'],
    'foreign-after-head' => ['HEAD', '202'],
    'foreign-after-no-content' => ['GET', '204'],
    'foreign-after-demoted' => ['GET', '204'],
    'foreign-before-halt' => ['GET', '204'],
    'foreign-middle-head' => ['HEAD', '202'],
    'foreign-middle-no-content' => ['GET', '204'],
    'foreign-terminal-missing' => ['HEAD', '404'],
    'foreign-terminal-method' => ['POST', '204'],
] as $path => [$method, $status]) {
    $body = file_get_contents($base . '/psr-stream/' . $path, false, $workerContext($method));
    $headers = last_response_headers();
    if ($body !== '' || $streamPid($headers) !== $pid || !str_contains($headers[0] ?? '', $status)
        || file_exists($foreignBodyLog)) {
        throw new RuntimeException('The worker acquired a foreign PSR-7 body forbidden by ' . $path);
    }
    if ($path === 'foreign-terminal-method' && stripos(implode("\n", $headers), 'allow: GET') === false) {
        throw new RuntimeException('The method error handler lost its Allow header');
    }
    if ($path === 'foreign-terminal-missing'
        && stripos(implode("\n", $headers), 'x-request-id: download-rid') === false) {
        throw new RuntimeException('The not-found response lost its request ID');
    }
}
$replacement = file_get_contents($base . '/psr-stream/foreign-after-replaced', false, $workerContext('GET'));
if ($replacement !== 'replacement' || $streamPid(last_response_headers()) !== $pid
    || file_exists($foreignBodyLog)) {
    throw new RuntimeException('Middleware replacement opened the discarded response body');
}

$fifo = $tmp . '/input.fifo';
if (function_exists('posix_mkfifo')) {
    $created = posix_mkfifo($fifo, 0600);
} else {
    exec('mkfifo -m 600 ' . escapeshellarg($fifo), $ignored, $code);
    $created = $code === 0;
}
if (!$created) {
    throw new RuntimeException('Could not create the streaming pipe fixture');
}
$ack = $tmp . '/first-chunk-received';
$writerCode = <<<'PHP'
[$fifo, $ack] = array_slice($argv, 1);
$stream = fopen($fifo, 'wb');
fwrite($stream, str_repeat('p', 8192));
fflush($stream);
$deadline = microtime(true) + 3.0;
while (!is_file($ack)) {
    if (microtime(true) >= $deadline) {
        exit(1);
    }
    usleep(10000);
}
fwrite($stream, "tail\0");
fclose($stream);
PHP;
try {
    foreach (['pipe', 'resource-pipe', 'factory-resource-pipe', 'resource-nonblocking-pipe', 'factory-resource-nonblocking-pipe'] as $path) {
        @unlink($ack);
        $writer = proc_open([PHP_BINARY, '-n', '-r', $writerCode, $fifo, $ack], [], $writerPipes);
        if (!is_resource($writer)) {
            throw new RuntimeException('Could not start pipe writer');
        }
        try {
            $client = fopen($base . '/psr-stream/' . $path, 'rb', false, $workerContext('GET'));
            if ($client === false) {
                throw new RuntimeException('Could not open the chunked pipe response');
            }
            try {
                $chunk = stream_get_contents($client, 8192);
                if ($chunk !== str_repeat('p', 8192) || $streamPid(stream_get_meta_data($client)['wrapper_data']) !== $pid) {
                    throw new RuntimeException('The first pipe chunk did not arrive before EOF for ' . $path);
                }
                touch($ack);
                if (stream_get_contents($client) !== "tail\0") {
                    throw new RuntimeException('The pipe lost its binary tail for ' . $path);
                }
            } finally {
                fclose($client);
            }
            if (proc_close($writer) !== 0) {
                throw new RuntimeException('The pipe writer did not finish');
            }
        } finally {
            if (is_resource($writer)) {
                proc_terminate($writer, 9);
                proc_close($writer);
            }
        }
    }
} finally {
    @unlink($fifo);
    @unlink($ack);
    @unlink($tmp . '/input.bin');
    @unlink($tmp . '/resource-open');
}
echo "psr_pipe_delivered_before_eof\n";

$cancelled = file_get_contents($base . '/task-cancel', false, $workerContext('GET'));
$cancelHeaders = last_response_headers();
$cancelPid = is_file($tmp . '/task-pid') ? file_get_contents($tmp . '/task-pid') : '';
@unlink($tmp . '/task-pid');
if (!str_contains($cancelHeaders[0] ?? '', '500')
    || !str_contains((string) $cancelled, 'Task was cancelled') || $cancelPid !== $pid) {
    throw new RuntimeException('The worker did not finish the cancelled Fiber');
}
$afterCancel = file_get_contents($base . '/task-after-cancel', false, $workerContext('GET'));
$afterHeaders = last_response_headers();
if ($afterCancel !== 'r' || !str_contains($afterHeaders[0] ?? '', '200') || $streamPid($afterHeaders) !== $pid) {
    throw new RuntimeException('The worker could not schedule another task after cancellation');
}
echo "task_cancelled_and_worker_reused\n";

$taskStream = file_get_contents($base . '/task-stream-body', false, $workerContext('GET'));
$taskStreamHeaders = last_response_headers();
if ($taskStream !== "fiber\0stream" || $streamPid($taskStreamHeaders) !== $pid
    || !str_contains($taskStreamHeaders[0] ?? '', '200')
    || stripos(implode("\n", $taskStreamHeaders), 'x-vhttpd-stream-mode: direct') === false) {
    throw new RuntimeException('The worker did not stream the result of a task consuming a nonblocking resource');
}
echo "task_stream_body_on_same_worker\n";

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
psr_file_streamed
psr_bodyless_unread
psr_pipe_delivered_before_eof
task_cancelled_and_worker_reused
task_stream_body_on_same_worker
stopped
