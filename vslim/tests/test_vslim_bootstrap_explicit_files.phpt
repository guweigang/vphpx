--TEST--
VSlim explicit file bootstrap shares path validation while preserving Web and CLI return handling
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-explicit-files-' . bin2hex(random_bytes(8));
$cwd = getcwd();
$includePath = get_include_path();
mkdir($root . '/app/Providers', 0700, true);
mkdir($root . '/bootstrap', 0700);
try {
    file_put_contents($root . '/app/Providers/ExplicitProbeProvider.php', <<<'PHP'
<?php
namespace App\Providers;
final class ExplicitProbeProvider {}
PHP);
    file_put_contents($root . '/app.php', <<<'PHP'
<?php
return [
    'providers' => [new \App\Providers\ExplicitProbeProvider()],
    'routes' => static function (VSlim\App $app): void {
        $app->get('/explicit', static fn () => 'app-entry');
    },
];
PHP);
    file_put_contents($root . '/bootstrap/cli.php', <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    return ['commands' => ['explicit' => static fn () => 0], 'boot' => true];
};
PHP);
    file_put_contents($root . '/bootstrap/invalid.php', '<?php return null;');
    chdir($root);

    foreach (['bootstrapFile', 'bootstrapDir'] as $method) {
        foreach ([VSlim\App::class, VSlim\Cli\App::class] as $class) {
            $signature = new ReflectionMethod($class, $method);
            $parameter = $signature->getParameters()[0];
            if ($parameter->getName() !== 'path' || (string) $parameter->getType() !== 'string'
                || $signature->getNumberOfRequiredParameters() !== 1
                || (string) $signature->getReturnType() !== $class) {
                throw new RuntimeException("Unexpected bootstrap signature for $class::$method");
            }
        }
        $web = new VSlim\App();
        $web->$method(path: ' app.php ');
        echo 'web|' . (int) $web->booted() . '|' . $web->providerCount() . '|'
            . $web->dispatch('GET', '/explicit')->body . '|' . (int) $web->booted() . PHP_EOL;

        $cli = new VSlim\Cli\App();
        $cli->$method(path: ' app.php ');
        $core = $cli->app();
        echo 'cli-app|' . (int) $core->booted() . '|' . $core->providerCount() . '|'
            . $core->dispatch('GET', '/explicit')->body . '|' . (int) $core->booted() . PHP_EOL;

        $cli = new VSlim\Cli\App();
        $cli->$method(path: ' bootstrap\\cli.php ');
        echo 'cli-config|' . (int) $cli->hasCommand('explicit') . '|'
            . (int) $cli->app()->booted() . PHP_EOL;

        foreach ([new VSlim\App(), new VSlim\Cli\App()] as $app) {
            foreach (['bootstrap/missing.php', 'bootstrap/invalid.php'] as $file) {
                try {
                    $app->$method($file);
                    echo "accepted-invalid-file\n";
                } catch (InvalidArgumentException $error) {
                    echo $error->getMessage() . PHP_EOL;
                }
            }
        }
    }

    set_include_path($root . '/bootstrap');
    $cli = new VSlim\Cli\App();
    $cli->bootstrapFile('cli.php');
    echo 'include-path|' . (int) $cli->hasCommand('explicit') . PHP_EOL;

    mkdir($root . '/alternate/app/Providers', 0700, true);
    file_put_contents($root . '/alternate/app/Providers/IncludePathProbeProvider.php',
        '<?php namespace App\Providers; final class IncludePathProbeProvider {}');
    file_put_contents($root . '/alternate/app.php',
        '<?php return ["providers" => [new \App\Providers\IncludePathProbeProvider()]];');
    set_include_path($root . '/alternate');
    $web = new VSlim\App();
    $web->bootstrapFile('app.php');
    echo 'resolved-app|' . (int) $web->hasProvider(\App\Providers\IncludePathProbeProvider::class) . PHP_EOL;
} finally {
    chdir($cwd);
    set_include_path($includePath);
    $files = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($root, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST,
    );
    foreach ($files as $file) {
        $file->isDir() ? rmdir($file->getPathname()) : unlink($file->getPathname());
    }
    rmdir($root);
}
?>
--EXPECT--
web|0|1|app-entry|1
cli-app|0|1|app-entry|1
cli-config|1|1
bootstrap file "bootstrap/missing.php" does not exist or is not a file
bootstrap file "bootstrap/invalid.php" must return iterable spec, callable, or VSlim\App
CLI bootstrap file "bootstrap/missing.php" does not exist or is not a file
CLI bootstrap file "bootstrap/invalid.php" must return iterable commands/spec, callable, or VSlim\Cli\App
web|0|1|app-entry|1
cli-app|0|1|app-entry|1
cli-config|1|1
bootstrap file "bootstrap/missing.php" does not exist or is not a file
bootstrap file "bootstrap/invalid.php" must return iterable spec, callable, or VSlim\App
CLI bootstrap file "bootstrap/missing.php" does not exist or is not a file
CLI bootstrap file "bootstrap/invalid.php" must return iterable commands/spec, callable, or VSlim\Cli\App
include-path|1
resolved-app|1
