<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Commands/AboutCommand.php';
require_once __DIR__ . '/../app/Commands/DbMigrateCommand.php';
require_once __DIR__ . '/../app/Commands/DbRollbackCommand.php';
require_once __DIR__ . '/../app/Commands/DbSeedCommand.php';

return [
    "commands" => [
        "template:about" => \App\Commands\AboutCommand::class,
        "db:migrate" => \App\Commands\DbMigrateCommand::class,
        "db:rollback" => \App\Commands\DbRollbackCommand::class,
        "db:seed" => \App\Commands\DbSeedCommand::class,
    ],
];
