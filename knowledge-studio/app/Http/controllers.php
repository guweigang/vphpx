<?php
declare(strict_types=1);

require_once __DIR__ . '/Controllers/HomeController.php';
require_once __DIR__ . '/Controllers/AuthController.php';
require_once __DIR__ . '/Controllers/ConsoleController.php';
require_once __DIR__ . '/Controllers/PublicController.php';
require_once dirname(__DIR__) . '/Support/DemoCatalog.php';
require_once dirname(__DIR__) . '/Services/ConsoleWorkspaceService.php';

return function (VSlim\App $app): void {
    $catalog = $app->container()->get('studio.catalog');
    $consoleService = $app->container()->get(\App\Services\ConsoleWorkspaceService::class);

    $app->container()->set(
        \App\Http\Controllers\HomeController::class,
        new \App\Http\Controllers\HomeController($app)
    );
    $app->container()->set(
        \App\Http\Controllers\AuthController::class,
        new \App\Http\Controllers\AuthController($app, $catalog)
    );
    $app->container()->set(
        \App\Http\Controllers\ConsoleController::class,
        new \App\Http\Controllers\ConsoleController($app, $catalog, $consoleService)
    );
    $app->container()->set(
        \App\Http\Controllers\PublicController::class,
        new \App\Http\Controllers\PublicController($app, $catalog)
    );
};
