<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeSeedCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new database seeder.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Seeder class base name'],
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
            fwrite(STDERR, "make-seed-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $class = preg_replace('/[^A-Za-z0-9_]/', '', $name) ?: 'Database';
        if (!str_ends_with($class, 'Seeder')) {
            $class .= 'Seeder';
        }
        $path = $root . '/database/seeds/' . $class . '.php';
        $body = <<<PHP
<?php
declare(strict_types=1);

return new class extends VSlim\\Database\\Seeder {
    public function run(): void
    {
        // \$this->db()->executeParams('insert into ...', []);
    }
};
PHP;
        if (!is_dir(dirname($path))) {
            mkdir(dirname($path), 0777, true);
        }
        file_put_contents($path, $body . PHP_EOL);
        echo "created|{$path}", PHP_EOL;
        return 0;
    }
}
