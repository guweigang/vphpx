<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->container()->set(
        \App\Http\Controllers\CatalogController::class,
        new \App\Http\Controllers\CatalogController(
            $app->container()->get(\SkeletonCatalogService::class)
        )
    );
};
