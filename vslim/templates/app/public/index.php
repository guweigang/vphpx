<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/bootstrap/http.php';

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
