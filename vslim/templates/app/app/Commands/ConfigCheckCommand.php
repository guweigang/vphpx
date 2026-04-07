<?php
declare(strict_types=1);

namespace App\Commands;

final class ConfigCheckCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Inspect resolved application config.',
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
        $config = $cli->app()->config();
        $payload = [
            'loaded' => $config->is_loaded(),
            'path' => $config->path(),
            'app.name' => $config->get_string('app.name', ''),
            'database.driver' => $config->get_string('database.driver', ''),
            'session.cookie' => $config->get_string('session.cookie', ''),
            'auth.redirect_to' => $config->get_string('auth.redirect_to', ''),
        ];

        if ((string) $cli->option('format', 'text') === 'json') {
            echo json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), PHP_EOL;
            return $payload['loaded'] ? 0 : 1;
        }

        foreach ($payload as $key => $value) {
            echo $key . '=' . (is_bool($value) ? ($value ? 'true' : 'false') : (string) $value), PHP_EOL;
        }
        return $payload['loaded'] ? 0 : 1;
    }
}
