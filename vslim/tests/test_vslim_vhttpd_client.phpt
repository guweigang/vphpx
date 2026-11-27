--TEST--
VSlim\\VHttpd\\Client speaks the php-worker framed unix socket protocol
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
if (!function_exists('proc_open')) print "skip";
$probe = '/tmp/vslim_vhttpd_client_probe_' . getmypid() . '.sock';
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
$childProbe = '/tmp/vslim_vhttpd_client_child_probe_' . getmypid() . '.sock';
@unlink($childProbe);
$cmd = sprintf(
    'php -r %s',
    escapeshellarg('$sock=$argv[1]; @unlink($sock); $errno=0; $errstr=""; $server=@stream_socket_server("unix://".$sock,$errno,$errstr); if(!is_resource($server)){fwrite(STDERR,"bind_failed:$errstr:$errno\n"); exit(2);} fclose($server); @unlink($sock);'),
);
$spec = [
    0 => ['pipe', 'r'],
    1 => ['pipe', 'w'],
    2 => ['pipe', 'w'],
];
$proc = proc_open($cmd . ' ' . escapeshellarg($childProbe), $spec, $pipes);
if (!is_resource($proc)) {
    print 'skip';
    return;
}
foreach ($pipes as $pipe) {
    if (is_resource($pipe)) {
        fclose($pipe);
    }
}
$code = proc_close($proc);
@unlink($childProbe);
if ($code !== 0) {
    print 'skip child unix socket unavailable';
}
?>
--FILE--
<?php
$tmp = '/tmp/vslim_vhttpd_client_' . getmypid() . '_' . random_int(1000, 9999);
@mkdir($tmp, 0777, true);
$sock = $tmp . '/client.sock';
$serverScript = $tmp . '/server.php';
$stdoutLog = $tmp . '/server.out';
$stderrLog = $tmp . '/server.err';

$serverPhp = <<<'PHP'
<?php
$socketPath = $argv[1] ?? '';
@unlink($socketPath);
$errno = 0;
$errstr = '';
$server = stream_socket_server('unix://' . $socketPath, $errno, $errstr);
if (!is_resource($server)) {
    fwrite(STDERR, "bind_failed:$errstr:$errno\n");
    exit(2);
}
touch($socketPath . '.ready');

$readExactly = static function ($conn, int $len): ?string {
    $buf = '';
    while (strlen($buf) < $len) {
        $chunk = fread($conn, $len - strlen($buf));
        if ($chunk === '' || $chunk === false) {
            return null;
        }
        $buf .= $chunk;
    }
    return $buf;
};

$readFrame = static function ($conn) use ($readExactly): ?string {
    $header = $readExactly($conn, 4);
    if ($header === null) {
        return null;
    }
    $len = unpack('Nlen', $header);
    $size = (int) ($len['len'] ?? 0);
    if ($size <= 0) {
        return null;
    }
    return $readExactly($conn, $size);
};

$writeFrame = static function ($conn, string $payload): void {
    fwrite($conn, pack('N', strlen($payload)) . $payload);
};

$conn = stream_socket_accept($server, 5.0);
if (!is_resource($conn)) {
    fwrite(STDERR, "accept_timeout\n");
    exit(3);
}
stream_set_timeout($conn, 0, 150000);

$rawRequest = $readFrame($conn);
$request = is_string($rawRequest) ? json_decode($rawRequest, true) : null;
$frames = [];
while (true) {
    $rawFrame = $readFrame($conn);
    if (!is_string($rawFrame)) {
        break;
    }
    $frames[] = $rawFrame;
}

$response = json_encode([
    'ok' => true,
    'request' => $request,
    'frames' => $frames,
    'frame_count' => count($frames),
], JSON_UNESCAPED_UNICODE);

$writeFrame($conn, (string) $response);
fclose($conn);
fclose($server);
?>
PHP;
file_put_contents($serverScript, $serverPhp);

$startServer = static function () use ($serverScript, $sock, $stdoutLog, $stderrLog) {
    @unlink($sock);
    $ready = $sock . '.ready';
    @unlink($ready);
    $cmd = sprintf(
        'php %s %s',
        escapeshellarg($serverScript),
        escapeshellarg($sock),
    );
    $spec = [
        0 => ['pipe', 'r'],
        1 => ['file', $stdoutLog, 'a'],
        2 => ['file', $stderrLog, 'a'],
    ];
    $proc = proc_open($cmd, $spec, $pipes);
    if (!is_resource($proc)) {
        throw new RuntimeException('proc_open_failed');
    }
    foreach ($pipes as $pipe) {
        if (is_resource($pipe)) {
            fclose($pipe);
        }
    }
    $deadline = microtime(true) + 3.0;
    while (microtime(true) < $deadline) {
        clearstatcache(true, $ready);
        if (is_file($ready)) {
            unlink($ready);
            return $proc;
        }
        usleep(20000);
    }
    proc_terminate($proc);
    proc_close($proc);
    throw new RuntimeException('socket_not_ready');
};

$stopServer = static function ($proc) {
    $status = proc_get_status($proc);
    if (($status['running'] ?? false) === true) {
        proc_terminate($proc);
    }
    proc_close($proc);
};

$client = new VSlim\VHttpd\Client(connectTimeoutSeconds: 2.0, socketPath: $sock);
$signature = new ReflectionMethod($client, 'requestFrames');
[$payload, $frames] = $signature->getParameters();
if ($signature->getNumberOfRequiredParameters() !== 1 || $payload->getName() !== 'payload'
    || $frames->getName() !== 'frames' || (string) $frames->getType() !== '?array'
    || $frames->getDefaultValue() !== [] || (string) $signature->getReturnType() !== 'array') {
    throw new RuntimeException('Unexpected requestFrames signature');
}

$proc = $startServer();
$res = $client->request(payload: [
    'mode' => 'db',
    'op' => 'ping',
    'payload' => ['a' => '1'],
]);
echo ($res['ok'] ? 'ok' : 'fail') . '|' . $res['request']['mode'] . '|' . $res['request']['op'] . '|' . $res['frame_count'] . PHP_EOL;
$stopServer($proc);

$proc = $startServer();
$res = $client->requestFrames(
    frames: ['chunk-1', 'chunk-2'],
    payload: ['mode' => 'db', 'op' => 'query'],
);
echo $res['request']['mode'] . '|' . $res['request']['op'] . '|' . implode(',', $res['frames']) . '|' . $res['frame_count'] . PHP_EOL;
$stopServer($proc);

foreach (['omitted' => [], 'null' => ['frames' => null]] as $label => $arguments) {
    $proc = $startServer();
    try {
        $res = $client->requestFrames(...($arguments + ['payload' => ['mode' => 'db', 'op' => 'ping']]));
        echo $label, '|', $res['frame_count'], PHP_EOL;
    } finally {
        $stopServer($proc);
    }
}
?>
--EXPECT--
ok|db|ping|0
db|query|chunk-1,chunk-2|2
omitted|0
null|0
