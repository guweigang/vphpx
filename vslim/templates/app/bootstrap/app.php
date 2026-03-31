<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Providers/AppServiceProvider.php';
require_once __DIR__ . '/../app/Modules/StatusModule.php';

$errors = require __DIR__ . '/../app/Http/errors.php';

return [
    'config_path' => dirname(__DIR__) . '/config/app.toml',
    'base_path' => '/template',
    'view_base_path' => dirname(__DIR__) . '/resources/views',
    'not_found' => $errors['not_found'] ?? null,
    'error' => $errors['error'] ?? null,
    'providers' => [
        \App\Providers\AppServiceProvider::class,
    ],
    'modules' => [
        \App\Modules\StatusModule::class,
    ],
    'middleware_setup' => require __DIR__ . '/../app/Http/middleware.php',
    'routes' => [
        require __DIR__ . '/../app/Http/controllers.php',
        require __DIR__ . '/../app/Http/routes/web.php',
    ],
    'boot' => true,
];
