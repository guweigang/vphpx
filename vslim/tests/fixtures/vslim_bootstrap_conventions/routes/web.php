<?php
declare(strict_types=1);

require_once dirname(__DIR__) . "/support.php";

use Psr\Http\Message\ServerRequestInterface;

return function (VSlim\App $app): void {
    $app->get("/hello", function (ServerRequestInterface $request) use ($app): string {
        return implode("|", [
            "hello",
            $app->config()->getString("app.name", ""),
            (string) $app->container()->get("provider.message"),
            (string) $app->container()->get("provider.booted"),
            (string) $request->getAttribute("mw", ""),
        ]);
    });

    $app->get("/broken", "missing.service");
};
