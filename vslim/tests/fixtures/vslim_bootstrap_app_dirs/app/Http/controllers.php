<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->container()->set(
        \App\Http\Controllers\BoundPageController::class,
        new \App\Http\Controllers\BoundPageController(
            (string) $app->container()->get("page.message")
        )
    );
};
