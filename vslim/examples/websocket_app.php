<?php

declare(strict_types=1);

$html = <<<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VSlim WebSocket Room Demo</title>
  <script defer src="/assets/websocket_app.js"></script>
  <style>
    :root {
      --bg: #f6f1e8;
      --panel: #fffdf8;
      --line: #ddcfbc;
      --ink: #18212f;
      --muted: #6a7280;
      --accent: #0f766e;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: "Iowan Old Style", "Palatino Linotype", serif;
      color: var(--ink);
      background:
        radial-gradient(circle at top left, rgba(15, 118, 110, 0.15), transparent 28%),
        linear-gradient(180deg, #fcf8f0 0%, var(--bg) 100%);
    }
    main { max-width: 980px; margin: 0 auto; padding: 40px 20px 56px; }
    .panel {
      background: rgba(255, 253, 248, 0.92);
      border: 1px solid var(--line);
      border-radius: 22px;
      padding: 18px;
      box-shadow: 0 20px 48px rgba(24, 33, 47, 0.08);
    }
    .grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); }
    h1 { margin: 0 0 12px; font-size: clamp(34px, 5vw, 58px); line-height: 0.98; }
    p { color: var(--muted); line-height: 1.7; }
    label { display: block; margin: 0 0 8px; color: var(--muted); font-size: 13px; }
    input, textarea, button { width: 100%; font: inherit; }
    input, textarea { border: 1px solid var(--line); border-radius: 14px; padding: 12px 14px; background: white; color: var(--ink); }
    textarea { min-height: 220px; resize: vertical; font-family: ui-monospace, Menlo, monospace; font-size: 14px; line-height: 1.5; }
    .actions { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 14px; }
    button { width: auto; border: 0; border-radius: 999px; padding: 10px 16px; cursor: pointer; background: var(--ink); color: white; }
    button.secondary { background: white; color: var(--ink); border: 1px solid var(--line); }
    code { background: rgba(0,0,0,0.04); border-radius: 6px; padding: 0.15em 0.35em; }
  </style>
</head>
<body>
  <main data-vslim-websocket-demo="1">
    <section style="margin-bottom: 24px;">
      <p style="margin: 0 0 8px; color: var(--accent); font-size: 12px; letter-spacing: 0.12em; text-transform: uppercase;">VSlim + vhttpd + php-worker</p>
      <h1>VSlim WebSocket Room Demo</h1>
      <p>This page serves HTTP through <code>VSlim\App</code>, upgrades <code>/ws</code> through <code>VSlim\WebSocket\App</code>, and uses connection-level room commands so multi-worker fanout still works.</p>
    </section>

    <section class="grid">
      <div class="panel">
        <label for="ws-url">WebSocket Endpoint</label>
        <input id="ws-url" value="ws://127.0.0.1:19891/ws">
        <label for="ws-room" style="margin-top: 14px;">Room</label>
        <input id="ws-room" value="lobby">
        <label for="ws-user" style="margin-top: 14px;">User</label>
        <input id="ws-user" value="codex">
        <label for="ws-message" style="margin-top: 14px;">Message</label>
        <input id="ws-message" value="hello">
        <div class="actions">
          <button id="ws-connect" type="button">Connect</button>
          <button id="ws-send" type="button">Send</button>
          <button id="ws-bye" type="button">Send bye</button>
          <button id="ws-disconnect" class="secondary" type="button">Disconnect</button>
          <button id="ws-clear" class="secondary" type="button">Clear Log</button>
        </div>
        <p style="margin-top: 14px;">HTTP metadata: <code>/meta</code>. Connect two browser tabs to the same room and you will see room broadcasts.</p>
      </div>

      <div class="panel">
        <label for="ws-log">Log</label>
        <textarea id="ws-log" readonly></textarea>
        <p id="ws-status">Idle.</p>
      </div>
    </section>
  </main>
</body>
</html>
HTML;

$app = new VSlim\App();

