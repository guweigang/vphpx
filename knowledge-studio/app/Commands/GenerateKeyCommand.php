<?php
declare(strict_types=1);

namespace App\Commands;

final class GenerateKeyCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a secure random secret.',
            'examples' => [
                'vslim key:generate',
                'vslim key:generate --bytes=48',
                'vslim key:generate --name=VSLIM_SESSION_SECRET',
            ],
            'options' => [
                [
                    'name' => 'bytes',
                    'short' => 'b',
                    'type' => 'int',
                    'default' => 32,
                    'description' => 'Random byte length before base64url encoding',
                ],
                [
                    'name' => 'name',
                    'short' => 'n',
                    'type' => 'string',
                    'default' => '',
                    'description' => 'Optional env variable name prefix',
                ],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $bytes = (int) $cli->option('bytes', 32);
        if ($bytes < 16) {
            fwrite(STDERR, "bytes-must-be-at-least-16\n");
            return 1;
        }

        $secret = rtrim(strtr(base64_encode(random_bytes($bytes)), '+/', '-_'), '=');
        $name = trim((string) $cli->option('name', ''));

        if ($name === '') {
            echo $secret, PHP_EOL;
            return 0;
        }

        echo $name, '=', $secret, PHP_EOL;
        return 0;
    }
}
