<?php
declare(strict_types=1);

\VSlim\EnvLoader::bootstrap(dirname(__DIR__));
\App\Support\StudioTimezone::bootstrap();

return [
    'commands' => [
        'studio:about' => \App\Commands\AboutCommand::class,
        'key:generate' => \App\Commands\GenerateKeyCommand::class,
        'db:migrate' => \App\Commands\DbMigrateCommand::class,
        'db:rollback' => \App\Commands\DbRollbackCommand::class,
        'db:seed' => \App\Commands\DbSeedCommand::class,
        'queue:work' => \App\Commands\QueueWorkCommand::class,
        'workspace:catalog' => \App\Commands\WorkspaceCatalogCommand::class,
        'studio:seed-demo' => \App\Commands\SeedDemoCommand::class,
    ],
];
