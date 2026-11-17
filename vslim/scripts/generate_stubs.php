<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . '/vphp/stub/render.php';

main($argv);

function main(array $argv): void
{
    $options = parse_options($argv);
    if ($options['help']) {
        fwrite(STDOUT, usage());
        return;
    }

    $root = dirname(__DIR__);
    $defaultExtension = $root . '/vslim.so';
    $extensionPath = $options['extension'] ?? $defaultExtension;
    $outputPath = $options['output'] ?? ($root . '/stubs/vslim.php');
    $stdout = $options['stdout'];

    if (!is_file($extensionPath)) {
        fail("vslim extension not found: {$extensionPath}");
    }

    if (!$options['no_reexec']) {
        exit(reexec_with_extension($argv, $extensionPath));
    }

    if (!extension_loaded('vslim')) {
        fail("vslim extension is not loaded; tried {$extensionPath}");
    }

    $stub = generate_stub(new ReflectionExtension('vslim'), 'php vslim/scripts/generate_stubs.php');
    if ($stdout) {
        fwrite(STDOUT, $stub);
        return;
    }

    $dir = dirname($outputPath);
    if (!is_dir($dir) && !mkdir($dir, 0777, true) && !is_dir($dir)) {
        fail("failed to create stub directory: {$dir}");
    }

    if (file_put_contents($outputPath, $stub) === false) {
        fail("failed to write stub file: {$outputPath}");
    }

    fwrite(STDOUT, "Generated {$outputPath}\n");
}

/**
 * @return array{extension:?string, output:?string, stdout:bool, help:bool, no_reexec:bool}
 */
function parse_options(array $argv): array
{
    $options = [
        'extension' => null,
        'output' => null,
        'stdout' => false,
        'help' => false,
        'no_reexec' => false,
    ];

    for ($i = 1; $i < count($argv); $i++) {
        $arg = $argv[$i];
        if ($arg === '--help' || $arg === '-h') {
            $options['help'] = true;
            continue;
        }
        if ($arg === '--stdout') {
            $options['stdout'] = true;
            continue;
        }
        if ($arg === '--no-reexec') {
            $options['no_reexec'] = true;
            continue;
        }
        if (str_starts_with($arg, '--extension=')) {
            $options['extension'] = substr($arg, strlen('--extension='));
            continue;
        }
        if ($arg === '--extension') {
            $options['extension'] = $argv[++$i] ?? fail('missing value for --extension');
            continue;
        }
        if (str_starts_with($arg, '--output=')) {
            $options['output'] = substr($arg, strlen('--output='));
            continue;
        }
        if ($arg === '--output') {
            $options['output'] = $argv[++$i] ?? fail('missing value for --output');
            continue;
        }
        fail("unknown argument: {$arg}");
    }

    return $options;
}

function usage(): string
{
    return <<<TXT
Usage:
  php scripts/generate_stubs.php [--extension=/path/to/vslim.so] [--output=/path/to/vslim.php]
  php scripts/generate_stubs.php --stdout

Options:
  --extension   Path to the compiled vslim extension. Defaults to vslim/vslim.so.
  --output      Output path for the generated stub file. Defaults to vslim/stubs/vslim.php.
  --stdout      Print the generated stubs to stdout instead of writing a file.
  --help, -h    Show this help message.

TXT;
}

function reexec_with_extension(array $argv, string $extensionPath): int
{
    $command = [
        PHP_BINARY,
        '-n',
        '-d',
        'extension=' . $extensionPath,
        __FILE__,
        '--no-reexec',
    ];

    for ($i = 1; $i < count($argv); $i++) {
        if ($argv[$i] === '--no-reexec') {
            continue;
        }
        $command[] = $argv[$i];
    }

    $escaped = array_map('escapeshellarg', $command);
    passthru(implode(' ', $escaped), $code);
    return (int) $code;
}

function fail(string $message)
{
    fwrite(STDERR, $message . PHP_EOL);
    exit(1);
}
