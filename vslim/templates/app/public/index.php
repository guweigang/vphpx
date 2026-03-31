<?php
declare(strict_types=1);

$root = dirname(__DIR__);
$autoload = $root . '/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = $root . '/../../../vhttpd/php/package/vendor/autoload.php';
}
if (is_file($autoload)) {
    require_once $autoload;
}

function build_template_app(): VSlim\App
{
    return (new VSlim\App())->bootstrapDir(dirname(__DIR__));
}

function build_template_request_from_globals(): VSlim\Vhttpd\Request
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

function emit_template_response(VSlim\Vhttpd\Response $response): void
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

if (!extension_loaded('vslim')) {
    fwrite(STDERR, "vslim extension is not loaded\n");
    exit(1);
}

if (PHP_SAPI === 'cli' && !isset($_SERVER['REQUEST_METHOD'])) {
    echo "Usage:\n";
    echo "  php -d extension=./vslim.so -S 127.0.0.1:8080 public/index.php\n";
    exit(0);
}

$app = build_template_app();
$response = $app->dispatch_request(build_template_request_from_globals());
emit_template_response($response);
