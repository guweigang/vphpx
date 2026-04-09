<?php
declare(strict_types=1);

namespace App\Commands;

final class AboutCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Show Knowledge Studio bootstrap status.',
            'examples' => [
                'vslim studio:about',
                'vslim studio:about --format=json',
            ],
            'options' => [
                [
                    'name' => 'format',
                    'short' => 'f',
                    'type' => 'string',
                    'default' => 'text',
                    'choices' => ['text', 'json'],
                    'description' => 'Output format',
                ],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $app = $cli->app();
        $catalog = $app->container()->get('studio.catalog');
        $workspaces = is_object($catalog) && method_exists($catalog, 'workspaces')
            ? $catalog->workspaces()
            : [];
        $users = is_object($catalog) && method_exists($catalog, 'users')
            ? $catalog->users()
            : [];
        $format = (string) $cli->option('format', 'text');

        if ($format === 'json') {
            echo json_encode([
                'app' => $app->config()->get_string('app.name', ''),
                'phase' => (string) $app->container()->get('studio.phase'),
                'workspaces' => count(is_array($workspaces) ? $workspaces : []),
                'users' => count(is_array($users) ? $users : []),
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), PHP_EOL;
            return 0;
        }

        echo implode('|', [
            $app->config()->get_string('app.name', ''),
            (string) $app->container()->get('studio.phase'),
            'workspaces=' . count(is_array($workspaces) ? $workspaces : []),
            'users=' . count(is_array($users) ? $users : []),
        ]), PHP_EOL;

        return 0;
    }
}
