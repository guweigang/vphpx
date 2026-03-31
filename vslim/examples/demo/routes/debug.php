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
                    "count" => $app->route_count(),
                    "names" => $app->route_names(),
                    "manifest" => $app->route_manifest(),
                    "manifest_lines" => $app->route_manifest_lines(),
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
                    "conflicts" => $app->route_conflicts(),
                    "conflict_keys" => $app->route_conflict_keys(),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });
};
