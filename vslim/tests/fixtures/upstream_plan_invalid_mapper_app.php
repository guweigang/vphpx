<?php
declare(strict_types=1);

use VPhp\VHttpd\Upstream\Plan;

return static function (mixed $request, array $envelope = []): array|Plan {
    $src = is_array($request) ? $request : $envelope;
    $pathWithQuery = (string) ($src['path'] ?? '/');
    $path = (string) (parse_url($pathWithQuery, PHP_URL_PATH) ?? '/');

    if ($path === '/health') {
        return [
            'status' => 200,
            'content_type' => 'text/plain; charset=utf-8',
            'body' => 'OK',
        ];
    }

    return Plan::http(
        url: 'http://127.0.0.1:11434/api/chat',
        method: 'POST',
        requestHeaders: [
            'content-type' => 'application/json',
            'accept' => 'application/x-ndjson',
        ],
        body: '{"stream":true}',
        codec: 'ndjson',
        mapper: 'unsupported_mapper',
        outputStreamType: 'text',
        outputContentType: 'text/plain; charset=utf-8',
        responseHeaders: [
            'x-demo' => 'invalid-mapper',
        ],
        name: 'invalid_mapper_demo',
        meta: [
            'field_path' => 'message.content',
        ],
    );
};
