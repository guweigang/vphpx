<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeCommandCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new CLI command class.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Command class base name'],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $name = trim((string) $cli->argument('name', ''));
        if ($name === '') {
            fwrite(STDERR, "make-command-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $class = preg_replace('/[^A-Za-z0-9_]/', '', $name) ?: 'Generated';
        if (!str_ends_with($class, 'Command')) {
            $class .= 'Command';
        }
        $path = $root . '/app/Commands/' . $class . '.php';
        if (is_file($path)) {
            fwrite(STDERR, "make-command-failed|exists|{$path}\n");
            return 1;
        }
        $body = <<<PHP
<?php
declare(strict_types=1);

namespace App\\Commands;

final class {$class}
{
    public function handle(array \$args, \\VSlim\\Cli\\App \$cli): int
    {
        echo "{$class}|todo", PHP_EOL;
        return 0;
    }
}
PHP;
        if (!is_dir(dirname($path))) {
            mkdir(dirname($path), 0777, true);
        }
        file_put_contents($path, $body . PHP_EOL);
        echo "created|{$path}", PHP_EOL;
        return 0;
    }
}
