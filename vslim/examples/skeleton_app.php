<?php
declare(strict_types=1);

$autoload = __DIR__ . "/vendor/autoload.php";
if (!is_file($autoload)) {
    $autoload = __DIR__ . "/../../../vhttpd/php/package/vendor/autoload.php";
}
if (is_file($autoload)) {
    require_once $autoload;
}

use VPhp\VSlim\Psr7Adapter;

function build_skeleton_app(): VSlim\App
{
    return (new VSlim\App())->bootstrapDir(__DIR__ . "/skeleton");
}

function build_skeleton_request_from_globals(): VSlim\Vhttpd\Request
{
    $req = new VSlim\Vhttpd\Request();
    $method = $_SERVER["REQUEST_METHOD"] ?? "GET";
    $uri = $_SERVER["REQUEST_URI"] ?? "/";
    $body = file_get_contents("php://input") ?: "";

    $headers = [];
    foreach ($_SERVER as $k => $v) {
        if (!is_string($v)) {
            continue;
        }
        if (str_starts_with($k, "HTTP_")) {
            $headers[strtolower(str_replace("_", "-", substr($k, 5)))] = $v;
        }
    }
    if (
        isset($_SERVER["CONTENT_TYPE"]) &&
        is_string($_SERVER["CONTENT_TYPE"])
    ) {
        $headers["content-type"] = $_SERVER["CONTENT_TYPE"];
    }

    $serverMap = [];
    foreach ($_SERVER as $k => $v) {
        if (is_scalar($v)) {
            $serverMap[(string) $k] = (string) $v;
        }
    }

    $req->construct($method, $uri, $body);
    $req->set_headers($headers);
    $req->set_cookies($_COOKIE);
    $req->set_server($serverMap);
    $req->set_remote_addr((string) ($_SERVER["REMOTE_ADDR"] ?? ""));
    $req->set_scheme(
        !empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off"
            ? "https"
            : "http",
    );
    $req->set_host((string) ($_SERVER["HTTP_HOST"] ?? "localhost"));

    return $req;
}

function emit_skeleton_response(VSlim\Vhttpd\Response $res): void
{
    http_response_code($res->status);
    foreach ($res->headers() as $name => $value) {
        if ($name === "") {
            continue;
        }
        header($name . ": " . $value, true);
    }
    echo $res->body;
}

function normalize_skeleton_worker_response(VSlim\Vhttpd\Response $res): array
{
    return [
        "status" => $res->status,
        "content_type" => $res->content_type,
        "headers" => $res->headers(),
        "body" => $res->body,
    ];
}

function skeleton_app_handler(): callable
{
    return static function (mixed $request, array $envelope = []): array {
        static $app = null;
        if (!$app instanceof VSlim\App) {
            $app = build_skeleton_app();
        }

        if ($envelope !== []) {
            if (method_exists($app, "dispatch_envelope_map")) {
                $map = $app->dispatch_envelope_map($envelope);
                $headers = [];
                foreach ($map as $k => $v) {
                    if (!is_string($k) || !str_starts_with($k, "headers_")) {
                        continue;
                    }
                    $headers[substr($k, 8)] = (string) $v;
                }
                return [
                    "status" => (int) ($map["status"] ?? "500"),
                    "content_type" =>
                        (string) ($map["content_type"] ??
                            "text/plain; charset=utf-8"),
                    "headers" => $headers,
                    "body" => (string) ($map["body"] ?? ""),
                ];
            }
            return normalize_skeleton_worker_response(
                $app->dispatch_envelope($envelope),
            );
        }

        if (is_object($request)) {
            return normalize_skeleton_worker_response(
                Psr7Adapter::dispatch($app, $request),
            );
        }

        if (is_array($request)) {
            return normalize_skeleton_worker_response(
                $app->dispatch_envelope($request),
            );
        }

        return [
            "status" => 500,
            "content_type" => "text/plain; charset=utf-8",
            "body" => "No request payload available",
        ];
    };
}

function run_skeleton_self_test(): void
{
    $app = build_skeleton_app();

    $home = $app->dispatch("GET", "/?trace_id=skeleton-home");
    echo "GET / => {$home->status} " .
        (str_contains($home->body, "VSlim Skeleton Home") ? "home-ok" : "home-miss") .
        " | x-skeleton-after={$home->header("x-skeleton-after")}\n";

    $catalog = $app->dispatch("GET", "/catalog/books?trace_id=skeleton-catalog");
    echo "GET /catalog/books => {$catalog->status} {$catalog->body}\n";

    $module = $app->dispatch("GET", "/module/ping");
    echo "GET /module/ping => {$module->status} {$module->body}\n";

    $api = $app->dispatch("GET", "/api/status?trace_id=skeleton-api");
    echo "GET /api/status => {$api->status} {$api->body}\n";

    $links = $app->dispatch("GET", "/links");
    echo "GET /links => {$links->status} {$links->body}\n";

    $missing = $app->dispatch("GET", "/missing");
    echo "GET /missing => {$missing->status} {$missing->body}\n";

    $broken = $app->dispatch("GET", "/broken");
    echo "GET /broken => {$broken->status} {$broken->body}\n";
}

if (realpath((string) ($_SERVER["SCRIPT_FILENAME"] ?? "")) !== __FILE__) {
    return skeleton_app_handler();
}

if (!extension_loaded("vslim")) {
    fwrite(STDERR, "vslim extension is not loaded\n");
    exit(1);
}

if (PHP_SAPI === "cli" && in_array("--self-test", $argv ?? [], true)) {
    run_skeleton_self_test();
    exit(0);
}

if (PHP_SAPI === "cli" && !isset($_SERVER["REQUEST_METHOD"])) {
    echo "Usage:\n";
    echo "  php -d extension=./vslim.so vslim/examples/skeleton_app.php --self-test\n";
    echo "  php -d extension=./vslim.so -S 127.0.0.1:8089 vslim/examples/skeleton_app.php\n";
    exit(0);
}

$app = build_skeleton_app();
$response = $app->dispatch_request(build_skeleton_request_from_globals());
emit_skeleton_response($response);
