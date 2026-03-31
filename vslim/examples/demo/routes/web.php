<?php
declare(strict_types=1);

use Psr\Http\Message\ServerRequestInterface;

return function (VSlim\App $app): void {
    $app->get("/", function (): array {
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "name" => "vslim-demo",
                    "routes" =>
                        "GET /health, GET /hello/:name, GET /mvc/home/:name, POST /forms/echo, GET /api/users/:id, GET /rest/users, GET /debug/routes, GET /debug/route-conflicts",
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });

    $app->get("/health", fn () => "ok");

    $app->get("/hello/:name", function (ServerRequestInterface $req): string {
        return "hello " . $req->getAttribute("name");
    });

    $app->post("/forms/echo", function (ServerRequestInterface $req): array {
        $parsed = $req->getParsedBody();
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => true,
                    "body_format" => $req->getHeaderLine("content-type"),
                    "query" => $req->getQueryParams(),
                    "parsed_body" => $parsed,
                    "inputs" => array_merge(
                        $req->getQueryParams(),
                        is_array($parsed) ? $parsed : [],
                    ),
                    "uploaded_files" => array_keys($req->getUploadedFiles()),
                    "content_type" => $req->getHeaderLine("content-type"),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });

    $app->get("/auto/:id", DemoAutoPing::class);
    $app->get("/mvc/home/:name", [DemoPageController::class, "home"]);

    $app->get("/links", function () use ($app): array {
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "user_42" => $app->url_for("api.users.show", [
                        "id" => "42",
                    ]),
                    "user_42_abs" => $app->url_for_abs(
                        "api.users.show",
                        ["id" => "42"],
                        "https",
                        "example.local",
                    ),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    });

    $app->get("/broken", function () {
        return fopen("php://memory", "r");
    });
};
