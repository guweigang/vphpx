<?php
declare(strict_types=1);

require_once __DIR__ . '/Controllers/HomeController.php';

return function (VSlim\App $app): void {
    $app->container()->set(
        \App\Http\Controllers\HomeController::class,
        new \App\Http\Controllers\HomeController($app)
    );
};
