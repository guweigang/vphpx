<?php

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';

if ($path === '/health') {
    header('Content-Type: text/plain');
    echo 'ok';
    return;
}

if ($path === '/ollama-redirect') {
    header('Location: /status/404', true, 302);
    return;
}

$chunks = match ($path) {
    '/chunked-response' => "3;tag=first\r\na\0b\r\n2\r\ncd\r\n0\r\nX-Trace: done\r\n\r\n",
    '/chunked-no-last' => "3\r\nabc\r\n",
    '/chunked-short-data' => "6\r\nabc",
    '/chunked-short-trailer' => "3\r\nabc\r\n0\r\nX-Trace: partial\r\n",
    '/chunked-bad-delimiter' => "3\r\nabcXX0\r\n\r\n",
    default => null,
};
if ($chunks !== null) {
    header('Transfer-Encoding: chunked');
    echo $chunks;
    return;
}

if (in_array($path, ['/short-response', '/slow-response', '/complete-response'], true)) {
    header('Content-Length: ' . ($path === '/complete-response' ? '3' : '6'));
    echo 'abc';
    if ($path !== '/short-response') {
        while (ob_get_level() > 0) {
            ob_end_flush();
        }
        flush();
        usleep(2_200_000);
        if ($path === '/slow-response') {
            echo 'def';
        }
    }
    return;
}

$status = match ($path) {
    '/status/404' => 404,
    '/status/500' => 500,
    default => 200,
};

http_response_code($status);
header('Content-Type: application/json');
header('X-Reply-Path: ' . $path);

$headers = function_exists('getallheaders') ? getallheaders() : [];
ksort($headers);

echo json_encode([
    'method' => $_SERVER['REQUEST_METHOD'] ?? '',
    'path' => $path,
    'query' => $_GET,
    'body' => file_get_contents('php://input'),
    'headers' => $headers,
], JSON_UNESCAPED_SLASHES);
