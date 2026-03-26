<?php

declare(strict_types=1);

function ws_fixture_handshake(string $host, int $port, string $path)
{
    $conn = @stream_socket_client("tcp://{$host}:{$port}", $errno, $errstr, 5.0);
    if (!is_resource($conn)) {
        throw new RuntimeException("connect_failed: {$errstr} ({$errno})");
    }
    stream_set_blocking($conn, true);
    $key = base64_encode(random_bytes(16));
    $req = "GET {$path} HTTP/1.1\r\n"
        . "Host: {$host}:{$port}\r\n"
        . "Upgrade: websocket\r\n"
        . "Connection: Upgrade\r\n"
        . "Sec-WebSocket-Key: {$key}\r\n"
        . "Sec-WebSocket-Version: 13\r\n\r\n";
    fwrite($conn, $req);
    $response = '';
    while (!str_contains($response, "\r\n\r\n")) {
        $chunk = fread($conn, 2048);
        if ($chunk === '' || $chunk === false) {
            break;
        }
        $response .= $chunk;
    }
    if (!str_contains($response, '101 Switching Protocols')) {
        throw new RuntimeException("handshake_failed: {$response}");
    }
    return $conn;
}

function ws_fixture_send_text($conn, string $payload): void
{
    $mask = random_bytes(4);
    $len = strlen($payload);
    if ($len >= 126) {
        throw new RuntimeException('payload_too_large_for_fixture');
    }
    $header = chr(0x81) . chr(0x80 | $len);
    $masked = '';
    for ($i = 0; $i < $len; $i++) {
        $masked .= $payload[$i] ^ $mask[$i % 4];
    }
    fwrite($conn, $header . $mask . $masked);
}

function ws_fixture_read_frame($conn): ?array
{
    $h = fread($conn, 2);
    if (!is_string($h) || strlen($h) < 2) {
        return null;
    }
    $b1 = ord($h[0]);
    $b2 = ord($h[1]);
    $opcode = $b1 & 0x0f;
    $len = $b2 & 0x7f;
    if ($len === 126) {
        $ext = fread($conn, 2);
        if (!is_string($ext) || strlen($ext) < 2) {
            return null;
        }
        $len = unpack('nlen', $ext)['len'];
    } elseif ($len === 127) {
        throw new RuntimeException('payload_too_large_for_fixture');
    }
    $payload = '';
    while (strlen($payload) < $len) {
        $chunk = fread($conn, $len - strlen($payload));
        if ($chunk === '' || $chunk === false) {
            return null;
        }
        $payload .= $chunk;
    }
    return ['opcode' => $opcode, 'payload' => $payload];
}

function ws_fixture_read_json($conn): array
{
    $frame = ws_fixture_read_frame($conn);
    if (!is_array($frame)) {
        throw new RuntimeException('frame_read_failed');
    }
    if (($frame['opcode'] ?? 0) === 8) {
        throw new RuntimeException('unexpected_close_frame');
    }
    $decoded = json_decode((string) $frame['payload'], true);
    if (!is_array($decoded)) {
        throw new RuntimeException('invalid_json_payload: ' . (string) $frame['payload']);
    }
    return $decoded;
}

$host = $argv[1] ?? '127.0.0.1';
$port = isset($argv[2]) ? (int) $argv[2] : 19891;

$alice = ws_fixture_handshake($host, $port, '/ws?room=lobby&user=alice');
$aliceOpen = ws_fixture_read_json($alice);

$bob = ws_fixture_handshake($host, $port, '/ws?room=lobby&user=bob');
$bobOpen = ws_fixture_read_json($bob);
$aliceJoin = ws_fixture_read_json($alice);

ws_fixture_send_text($alice, (string) json_encode([
    'room' => 'lobby',
    'text' => 'hello-cross-worker',
], JSON_UNESCAPED_UNICODE));

$aliceSelf = ws_fixture_read_json($alice);
$bobRecv = ws_fixture_read_json($bob);

ws_fixture_send_text($alice, (string) json_encode([
    'room' => 'lobby',
    'text' => '/who',
], JSON_UNESCAPED_UNICODE));
$aliceWho = ws_fixture_read_json($alice);

echo ($aliceOpen['text'] ?? ''), PHP_EOL;
echo ($bobOpen['text'] ?? ''), PHP_EOL;
echo ($aliceJoin['text'] ?? ''), PHP_EOL;
echo ($aliceSelf['user'] ?? ''), '|', ($aliceSelf['text'] ?? ''), '|', (($aliceSelf['self'] ?? false) ? 'self' : 'peer'), PHP_EOL;
echo ($bobRecv['user'] ?? ''), '|', ($bobRecv['text'] ?? ''), '|', (($bobRecv['self'] ?? false) ? 'self' : 'peer'), PHP_EOL;
echo ($aliceWho['text'] ?? ''), PHP_EOL;

fclose($alice);
fclose($bob);
