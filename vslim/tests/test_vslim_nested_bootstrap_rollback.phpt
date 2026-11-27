--TEST--
VSlim rolls back nested bootstrap registration and progress when an enclosing callback throws
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function nestedStep(string $name, bool $failFirst = false): void
{
    $GLOBALS['events'][] = $name;
    if ($failFirst && !isset($GLOBALS['tried'][$name])) {
        $GLOBALS['tried'][$name] = true;
        throw new LogicException($name);
    }
}

function nestedRoute(string $name, bool $failFirst = false): Closure
{
    return static function (VSlim\App $app) use ($name, $failFirst): void {
        nestedStep($name, $failFirst);
        $app->getNamed($name, '/' . $name, static fn (): string => $name);
    };
}

class NestedBootstrapProvider
{
    public function register(): void { nestedStep('provider-register'); }
    public function boot(VSlim\App $app): void { nestedRoute('boot-route')($app); }
}

class NestedBootstrapCommand
{
    public function __construct(private string $name, private bool $failFirst = false) {}
    public function aliases(): array
    {
        nestedStep($this->name, $this->failFirst);
        return [$this->name . '-alias'];
    }
    public function handle(): int { return 7; }
}

class NestedCallerCommand extends NestedBootstrapCommand
{
    public function aliases(): array
    {
        nestedStep('outer-nested');
        $GLOBALS['cli']->bootstrapFile($GLOBALS['innerCli']);
        nestedStep('after-inner', true);
        return parent::aliases();
    }
}

function nestedAttempt(string $mode, callable $run, VSlim\App $app, ?VSlim\Cli\App $cli = null): void
{
    $GLOBALS['events'] = [];
    try {
        $run();
        $status = 'ok';
    } catch (LogicException $error) {
        $status = $error->getMessage();
    }
    echo "$mode|$status|", implode(',', $GLOBALS['events']), '|',
        implode(',', $app->routeNames()), '|', (int) $app->booted(), '|', $app->providerCount();
    if ($cli !== null) {
        echo '|', implode(',', $cli->commandNames()), '|', (int) $cli->hasCommand('inner-tail-alias');
    }
    echo PHP_EOL;
}

$root = sys_get_temp_dir() . '/vslim-nested-bootstrap-' . bin2hex(random_bytes(8));
mkdir($root, 0700);
try {
    file_put_contents("$root/web.php", <<<'PHP'
<?php
nestedStep('inner-file');
return static function (): array {
    nestedStep('inner-config');
    return [
        'providers' => [new NestedBootstrapProvider()],
        'routes' => [nestedRoute('inner-first'), nestedRoute('inner-middle', true), nestedRoute('inner-tail')],
        'boot' => true,
    ];
};
PHP);
    $app = new VSlim\App();
    $GLOBALS['tried'] = [];
    nestedAttempt('web-inner', static fn () => $app->bootstrapFile("$root/web.php"), $app);
    $outer = ['routes' => [
        nestedRoute('outer-first'),
        static function (VSlim\App $app) use ($root): void {
            nestedStep('outer-nested');
            $app->bootstrapFile("$root/web.php");
            nestedStep('after-inner', true);
        },
        nestedRoute('outer-tail'),
    ]];
    $web = static fn () => $app->bootstrap($outer);
    nestedAttempt('web-outer', $web, $app);
    nestedAttempt('web-retry', $web, $app);
    echo 'web-dispatch|', $app->dispatch('GET', '/boot-route')->body, '|',
        $app->dispatch('GET', '/inner-tail')->body, PHP_EOL;

    $app = new VSlim\App();
    $GLOBALS['tried'] = [];
    $inner = [
        'providers' => [new NestedBootstrapProvider()],
        'routes' => nestedRoute('fresh-route'),
        'boot' => true,
    ];
    $outer = ['routes' => static function (VSlim\App $app) use ($inner): void {
        $app->bootstrap($inner);
        nestedStep('after-fresh', true);
    }];
    $web = static fn () => $app->bootstrap($outer);
    nestedAttempt('web-fresh', $web, $app);
    nestedAttempt('web-fresh-retry', $web, $app);

    $GLOBALS['innerCli'] = "$root/cli-inner.php";
    file_put_contents($GLOBALS['innerCli'], <<<'PHP'
<?php
nestedStep('inner-file');
return static function (): array {
    nestedStep('inner-config');
    return ['commands' => [
        'inner-first' => new NestedBootstrapCommand('inner-first'),
        'inner-middle' => new NestedBootstrapCommand('inner-middle', true),
        'inner-tail' => new NestedBootstrapCommand('inner-tail'),
    ], 'boot' => true];
};
PHP);
    file_put_contents("$root/cli-outer.php", <<<'PHP'
<?php
nestedStep('outer-file');
return static function (): array {
    nestedStep('outer-config');
    return ['commands' => [
        'outer-first' => new NestedBootstrapCommand('outer-first'),
        'outer-middle' => new NestedCallerCommand('outer-middle'),
        'outer-tail' => new NestedBootstrapCommand('outer-tail'),
    ]];
};
PHP);
    $GLOBALS['tried'] = [];
    $GLOBALS['cli'] = $cli = new VSlim\Cli\App();
    $cli->app()->register(new NestedBootstrapProvider());
    nestedAttempt('cli-inner', static fn () => $cli->bootstrapFile($GLOBALS['innerCli']), $cli->app(), $cli);
    $run = static fn () => $cli->bootstrapFile("$root/cli-outer.php");
    nestedAttempt('cli-outer', $run, $cli->app(), $cli);
    nestedAttempt('cli-retry', $run, $cli->app(), $cli);
    echo 'cli-run|', $cli->run('inner-tail-alias', []), PHP_EOL;
} finally {
    foreach (glob("$root/*.php") as $file) {
        unlink($file);
    }
    rmdir($root);
}
?>
--EXPECT--
web-inner|inner-middle|inner-file,inner-config,provider-register,inner-first,inner-middle|inner-first|0|1
web-outer|after-inner|outer-first,outer-nested,inner-middle,inner-tail,boot-route,after-inner|inner-first,outer-first|0|1
web-retry|ok|outer-nested,inner-middle,inner-tail,boot-route,after-inner,outer-tail|inner-first,outer-first,inner-middle,inner-tail,boot-route,outer-tail|1|1
web-dispatch|boot-route|inner-tail
web-fresh|after-fresh|provider-register,fresh-route,boot-route,after-fresh||0|0
web-fresh-retry|ok|provider-register,fresh-route,boot-route,after-fresh|fresh-route,boot-route|1|1
cli-inner|inner-middle|inner-file,inner-config,inner-first,inner-middle||0|1|inner-first|0
cli-outer|after-inner|outer-file,outer-config,outer-first,outer-nested,inner-middle,inner-tail,boot-route,after-inner||0|1|inner-first,outer-first|0
cli-retry|ok|outer-nested,inner-middle,inner-tail,boot-route,after-inner,outer-middle,outer-tail|boot-route|1|1|inner-first,outer-first,inner-middle,inner-tail,outer-middle,outer-tail|1
cli-run|7
