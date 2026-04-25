<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->getNamed(
        'studio.home',
        '/',
        [\App\Http\Controllers\HomeController::class, 'index'],
    );

    $app->getNamed(
        'studio.login',
        '/login',
        [\App\Http\Controllers\AuthController::class, 'show'],
    );
    $app->post('/login', [\App\Http\Controllers\AuthController::class, 'login']);
    $app->post('/logout', [\App\Http\Controllers\AuthController::class, 'logout']);

    $app->getNamed(
        'studio.console',
        '/console',
        [\App\Http\Controllers\ConsoleController::class, 'index'],
    );
    $app->getNamed(
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
        // Legacy compat path: direct publish is no longer a first-class product action.
        '/console/knowledge/documents/:document/publish',
        [\App\Http\Controllers\ConsoleController::class, 'publishDocument'],
    );
    $app->getNamed(
        'studio.console.faqs',
        '/console/knowledge/faqs',
        [\App\Http\Controllers\ConsoleController::class, 'faqs'],
    );
    $app->getNamed(
        'studio.console.members',
        '/console/members',
        [\App\Http\Controllers\ConsoleController::class, 'members'],
    );
    $app->getNamed(
        'studio.console.subscribers',
        '/console/subscribers',
        [\App\Http\Controllers\ConsoleController::class, 'subscribers'],
    );
    $app->get(
        '/console/subscribers/:subscriber',
        [\App\Http\Controllers\ConsoleController::class, 'subscriberDetail'],
    );
    $app->getNamed(
        'studio.console.account',
        '/console/account',
        [\App\Http\Controllers\ConsoleController::class, 'account'],
    );
    $app->post(
        '/console/workspace',
        [\App\Http\Controllers\ConsoleController::class, 'switchWorkspace'],
    );
    $app->post(
        '/console/account/password',
        [\App\Http\Controllers\ConsoleController::class, 'updatePassword'],
    );
    $app->post(
        '/console/knowledge/faqs',
        [\App\Http\Controllers\ConsoleController::class, 'storeEntry'],
    );
    $app->post(
        '/console/members',
        [\App\Http\Controllers\ConsoleController::class, 'storeMember'],
    );
    $app->post(
        '/console/members/:member/role',
        [\App\Http\Controllers\ConsoleController::class, 'updateMemberRole'],
    );
    $app->post(
        '/console/members/:member/remove',
        [\App\Http\Controllers\ConsoleController::class, 'removeMember'],
    );
    $app->post(
        '/console/subscribers/:subscriber/status',
        [\App\Http\Controllers\ConsoleController::class, 'updateSubscriberStatus'],
    );
    $app->post(
        '/console/subscribers/:subscriber/followups',
        [\App\Http\Controllers\ConsoleController::class, 'storeSubscriberFollowup'],
    );
    $app->post(
        '/console/subscribers/:subscriber/provisioning',
        [\App\Http\Controllers\ConsoleController::class, 'queueSubscriberProvisioning'],
    );
    $app->post(
        '/console/subscribers/:subscriber/provisioning/:item/complete',
        [\App\Http\Controllers\ConsoleController::class, 'completeSubscriberProvisioningItem'],
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
        // Legacy compat path: direct publish is no longer a first-class product action.
        '/console/knowledge/faqs/:entry/publish',
        [\App\Http\Controllers\ConsoleController::class, 'publishEntry'],
    );
    $app->getNamed(
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

    $app->getNamed(
        'studio.brand',
        '/brand/:tenant',
        [\App\Http\Controllers\PublicController::class, 'landing'],
    );
    $app->getNamed(
        'studio.validation',
        '/brand/:tenant/validation',
        [\App\Http\Controllers\PublicController::class, 'validation'],
    );
    $app->getNamed(
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
                'app' => $app->config()->getString('app.name', ''),
                'phase' => $app->container()->get('studio.phase'),
                'workspaces' => count($catalog->workspaces()),
                'users' => count($catalog->users()),
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
        ];
    });
};
