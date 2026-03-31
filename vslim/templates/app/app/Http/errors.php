<?php
declare(strict_types=1);

return [
    "not_found" => function (\VSlim\Psr7\ServerRequest $request): array {
        return [
            "status" => 404,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "template-not-found",
                    "path" => $request->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
    "error" => function (
        \VSlim\Psr7\ServerRequest $request,
        string $message,
        int $status,
    ): array {
        return [
            "status" => $status,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => false,
                    "error" => "template-runtime",
                    "status" => $status,
                    "message" => $message,
                    "path" => $request->getUri()->getPath(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    },
];
