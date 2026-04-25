<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $api = $app->group("/api");
    $api->getNamed("api.users.show", "/users/:id", [
        DemoUserController::class,
        "show",
    ]);
    $api->map(["PUT", "PATCH"], "/users/:id", [
        DemoUserController::class,
        "update",
    ]);

    $app->resource("/rest/users", DemoUserController::class);
};
