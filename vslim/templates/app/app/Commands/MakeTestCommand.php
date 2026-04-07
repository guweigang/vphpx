<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeTestCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a lightweight VSlim PHPT test file.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Test file base name'],
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
            fwrite(STDERR, "make-test-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $slug = strtolower(trim((string) preg_replace('/[^A-Za-z0-9]+/', '_', $name), '_')) ?: 'generated';
        if (!str_starts_with($slug, 'test_')) {
            $slug = 'test_' . $slug;
        }
        if (!str_ends_with($slug, '.phpt')) {
            $slug .= '.phpt';
        }
        $path = $root . '/tests/' . $slug;
        if (is_file($path)) {
            fwrite(STDERR, "make-test-failed|exists|{$path}\n");
            return 1;
        }
        $body = <<<PHPT
--TEST--
Template generated test
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
echo "ok", PHP_EOL;
?>
--EXPECT--
ok
PHPT;
        if (!is_dir(dirname($path))) {
            mkdir(dirname($path), 0777, true);
        }
        file_put_contents($path, $body . PHP_EOL);
        echo "created|{$path}", PHP_EOL;
        return 0;
    }
}
