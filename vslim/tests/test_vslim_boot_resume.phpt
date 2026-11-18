--TEST--
VSlim Web and CLI resume auto-boot at the failed provider or module callback
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class BootResumeProvider
{
    public function __construct(private string $name, private bool $fails = false) {}
    public function setApp(VSlim\App $app): void { $GLOBALS['events'][] = "$this->name.bind"; }
    public function boot(): void
    {
        $GLOBALS['events'][] = "$this->name.boot";
        if ($this->fails) {
            $this->fails = false;
            throw new LogicException('provider failed');
        }
    }
}
class BootResumeFirstProvider extends BootResumeProvider {}

class BootResumeModule
{
    private int $routeAttempts = 0;
    private int $bootAttempts = 0;

    public function __construct(private string $name, private bool $fails = false) {}
    public function setApp(VSlim\App $app): void { $GLOBALS['events'][] = "$this->name.bind"; }
    public function middlewares(): void { $GLOBALS['events'][] = "$this->name.middleware"; }
    public function routes(): void
    {
        $GLOBALS['events'][] = "$this->name.routes";
        if ($this->fails && ++$this->routeAttempts === 1) {
            throw new LogicException('module routes failed');
        }
    }
    public function boot(): void
    {
        $GLOBALS['events'][] = "$this->name.boot";
        if ($this->fails && ++$this->bootAttempts === 1) {
            throw new LogicException('module boot failed');
        }
    }
}
class BootResumeFirstModule extends BootResumeModule {}
class BootResumeLastModule extends BootResumeModule {}

$root = sys_get_temp_dir() . '/vslim-boot-resume-' . bin2hex(random_bytes(8));
mkdir("$root/bootstrap", 0700, true);
try {
    file_put_contents("$root/bootstrap/app.php", '<?php return [];');
    file_put_contents("$root/bootstrap/cli.php", '<?php return ["probe" => static fn (): int => 7];');
    foreach (['web', 'cli'] as $mode) {
        $cli = new VSlim\Cli\App();
        $app = $mode === 'cli' ? $cli->app() : new VSlim\App();
        $GLOBALS['events'] = [];
        $app->registerMany([new BootResumeFirstProvider('p1'), new BootResumeProvider('p2', true)]);
        $app->moduleMany([
            new BootResumeFirstModule('m1'),
            new BootResumeModule('m2', true),
            new BootResumeLastModule('m3'),
        ]);
        $app->get('/', static fn (): string => 'route reached');
        for ($attempt = 1; $attempt <= 4; $attempt++) {
            $GLOBALS['events'] = [];
            try {
                $result = $mode === 'web'
                    ? $app->dispatch('GET', '/')->body
                    : $cli->runArgv(['vslim', '--bootstrap-dir', $root, 'probe']);
            } catch (LogicException $error) {
                $result = $error->getMessage();
            }
            echo "$mode|$attempt|$result|", (int) $app->booted(), '|', implode(',', $GLOBALS['events']), PHP_EOL;
        }
        $GLOBALS['events'] = [];
        $app->boot();
        echo "$mode|boot again|", count($GLOBALS['events']), PHP_EOL;
    }
} finally {
    unlink("$root/bootstrap/cli.php");
    unlink("$root/bootstrap/app.php");
    rmdir("$root/bootstrap");
    rmdir($root);
}
?>
--EXPECT--
web|1|provider failed|0|p1.bind,p1.boot,p2.bind,p2.boot
web|2|module routes failed|0|p2.boot,m1.bind,m1.middleware,m1.routes,m1.boot,m2.bind,m2.middleware,m2.routes
web|3|module boot failed|0|m2.routes,m2.boot
web|4|route reached|1|m2.boot,m3.bind,m3.middleware,m3.routes,m3.boot
web|boot again|0
cli|1|provider failed|0|p1.bind,p1.boot,p2.bind,p2.boot
cli|2|module routes failed|0|p2.boot,m1.bind,m1.middleware,m1.routes,m1.boot,m2.bind,m2.middleware,m2.routes
cli|3|module boot failed|0|m2.routes,m2.boot
cli|4|7|1|m2.boot,m3.bind,m3.middleware,m3.routes,m3.boot
cli|boot again|0