$app->get('/', static function () use ($html): VSlim\VHttpd\Response {
    return (new VSlim\VHttpd\Response(200, '', 'text/html; charset=utf-8'))->html($html);
});

$app->get('/health', static function (): VSlim\VHttpd\Response {
    return (new VSlim\VHttpd\Response(200, 'OK', 'text/plain; charset=utf-8'))->text('OK');
});

$app->get('/meta', static function (): VSlim\VHttpd\Response {
    return (new VSlim\VHttpd\Response(200, '', 'application/json; charset=utf-8'))->json((string) json_encode([
        'name' => 'vslim-websocket-room-demo',
        'http' => '/',
        'websocket' => '/ws',
        'room_demo' => true,
    ], JSON_UNESCAPED_UNICODE));
});

$wsEnvelope = static function (string $type, string $room, string $user, string $text, bool $self = false): string {
    return (string) json_encode([
        'type' => $type,
        'room' => $room,
        'user' => $user,
        'text' => $text,
        'self' => $self,
    ], JSON_UNESCAPED_UNICODE);
};

$wsWhoText = static function (array $frame, string $room): string {
    $roomCounts = is_array($frame['room_counts'] ?? null) ? $frame['room_counts'] : [];
    $presenceUsers = is_array($frame['presence_users'] ?? null) ? $frame['presence_users'] : [];
    $users = is_array($presenceUsers[$room] ?? null) ? $presenceUsers[$room] : [];
    sort($users);
    $count = (int) ($roomCounts[$room] ?? count($users));
    return $users === [] ? 'online (0): none' : 'online (' . $count . '): ' . implode(', ', $users);
};

$wsMeta = static function ($conn, array $frame): array {
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

$ws = new VSlim\WebSocket\App();

$ws
    ->onOpen(static function ($conn, array $frame) use ($wsMeta, $wsEnvelope): string {
        [$room, $user] = $wsMeta($conn, $frame);
        $conn->setMeta('user', $user);
        $conn->setPresence('online');
        $conn->join($room);
        $conn->broadcast($room, $wsEnvelope('system', $room, $user, $user . ' joined', false), 'text', $conn->id());
        return $wsEnvelope('system', $room, $user, 'joined ' . $room, true);
    })
    ->onMessage(static function ($conn, string $message, array $frame) use ($wsMeta, $wsEnvelope, $wsWhoText): ?string {
        if ($message === 'bye') {
            $conn->close(1000, 'bye');
            return null;
        }
        $payload = json_decode($message, true);
        if (!is_array($payload)) {
            $payload = ['text' => $message];
        }
        $metadata = is_array($frame['metadata'] ?? null) ? $frame['metadata'] : [];
        $user = trim((string) ($payload['user'] ?? ($metadata['user'] ?? 'guest')));
        $text = trim((string) ($payload['text'] ?? $message));
        [$room] = $wsMeta($conn, $frame);
        $room = trim((string) ($payload['room'] ?? $room));
        if ($room === '') {
            $room = 'lobby';
        }
        if ($text === '') {
            return null;
        }
        if ($text === '/who') {
            return $wsEnvelope('system', $room, $user, $wsWhoText($frame, $room), true);
        }
        $wire = $wsEnvelope('chat', $room, $user, $text, false);
        $conn->broadcast($room, $wire, 'text', $conn->id());
        return $wsEnvelope('chat', $room, $user, $text, true);
    })
    ->onClose(static function ($conn, int $code, string $reason, array $frame) use ($wsEnvelope): void {
        $rooms = is_array($frame['rooms'] ?? null) ? $frame['rooms'] : [];
        $metadata = is_array($frame['metadata'] ?? null) ? $frame['metadata'] : [];
        $user = (string) ($metadata['user'] ?? 'guest');
        foreach ($rooms as $room) {
            if (!is_string($room) || $room === '') {
                continue;
            }
            $conn->broadcast($room, $wsEnvelope('system', $room, $user, $user . ' left', false), 'text', $conn->id());
        }
    });

$app->websocket('/ws', $ws);

return $app;
