--TEST--
VSlim resumes failed configuration, route and command items with or without an earlier boot failure
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class FollowupBootProvider
{
    public function __construct(private bool $fails = true) {}
    public function boot(): void { followupStep('boot', $this->fails); }
}

function followupStep(string $name, bool $fails = false): void
{
    $GLOBALS['events'][] = $name;
    if ($fails && empty($GLOBALS['attempted'][$name])) {
        $GLOBALS['attempted'][$name] = true;
        throw new LogicException($name);
    }
}

function followupRoute(string $name, bool $fails = false): Closure
{
    return static function (VSlim\App $app) use ($name, $fails): void {
        followupStep($name, $fails);
        $app->get('/' . $name, static fn (): string => $name);
    };
}

class FollowupCommand
{
    private bool $attempted = false;

    public function __construct(private string $name, private bool $fails = false) {}
    public function aliases(): array
    {
        followupStep($this->name);
        if ($this->fails && !$this->attempted) {
            $this->attempted = true;
            throw new LogicException($this->name);
        }
        return [];
    }
    public function handle(): int { return 7; }
}

function followupRetry(string $mode, int $count, callable $run): void
{
    $GLOBALS['attempted'] = [];
    for ($index = 1; $index <= $count; ++$index) {
        $GLOBALS['events'] = [];
        try {
            $result = $run();
            $status = is_int($result) ? $result : 'ok';
        } catch (LogicException $error) {
            $status = $error->getMessage();
        }
        echo "$mode|$index|$status|", implode(',', $GLOBALS['events']), PHP_EOL;
    }
}

