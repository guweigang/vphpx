<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $catalog = $app->container()->get('studio.catalog');
    $locales = $app->container()->get(\App\Support\LocaleCatalog::class);
    $urls = $app->container()->get(\App\Support\LocalizedUrlBuilder::class);
    $workspaces = $app->container()->get(\App\Repositories\WorkspaceRepository::class);
    $consoleService = $app->container()->get(\App\Services\ConsoleWorkspaceService::class);
    $answerService = $app->container()->get(\App\Services\AssistantAnswerService::class);
    $answerPresenter = $app->container()->get(\App\Presenters\AssistantAnswerPresenter::class);
    $brandPresenter = $app->container()->get(\App\Presenters\PublicBrandPresenter::class);
    $publicService = $app->container()->get(\App\Services\PublicWorkspaceService::class);

    $app->container()->set(
        \App\Http\Controllers\HomeController::class,
        new \App\Http\Controllers\HomeController($app, $locales, $urls)
    );
    $app->container()->set(
        \App\Http\Controllers\AuthController::class,
        new \App\Http\Controllers\AuthController($app, $catalog, $workspaces, $locales, $urls)
    );
    $app->container()->set(
        \App\Http\Controllers\ConsoleController::class,
        new \App\Http\Controllers\ConsoleController($app, $catalog, $consoleService, $locales, $urls)
    );
    $app->container()->set(
        \App\Http\Controllers\PublicController::class,
        new \App\Http\Controllers\PublicController($app, $catalog, $publicService, $answerService, $answerPresenter, $brandPresenter, $locales, $urls)
    );
};
