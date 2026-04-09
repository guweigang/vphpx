<?php
declare(strict_types=1);

namespace App\Commands;

final class DbRollbackCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Rollback the latest migration batch.',
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        try {
            $count = (int) $cli->app()->migrator()->rollback();
            echo 'rolled_back|' . $count . PHP_EOL;
            return 0;
        } catch (\Throwable $e) {
            fwrite(STDERR, 'db-rollback-failed|' . $e->getMessage() . PHP_EOL);
            return 1;
        }
    }
}
