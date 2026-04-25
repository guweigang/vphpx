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
            'loaded' => $config->isLoaded(),
            'path' => $config->path(),
            'app.name' => $config->getString('app.name', ''),
            'database.transport' => $config->getString('database.transport', ''),
            'database.driver' => $config->getString('database.driver', ''),
            'database.upstream.socket' => $config->getString('database.upstream.socket', ''),
            'session.cookie' => $config->getString('session.cookie', ''),
            'session.secret_configured' => $config->getString('session.secret', '') !== '' ? 'true' : 'false',
            'session.secret_placeholder' => trim($config->getString('session.secret', '')) === 'change-me' ? 'true' : 'false',
            'auth.redirect_to' => $config->getString('auth.redirect_to', ''),
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
