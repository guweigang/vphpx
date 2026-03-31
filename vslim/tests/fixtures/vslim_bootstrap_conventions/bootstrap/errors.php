<?php
declare(strict_types=1);

return [
    "not_found" => function ($request): array {
        return [
            "status" => 404,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "missing-from-errors",
                    "path" => $request->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
    "error" => function ($request, string $message, int $status): array {
        return [
            "status" => $status,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "runtime-from-errors",
                    "status" => $status,
                    "message" => $message,
                    "path" => $request->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
];
