<?php
declare(strict_types=1);

\VSlim\EnvLoader::bootstrap(dirname(__DIR__));

$errors = require __DIR__ . '/../app/Http/errors.php';

return [
    'config_path' => dirname(__DIR__) . '/config',
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
