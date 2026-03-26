<?php

declare(strict_types=1);

$app = new VSlim\App();

$app->get('/health', static function (): VSlim\Response {
    return (new VSlim\Response(200, 'OK', 'text/plain; charset=utf-8'))->text('OK');
});

$app->get('/meta', static function (): VSlim\Response {
    return (new VSlim\Response(200, '', 'application/json; charset=utf-8'))->json((string) json_encode([
        'name' => 'vslim-websocket-fixture',
        'http' => '/health',
        'websocket' => '/ws',
    ], JSON_UNESCAPED_UNICODE));
});

$ws = (new VSlim\WebSocket\App())
    ->on_open(static function ($conn, array $frame): string {
        return 'vslim:connected';
    })
    ->on_message(static function ($conn, string $message, array $frame): ?string {
        if ($message === 'bye') {
            $conn->close(1000, 'bye');
            return null;
        }
        return 'vslim:' . $message;
    })
    ->on_close(static function ($conn, int $code, string $reason, array $frame): void {
    });

$app->websocket('/ws', $ws);

return $app;
