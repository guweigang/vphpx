<?php
declare(strict_types=1);

$root = dirname(__DIR__);
$autoloadCandidates = [
    $root . '/vendor/autoload.php',
    $root . '/../../../../vhttpd/php/package/vendor/autoload.php',
    $root . '/../../../vhttpd/php/package/vendor/autoload.php',
];
foreach ($autoloadCandidates as $autoload) {
    if (!is_file($autoload)) {
        continue;
    }
    require_once $autoload;
    break;
}

\VSlim\EnvLoader::bootstrap($root);
\App\Support\PsrStubLoader::load();

function knowledge_studio_worker_log_path(): string
{
    $path = getenv('KS_WORKER_LOG');
    return is_string($path) ? trim($path) : '';
}

function knowledge_studio_log_worker(string $message): void
{
    $path = knowledge_studio_worker_log_path();
    if ($path === '') {
        return;
    }
    $line = '[' . date('c') . '][pid:' . getmypid() . '] ' . $message . "\n";
    @file_put_contents($path, $line, FILE_APPEND);
}

set_exception_handler(static function (\Throwable $e): void {
    knowledge_studio_log_worker(
        'uncaught_exception class=' . $e::class .
        ' message=' . $e->getMessage() .
        ' file=' . $e->getFile() .
        ' line=' . $e->getLine()
    );
    @file_put_contents(
        'php://stderr',
        '[ks-worker] uncaught_exception ' . $e::class . ': ' . $e->getMessage() . "\n"
    );
});

register_shutdown_function(static function (): void {
    $error = error_get_last();
    if (!is_array($error)) {
        return;
    }
    $fatalTypes = [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR];
    if (!in_array((int) ($error['type'] ?? 0), $fatalTypes, true)) {
        return;
    }
    knowledge_studio_log_worker(
        'fatal_shutdown type=' . (string) ($error['type'] ?? 0) .
        ' message=' . (string) ($error['message'] ?? '') .
        ' file=' . (string) ($error['file'] ?? '') .
        ' line=' . (string) ($error['line'] ?? 0)
    );
    @file_put_contents(
        'php://stderr',
        '[ks-worker] fatal_shutdown ' . (string) ($error['message'] ?? '') . "\n"
    );
});

function build_knowledge_studio_app(): VSlim\App
{
    return (new VSlim\App())->bootstrapDir(dirname(__DIR__));
}

function build_knowledge_studio_request_from_globals(): VSlim\Vhttpd\Request
{
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    $uri = $_SERVER['REQUEST_URI'] ?? '/';
    $body = file_get_contents('php://input') ?: '';
    $request = new VSlim\Vhttpd\Request($method, $uri, $body);

    $headers = [];
    foreach ($_SERVER as $key => $value) {
        if (!is_string($value)) {
            continue;
        }
        if (str_starts_with($key, 'HTTP_')) {
            $headers[strtolower(str_replace('_', '-', substr($key, 5)))] = $value;
        }
    }
    if (isset($_SERVER['CONTENT_TYPE']) && is_string($_SERVER['CONTENT_TYPE'])) {
        $headers['content-type'] = $_SERVER['CONTENT_TYPE'];
    }

    $server = [];
    foreach ($_SERVER as $key => $value) {
        if (is_scalar($value)) {
            $server[(string) $key] = (string) $value;
        }
    }

    $request->set_headers($headers);
    $request->set_cookies($_COOKIE);
    $request->set_server($server);
    $request->set_remote_addr((string) ($_SERVER['REMOTE_ADDR'] ?? ''));
    $request->set_scheme(
        !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' ? 'https' : 'http',
    );
    $request->set_host((string) ($_SERVER['HTTP_HOST'] ?? 'localhost'));

    return $request;
}

function emit_knowledge_studio_response(VSlim\Vhttpd\Response $response): void
{
    http_response_code($response->status);
    foreach ($response->headers() as $name => $value) {
        if ($name === '') {
            continue;
        }
        header($name . ': ' . $value, true);
    }
    echo $response->body;
}

function normalize_knowledge_studio_worker_response(VSlim\Vhttpd\Response $response): array
{
    return [
        'status' => $response->status,
        'content_type' => $response->content_type,
        'headers' => $response->headers(),
        'body' => $response->body,
    ];
}

function knowledge_studio_headers_from_envelope_map(array $map): array
{
    $headers = [];
    foreach ($map as $key => $value) {
        if (!is_string($key) || !str_starts_with($key, 'headers_')) {
            continue;
        }
        $name = substr($key, 8);
        if ($name === '') {
            continue;
        }
        $headers[strtolower($name)] = (string) $value;
    }
    return $headers;
}

function dispatch_knowledge_studio_envelope(VSlim\App $app, array $envelope): array
{
    if (method_exists($app, 'dispatch_envelope_map')) {
        $map = $app->dispatch_envelope_map($envelope);
        $headers = knowledge_studio_headers_from_envelope_map($map);
        $contentType = (string) ($map['content_type'] ?? 'text/plain; charset=utf-8');
        if (!isset($headers['content-type'])) {
            $headers['content-type'] = $contentType;
        }
        return [
            'status' => (int) ($map['status'] ?? '500'),
            'content_type' => $contentType,
            'headers' => $headers,
            'body' => (string) ($map['body'] ?? ''),
        ];
    }

    return normalize_knowledge_studio_worker_response($app->dispatch_envelope($envelope));
}

function knowledge_studio_app_handler(): callable
{
    return static function (mixed $request, array $envelope = []): array {
        static $app = null;
        if (!$app instanceof VSlim\App) {
            $app = build_knowledge_studio_app();
        }

        if ($envelope !== []) {
            return dispatch_knowledge_studio_envelope($app, $envelope);
        }

        if (is_object($request)) {
            if (class_exists(\VPhp\VSlim\Psr7Adapter::class)) {
                return normalize_knowledge_studio_worker_response(
                    \VPhp\VSlim\Psr7Adapter::dispatch($app, $request),
                );
            }
            return [
                'status' => 500,
                'content_type' => 'text/plain; charset=utf-8',
                'body' => 'PSR-7 bridge is not available',
            ];
        }

        if (is_array($request)) {
            return dispatch_knowledge_studio_envelope($app, $request);
        }

        return [
            'status' => 500,
            'content_type' => 'text/plain; charset=utf-8',
            'body' => 'No request payload available',
        ];
    };
}
