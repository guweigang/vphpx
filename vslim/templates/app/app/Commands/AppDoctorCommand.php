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
        foreach ([
            'config_loaded' => 'config_not_loaded',
            'session_configured' => 'session_not_configured',
        ] as $key => $issue) {
            if (($doctor[$key] ?? 'false') !== 'true') {
                $issues[] = $issue;
            }
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
