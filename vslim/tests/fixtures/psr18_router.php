<?php

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';

if ($path === '/health') {
    header('Content-Type: text/plain');
    echo 'ok';
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
