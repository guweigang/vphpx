<?php
declare(strict_types=1);

namespace App\Commands;

final class AppDoctorCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Run a lightweight framework health check.',
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
        $doctor = $cli->app()->doctor();
        $issues = [];
        if (($doctor['config_loaded'] ?? 'false') !== 'true') {
            $issues[] = 'config_not_loaded';
        }
        if (($doctor['session_configured'] ?? 'false') !== 'true') {
            $issues[] = 'session_not_configured';
        }
        if (($doctor['session_secret_placeholder'] ?? 'false') === 'true') {
            $issues[] = 'session_secret_placeholder';
        }
        if (($doctor['database_transport'] ?? '') === 'vhttpd_upstream'
            && trim((string) ($doctor['database_upstream_socket'] ?? '')) === '') {
            $issues[] = 'database_upstream_socket_missing';
        }
        if (($doctor['auth_user_provider_defined'] ?? 'false') !== 'true'
            && ($doctor['auth_resolver_defined'] ?? 'false') !== 'true') {
            $issues[] = 'auth_user_provider_missing';
        }

        if ((string) $cli->option('format', 'text') === 'json') {
            echo json_encode([
                'ok' => $issues === [],
                'doctor' => $doctor,
                'issues' => $issues,
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), PHP_EOL;
            return $issues === [] ? 0 : 1;
        }

        foreach ($doctor as $key => $value) {
            echo $key . '=' . $value, PHP_EOL;
        }
        echo 'issues=' . implode(',', $issues), PHP_EOL;
        return $issues === [] ? 0 : 1;
    }
}
