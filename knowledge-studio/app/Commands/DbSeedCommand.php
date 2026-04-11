<?php
declare(strict_types=1);

namespace App\Commands;

final class DbSeedCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Run database seeders.',
            'arguments' => [
                [
                    'name' => 'name',
                    'required' => false,
                    'default' => '',
                    'description' => 'Optional seeder name',
                ],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        try {
            $name = (string) $cli->argument('name', '');
            $count = (int) $cli->app()->migrator()->seed($name);
            echo 'seeded|' . $count . '|' . $name . PHP_EOL;
            return 0;
        } catch (\Throwable $e) {
            fwrite(STDERR, 'db-seed-failed|' . $e->getMessage() . PHP_EOL);
            return 1;
        }
    }
}
