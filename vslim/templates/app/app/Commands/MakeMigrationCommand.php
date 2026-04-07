<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeMigrationCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new migration file.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Migration slug'],
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
            fwrite(STDERR, "make-migration-failed|missing-name\n");
            return 1;
        }
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9]+/', '_', $name), '_')) ?: 'migration';
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $dir = $root . '/database/migrations';
        $path = $dir . '/' . date('Ymd_His') . '_' . $slug . '.php';
        $body = <<<PHP
<?php
declare(strict_types=1);

return new class extends VSlim\\Database\\Migration {
    public function up(): void
    {
        // \$this->execute('create table ...');
    }

    public function down(): void
    {
        // \$this->execute('drop table ...');
    }
};
PHP;
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        file_put_contents($path, $body . PHP_EOL);
        echo "created|{$path}", PHP_EOL;
        return 0;
    }
}
