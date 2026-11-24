--TEST--
VSlim normalizes arrays and Traversable once and applies bootstrap boot options after routes or commands
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--INI--
disable_functions=iterator_to_array
--FILE--
<?php
function iterator_to_array(): never
{
    throw new LogicException('Native iterable collection must not call a global PHP function');
}

final class BootstrapSpecProbe
{
    public function __construct(private ?WeakReference $cli = null) {}

    public function boot(): void
    {
        $cli = $this->cli?->get();
        $GLOBALS['events'][] = $cli === null ? 'boot' : 'boot:' . implode(',', $cli->commandNames());
    }
}

function specInput(array $spec, bool $traversable): iterable
{
    if (!$traversable) {
        return $spec;
    }
    return (static function () use ($spec): Generator {
        ++$GLOBALS['iterations'];
        yield from $spec;
    })();
}

function repeatedPositions(array $values): Generator
{
    foreach ($values as $value) {
        yield 8 => $value;
    }
}

$root = sys_get_temp_dir() . '/vslim-bootstrap-iteration-' . bin2hex(random_bytes(8));
mkdir($root . '/app/Providers/Nested', 0700, true);
$cliFile = $root . '/cli.php';
file_put_contents($cliFile, '<?php return $GLOBALS["cliSpec"];');
try {
    foreach (['array' => false, 'traversable' => true] as $type => $traversable) {
        foreach (['omitted' => null, 'true' => true, 'false' => false] as $label => $boot) {
            $option = $boot === null ? [] : ['boot' => $boot];
            $GLOBALS['events'] = [];
            $GLOBALS['iterations'] = 0;
            $app = new VSlim\App();
            $app->bootstrap(specInput([
                'providers' => [new BootstrapSpecProbe()],
                'routes' => [
                    static function (VSlim\App $app): void {
                        $GLOBALS['events'][] = 'route-a';
                        $app->get('/first', static fn () => 'first');
                    },
                    static function (VSlim\App $app): void {
                        $GLOBALS['events'][] = 'route-b';
                        $app->get('/second', static fn () => 'second');
                    },
                ],
            ] + $option, $traversable));
            $before = (int) $app->booted();
            echo "web|$type|$label|$before|", $app->dispatch('GET', '/second')->body, '|',
                implode(',', $GLOBALS['events']), '|', $GLOBALS['iterations'], PHP_EOL;

            $GLOBALS['events'] = [];
            $GLOBALS['iterations'] = 0;
            $cli = new VSlim\Cli\App();
            $cli->app()->register(new BootstrapSpecProbe(WeakReference::create($cli)));
            $GLOBALS['cliSpec'] = specInput([
                'commands' => ['beta' => static fn () => 0, 'alpha' => static fn () => 0],
            ] + $option, $traversable);
            $cli->bootstrapFile($cliFile);
            echo "cli|$type|$label|", (int) $cli->app()->booted(), '|', implode(',', $cli->commandNames()), '|',
                implode(',', $GLOBALS['events']), '|', $GLOBALS['iterations'], PHP_EOL;
        }
    }

    $GLOBALS['iterations'] = 0;
    $GLOBALS['cliSpec'] = specInput(['only' => static fn () => 0], true);
    $cli = new VSlim\Cli\App();
    $cli->bootstrapFile($cliFile);
    echo 'shorthand|', implode(',', $cli->commandNames()), '|', $GLOBALS['iterations'], PHP_EOL;

    file_put_contents($root . '/app/Providers/Nested/SinglePassProvider.php',
        '<?php namespace App\Providers\Nested; final class SinglePassProvider {}');
    file_put_contents($root . '/app.php', <<<'PHP'
<?php
return (static function (): Generator {
    ++$GLOBALS['iterations'];
    yield 'providers' => [\App\Providers\Nested\SinglePassProvider::class];
    yield 'boot' => true;
    yield 'boot' => false;
})();
PHP);
    $GLOBALS['iterations'] = 0;
    $app = new VSlim\App();
    $app->bootstrapFile($root . '/app.php');
    echo 'project|', $app->providerCount(), '|', (int) $app->booted(), '|', $GLOBALS['iterations'], PHP_EOL;

    $events = [];
    $firstProvider = new class ($events) {
        public function __construct(private array &$events) {}
        public function register(): void { $this->events[] = 'provider-a'; }
    };
    $secondProvider = new class ($events) {
        public function __construct(private array &$events) {}
        public function register(): void { $this->events[] = 'provider-b'; }
    };
    $firstModule = new class ($events) {
        public function __construct(private array &$events) {}
        public function register(): void { $this->events[] = 'module-a'; }
    };
    $secondModule = new class ($events) {
        public function __construct(private array &$events) {}
        public function register(): void { $this->events[] = 'module-b'; }
    };
    $app = new VSlim\App();
    $app->bootstrap([
        'providers' => repeatedPositions([$firstProvider, $secondProvider]),
        'modules' => repeatedPositions([$firstModule, $secondModule]),
        'routes' => repeatedPositions([
            static function (VSlim\App $app) use (&$events): void {
                $events[] = 'route-a';
                $app->get('/position-a', static fn () => 'a');
            },
            static function (VSlim\App $app) use (&$events): void {
                $events[] = 'route-b';
                $app->get('/position-b', static fn () => 'b');
            },
        ]),
    ]);
    echo 'positions|', $app->providerCount(), '|', $app->moduleCount(), '|',
        $app->dispatch('GET', '/position-b')->body, '|', implode(',', $events), PHP_EOL;
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
web|array|omitted|0|second|route-a,route-b,boot|0
cli|array|omitted|0|beta,alpha||0
web|array|true|1|second|route-a,route-b,boot|0
cli|array|true|1|beta,alpha|boot:beta,alpha|0
web|array|false|0|second|route-a,route-b,boot|0
cli|array|false|0|beta,alpha||0
web|traversable|omitted|0|second|route-a,route-b,boot|1
cli|traversable|omitted|0|beta,alpha||1
web|traversable|true|1|second|route-a,route-b,boot|1
cli|traversable|true|1|beta,alpha|boot:beta,alpha|1
web|traversable|false|0|second|route-a,route-b,boot|1
cli|traversable|false|0|beta,alpha||1
shorthand|only|1
project|1|0|1
positions|2|2|b|provider-a,provider-b,module-a,module-b,route-a,route-b
