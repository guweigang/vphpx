<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Commands/AboutCommand.php';
require_once __DIR__ . '/../app/Commands/AppDoctorCommand.php';
require_once __DIR__ . '/../app/Commands/ConfigCheckCommand.php';
require_once __DIR__ . '/../app/Commands/DbMigrateCommand.php';
require_once __DIR__ . '/../app/Commands/DbRollbackCommand.php';
require_once __DIR__ . '/../app/Commands/DbSeedCommand.php';
require_once __DIR__ . '/../app/Commands/MakeCommandCommand.php';
require_once __DIR__ . '/../app/Commands/MakeControllerCommand.php';
require_once __DIR__ . '/../app/Commands/MakeMigrationCommand.php';
require_once __DIR__ . '/../app/Commands/MakeMiddlewareCommand.php';
require_once __DIR__ . '/../app/Commands/MakeSeedCommand.php';
require_once __DIR__ . '/../app/Commands/RouteListCommand.php';

return [
    "commands" => [
        "template:about" => \App\Commands\AboutCommand::class,
        "app:doctor" => \App\Commands\AppDoctorCommand::class,
        "config:check" => \App\Commands\ConfigCheckCommand::class,
        "db:migrate" => \App\Commands\DbMigrateCommand::class,
        "db:rollback" => \App\Commands\DbRollbackCommand::class,
        "db:seed" => \App\Commands\DbSeedCommand::class,
        "make:command" => \App\Commands\MakeCommandCommand::class,
        "make:controller" => \App\Commands\MakeControllerCommand::class,
        "make:migration" => \App\Commands\MakeMigrationCommand::class,
        "make:middleware" => \App\Commands\MakeMiddlewareCommand::class,
        "make:seed" => \App\Commands\MakeSeedCommand::class,
        "route:list" => \App\Commands\RouteListCommand::class,
    ],
];
