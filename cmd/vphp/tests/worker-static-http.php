<?php
declare(strict_types=1);

require __DIR__ . '/../../../vslim/tests/vhttpd_process_fixture.php';

[, $vhttpdRoot, $vhttpdBin, $temp, $extension] = $argv;
copy($extension, "$temp/standalone_probe.so");
copy(__DIR__ . '/worker-static-app.php', "$temp/worker-static-app.php");
copy(__DIR__ . '/worker-static-fibers.php', "$temp/worker-static-fibers.php");

$probe = stream_socket_server('tcp://127.0.0.1:0');
$address = stream_socket_get_name($probe, false);
fclose($probe);
$port = (int) substr(strrchr($address, ':'), 1);
$config = "$temp/vhttpd.toml";
file_put_contents($config, <<<TOML
[server]
host = "127.0.0.1"
port = $port

[files]
pid_file = "$temp/vhttpd.pid"
event_log = "$temp/events.ndjson"

[php]
worker_entry = "$vhttpdRoot/php/package/bin/vphp-worker"
app_entry = "$temp/worker-static-app.php"
extensions = ["$temp/standalone_probe.so"]

[worker]
autostart = true
pool_size = 1
queue_capacity = 1
queue_timeout_ms = 3000
read_timeout_ms = 6000
socket = "$temp/worker.sock"
TOML);

$log = "$temp/server.log";
$process = launch_vhttpd($vhttpdBin, $config, $log);
$request = static function (string $path, float $timeout = 5.0) use ($address): array {
    $context = stream_context_create(['http' => ['ignore_errors' => true, 'timeout' => $timeout]]);
    $body = @file_get_contents("http://$address$path", false, $context);
    $headers = function_exists('http_get_last_response_headers')
        ? http_get_last_response_headers()
        : ($http_response_header ?? []);
    return [$body, $headers ?: []];
};

$assertStreamError = static function (string $path, string $kind) use ($temp): void {
    foreach (file("$temp/events.ndjson", FILE_IGNORE_NEW_LINES) as $line) {
        $event = json_decode($line, true, flags: JSON_THROW_ON_ERROR);
        if (($event['type'] ?? '') === 'http.stream.error' && ($event['path'] ?? '') === $path
            && ($event['error_class'] ?? '') === 'WorkerStaticProbeFailure' && ($event['error'] ?? '') === $kind) {
            return;
        }
    }
    throw new RuntimeException("vhttpd did not report the exception for $path");
};

$failStream = static function (string $kind, string $mode) use ($address, $temp, $assertStreamError): void {
    $disconnect = str_starts_with($mode, 'sse-disconnect');
    $route = $disconnect ? $mode : "$mode-fail";
    $path = "/$route/$kind";
    $release = "$temp/release-$route-$kind";
    $socket = stream_socket_client("tcp://$address", timeout: 3.0);
    stream_set_timeout($socket, 6);
    try {
        fwrite($socket, "GET $path HTTP/1.1\r\nHost: $address\r\nConnection: close\r\n\r\n");
        $status = fgets($socket);
        $headers = [];
        while (($line = fgets($socket)) !== false && $line !== "\r\n") {
            $headers[] = strtolower(trim($line));
        }
        if (!preg_match('/^HTTP\/\S+ 200\b/', (string) $status)) {
            throw new RuntimeException("Expected HTTP 200 for the $kind $mode stream");
        }
        if ($mode !== 'stream') {
            $event = "id: $kind\nevent: ready\ndata: first-$kind\n\n";
            if (!in_array('content-type: text/event-stream', $headers, true)
                || stream_get_contents($socket, strlen($event)) !== $event) {
                throw new RuntimeException("Did not receive the first complete $kind SSE event");
            }
        } else {
            $firstChunk = "first-$kind\n";
            if (!in_array('transfer-encoding: chunked', $headers, true)
                || trim((string) fgets($socket)) !== dechex(strlen($firstChunk))
                || stream_get_contents($socket, strlen($firstChunk) + 2) !== "$firstChunk\r\n") {
                throw new RuntimeException("Did not receive the first $kind chunk");
            }
        }
        if ($disconnect) {
            $ready = "$temp/deepest-ready-$route-$kind";
            $deadline = microtime(true) + 3;
            do {
                clearstatcache(true, $ready);
                if (is_file($ready)) {
                    break;
                }
                usleep(10_000);
            } while (microtime(true) < $deadline);
            if (!is_file($ready)) {
                throw new RuntimeException("The deepest $kind worker did not start before disconnect");
            }
            $client = socket_import_stream($socket);
            if ($client === false || !socket_set_option($client, SOL_SOCKET, SO_LINGER, ['l_onoff' => 1, 'l_linger' => 0])) {
                throw new RuntimeException("Could not reset the $kind SSE connection");
            }
        } else {
            touch($release);
            $end = $mode === 'sse' ? '' : "0\r\n\r\n";
            if (stream_get_contents($socket) !== $end || !feof($socket) || stream_get_meta_data($socket)['timed_out']) {
                throw new RuntimeException("The failed $kind $mode stream did not terminate cleanly");
            }
        }
    } finally {
        fclose($socket);
    }
    if ($disconnect) {
        touch($release);
        return;
    }

    // The HTTP status is already committed. vhttpd reports the terminal worker
    // error in its event log and closes the response.
    $assertStreamError($path, $kind);
};

