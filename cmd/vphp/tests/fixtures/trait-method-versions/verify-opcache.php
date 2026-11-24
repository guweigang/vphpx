<?php
declare(strict_types=1);

if (PHP_SAPI === 'cli-server') {
    require __DIR__ . '/verify.php';
    $cache = opcache_get_status(false);
    if ($cache === false || !$cache['opcache_enabled']) {
        throw new RuntimeException('The server did not enable OPcache');
    }
    echo json_encode(['pid' => getmypid(), 'hits' => $cache['opcache_statistics']['hits']], JSON_THROW_ON_ERROR);
    return;
}

[, $extension, $log] = $argv;
$socket = stream_socket_server('tcp://127.0.0.1:0');
if ($socket === false) {
    throw new RuntimeException('Could not reserve an OPcache test port');
}
$address = stream_socket_get_name($socket, false);
fclose($socket);

$server = proc_open([
    PHP_BINARY, '-n', '-d', "extension=$extension",
    '-d', 'opcache.enable=1', '-d', 'opcache.enable_cli=1',
    '-d', 'opcache.file_update_protection=0',
    '-S', $address, __FILE__,
], [
    0 => ['file', '/dev/null', 'r'],
    1 => ['file', $log, 'a'],
    2 => ['redirect', 1],
], $pipes);
if (!is_resource($server)) {
    throw new RuntimeException('Could not start the PHP test server');
}

try {
    $client = stream_context_create(['http' => ['timeout' => 5.0]]);
    $url = "http://$address/";
    $deadline = microtime(true) + 15.0;
    do {
        $first = @file_get_contents($url, false, $client);
        if ($first !== false || !proc_get_status($server)['running']) {
            break;
        }
        usleep(50_000);
    } while (microtime(true) < $deadline);
    $second = $first === false ? false : file_get_contents($url, false, $client);
    if ($first === false || $second === false) {
        throw new RuntimeException('The OPcache test server failed to respond.' . PHP_EOL . file_get_contents($log));
    }
    $firstResult = json_decode($first, true, flags: JSON_THROW_ON_ERROR);
    $secondResult = json_decode($second, true, flags: JSON_THROW_ON_ERROR);
    if ($firstResult['pid'] !== $secondResult['pid'] || $secondResult['hits'] <= $firstResult['hits']) {
        throw new RuntimeException('The trait was not verified in consecutive cached requests in one PHP process');
    }
} finally {
    proc_terminate($server);
    proc_close($server);
}
