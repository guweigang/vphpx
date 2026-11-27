--TEST--
VSlim resumes Web and CLI bootstrap after automatic boot fails without replaying completed configuration
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class BootstrapRetryProvider
{
    private int $attempt = 0;

    public function boot(): void
    {
        $GLOBALS['events'][] = 'boot-' . ++$this->attempt;
        if ($this->attempt < 3) {
            throw new LogicException('boot failed');
        }
    }
}

class BootstrapRetryCommand
{
    public function aliases(): array
    {
        $GLOBALS['events'][] = 'command-metadata';
        return [];
    }

    public function handle(): int { return 7; }
}

function addRetryRoute(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'route';
    $app->get('/probe', static fn (): string => 'ready');
}

function retryBootstrap(string $label, VSlim\App $app, callable $attempt): void
{
    $app->register(new BootstrapRetryProvider());
    for ($i = 1; $i <= 3; ++$i) {
        $GLOBALS['events'] = [];
        try {
            $attempt();
            $status = 'ok';
        } catch (LogicException $error) {
            $status = $error->getMessage();
        }
        echo "$label|$i|$status|", (int) $app->booted(), '|', implode(',', $GLOBALS['events']), PHP_EOL;
    }
}

function routeCheck(VSlim\App $app): void
{
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/probe')->body, PHP_EOL;
}

