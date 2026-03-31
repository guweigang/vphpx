<?php
declare(strict_types=1);

use Psr\Http\Message\ServerRequestInterface;

return function (VSlim\App $app): void {
    $app->get_named("appdir.home", "/home", function (ServerRequestInterface $request) use ($app): string {
        return implode("|", [
            "home",
            $app->config()->get_string("app.name", ""),
            (string) $app->container()->get("app.provider"),
            (string) $request->getAttribute("dir_mw", ""),
        ]);
    });

    $app->get("/controller/home", [\App\Http\Controllers\PageController::class, "home"]);
    $app->get("/controller/bound", [\App\Http\Controllers\BoundPageController::class, "show"]);
};
