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
    $app->post(
        '/console/knowledge/documents',
        [\App\Http\Controllers\ConsoleController::class, 'storeDocument'],
    );
    $app->get(
        '/console/knowledge/documents/:document',
        [\App\Http\Controllers\ConsoleController::class, 'editDocument'],
    );
    $app->post(
        '/console/knowledge/documents/:document',
        [\App\Http\Controllers\ConsoleController::class, 'updateDocument'],
    );
    $app->post(
        '/console/knowledge/documents/:document/publish',
        [\App\Http\Controllers\ConsoleController::class, 'publishDocument'],
    );
    $app->get_named(
        'studio.console.faqs',
        '/console/knowledge/faqs',
        [\App\Http\Controllers\ConsoleController::class, 'faqs'],
    );
    $app->get_named(
        'studio.console.members',
        '/console/members',
        [\App\Http\Controllers\ConsoleController::class, 'members'],
    );
    $app->post(
        '/console/knowledge/faqs',
        [\App\Http\Controllers\ConsoleController::class, 'storeEntry'],
    );
    $app->post(
        '/console/members',
        [\App\Http\Controllers\ConsoleController::class, 'storeMember'],
    );
    $app->get(
        '/console/knowledge/faqs/:entry',
        [\App\Http\Controllers\ConsoleController::class, 'editEntry'],
    );
    $app->post(
        '/console/knowledge/faqs/:entry',
        [\App\Http\Controllers\ConsoleController::class, 'updateEntry'],
    );
    $app->post(
        '/console/knowledge/faqs/:entry/publish',
        [\App\Http\Controllers\ConsoleController::class, 'publishEntry'],
    );
    $app->get_named(
        'studio.console.ops',
        '/console/ops',
        [\App\Http\Controllers\ConsoleController::class, 'ops'],
    );
    $app->get(
        '/console/releases',
        [\App\Http\Controllers\ConsoleController::class, 'releases'],
    );
    $app->post(
        '/console/releases',
        [\App\Http\Controllers\ConsoleController::class, 'storeRelease'],
    );
    $app->post(
        '/console/ops/jobs',
        [\App\Http\Controllers\ConsoleController::class, 'storeJob'],
    );
    $app->post(
        '/console/ops/jobs/:job/retry',
        [\App\Http\Controllers\ConsoleController::class, 'retryJob'],
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
    $app->get(
        '/brand/:tenant/documents/:document',
        [\App\Http\Controllers\PublicController::class, 'document'],
    );
    $app->get(
        '/brand/:tenant/entries/:entry',
        [\App\Http\Controllers\PublicController::class, 'entry'],
    );
    $app->post(
        '/brand/:tenant/subscribe',
        [\App\Http\Controllers\PublicController::class, 'subscribe'],
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
