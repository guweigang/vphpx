<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Support/EnvLoader.php';
require_once __DIR__ . '/../app/Support/PsrStubLoader.php';
require_once __DIR__ . '/../app/Commands/AboutCommand.php';
require_once __DIR__ . '/../app/Commands/DbMigrateCommand.php';
require_once __DIR__ . '/../app/Commands/DbRollbackCommand.php';
require_once __DIR__ . '/../app/Commands/DbSeedCommand.php';
require_once __DIR__ . '/../app/Commands/WorkspaceCatalogCommand.php';
require_once __DIR__ . '/../app/Commands/SeedDemoCommand.php';

\App\Support\EnvLoader::bootstrap(dirname(__DIR__));
\App\Support\PsrStubLoader::load();

return [
    'commands' => [
        'studio:about' => \App\Commands\AboutCommand::class,
        'db:migrate' => \App\Commands\DbMigrateCommand::class,
        'db:rollback' => \App\Commands\DbRollbackCommand::class,
        'db:seed' => \App\Commands\DbSeedCommand::class,
        'workspace:catalog' => \App\Commands\WorkspaceCatalogCommand::class,
        'studio:seed-demo' => \App\Commands\SeedDemoCommand::class,
    ],
];
