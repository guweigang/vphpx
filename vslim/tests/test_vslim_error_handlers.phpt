--TEST--
VSlim\App supports custom not_found and error handlers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->get('/ok', function ($req) {
    return 'ok';
});
$app->post('/write', function ($req) {
    return 'w:' . (string) $req->getBody();
});
$app->get('/bad', function ($req) {
    return 123;
});

$app->setNotFoundHandler(function ($req) {
    return [
        'status' => 404,
        'content_type' => 'application/json; charset=utf-8',
        'body' => json_encode(['missing' => $req->getUri()->getPath()]),
    ];
});

$app->setErrorHandler(function ($req, string $message, int $status) {
    return [
        'status' => $status,
        'content_type' => 'application/json; charset=utf-8',
        'body' => json_encode([
            'path' => $req->getUri()->getPath(),
            'status' => $status,
            'message' => $message,
        ]),
    ];
});

echo $app->dispatch('GET', '/missing')->status . '|' . $app->dispatch('GET', '/missing')->body . PHP_EOL;
echo $app->dispatch('GET', '/bad')->status . '|' . $app->dispatch('GET', '/bad')->body . PHP_EOL;
echo $app->dispatch('GET', '/write')->status . '|' . $app->dispatch('GET', '/write')->body . PHP_EOL;

$app->setNotFoundHandler(static function &() {
    $response = ['status' => 418, 'body' => 'referenced missing'];
    return $response;
});
$app->setErrorHandler(static function &() {
    $response = (new VSlim\Psr7\Response(503))->withBody(new VSlim\Psr7\Stream('referenced error'));
    return $response;
});
foreach (['/missing' => [418, 'referenced missing'], '/bad' => [503, 'referenced error']] as $path => $expected) {
    $raw = $app->dispatch('GET', $path);
    $psr = $app->handle(request: (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('GET', $path));
    if ([$raw->status, $raw->body] !== $expected
        || [$psr->getStatusCode(), (string) $psr->getBody()] !== $expected) {
        throw new RuntimeException("Unexpected referenced handler response for $path");
    }
}

try {
    $app->setNotFoundHandler(123);
    echo "not_found_invalid_not_thrown\n";
} catch (Throwable $e) {
    echo "not_found_invalid_thrown\n";
}

try {
    $app->setErrorHandler(123);
    echo "error_invalid_not_thrown\n";
} catch (Throwable $e) {
    echo "error_invalid_thrown\n";
}
?>
--EXPECT--
404|{"missing":"\/missing"}
500|{"path":"\/bad","status":500,"message":"Invalid route response"}
405|{"path":"\/write","status":405,"message":"Method not allowed"}
not_found_invalid_thrown
error_invalid_thrown
