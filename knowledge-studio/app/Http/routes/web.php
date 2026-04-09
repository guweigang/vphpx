<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->get_named(
        'studio.home',
        '/',
        [\App\Http\Controllers\HomeController::class, 'index'],
    );

    $app->get_named(
        'studio.login',
        '/login',
        [\App\Http\Controllers\AuthController::class, 'show'],
    );
    $app->post('/login', [\App\Http\Controllers\AuthController::class, 'login']);
    $app->post('/logout', [\App\Http\Controllers\AuthController::class, 'logout']);

    $app->get_named(
        'studio.console',
        '/console',
        [\App\Http\Controllers\ConsoleController::class, 'index'],
    );
    $app->get_named(
        'studio.console.documents',
        '/console/knowledge/documents',
        [\App\Http\Controllers\ConsoleController::class, 'documents'],
    );
    $app->get_named(
        'studio.console.faqs',
        '/console/knowledge/faqs',
        [\App\Http\Controllers\ConsoleController::class, 'faqs'],
    );
    $app->get_named(
        'studio.console.ops',
        '/console/ops',
        [\App\Http\Controllers\ConsoleController::class, 'ops'],
    );

    $app->get_named(
        'studio.brand',
        '/brand/:tenant',
        [\App\Http\Controllers\PublicController::class, 'landing'],
    );
    $app->get_named(
        'studio.assistant',
        '/brand/:tenant/assistant',
        [\App\Http\Controllers\PublicController::class, 'assistant'],
    );

    $app->get('/health', function () use ($app): array {
        $catalog = $app->container()->get('studio.catalog');
        return [
            'status' => 200,
            'content_type' => 'application/json; charset=utf-8',
            'body' => json_encode([
                'ok' => true,
                'app' => $app->config()->get_string('app.name', ''),
                'phase' => $app->container()->get('studio.phase'),
                'workspaces' => count($catalog->workspaces()),
                'users' => count($catalog->users()),
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
        ];
    });
};
