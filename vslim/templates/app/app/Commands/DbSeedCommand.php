<?php
declare(strict_types=1);

namespace App\Commands;

final class DbSeedCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Run database seeders.',
            'examples' => [
                'vslim db:seed',
                'vslim db:seed DemoUsersSeeder',
            ],
            'arguments' => [
                [
                    'name' => 'name',
                    'required' => false,
                    'default' => '',
                    'placeholder' => 'seeder',
                    'value_hint' => 'optional seeder file or entry name',
                    'description' => 'Run a single seeder when provided',
                ],
            ],
        ];
    }

    public function description(): string
    {
        return 'Run database seeders.';
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        try {
            $name = (string) $cli->argument('name', '');
            $count = (int) $cli->app()->migrator()->seed($name);
            echo 'seeded|', $count, '|', $name, PHP_EOL;
            return 0;
        } catch (\Throwable $e) {
            fwrite(STDERR, 'db-seed-failed|' . $e->getMessage() . PHP_EOL);
            return 1;
        }
    }
}
