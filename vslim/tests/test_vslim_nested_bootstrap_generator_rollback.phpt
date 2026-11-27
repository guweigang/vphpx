--TEST--
VSlim retries a nested bootstrap with the same Generator when only its yielded spec needs replay
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function generatorRoute(string $name): Closure
{
    return static function (VSlim\App $app) use ($name): void {
        $GLOBALS['events'][] = $name;
        $app->getNamed($name, '/' . $name, static fn (): string => $name);
    };
}

function generatorSpec(): Generator
{
    $GLOBALS['events'][] = 'iterate';
    yield 'routes' => generatorRoute('yielded');
}

function generatorAttempt(string $mode, VSlim\App $app, callable $run): void
{
    $GLOBALS['events'] = [];
    try {
        $run();
        $status = 'ok';
    } catch (Throwable $error) {
        $status = $error->getMessage();
    }
    echo "$mode|$status|", implode(',', $GLOBALS['events']), '|', implode(',', $app->routeNames()), PHP_EOL;
}

$app = new VSlim\App();
$generator = generatorSpec();
$attempt = 0;
$outer = ['routes' => [
    generatorRoute('prefix'),
    static function (VSlim\App $app) use ($generator, &$attempt): void {
        $app->bootstrap($generator);
        if (++$attempt < 3) {
            throw new LogicException('outer failed');
        }
    },
    generatorRoute('suffix'),
]];
for ($i = 0; $i < 3; ++$i) {
    generatorAttempt('web', $app, static fn () => $app->bootstrap($outer));
}
echo 'dispatch|', $app->dispatch('GET', '/yielded')->body, PHP_EOL;

$cli = new VSlim\Cli\App();
$GLOBALS['generator'] = generatorSpec();
$GLOBALS['failCli'] = true;
$file = tempnam(sys_get_temp_dir(), 'vslim-generator-');
try {
    file_put_contents($file, <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    $cli->app()->bootstrap($GLOBALS['generator']);
    $cli->command('probe', static fn (): int => 7);
    if ($GLOBALS['failCli']) {
        $GLOBALS['failCli'] = false;
        throw new LogicException('CLI outer failed');
    }
    return [];
};
PHP);
    $run = static fn () => $cli->bootstrapFile($file);
    generatorAttempt('cli', $cli->app(), $run);
    echo 'commands|', implode(',', $cli->commandNames()), PHP_EOL;
    generatorAttempt('cli', $cli->app(), $run);
    echo 'commands|', implode(',', $cli->commandNames()), '|', $cli->run('probe', []), PHP_EOL;
} finally {
    unlink($file);
}

$app = new VSlim\App();
$make = static function () use ($app): Generator {
    generatorRoute('iteration-route')($app);
    yield from generatorSpec();
};
$generator = $make();
$first = true;
$outer = ['routes' => static function (VSlim\App $app) use (&$generator, &$first): void {
    $app->bootstrap($generator);
    if ($first) {
        $first = false;
        throw new LogicException('outer failed');
    }
}];
$run = static fn () => $app->bootstrap($outer);
generatorAttempt('side-effect', $app, $run);
generatorAttempt('side-effect', $app, $run);
$generator = $make();
generatorAttempt('side-effect', $app, $run);

$app = new VSlim\App();
$failure = new DomainException('iteration failed');
$spec = new class($app, $failure) implements IteratorAggregate {
    private int $attempt = 0;
    public function __construct(private VSlim\App $app, private Throwable $failure) {}
    public function getIterator(): Traversable
    {
        if (++$this->attempt === 1) {
            $this->app->getNamed('discarded', '/discarded', static fn () => 'discarded');
            yield 'routes' => generatorRoute('partial');
            throw $this->failure;
        }
        yield 'routes' => generatorRoute('complete');
    }
};
try {
    $app->bootstrap($spec);
    throw new RuntimeException('VSlim accepted a partial iterable bootstrap spec');
} catch (DomainException $error) {
    if ($error !== $failure || $app->routeNames() !== []) {
        throw new RuntimeException('Iterable bootstrap lost the original exception or failed to roll back');
    }
}
$app->bootstrap($spec);
if ($app->routeNames() !== ['complete']) {
    throw new RuntimeException('A failed iterable bootstrap affected its retry');
}
?>
--EXPECT--
web|outer failed|prefix,iterate,yielded|prefix
web|outer failed|yielded|prefix
web|ok|yielded,suffix|prefix,yielded,suffix
dispatch|yielded
cli|CLI outer failed|iterate,yielded|
commands|
cli|ok|yielded|yielded
commands|probe|7
side-effect|outer failed|iteration-route,iterate,yielded|
side-effect|Cannot traverse an already closed generator||
side-effect|ok|iteration-route,iterate,yielded|iteration-route,yielded
