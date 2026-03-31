<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->get_named(
        "template.home",
        "/",
        [\App\Http\Controllers\HomeController::class, "index"],
    );

    $app->get("/health", function () use ($app): string {
        return implode("|", [
            "ok",
            $app->config()->get_string("app.name", ""),
            (string) $app->container()->get("template.message"),
        ]);
    });

    $app->get("/broken", "missing.service");
};
