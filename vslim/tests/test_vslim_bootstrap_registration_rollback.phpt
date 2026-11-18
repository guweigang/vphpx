--TEST--
VSlim rolls back registrations made by failing bootstrap and lifecycle callbacks before retry
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
require __DIR__ . '/fixtures/vslim_bootstrap_app_dirs/support.php';

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

class RollbackMiddleware implements MiddlewareInterface
{
    public function __construct(private string $label) {}
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $GLOBALS['middleware'][] = $this->label;
        return $handler->handle($request);
    }
}

class RollbackProvider
{
    private int $attempt = 0;
    public function boot(VSlim\App $app): void
    {
        $label = ++$this->attempt === 1 ? 'boot-bad' : 'boot-good';
        $app->getNamed($label, '/boot', static fn (): string => $label);
        $app->before(new RollbackMiddleware($label));
        if ($this->attempt === 1) {
            throw new LogicException('boot failed');
        }
    }
}

function expectRollbackFailure(callable $run): void
{
    try {
        $run();
        echo "unexpected success\n";
    } catch (LogicException $error) {
        echo $error->getMessage(), PHP_EOL;
    }
}

class RollbackCommand
{
    public function __construct(
        private int $code,
        private array $aliases = [],
        private bool $hidden = false,
    ) {}
    public function aliases(): array { return $this->aliases; }
    public function hidden(): bool { return $this->hidden; }
    public function handle(): int { return $this->code; }
}

$root = sys_get_temp_dir() . '/vslim-registration-rollback-' . bin2hex(random_bytes(8));
mkdir("$root/bootstrap", 0700, true);
mkdir("$root/routes");
try {
    file_put_contents("$root/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/routes/web.php", <<<'PHP'
<?php
return [
    static function (VSlim\App $app): void {
        $app->getNamed('prefix', '/prefix', static fn (): string => 'prefix');
        $app->middleware(new RollbackMiddleware('prefix'));
    },
    static function (VSlim\App $app): void {
        $label = empty($GLOBALS['routeTried']) ? 'route-bad' : 'route-good';
        $app->getNamed($label, '/probe', static fn (): string => $label);
        $app->group('/probe')->middleware(new RollbackMiddleware($label));
        $app->groupAfter('/probe', new RollbackMiddleware($label . '-after'));
        if (empty($GLOBALS['routeTried'])) {
            $GLOBALS['routeTried'] = true;
            throw new LogicException('route failed');
        }
    },
    static function (VSlim\App $app): void {
        $app->getNamed('suffix', '/suffix', static fn (): string => 'suffix');
    },
];
PHP);
    $app = new VSlim\App();
    $app->getNamed('original', '/original', static fn (): string => 'original');
    $app->middleware(new RollbackMiddleware('original'));
    $app->register(new RollbackProvider());
    expectRollbackFailure(static fn () => $app->bootstrapDir($root));
    echo 'after-boot|', implode(',', $app->routeNames()), PHP_EOL;
    expectRollbackFailure(static fn () => $app->bootstrapDir($root));
    echo 'after-route|', implode(',', $app->routeNames()), PHP_EOL;
    $app->bootstrapDir($root);
    $GLOBALS['middleware'] = [];
    echo 'web|', implode(',', $app->routeNames()), '|', $app->dispatch('GET', '/probe')->body, '|',
        implode(',', $GLOBALS['middleware']), PHP_EOL;

    file_put_contents("$root/bootstrap/app.php", '<?php return [];');
    file_put_contents("$root/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    $cli->command('stable', new RollbackCommand(9, ['intermediate']));
    $cli->command('stable', new RollbackCommand(13, ['new-alias'], true));
    $cli->command('manual', static fn (): int => 5);
    $cli->app()->getNamed('cli-route', '/cli', static fn (): string => 'ready');
    if (empty($GLOBALS['cliTried'])) {
        $GLOBALS['cliTried'] = true;
        throw new LogicException('CLI configuration failed');
    }
    return [
        'prefix' => static fn (): int => 1,
        'middle' => new class(WeakReference::create($cli)) {
            private bool $attempted = false;
            public function __construct(private WeakReference $cli) {}
            public function aliases(): array
            {
                $this->cli->get()->command('manual-metadata', static fn (): int => 6);
                if (!$this->attempted) {
                    $this->attempted = true;
                    throw new LogicException('command metadata failed');
                }
                return [];
            }
            public function handle(): int { return 7; }
        },
        'tail' => static fn (): int => 8,
    ];
};
PHP);
    $cli = new VSlim\Cli\App();
    $cli->app()->register(new RollbackProvider());
    $cli->command('stable', new RollbackCommand(3, ['old-alias']));
    expectRollbackFailure(static fn () => $cli->bootstrapDir($root));
    expectRollbackFailure(static fn () => $cli->bootstrapDir($root));
    echo 'after-cli-config|', implode(',', $cli->commandNames()), '|', $cli->run('old-alias', []), '|',
        (int) $cli->hasCommand('new-alias'), (int) $cli->hasCommand('intermediate'), '|',
        (int) str_contains($cli->helpText(), 'stable'), '|', implode(',', $cli->app()->routeNames()), PHP_EOL;
    expectRollbackFailure(static fn () => $cli->bootstrapDir($root));
    echo 'after-cli-metadata|', implode(',', $cli->commandNames()), '|',
        (int) $cli->hasCommand('manual-metadata'), PHP_EOL;
    $cli->bootstrapDir($root);
    echo 'cli|', implode(',', $cli->commandNames()), '|', $cli->run('new-alias', []), '|',
        (int) $cli->hasCommand('old-alias'), '|', (int) str_contains($cli->helpText(), 'stable'), '|',
        implode(',', $cli->app()->routeNames()), PHP_EOL;
} finally {
    foreach (glob("$root/bootstrap/*.php") as $file) {
        unlink($file);
    }
    unlink("$root/routes/web.php");
    rmdir("$root/routes");
    rmdir("$root/bootstrap");
    rmdir($root);
}
?>
--EXPECT--
boot failed
after-boot|original
route failed
after-route|original,boot-good,prefix
web|original,boot-good,prefix,route-good,suffix|route-good|boot-good,original,prefix,route-good,route-good-after
boot failed
CLI configuration failed
after-cli-config|stable|3|00|1|boot-good
command metadata failed
after-cli-metadata|stable,manual,prefix|0
cli|stable,manual,prefix,manual-metadata,middle,tail|13|0|0|boot-good,cli-route
