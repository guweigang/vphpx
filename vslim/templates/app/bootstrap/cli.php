<?php
declare(strict_types=1);

\VSlim\EnvLoader::bootstrap(dirname(__DIR__));

return [
    "commands" => [
        "template:about" => \App\Commands\AboutCommand::class,
        "app:doctor" => \App\Commands\AppDoctorCommand::class,
        "config:check" => \App\Commands\ConfigCheckCommand::class,
        "db:migrate" => \App\Commands\DbMigrateCommand::class,
        "db:rollback" => \App\Commands\DbRollbackCommand::class,
        "db:seed" => \App\Commands\DbSeedCommand::class,
        "key:generate" => \App\Commands\GenerateKeyCommand::class,
        "make:command" => \App\Commands\MakeCommandCommand::class,
        "make:controller" => \App\Commands\MakeControllerCommand::class,
        "make:migration" => \App\Commands\MakeMigrationCommand::class,
        "make:middleware" => \App\Commands\MakeMiddlewareCommand::class,
        "make:provider" => \App\Commands\MakeProviderCommand::class,
        "make:seed" => \App\Commands\MakeSeedCommand::class,
        "make:test" => \App\Commands\MakeTestCommand::class,
        "route:list" => \App\Commands\RouteListCommand::class,
    ],
];
