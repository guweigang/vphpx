<?php

declare(strict_types=1);

$app = new VSlim\App();

$app->get('/health', static function (): VSlim\VHttpd\Response {
    return (new VSlim\VHttpd\Response(200, 'OK', 'text/plain; charset=utf-8'))->text('OK');
});

$app->get('/meta', static function (): VSlim\VHttpd\Response {
    return (new VSlim\VHttpd\Response(200, '', 'application/json; charset=utf-8'))->json((string) json_encode([
        'name' => 'vslim-websocket-fixture',
        'http' => '/health',
        'websocket' => '/ws',
    ], JSON_UNESCAPED_UNICODE));
});

$ws = (new VSlim\WebSocket\App())
    ->onOpen(static function ($conn, array $frame): string {
        return 'vslim:connected';
    })
    ->onMessage(static function ($conn, string $message, array $frame): ?string {
        if ($message === 'bye') {
            $conn->close(1000, 'bye');
            return null;
        }
        return 'vslim:' . $message;
    })
    ->onClose(static function ($conn, int $code, string $reason, array $frame): void {
    });

$app->websocket('/ws', $ws);

$app->websocket('/callback', static function &($conn, ...$arguments): ?string {
    $frame = $arguments[array_key_last($arguments)];
    $reply = match ($frame['event']) {
        'open' => 'callback:connected',
        'message' => 'callback:' . $arguments[0],
        default => null,
    };
    return $reply;
});
$app->websocket('/reject', static function &(): bool {
    $accepted = false;
    return $accepted;
});

foreach (['/reject-direct' => 'reject', '/close-during-open' => 'close'] as $path => $command) {
    $terminal = (new VSlim\WebSocket\App())->onMessage(static fn (): string => 'unexpected message');
    $terminal->onOpen(static function ($conn) use ($terminal, $command): string {
        $terminal->join('pending', $conn);
        if ($command === 'reject') {
            $conn->reject(401, 'denied');
        } else {
            $conn->close(1000, 'closed before accept');
        }
        return 'unexpected text frame';
    });
    $app->websocket($path, $terminal);
}

return $app;
