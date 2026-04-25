<?php

declare(strict_types=1);

$app = new VSlim\App();

$app->get('/hello/:name', function ($req) {
    $res = new VSlim\VHttpd\Response(200, 'Hello, ' . $req->getAttribute('name'), 'text/plain; charset=utf-8');
    return $res->setHeader('x-app', 'builder-object');
});

$app->post('/submit', function ($req) {
    $query = $req->getQueryParams();
    return [
        'status' => 202,
        'content_type' => 'application/json; charset=utf-8',
        'headers' => ['x-app' => 'builder-object'],
        'body' => json_encode([
            'body' => (string) $req->getBody(),
            'trace' => $query['trace_id'] ?? 'none',
        ], JSON_UNESCAPED_UNICODE),
    ];
});

return $app;
