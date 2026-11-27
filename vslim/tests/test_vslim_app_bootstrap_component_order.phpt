--TEST--
VSlim Web and CLI reuse the preloaded component files and automatically boot once
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-components-' . bin2hex(random_bytes(8));
$GLOBALS['componentEvents'] = [];

try {
    mkdir($root . '/bootstrap', 0700, true);
    foreach (['Providers', 'Modules'] as $directory) {
        mkdir($root . '/app/' . $directory, 0700, true);
        foreach (['Zulu', 'Beta', 'Alpha'] as $name) {
            $class = <<<'PHP'
<?php
namespace App\{directory};

final class {name}
{
    public function register(): void
    {
        $GLOBALS['componentEvents'][] = 'register:{directory}:{name}';
    }

    public function boot(): void
    {
        $GLOBALS['componentEvents'][] = 'boot:{directory}:{name}';
    }
}
PHP;
            file_put_contents($root . '/app/' . $directory . '/' . $name . '.php', strtr($class, [
                '{directory}' => $directory,
                '{name}' => $name,
            ]));
        }

        $config = <<<'PHP'
<?php
$GLOBALS['componentEvents'][] = 'config:{directory}';
$file = dirname(__DIR__) . '/app/{directory}/Alpha.php';
if (is_file($file)) {
    rename($file, $file . '.hidden');
}
return [\App\{directory}\Zulu::class, new \App\{directory}\Zulu()];
PHP;
        file_put_contents($root . '/bootstrap/' . strtolower($directory) . '.php', strtr($config, [
            '{directory}' => $directory,
        ]));
    }

    // The config files instantiate classes before registration and hide an
    // already loaded file. A second directory scan would miss Alpha.
    $cli = new VSlim\Cli\App();
    $cli->bootstrapDir($root);
    $app = $cli->app();
    $cliEvents = $GLOBALS['componentEvents'];
    echo implode(PHP_EOL, $cliEvents) . PHP_EOL;
    echo $app->providerCount() . '|' . $app->moduleCount() . '|' . (int) $app->booted() . PHP_EOL;

    foreach (['Providers', 'Modules'] as $directory) {
        $file = $root . '/app/' . $directory . '/Alpha.php';
        rename($file . '.hidden', $file);
    }

    $GLOBALS['componentEvents'] = [];
    $app = new VSlim\App();
    $app->bootstrapDir($root . '/bootstrap');
    echo 'web-matches-cli=' . (int) ($GLOBALS['componentEvents'] === $cliEvents) . PHP_EOL;
    echo $app->providerCount() . '|' . $app->moduleCount() . '|' . (int) $app->booted() . PHP_EOL;

    $GLOBALS['componentEvents'] = [];
    $app->bootstrapDir($root);
    echo implode(PHP_EOL, $GLOBALS['componentEvents']) . PHP_EOL;
    echo $app->providerCount() . '|' . $app->moduleCount() . '|' . (int) $app->booted() . PHP_EOL;

    file_put_contents($root . '/app/Providers/EntryOnly.php', '<?php namespace App\Providers; class EntryOnly {}');
    $entry = $root . '/bootstrap/app.php';
    file_put_contents($entry, '<?php return ["providers" => [new \App\Providers\EntryOnly()], "boot" => true];');
    $explicit = new VSlim\App();
    $explicit->bootstrapFile($entry);
    echo 'explicit|' . $explicit->providerCount() . '|' . (int) $explicit->booted() . PHP_EOL;
} finally {
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
config:Providers
register:Providers:Zulu
register:Providers:Alpha
register:Providers:Beta
config:Modules
register:Modules:Zulu
register:Modules:Alpha
register:Modules:Beta
boot:Providers:Zulu
boot:Providers:Alpha
boot:Providers:Beta
boot:Modules:Zulu
boot:Modules:Alpha
boot:Modules:Beta
3|3|1
web-matches-cli=1
3|3|1
config:Providers
config:Modules
3|3|1
explicit|1|1
