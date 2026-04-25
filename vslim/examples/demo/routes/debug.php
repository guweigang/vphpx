<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $debug = $app->group("/debug");

    $debug->get("/routes", function () use ($app): array {
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "count" => $app->routeCount(),
                    "names" => $app->routeNames(),
                    "manifest" => $app->routeManifest(),
                    "manifest_lines" => $app->routeManifestLines(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });

    $debug->get("/route-conflicts", function () use ($app): array {
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "conflicts" => $app->routeConflicts(),
                    "conflict_keys" => $app->routeConflictKeys(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });
};
