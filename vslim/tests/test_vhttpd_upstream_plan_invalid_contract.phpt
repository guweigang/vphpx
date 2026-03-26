--TEST--
vhttpd rejects invalid upstream plan contracts with direct 502
--SKIPIF--
<?php
if (!is_file(dirname(__DIR__, 3) . '/vhttpd/vhttpd')) {
    echo "skip vhttpd binary missing";
    return;
}
$probeSock = sys_get_temp_dir() . '/vhttpd_upstream_contract_probe_' . getmypid() . '.sock';
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
$app = __DIR__ . '/fixtures/upstream_plan_invalid_mapper_app.php';
$serverPort = free_port();
$adminPort = free_port();
$tmp = sys_get_temp_dir() . '/vhttpd_upstream_contract_' . getmypid();
@mkdir($tmp, 0777, true);
$pidFile = $tmp . '/vhttpd.pid';
$eventLog = $tmp . '/events.ndjson';
$stdoutLog = $tmp . '/stdout.log';
$workerSock = $tmp . '/worker.sock';
$config = $tmp . '/contract.toml';

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
    $health = @file_get_contents("http://127.0.0.1:{$serverPort}/health", false, $ctx);
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

$ctx = stream_context_create(['http' => ['timeout' => 3.0, 'ignore_errors' => true]]);
$body = @file_get_contents("http://127.0.0.1:{$serverPort}/invalid", false, $ctx);
$headers = last_response_headers();
$status = $headers[0] ?? '';
$headerLines = implode("\n", $headers);
echo (str_contains($status, '502') ? "bad_gateway\n" : "not_bad_gateway\n");
echo (stripos($headerLines, 'x-vhttpd-error-class: unsupported_mapper') !== false ? "mapper_class\n" : "mapper_class_missing\n");
echo (trim((string) $body) === 'Bad Gateway' ? "body_ok\n" : "body_bad\n");

if ($pid > 0) {
    exec(sprintf('kill %d >/dev/null 2>&1', $pid));
}
?>
--EXPECT--
ready
bad_gateway
mapper_class
body_ok
