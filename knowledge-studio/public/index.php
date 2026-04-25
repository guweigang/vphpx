<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/bootstrap/http.php';

if (!extension_loaded('vslim')) {
    fwrite(STDERR, "vslim extension is not loaded\n");
    exit(1);
}

if (PHP_SAPI === 'cli' && !isset($_SERVER['REQUEST_METHOD'])) {
    echo "Usage:\n";
    echo "  php -d extension=../vslim/vslim.so -S 127.0.0.1:8094 public/index.php\n";
    exit(0);
}

$app = build_knowledge_studio_app();
$response = $app->dispatchRequest(build_knowledge_studio_request_from_globals());
emit_knowledge_studio_response($response);
