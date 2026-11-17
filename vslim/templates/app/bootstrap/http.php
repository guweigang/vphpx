<?php
declare(strict_types=1);

$root = dirname(__DIR__);
$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname($root, 3) . '/vhttpd';
$autoloadCandidates = [
    $root . '/vendor/autoload.php',
    dirname($root, 2) . '/vendor/autoload.php',
    $vhttpdRoot . '/php/package/vendor/autoload.php',
];
foreach ($autoloadCandidates as $autoload) {
    if (!is_file($autoload)) {
        continue;
    }
    require_once $autoload;
    break;
}

\VSlim\EnvLoader::bootstrap($root);

function build_template_app(): VSlim\App
{
    return (new VSlim\App())->bootstrapDir(dirname(__DIR__));
}

function build_template_request_from_globals(): VSlim\VHttpd\Request
{
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    $uri = $_SERVER['REQUEST_URI'] ?? '/';
    $body = file_get_contents('php://input') ?: '';
    $request = new VSlim\VHttpd\Request($method, $uri, $body);

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

    $request->setHeaders($headers);
    $request->setCookies($_COOKIE);
    $request->setServer($server);
    $request->setRemoteAddr((string) ($_SERVER['REMOTE_ADDR'] ?? ''));
    $request->setScheme(
        !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' ? 'https' : 'http',
    );
    $request->setHost((string) ($_SERVER['HTTP_HOST'] ?? 'localhost'));

    return $request;
}

function emit_template_response(VSlim\VHttpd\Response $response): void
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

require_once __DIR__ . '/worker.php';

function template_app_handler(): callable
{
    return static function (mixed $request, array $envelope = []): array|\VHttpd\PhpWorker\StreamResponse {
        static $app = null;
        if (!$app instanceof VSlim\App) {
            $app = build_template_app();
        }

        if ($envelope !== []) {
            return \VSlim\Worker\Adapter::dispatch($app, $envelope);
        }

        if (is_object($request)) {
            if (class_exists(\VSlim\Psr7Adapter::class)) {
                $vRequest = \VSlim\Psr7Adapter::toVSlimRequest($request);
                return \VSlim\Worker\Adapter::response(
                    $app->dispatchRequest($vRequest),
                );
            }
            return [
                'status' => 500,
                'content_type' => 'text/plain; charset=utf-8',
                'body' => 'PSR-7 bridge is not available',
            ];
        }

        if (is_array($request)) {
            return \VSlim\Worker\Adapter::dispatch($app, $request);
        }

        return [
            'status' => 500,
            'content_type' => 'text/plain; charset=utf-8',
            'body' => 'No request payload available',
        ];
    };
}
