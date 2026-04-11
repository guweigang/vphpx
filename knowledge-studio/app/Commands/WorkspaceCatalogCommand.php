<?php
declare(strict_types=1);

namespace App\Commands;

final class WorkspaceCatalogCommand
{
    public function definition(): array
    {
        return [
            'description' => 'List demo workspaces and users for the current sample.',
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $catalog = $cli->app()->container()->get('studio.catalog');
        if (!is_object($catalog)) {
            fwrite(STDERR, "catalog-unavailable\n");
            return 1;
        }

        foreach ($catalog->workspaces() as $workspace) {
            echo implode('|', [
                'workspace',
                (string) ($workspace['slug'] ?? ''),
                (string) ($workspace['name'] ?? ''),
                (string) ($workspace['plan'] ?? ''),
            ]), PHP_EOL;
        }

        foreach ($catalog->users() as $user) {
            echo implode('|', [
                'user',
                (string) ($user['email'] ?? ''),
                (string) ($user['role'] ?? ''),
                (string) ($user['workspace_slug'] ?? ''),
            ]), PHP_EOL;
        }

        return 0;
    }
}
