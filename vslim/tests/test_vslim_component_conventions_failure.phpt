--TEST--
VSlim Web and CLI bootstrap stop on a shared provider or module registration exception
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-components-' . bin2hex(random_bytes(8));
mkdir($root . '/app/Providers', 0700, true);
mkdir($root . '/app/Modules');
mkdir($root . '/bootstrap');
try {
    foreach ([
        'Providers' => ['FirstProvider', 'FailingProvider', 'SuffixProvider'],
        'Modules' => ['FirstModule', 'MiddleModule', 'SuffixModule'],
    ] as $namespace => $classes) {
        foreach ($classes as $class) {
            $register = '$GLOBALS["events"][] = "' . $class . '";';
            if (in_array($class, ['FailingProvider', 'MiddleModule'], true)) {
                $register .= 'throw new \LogicException("' . $class . ' failed");';
            }
            file_put_contents("$root/app/$namespace/$class.php",
                '<?php namespace App\\' . $namespace . '; final class ' . $class
                . ' { public function register(): void { ' . $register
                . ' } public function boot(): void { $GLOBALS["events"][] = "boot"; } }');
        }
    }
    file_put_contents("$root/bootstrap/cli.php", '<?php $GLOBALS["events"][] = "cli"; return [];');
    file_put_contents("$root/bootstrap/providers.php", <<<'PHP'
<?php
return [
    new App\Providers\FirstProvider(),
    new App\Providers\FailingProvider(),
    new App\Providers\SuffixProvider(),
];
PHP);
    foreach (['config', 'directory', 'entry'] as $stage) {
        if ($stage === 'directory') {
            unlink("$root/bootstrap/providers.php");
            unlink("$root/app/Providers/FailingProvider.php");
            unlink("$root/app/Providers/SuffixProvider.php");
        } elseif ($stage === 'entry') {
            file_put_contents("$root/bootstrap/app.php", <<<'PHP'
<?php
return [
    'providers' => [new App\Providers\FirstProvider()],
    'modules' => [new App\Modules\FirstModule(), new App\Modules\MiddleModule(), new App\Modules\SuffixModule()],
    'routes' => static function (): void { $GLOBALS['events'][] = 'routes'; },
    'boot' => true,
];
PHP);
        }
        foreach (['web', 'cli'] as $mode) {
            $GLOBALS['events'] = [];
            $entry = $mode === 'web' ? new VSlim\App() : new VSlim\Cli\App();
            $app = $mode === 'web' ? $entry : $entry->app();
            try {
                $entry->bootstrapDir($root);
                echo "unexpected success\n";
            } catch (LogicException $error) {
                echo "$stage|$mode|", $error->getMessage(), '|';
            }
            echo $app->providerCount(), '|', $app->moduleCount(), '|', (int) $app->booted(), '|',
                (int) $app->hasProvider(App\Providers\FirstProvider::class),
                (int) $app->hasProvider(App\Providers\FailingProvider::class),
                (int) $app->hasProvider(App\Providers\SuffixProvider::class),
                (int) $app->hasModule(App\Modules\FirstModule::class),
                (int) $app->hasModule(App\Modules\MiddleModule::class),
                (int) $app->hasModule(App\Modules\SuffixModule::class), '|',
                implode(',', $GLOBALS['events']), PHP_EOL;
        }
    }
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
config|web|FailingProvider failed|1|0|0|100000|FirstProvider,FailingProvider
config|cli|FailingProvider failed|1|0|0|100000|FirstProvider,FailingProvider
directory|web|MiddleModule failed|1|1|0|100100|FirstProvider,FirstModule,MiddleModule
directory|cli|MiddleModule failed|1|1|0|100100|FirstProvider,FirstModule,MiddleModule
entry|web|MiddleModule failed|1|1|0|100100|FirstProvider,FirstModule,MiddleModule
entry|cli|MiddleModule failed|1|1|0|100100|FirstProvider,FirstModule,MiddleModule