$root = sys_get_temp_dir() . '/vslim-boot-followup-' . bin2hex(random_bytes(8));
mkdir("$root/bootstrap", 0700, true);
mkdir("$root/routes");
mkdir("$root/app/Commands", 0700, true);
try {
    file_put_contents("$root/bootstrap/runtime.php", '<?php followupStep("runtime-file"); return ["boot" => true];');
    file_put_contents("$root/bootstrap/services.php", <<<'PHP'
<?php
followupStep('services-file');
return static function (): void { followupStep('configure-services', true); };
PHP);
    file_put_contents("$root/bootstrap/errors.php", <<<'PHP'
<?php
followupStep('errors-file');
return [
    'middleware_setup' => static function (): void { followupStep('setup-middleware'); },
    'routes' => [followupRoute('spec-first'), followupRoute('spec-middle', true)],
];
PHP);
    file_put_contents("$root/routes/10.php", <<<'PHP'
<?php
followupStep('routes-file');
return (static function (): Generator {
    followupStep('routes-list');
    yield followupRoute('route-first');
    yield followupRoute('route-middle', true);
    yield followupRoute('route-last');
})();
PHP);
    file_put_contents("$root/routes/20.php", '<?php followupStep("last-file"); return followupRoute("last");');
    $app = new VSlim\App();
    $app->register(new FollowupBootProvider());
    followupRetry('web', 5, static fn () => $app->bootstrapDir($root));
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/last')->body, PHP_EOL;

    $app = new VSlim\App();
    $app->register(new FollowupBootProvider(false));
    followupRetry('web-boot-ok', 4, static fn () => $app->bootstrapDir($root));
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/last')->body, PHP_EOL;

    file_put_contents("$root/bootstrap/app.php", '<?php followupStep("app-file"); return [];');
    foreach (['First', 'Middle', 'Suffix'] as $position) {
        $class = 'Followup' . $position . 'Command';
        $metadata = var_export("discovered-$position", true);
        $fails = $position === 'Middle' ? ', true' : '';
        file_put_contents("$root/app/Commands/$class.php", '<?php namespace App\\Commands; '
            . "final class $class extends \\FollowupCommand { public function __construct() {} "
            . "public function aliases(): array { \\followupStep($metadata$fails); return []; } }");
    }
    file_put_contents("$root/bootstrap/cli.php", <<<'PHP'
<?php
followupStep('cli-file');
return static function (): array {
    followupStep('cli-callback');
    return [
        'commands' => (static function (): Generator {
            followupStep('cli-list');
            yield 'first' => new FollowupCommand('first');
            yield 'middle' => new FollowupCommand('middle', true);
            yield 'tail' => new FollowupCommand('tail');
        })(),
    ];
};
PHP);
    $cli = new VSlim\Cli\App();
    $cli->app()->register(new FollowupBootProvider());
    followupRetry('cli', 4, static fn () => $cli->runArgv(['vslim', '--bootstrap-dir', $root, 'tail']));
    echo 'commands|', implode(',', $cli->commandNames()), PHP_EOL;

    $cli = new VSlim\Cli\App();
    $cli->app()->register(new FollowupBootProvider(false));
    followupRetry('cli-boot-ok', 3, static fn () => $cli->runArgv(['vslim', '--bootstrap-dir', $root, 'tail']));
    echo 'commands|', implode(',', $cli->commandNames()), PHP_EOL;

    $cli = new VSlim\Cli\App();
    followupRetry('cli-file', 2, static fn () => $cli->bootstrapFile("$root/bootstrap/cli.php"));
    echo 'commands|', implode(',', $cli->commandNames()), '|', $cli->run('tail', []), PHP_EOL;

    file_put_contents("$root/bootstrap/app.php", <<<'PHP'
<?php
followupStep('app-file');
return static function (): Generator {
    followupStep('app-callback');
    return (static function (): Generator {
        followupStep('app-spec');
        yield 'routes' => [followupRoute('first'), followupRoute('middle', true), followupRoute('tail')];
    })();
};
PHP);
    $app = new VSlim\App();
    followupRetry('web-entry', 2, static fn () => $app->bootstrapDir($root));
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/tail')->body, PHP_EOL;

    $app = new VSlim\App();
    followupRetry('web-file', 2, static fn () => $app->bootstrapFile("$root/bootstrap/app.php"));
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/tail')->body, PHP_EOL;

    $cli = new VSlim\Cli\App();
    followupRetry('cli-app-file', 2, static fn () => $cli->bootstrapFile("$root/bootstrap/app.php"));
    echo 'routes|', $cli->app()->routeCount(), '|', $cli->app()->dispatch('GET', '/tail')->body, PHP_EOL;

    $app = new VSlim\App();
    $load = require "$root/bootstrap/app.php";
    $spec = $load();
    followupRetry('web-inline', 2, static fn () => $app->bootstrap($spec));
    echo 'routes|', $app->routeCount(), '|', $app->dispatch('GET', '/tail')->body, PHP_EOL;
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
web|1|boot|runtime-file,boot
web|2|configure-services|boot,services-file,configure-services
web|3|spec-middle|configure-services,errors-file,setup-middleware,spec-first,spec-middle
web|4|route-middle|spec-middle,routes-file,routes-list,route-first,route-middle
web|5|ok|route-middle,route-last,last-file,last
routes|6|last
web-boot-ok|1|configure-services|runtime-file,boot,services-file,configure-services
web-boot-ok|2|spec-middle|configure-services,errors-file,setup-middleware,spec-first,spec-middle
web-boot-ok|3|route-middle|spec-middle,routes-file,routes-list,route-first,route-middle
web-boot-ok|4|ok|route-middle,route-last,last-file,last
routes|6|last
cli|1|boot|app-file,boot
cli|2|discovered-Middle|boot,discovered-First,discovered-Middle
cli|3|middle|discovered-Middle,discovered-Suffix,cli-file,cli-callback,cli-list,first,middle
cli|4|7|middle,tail
commands|followup-first,followup-middle,followup-suffix,first,middle,tail
cli-boot-ok|1|discovered-Middle|app-file,boot,discovered-First,discovered-Middle
cli-boot-ok|2|middle|discovered-Middle,discovered-Suffix,cli-file,cli-callback,cli-list,first,middle
cli-boot-ok|3|7|middle,tail
commands|followup-first,followup-middle,followup-suffix,first,middle,tail
cli-file|1|middle|cli-file,cli-callback,cli-list,first,middle
cli-file|2|ok|middle,tail
commands|first,middle,tail|7
web-entry|1|middle|app-file,app-callback,app-spec,first,middle
web-entry|2|ok|middle,tail
routes|3|tail
web-file|1|middle|app-file,app-callback,app-spec,first,middle
web-file|2|ok|middle,tail
routes|3|tail
cli-app-file|1|middle|app-file,app-callback,app-spec,first,middle
cli-app-file|2|ok|middle,tail
routes|3|tail
web-inline|1|middle|app-spec,first,middle
web-inline|2|ok|middle,tail
routes|3|tail
