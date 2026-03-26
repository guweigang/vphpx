<?php
declare(strict_types=1);

return static function (mixed $request, array $envelope = []): array|\VPhp\VHttpd\PhpWorker\StreamResponse {
    $path = (string) ($envelope['path'] ?? '/');

    if ($path === '/helper/text') {
        $chunks = (function (): iterable {
            yield "alpha\n";
            yield "beta\n";
        })();

        return vhttpd_stream_text($chunks, 200, 'text/plain; charset=utf-8', [
            'x-helper-source' => 'text',
        ]);
    }

    if ($path === '/helper/sse') {
        $events = (function (): iterable {
            yield [
                'id' => 'evt-1',
                'event' => 'token',
                'data' => '{"token":"hello"}',
            ];
            yield [
                'id' => 'evt-2',
                'event' => 'done',
                'data' => '{"done":true}',
            ];
        })();

        return vhttpd_stream_sse($events, 200, [
            'x-helper-source' => 'sse',
        ]);
    }

    return [
        'status' => 404,
        'content_type' => 'text/plain; charset=utf-8',
        'body' => 'Not Found',
    ];
};