$root = sys_get_temp_dir() . '/vslim-bootstrap-resume-' . bin2hex(random_bytes(8));
mkdir("$root/bootstrap", 0700, true);
mkdir("$root/routes");
mkdir("$root/app/Commands", 0700, true);
try {
    $app = new VSlim\App();
    $spec = (static function (): Generator {
        $GLOBALS['events'][] = 'iterate';
        yield 'routes' => 'addRetryRoute';
        yield 'boot' => true;
    })();
    retryBootstrap('inline', $app, static fn () => $app->bootstrap($spec));
    routeCheck($app);

    file_put_contents("$root/web.php", <<<'PHP'
<?php
$GLOBALS['events'][] = 'web-file';
return static function (): array {
    $GLOBALS['events'][] = 'web-callable';
    return ['routes' => 'addRetryRoute', 'boot' => true];
};
PHP);
    $app = new VSlim\App();
    retryBootstrap('web-file', $app, static fn () => $app->bootstrapFile("$root/web.php"));
    routeCheck($app);

    file_put_contents("$root/bootstrap/runtime.php", '<?php $GLOBALS["events"][] = "runtime-file"; return [];');
    file_put_contents("$root/routes/web.php", '<?php $GLOBALS["events"][] = "routes-file"; return "addRetryRoute";');
    $app = new VSlim\App();
    retryBootstrap('web-conventions', $app, static fn () => $app->bootstrapDir($root));
    routeCheck($app);

    file_put_contents("$root/bootstrap/services.php", '<?php $GLOBALS["events"][] = "services-file"; return ["boot" => true];');
    $app = new VSlim\App();
    retryBootstrap('web-mid-conventions', $app, static fn () => $app->bootstrapDir($root));
    routeCheck($app);
    unlink("$root/bootstrap/services.php");
    unlink("$root/bootstrap/runtime.php");

    file_put_contents("$root/commands.php", '<?php $GLOBALS["events"][] = "cli-file"; return [
        "commands" => ["probe" => new BootstrapRetryCommand()], "boot" => true];');
    $cli = new VSlim\Cli\App();
    retryBootstrap('cli-file', $cli->app(), static fn () => $cli->bootstrapFile("$root/commands.php"));
    echo 'commands|', implode(',', $cli->commandNames()), '|', $cli->run('probe', []), PHP_EOL;

    file_put_contents("$root/app/Commands/DiscoveredCommand.php", <<<'PHP'
<?php
namespace App\Commands;
$GLOBALS['events'][] = 'discovery-file';
class DiscoveredCommand extends \BootstrapRetryCommand {}
PHP);
    file_put_contents("$root/bootstrap/cli.php", '<?php $GLOBALS["events"][] = "cli-config"; return [
        "commands" => ["probe" => new BootstrapRetryCommand()], "boot" => true];');
    $cli = new VSlim\Cli\App();
    retryBootstrap('cli-conventions', $cli->app(), static fn () => $cli->bootstrapDir($root));
    echo 'commands|', implode(',', $cli->commandNames()), '|', $cli->run('probe', []), PHP_EOL;

    file_put_contents("$root/bootstrap/app.php", '<?php $GLOBALS["events"][] = "app-file"; return [
        "routes" => "addRetryRoute", "boot" => true];');
    $app = new VSlim\App();
    retryBootstrap('web-entry', $app, static fn () => $app->bootstrapDir($root));
    routeCheck($app);

    file_put_contents("$root/bootstrap/app.php", '<?php $GLOBALS["events"][] = "app-file"; return ["routes" => "addRetryRoute"];');
    $app = new VSlim\App();
    $first = true;
    retryBootstrap('web-deferred', $app, static function () use ($app, $root, &$first): void {
        $app->bootstrapDir($root);
        if ($first) {
            $first = false;
            $app->dispatch('GET', '/probe');
        }
    });
    routeCheck($app);

    $app = new VSlim\App();
    $spec = ['routes' => 'addRetryRoute'];
    $first = true;
    retryBootstrap('inline-deferred', $app, static function () use ($app, $spec, &$first): void {
        $app->bootstrap($spec);
        if ($first) {
            $first = false;
            $app->dispatch('GET', '/probe');
        }
    });
    routeCheck($app);

    $cli = new VSlim\Cli\App();
    retryBootstrap('cli-shared', $cli->app(), static function () use ($cli, $root): void {
        $result = $cli->runArgv(['vslim', '--bootstrap-dir', $root, 'probe']);
        $GLOBALS['events'][] = "exit-$result";
    });
    routeCheck($cli->app());
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
inline|1|boot failed|0|iterate,route,boot-1
inline|2|boot failed|0|boot-2
inline|3|ok|1|boot-3
routes|1|ready
web-file|1|boot failed|0|web-file,web-callable,route,boot-1
web-file|2|boot failed|0|boot-2
web-file|3|ok|1|boot-3
routes|1|ready
web-conventions|1|boot failed|0|runtime-file,routes-file,route,boot-1
web-conventions|2|boot failed|0|boot-2
web-conventions|3|ok|1|boot-3
routes|1|ready
web-mid-conventions|1|boot failed|0|runtime-file,services-file,boot-1
web-mid-conventions|2|boot failed|0|boot-2
web-mid-conventions|3|ok|1|boot-3,routes-file,route
routes|1|ready
cli-file|1|boot failed|0|cli-file,command-metadata,boot-1
cli-file|2|boot failed|0|boot-2
cli-file|3|ok|1|boot-3
commands|probe|7
cli-conventions|1|boot failed|0|discovery-file,command-metadata,cli-config,command-metadata,boot-1
cli-conventions|2|boot failed|0|boot-2
cli-conventions|3|ok|1|boot-3
commands|discovered,probe|7
web-entry|1|boot failed|0|app-file,route,boot-1
web-entry|2|boot failed|0|boot-2
web-entry|3|ok|1|boot-3
routes|1|ready
web-deferred|1|boot failed|0|app-file,route,boot-1
web-deferred|2|boot failed|0|boot-2
web-deferred|3|ok|1|boot-3
routes|1|ready
inline-deferred|1|boot failed|0|route,boot-1
inline-deferred|2|boot failed|0|boot-2
inline-deferred|3|ok|1|boot-3
routes|1|ready
cli-shared|1|boot failed|0|app-file,route,boot-1
cli-shared|2|boot failed|0|boot-2
cli-shared|3|ok|1|boot-3,command-metadata,cli-config,command-metadata,exit-7
routes|1|ready
