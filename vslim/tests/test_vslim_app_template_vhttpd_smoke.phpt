--TEST--
VSlim app template can serve requests through vhttpd and php-worker
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (getenv("CODEX_SANDBOX_NETWORK_DISABLED") === "1") print "skip";
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) print "skip";
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

function response_status_code(array $headers): int {
    $statusLine = $headers[0] ?? '';
    if (!preg_match('/\s(\d{3})\s/', (string) $statusLine, $m)) {
        return 0;
    }
    return (int) $m[1];
}

function response_header(array $headers, string $name): string {
    $prefix = strtolower($name) . ':';
    foreach ($headers as $header) {
        $line = strtolower((string) $header);
        if (!str_starts_with($line, $prefix)) {
            continue;
        }
        return trim(substr((string) $header, strlen($prefix)));
    }
    return '';
}

$root = dirname(__DIR__);
$repoRoot = dirname($root);
$bin = $repoRoot . '/vhttpd/vhttpd';
$templateRoot = $root . '/templates/app';
$workerPhp = $repoRoot . '/vhttpd/php/package/bin/php-worker';

$port = free_port();
$tmp = sys_get_temp_dir() . '/vslim_template_vhttpd_' . getmypid() . '_' . $port;
@mkdir($tmp, 0777, true);

$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$socket = $tmp . '/worker.sock';
$configPath = $tmp . '/vhttpd.toml';
$workerApp = $templateRoot . '/public/worker.php';

$toml = <<<TOML
[server]
host = "127.0.0.1"
port = {$port}

[files]
pid_file = "{$pidFile}"
event_log = "{$eventLog}"

[worker]
autostart = true
read_timeout_ms = 3000
socket = "{$socket}"
cmd = "php -d extension={$root}/vslim.so {$workerPhp} --socket {$socket}"

[worker.env]
VHTTPD_APP = "{$workerApp}"
TOML;
file_put_contents($configPath, $toml);

$cmd = sprintf(
    '%s --config %s >> %s 2>&1 &',
    escapeshellarg($bin),
    escapeshellarg($configPath),
    escapeshellarg($stdoutLog),
);
exec($cmd);

$base = 'http://127.0.0.1:' . $port;
$ready = false;
$deadline = microtime(true) + 8.0;
while (microtime(true) < $deadline) {
    $ctx = stream_context_create(['http' => ['timeout' => 0.2]]);
    $health = @file_get_contents($base . '/health', false, $ctx);
    if ($health !== false && trim((string) $health) === 'OK') {
        $ready = true;
        break;
    }
    usleep(100_000);
}
echo $ready ? "ready\n" : "not_ready\n";
if (!$ready) {
    exit;
}

$moduleCtx = stream_context_create([
    'http' => [
        'timeout' => 1.0,
        'ignore_errors' => true,
    ],
]);
$moduleBody = @file_get_contents($base . '/module/ping', false, $moduleCtx);
$moduleHeaders = last_response_headers();
echo response_status_code($moduleHeaders) . '|'
    . trim((string) $moduleBody) . '|'
    . response_header($moduleHeaders, 'x-template-app') . "\n";

$missingCtx = stream_context_create([
    'http' => [
        'timeout' => 1.0,
        'ignore_errors' => true,
    ],
]);
$missingBody = @file_get_contents($base . '/missing', false, $missingCtx);
$missingHeaders = last_response_headers();
echo response_status_code($missingHeaders) . '|'
    . trim((string) $missingBody) . "\n";

$pid = is_file($pidFile) ? (int) trim((string) file_get_contents($pidFile)) : 0;
if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
    usleep(200_000);
    exec(sprintf('kill -0 %d >/dev/null 2>&1', $pid), $noop, $alive);
    echo $alive === 0 ? "still_running\n" : "stopped\n";
} else {
    echo "stopped\n";
}
?>
--EXPECT--
ready
200|module|module-ready|yes|vslim-template
404|{"ok":false,"error":"template-not-found","path":"\/missing"}
stopped
