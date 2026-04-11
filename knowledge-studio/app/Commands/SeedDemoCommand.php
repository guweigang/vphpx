<?php
declare(strict_types=1);

namespace App\Commands;

final class SeedDemoCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Seed demo workspace data into the configured database.',
            'arguments' => [
                [
                    'name' => 'name',
                    'required' => false,
                    'default' => 'DemoWorkspaceSeeder',
                    'description' => 'Seeder name to run',
                ],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $name = trim((string) $cli->argument('name', 'DemoWorkspaceSeeder'));
        if ($name === '') {
            $name = 'DemoWorkspaceSeeder';
        }

        $count = (int) $cli->app()->migrator()->seed($name);
        echo 'seeded|' . $name . '|count=' . $count . PHP_EOL;
        return 0;
    }
}
