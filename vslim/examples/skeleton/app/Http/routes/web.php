<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->getNamed(
        "skeleton.home",
        "/",
        [\App\Http\Controllers\HomeController::class, "index"],
    );

    $app->getNamed(
        "skeleton.catalog",
        "/catalog/:slug",
        [\App\Http\Controllers\CatalogController::class, "show"],
    );

    $app->get("/broken", "missing.service");

    $app->get("/links", function () use ($app): string {
        return $app->urlFor("skeleton.catalog", ["slug" => "links"]);
    });
};
