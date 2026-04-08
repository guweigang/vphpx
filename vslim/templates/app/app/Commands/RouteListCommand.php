<?php
declare(strict_types=1);

namespace App\Commands;

final class RouteListCommand
{
    public function definition(): array
    {
        return [
            'description' => 'List registered HTTP routes.',
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
        $format = (string) $cli->option('format', 'text');
        $manifest = $app->route_manifest();
        $conflicts = $app->route_conflicts();

        if ($format === 'json') {
            echo json_encode([
                'count' => count($manifest),
                'routes' => $manifest,
                'conflicts' => $conflicts,
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), PHP_EOL;
            return count($manifest);
        }

        foreach ($manifest as $route) {
            echo implode('|', [
                $route['method'] ?? '',
                $route['pattern'] ?? '',
                $route['name'] ?? '',
                $route['handler_type'] ?? '',
            ]), PHP_EOL;
        }
        if ($conflicts !== []) {
            echo 'conflicts=' . count($conflicts), PHP_EOL;
        }
        return count($manifest);
    }
}
