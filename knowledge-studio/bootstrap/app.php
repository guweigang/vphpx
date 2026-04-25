<?php
declare(strict_types=1);

\VSlim\EnvLoader::bootstrap(dirname(__DIR__));
\App\Support\PsrStubLoader::load();
\App\Support\StudioTimezone::bootstrap();

$errors = require __DIR__ . '/../app/Http/errors.php';

return [
    'configPath' => dirname(__DIR__) . '/config',
    'basePath' => '',
    'viewBasePath' => dirname(__DIR__) . '/resources/views',
    'notFound' => $errors['not_found'] ?? null,
    'error' => $errors['error'] ?? null,
    'providers' => [
        \App\Providers\AppServiceProvider::class,
    ],
    'middlewareSetup' => require __DIR__ . '/../app/Http/middleware.php',
    'routes' => [
        require __DIR__ . '/../app/Http/controllers.php',
        require __DIR__ . '/../app/Http/routes/web.php',
    ],
    'boot' => true,
];
