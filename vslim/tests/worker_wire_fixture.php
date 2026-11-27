<?php
declare(strict_types=1);

require_once __DIR__ . '/php_worker_package_bootstrap.php';

use VHttpd\Wire\FrameCodec;

final class WorkerWireFixture
{
    private string $dir;
    private string $socket;
    private mixed $process = null;
    /** @var resource|null */
    private mixed $firstConnection = null;

    public function __construct(?string $entry = null, ?string $adapter = null)
    {
        $this->dir = '/tmp/vsw-' . bin2hex(random_bytes(8));
        $this->socket = $this->dir . '/worker.sock';
        if (!mkdir($this->dir, 0700)) {
            throw new RuntimeException('Could not create a worker fixture directory');
        }
        if ($adapter !== null) {
            $bootstrap = var_export(dirname(__DIR__) . '/templates/app/bootstrap/worker.php', true);
            $source = var_export($entry, true);
            $wrapper = $this->dir . '/app.php';
            file_put_contents($wrapper, "<?php\nrequire $bootstrap;\ndefine('VSLIM_TEST_WORKER_ENTRY', true);\nreturn $adapter(require $source);\n");
            $entry = $wrapper;
        }
        $root = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
        $env = getenv();
        if ($entry === null) {
            unset($env['VHTTPD_APP']);
        } else {
            $env['VHTTPD_APP'] = $entry;
        }
        $log = $this->dir . '/worker.log';
        $this->process = proc_open(
            [PHP_BINARY, '-d', 'extension=' . dirname(__DIR__) . '/vslim.so',
                $root . '/php/package/bin/vphp-worker', '--socket', $this->socket],
            [0 => ['file', '/dev/null', 'r'], 1 => ['file', $log, 'a'], 2 => ['redirect', 1]],
            $pipes,
            null,
            $env,
        );
        $deadline = microtime(true) + 5;
        while (is_resource($this->process) && proc_get_status($this->process)['running'] && microtime(true) < $deadline) {
            clearstatcache(true, $this->socket);
            if (file_exists($this->socket)) {
                $ready = @stream_socket_client('unix://' . $this->socket, $errno, $error, 0.1);
                if (is_resource($ready)) {
                    // Reuse the readiness connection for the first request. On Linux
                    // it may still be queued when the caller tries to connect again.
                    $this->firstConnection = $ready;
                    return;
                }
            }
            usleep(25_000);
        }
        $error = is_file($log) ? file_get_contents($log) : '';
        $this->close();
        throw new RuntimeException('Worker did not start: ' . $error);
    }

    public function frames(array $request): Generator
    {
        $conn = $this->firstConnection;
        $this->firstConnection = null;
        if ($conn === null) {
            $conn = stream_socket_client('unix://' . $this->socket, $errno, $error, 1);
        }
        if ($conn === false) {
            throw new RuntimeException('Worker connection failed: ' . $error);
        }
        try {
            stream_set_timeout($conn, 3);
            FrameCodec::write($conn, json_encode($request, JSON_THROW_ON_ERROR));
            $frame = json_decode(FrameCodec::read($conn), true, flags: JSON_THROW_ON_ERROR);
            yield $frame;
            if (($frame['event'] ?? '') === 'start') {
                do {
                    $frame = json_decode(FrameCodec::read($conn), true, flags: JSON_THROW_ON_ERROR);
                    yield $frame;
                } while (!in_array($frame['event'] ?? '', ['end', 'error'], true));
            }
        } finally {
            fclose($conn);
        }
    }

    public function request(array $request): array
    {
        return $this->frames($request)->current();
    }

    public function close(): void
    {
        if (is_resource($this->firstConnection)) {
            fclose($this->firstConnection);
            $this->firstConnection = null;
        }
        if (is_resource($this->process)) {
            proc_terminate($this->process);
            proc_close($this->process);
        }
        if (is_dir($this->dir)) {
            @unlink($this->socket);
            @unlink($this->dir . '/app.php');
            @unlink($this->dir . '/worker.log');
            rmdir($this->dir);
        }
    }

    public function __destruct()
    {
        $this->close();
    }
}
