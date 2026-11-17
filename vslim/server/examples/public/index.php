<?php

header('Content-Type: application/json; charset=utf-8');

echo json_encode([
    'engine' => 'embed',
    'method' => $_SERVER['REQUEST_METHOD'],
    'uri' => $_SERVER['REQUEST_URI'],
    'query' => $_GET,
    'post' => $_POST,
], JSON_UNESCAPED_SLASHES);
