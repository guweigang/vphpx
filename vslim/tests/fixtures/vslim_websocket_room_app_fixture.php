<?php

declare(strict_types=1);

$app = new VSlim\App();

$app->get('/meta', static function (): VSlim\Response {
    return (new VSlim\Response(200, '', 'application/json; charset=utf-8'))->json((string) json_encode([
        'name' => 'vslim-websocket-room-fixture',
        'websocket' => '/ws',
    ], JSON_UNESCAPED_UNICODE));
});

$encode = static function (string $type, string $room, string $user, string $text, bool $self = false): string {
    return (string) json_encode([
        'type' => $type,
        'room' => $room,
        'user' => $user,
        'text' => $text,
        'self' => $self,
    ], JSON_UNESCAPED_UNICODE);
};

$whoText = static function (array $frame, string $room): string {
    $roomCounts = is_array($frame['room_counts'] ?? null) ? $frame['room_counts'] : [];
    $presenceUsers = is_array($frame['presence_users'] ?? null) ? $frame['presence_users'] : [];
    $users = is_array($presenceUsers[$room] ?? null) ? $presenceUsers[$room] : [];
    sort($users);
    $count = (int) ($roomCounts[$room] ?? count($users));
    return $users === [] ? 'online (0): none' : 'online (' . $count . '): ' . implode(', ', $users);
};

$meta = static function (array $frame): array {
    $query = is_array($frame['query'] ?? null) ? $frame['query'] : [];
    $room = trim((string) ($query['room'] ?? 'lobby'));
    $user = trim((string) ($query['user'] ?? 'guest'));
    if ($room === '') {
        $room = 'lobby';
    }
    if ($user === '') {
        $user = 'guest';
    }
    return [$room, $user];
};

$ws = (new VSlim\WebSocket\App())
    ->on_open(static function ($conn, array $frame) use ($meta, $encode): string {
        [$room, $user] = $meta($frame);
        $conn->setMeta('user', $user);
        $conn->setPresence('online');
        $conn->join($room);
        $conn->broadcast($room, $encode('system', $room, $user, $user . ' joined', false), 'text', $conn->id());
        return $encode('system', $room, $user, 'joined ' . $room, true);
    })
    ->on_message(static function ($conn, string $message, array $frame) use ($meta, $encode, $whoText): ?string {
        if ($message === 'bye') {
            $conn->close(1000, 'bye');
            return null;
        }
        $payload = json_decode($message, true);
        if (!is_array($payload)) {
            $payload = ['text' => $message];
        }
        [$room] = $meta($frame);
        $room = trim((string) ($payload['room'] ?? $room));
        if ($room === '') {
            $room = 'lobby';
        }
        $metadata = is_array($frame['metadata'] ?? null) ? $frame['metadata'] : [];
        $user = trim((string) ($payload['user'] ?? ($metadata['user'] ?? 'guest')));
        $text = trim((string) ($payload['text'] ?? $message));
        if ($text === '') {
            return null;
        }
        if ($text === '/who') {
            return $encode('system', $room, $user, $whoText($frame, $room), true);
        }
        $wire = $encode('chat', $room, $user, $text, false);
        $conn->broadcast($room, $wire, 'text', $conn->id());
        return $encode('chat', $room, $user, $text, true);
    })
    ->on_close(static function ($conn, int $code, string $reason, array $frame) use ($encode): void {
        $rooms = is_array($frame['rooms'] ?? null) ? $frame['rooms'] : [];
        $metadata = is_array($frame['metadata'] ?? null) ? $frame['metadata'] : [];
        $user = (string) ($metadata['user'] ?? 'guest');
        foreach ($rooms as $room) {
            if (!is_string($room) || $room === '') {
                continue;
            }
            $conn->broadcast($room, $encode('system', $room, $user, $user . ' left', false), 'text', $conn->id());
        }
    });

$app->websocket('/ws', $ws);

return $app;
