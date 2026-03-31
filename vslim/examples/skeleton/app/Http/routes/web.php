<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->get_named(
        "skeleton.home",
        "/",
        [\App\Http\Controllers\HomeController::class, "index"],
    );

    $app->get_named(
        "skeleton.catalog",
        "/catalog/:slug",
        [\App\Http\Controllers\CatalogController::class, "show"],
    );

    $app->get("/broken", "missing.service");

    $app->get("/links", function () use ($app): string {
        return $app->url_for("skeleton.catalog", ["slug" => "links"]);
    });
};
