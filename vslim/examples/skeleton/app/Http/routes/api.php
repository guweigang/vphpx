<?php
declare(strict_types=1);

use Psr\Http\Message\ServerRequestInterface;

return function (VSlim\App $app): void {
    $app->get("/api/status", function (ServerRequestInterface $request) use ($app): array {
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => true,
                    "app" => $app->config()->get_string("app.name", ""),
                    "module" => (string) $app->container()->get("skeleton.module.booted"),
                    "mw" => (string) $request->getAttribute("skeleton_layer", ""),
                    "trace" => (string) $request->getHeaderLine("x-trace-id"),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });
};
