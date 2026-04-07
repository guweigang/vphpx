<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeProviderCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new service provider class.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Provider class base name'],
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
            fwrite(STDERR, "make-provider-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $class = preg_replace('/[^A-Za-z0-9_]/', '', $name) ?: 'Generated';
        if (!str_ends_with($class, 'Provider')) {
            $class .= 'Provider';
        }
        $path = $root . '/app/Providers/' . $class . '.php';
        if (is_file($path)) {
            fwrite(STDERR, "make-provider-failed|exists|{$path}\n");
            return 1;
        }
        $body = <<<PHP
<?php
declare(strict_types=1);

namespace App\\Providers;

final class {$class} extends \\VSlim\\Support\\ServiceProvider
{
    public function register(): void
    {
        // \$this->app()->container()->set('service.id', 'value');
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
