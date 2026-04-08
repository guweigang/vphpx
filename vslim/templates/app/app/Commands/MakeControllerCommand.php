<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeControllerCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new controller class.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Controller class base name'],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $name = trim((string) $cli->argument('name', ''));
        if ($name === '' && isset($args[0])) {
            $name = trim((string) $args[0]);
        }
        if ($name === '') {
            fwrite(STDERR, "make-controller-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $class = preg_replace('/[^A-Za-z0-9_]/', '', $name) ?: 'Generated';
        if (!str_ends_with($class, 'Controller')) {
            $class .= 'Controller';
        }
        $path = $root . '/app/Http/Controllers/' . $class . '.php';
        if (is_file($path)) {
            fwrite(STDERR, "make-controller-failed|exists|{$path}\n");
            return 1;
        }
        $body = <<<PHP
<?php
declare(strict_types=1);

namespace App\Http\Controllers;

final class {$class}
{
    public function __invoke(): string
    {
        return '{$class}|todo';
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