try {
    $deadline = microtime(true) + 8.0;
    do {
        [$health] = $request('/health', 0.2);
        if (trim((string) $health) === 'OK') {
            break;
        }
        usleep(50_000);
    } while (microtime(true) < $deadline);
    if (trim((string) $health) !== 'OK') {
        throw new RuntimeException('vhttpd health probe timed out');
    }

    [$failureBody, $failureHeaders] = $request('/zend-static-fail');
    if (!preg_match('/^HTTP\/\S+ 500\b/', $failureHeaders[0] ?? '')
        || trim((string) $failureBody) !== 'Worker Error: zend-static') {
        throw new RuntimeException('Expected ordinary static request failure: ' . json_encode([$failureBody, $failureHeaders]));
    }
    $workerPid = (int) file_get_contents("$temp/zend-static-failure.pid");
    $destructorPidFile = "$temp/zend-static-destructor.pid";
    if (!is_file($destructorPidFile) || (int) file_get_contents($destructorPidFile) !== $workerPid) {
        throw new RuntimeException('The failing worker did not run and catch the destructor reentry');
    }
    for ($index = 0; $index < 2; $index++) {
        [$body, $headers] = $request('/fiber-static');
        if (!preg_match('/^HTTP\/\S+ 200\b/', $headers[0] ?? '')
            || json_decode((string) $body, true, flags: JSON_THROW_ON_ERROR) !== ['pid' => $workerPid]) {
            throw new RuntimeException('Interleaved Fiber static scopes failed on the worker: ' . json_encode([$body, $headers]));
        }
        [$body, $headers] = $request('/zend-static-recover');
        if (!preg_match('/^HTTP\/\S+ 200\b/', $headers[0] ?? '') || $workerPid <= 0
            || json_decode((string) $body, true, flags: JSON_THROW_ON_ERROR) !== [$workerPid, 41, 43, 71, 83]) {
            throw new RuntimeException('Ordinary static references did not reset on the same worker: ' . json_encode([$body, $headers]));
        }
    }
    printf("ordinary Zend static references reset across HTTP requests on worker PID %d\n", $workerPid);
    foreach ([
        ['generic', 'http'], ['legacy', 'http'],
        ['generic', 'stream'], ['legacy', 'stream'],
        ['generic', 'sse'], ['legacy', 'sse'],
        ['generic', 'sse-disconnect'], ['legacy', 'sse-disconnect'],
        ['generic', 'sse-disconnect-fail'], ['legacy', 'sse-disconnect-fail'],
        ['generic', 'sse-disconnect-catch'], ['legacy', 'sse-disconnect-catch'],
        ['generic', 'sse-disconnect-catch-outer'], ['legacy', 'sse-disconnect-catch-outer'],
        ['generic', 'sse-disconnect-rethrow'], ['legacy', 'sse-disconnect-rethrow'],
        ['generic', 'sse-disconnect-rethrow-both'], ['legacy', 'sse-disconnect-rethrow-both'],
    ] as [$kind, $mode]) {
        $escapesWorker = in_array($mode, ['sse-disconnect-fail', 'sse-disconnect-rethrow-both'], true);
        $pidFile = str_starts_with($mode, 'sse-disconnect') && !$escapesWorker
            ? "$temp/disconnect.pid"
            : "$temp/failure.pid";
        @unlink($pidFile);
        if ($mode !== 'http') {
            $failStream($kind, $mode);
        } else {
            [$failureBody, $failureHeaders] = $request("/fail/$kind");
            if (!preg_match('/^HTTP\/\S+ 500\b/', $failureHeaders[0] ?? '')
                || !in_array('x-vhttpd-error-class: workerstaticprobefailure', array_map('strtolower', $failureHeaders), true)
                || trim((string) $failureBody) !== "Worker Error: $kind") {
                throw new RuntimeException("Expected the $kind worker exception to return HTTP 500: " . json_encode([$failureBody, $failureHeaders]));
            }
        }
        [$body, $headers] = $request('/recover');
        if (!preg_match('/^HTTP\/\S+ 200\b/', $headers[0] ?? '')) {
            throw new RuntimeException("Expected HTTP 200 after the $kind worker exception: " . json_encode([$body, $headers]));
        }
        $failedPid = is_file($pidFile) ? (int) file_get_contents($pidFile) : 0;
        $result = json_decode((string) $body, true, flags: JSON_THROW_ON_ERROR);
        $expected = [
            'generic' => [6, 112, 'php:V:V:child', 'php:V:V:child', ['count' => 112, 'label' => 'php:V:V:child']],
            'legacy' => [1, 212, 'php:V:V:child', 'php:V:V:child', ['count' => 212, 'label' => 'php:V:V:child']],
        ];
        if ($result['states'] !== $expected
            || $failedPid <= 0 || $result['pid'] !== $failedPid || ($workerPid !== null && $workerPid !== $failedPid)) {
            throw new RuntimeException("Worker did not recover in the same process: " . json_encode([$failedPid, $result, $headers]));
        }
        if ($escapesWorker) {
            $assertStreamError("/$mode/$kind", $kind);
        }
        $workerPid = $failedPid;
        $outcome = match ($mode) {
            'http' => 'HTTP 500',
            'sse-disconnect' => 'SSE disconnect with nested writes',
            'sse-disconnect-fail' => 'SSE disconnect with nested exception',
            'sse-disconnect-catch' => 'SSE disconnect with exception caught in the middle',
            'sse-disconnect-catch-outer' => 'SSE disconnect with exception caught outside the middle scope',
            'sse-disconnect-rethrow' => 'SSE disconnect with exception rethrown by the middle scope',
            'sse-disconnect-rethrow-both' => 'SSE disconnect with exception rethrown by both scopes',
            default => "$mode error",
        };
        printf("%s %s followed by HTTP 200 on worker PID %d\n", $kind, $outcome, $workerPid);
    }
} catch (Throwable $error) {
    fwrite(STDERR, file_get_contents($log) ?: '');
    throw $error;
} finally {
    if (!stop_vhttpd($process)) {
        throw new RuntimeException('vhttpd did not stop');
    }
}
