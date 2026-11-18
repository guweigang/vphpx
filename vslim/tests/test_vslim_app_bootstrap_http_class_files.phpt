--TEST--
VSlim bootstrap reuses preloaded HTTP class files for controller binding and middleware setup
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$fixture = __DIR__ . '/fixtures/vslim_bootstrap_app_dirs';
$root = sys_get_temp_dir() . '/vslim-http-class-files-' . bin2hex(random_bytes(8));

try {
    foreach (['bootstrap', 'app/Http/Controllers', 'app/Http/Middleware', 'app/Http/routes'] as $directory) {
        mkdir($root . '/' . $directory, 0700, true);
    }
    foreach (['support.php', 'app/Http/Controllers/PageController.php', 'app/Http/Middleware/TraceMiddleware.php'] as $file) {
        copy($fixture . '/' . $file, $root . '/' . $file);
    }
    file_put_contents($root . '/bootstrap/runtime.php', <<<'PHP'
<?php
$trace = new \App\Http\Middleware\TraceMiddleware();
$controllerFile = dirname(__DIR__) . '/app/Http/Controllers/PageController.php';
rename($controllerFile, $controllerFile . '.hidden');
file_put_contents(dirname(__DIR__) . '/app/Http/Middleware/LateFile.php', '<?php echo "late-include\n";');
echo "runtime\n";
return function (VSlim\App $app) use ($trace): void {
    $app->middleware($trace);
    $app->middleware(new AppDirTraceMiddleware());
};
PHP);
    file_put_contents($root . '/app/Http/controllers.php', <<<'PHP'
<?php
return function (VSlim\App $app): void {
    $class = \App\Http\Controllers\PageController::class;
    echo 'controllers|' . (int) $app->container()->has($class) . PHP_EOL;
    $app->container()->set('configured.controller', new \App\Http\Controllers\PageController($app));
};
PHP);
    file_put_contents($root . '/app/Http/middleware.php', <<<'PHP'
<?php
return function (VSlim\App $app): void {
    echo 'middleware|' . (int) $app->container()->has('configured.controller') . PHP_EOL;
};
PHP);
    file_put_contents($root . '/app/Http/routes/web.php', <<<'PHP'
<?php
return function (VSlim\App $app): void {
    echo "routes\n";
    $app->getNamed('appdir.home', '/home', function (\Psr\Http\Message\ServerRequestInterface $request): string {
        return 'home|' . $request->getAttribute('http_class_mw');
    });
    $app->get('/controller', [\App\Http\Controllers\PageController::class, 'home']);
};
PHP);

    $app = new VSlim\App();
    $app->bootstrapDir($root);
    echo 'booted|' . (int) $app->booted() . PHP_EOL;
    echo $app->dispatch('GET', '/home')->body . PHP_EOL;
    echo $app->dispatch('GET', '/controller')->body . PHP_EOL;

    unlink($root . '/app/Http/Middleware/LateFile.php');
    $entry = $root . '/bootstrap/app.php';
    file_put_contents($entry, <<<'PHP'
<?php
file_put_contents(dirname(__DIR__) . '/app/Http/Middleware/LateFile.php', '<?php echo "late-include\n";');
return ['middleware' => [new \App\Http\Middleware\TraceMiddleware()]];
PHP);
    $cli = new VSlim\Cli\App();
    $cli->bootstrapDir($root);
    echo 'cli-booted|' . (int) $cli->app()->booted() . PHP_EOL;
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
runtime
controllers|1
middleware|1
routes
booted|1
home|loaded
controller|yes|/home
cli-booted|1
