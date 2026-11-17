<?php
declare(strict_types=1);

function launch_vhttpd(string $bin, string $config, string $log, array $args = []): mixed
{
    $process = proc_open([$bin, '--config', $config, ...$args], [
        0 => ['file', '/dev/null', 'r'],
        1 => ['file', $log, 'a'],
        2 => ['redirect', 1],
    ], $pipes);
    if (!is_resource($process)) {
        throw new RuntimeException('Could not start vhttpd');
    }
    register_shutdown_function(static function () use ($process): void {
        if (is_resource($process)) {
            proc_terminate($process, 9);
            proc_close($process);
        }
    });
    return $process;
}

function stop_vhttpd(mixed $process): bool
{
    proc_terminate($process);
    $deadline = microtime(true) + 5.0;
    while (proc_get_status($process)['running'] && microtime(true) < $deadline) {
        usleep(50_000);
    }
    if (proc_get_status($process)['running']) {
        return false;
    }
    proc_close($process);
    return true;
}
