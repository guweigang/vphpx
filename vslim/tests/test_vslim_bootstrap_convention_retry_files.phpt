--TEST--
VSlim reuses discovered Web and CLI file lists until the pending bootstrap finishes
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class ConventionRetryCommand
{
    public function aliases(): array
    {
        if (get_class($this) === 'App\\Commands\\ConventionMiddleCommand') {
            conventionRetry();
        }
        return [];
    }
    public function handle(): int { return 7; }
}

function conventionRetry(): void
{
    if (!$GLOBALS['tried']) {
        $GLOBALS['tried'] = true;
        throw new LogicException('retry');
    }
}

function conventionFailure(callable $run): void
{
    try {
        $run();
    } catch (LogicException $error) {
        echo $error->getMessage(), PHP_EOL;
    }
}

$root = sys_get_temp_dir() . '/vslim-convention-list-' . bin2hex(random_bytes(8));
mkdir("$root/routes", 0700, true);
mkdir("$root/app/Commands", 0700, true);
try {
    $route = static function (string $file, string $name, bool $retry = false) use ($root): void {
        $begin = $retry ? '\\conventionRetry(); ' : '';
        file_put_contents("$root/routes/$file.php", '<?php return static function ($app): void { '
            . $begin . '$app->getNamed("' . $name . '", "/' . $name . '", static fn () => "ok"); };');
    };
    $route('10', 'first');
    $route('20', 'middle', true);
    $route('30', 'last');
    $app = new VSlim\App();
    $GLOBALS['tried'] = false;
    conventionFailure(static fn () => $app->bootstrapDir($root));
    $route('05', 'new');
    $app->bootstrapDir($root);
    echo 'web-retry|', implode(',', $app->routeNames()), PHP_EOL;
    echo 'web-fresh|', implode(',', (new VSlim\App())->bootstrapDir($root)->routeNames()), PHP_EOL;

    $command = static function (string $part) use ($root): void {
        $name = 'Convention' . $part . 'Command';
        file_put_contents("$root/app/Commands/$name.php", '<?php namespace App\\Commands; '
            . 'class ' . $name . ' extends \\ConventionRetryCommand {}');
    };
    foreach (['First', 'Middle', 'Suffix'] as $part) {
        $command($part);
    }
    $cli = new VSlim\Cli\App();
    $GLOBALS['tried'] = false;
    conventionFailure(static fn () => $cli->bootstrapDir($root));
    $command('Added');
    $cli->bootstrapDir($root);
    echo 'cli-retry|', implode(',', $cli->commandNames()), PHP_EOL;
    echo 'cli-fresh|', implode(',', (new VSlim\Cli\App())->bootstrapDir($root)->commandNames()), PHP_EOL;
} finally {
    foreach (glob("$root/routes/*.php") as $file) {
        unlink($file);
    }
    foreach (glob("$root/app/Commands/*.php") as $file) {
        unlink($file);
    }
    rmdir("$root/routes");
    rmdir("$root/app/Commands");
    rmdir("$root/app");
    rmdir($root);
}
?>
--EXPECT--
retry
web-retry|first,middle,last
web-fresh|new,first,middle,last
retry
cli-retry|convention-first,convention-middle,convention-suffix
cli-fresh|convention-added,convention-first,convention-middle,convention-suffix
