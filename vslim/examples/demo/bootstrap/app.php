<?php
declare(strict_types=1);

require_once __DIR__ . "/../support.php";

return [
    "base_path" => "/demo",
    "view_base_path" => dirname(__DIR__) . "/views",
    "assets_prefix" => "/assets",
    "not_found" => function ($req): array {
        return [
            "status" => 404,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "not_found",
                    "path" => $req->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
    "error" => function ($req, string $message, int $status): array {
        return [
            "status" => $status,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "runtime",
                    "status" => $status,
                    "message" => $message,
                    "path" => $req->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
    "providers" => require __DIR__ . "/providers.php",
    "middleware" => [
        DemoTraceMiddleware::class,
    ],
    "routes" => [
        require __DIR__ . "/../routes/web.php",
        require __DIR__ . "/../routes/api.php",
        require __DIR__ . "/../routes/debug.php",
    ],
    "boot" => true,
];
