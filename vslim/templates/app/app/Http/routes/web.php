<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->getNamed(
        "template.home",
        "/",
        [\App\Http\Controllers\HomeController::class, "index"],
    );

    $app->get("/health", function () use ($app): string {
        return implode("|", [
            "ok",
            $app->config()->getString("app.name", ""),
            (string) $app->container()->get("template.message"),
        ]);
    });

    $app->get("/broken", "missing.service");
};
