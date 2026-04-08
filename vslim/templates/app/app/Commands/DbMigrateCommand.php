<?php
declare(strict_types=1);

namespace App\Commands;

final class DbMigrateCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Run pending database migrations.',
            'examples' => [
                'vslim db:migrate',
            ],
            'epilog' => 'Uses the same configured database manager and migration paths as the app runtime.',
        ];
    }

    public function description(): string
    {
        return 'Run pending database migrations.';
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        try {
            $count = (int) $cli->app()->migrator()->migrate();
            echo 'migrated|', $count, PHP_EOL;
            return 0;
        } catch (\Throwable $e) {
            fwrite(STDERR, 'db-migrate-failed|' . $e->getMessage() . PHP_EOL);
            return 1;
        }
    }
}
