--TEST--
VSlim keeps the selected Web and CLI project entry across retries and rediscovers it on a new bootstrap
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function entryRoute(string $name, bool $fails = false): Closure
{
    return static function (VSlim\App $app) use ($name, $fails): void {
        if ($fails && !$GLOBALS['attempted']) {
            $GLOBALS['attempted'] = true;
            throw new LogicException('retry');
        }
        $app->getNamed($name, "/$name", static fn () => $name);
    };
}

$root = sys_get_temp_dir() . '/vslim-retry-entry-' . bin2hex(random_bytes(8));
mkdir("$root/web/routes", 0700, true);
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/routes/main.php", '<?php return [entryRoute("first"), entryRoute("remaining", true)];');
    $GLOBALS['attempted'] = false;
    $web = new VSlim\App();
    try {
        $web->bootstrapDir("$root/web");
    } catch (LogicException $error) {
        echo 'web|', $error->getMessage(), '|', implode(',', $web->routeNames()), PHP_EOL;
    }
    file_put_contents("$root/web/app.php", '<?php return ["routes" => entryRoute("new-entry")];');
    $web->bootstrapDir("$root/web");
    echo 'web-retry|', implode(',', $web->routeNames()), PHP_EOL;
    echo 'web-fresh|', implode(',', (new VSlim\App())->bootstrapDir("$root/web")->routeNames()), PHP_EOL;

    file_put_contents("$root/cli/app.php", '<?php return ["routes" => [entryRoute("first"), entryRoute("remaining", true)]];');
    file_put_contents("$root/cli/bootstrap/cli.php", '<?php return ["probe" => static fn (): int => 7];');
    $GLOBALS['attempted'] = false;
    $cli = new VSlim\Cli\App();
    try {
        $cli->bootstrapDir("$root/cli");
    } catch (LogicException $error) {
        echo 'cli|', $error->getMessage(), '|', implode(',', $cli->app()->routeNames()), PHP_EOL;
    }
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return ["routes" => entryRoute("priority-entry")];');
    $cli->bootstrapDir("$root/cli");
    echo 'cli-retry|', implode(',', $cli->app()->routeNames()), '|', $cli->run('probe', []), PHP_EOL;
    $fresh = (new VSlim\Cli\App())->bootstrapDir("$root/cli");
    echo 'cli-fresh|', implode(',', $fresh->app()->routeNames()), '|', $fresh->run('probe', []), PHP_EOL;
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
web|retry|first
web-retry|first,remaining
web-fresh|new-entry
cli|retry|first
cli-retry|first,remaining|7
cli-fresh|priority-entry|7
