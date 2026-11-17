--TEST--
VSlim restores services, factories and cached resolutions when Web and CLI bootstrap callbacks throw
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class ContainerRollbackProvider
{
    private int $attempts = 0;
    public function boot(VSlim\App $app): void
    {
        $GLOBALS['events'][] = 'boot';
        if (++$this->attempts === 1) {
            $app->container()->set('boot-residue', true);
            throw new LogicException('boot failed');
        }
        $app->container()->set('boot-service', true);
    }
}

function registerPrefixService(VSlim\Container $container): void
{
    $GLOBALS['events'][] = 'prefix';
    $container->set('prefix', new stdClass());
}

function updateServices(VSlim\Container $container): void
{
    $failedAttempt = empty($GLOBALS['updated']);
    $GLOBALS['updated'] = true;
    $label = $failedAttempt ? 'failed' : 'ready';
    $GLOBALS['events'][] = $label;
    $container->set('new-service', $label);
    $container->factory('new-factory', static fn () => (object) ['label' => $label]);
    $container->get('new-factory');
    $container->factory('direct', static fn () => (object) ['label' => $label]);
    $container->get('direct');
    $container->set('cached', (object) ['label' => 'temporary']);
    $container->factory('cached', static fn () => (object) ['label' => $label]);
    $container->get('cached');
    $container->set('cold', $label);
    $container->set('nullable', $label);
    $container->get('warm-on-failure');
    if ($failedAttempt) {
        throw new LogicException('service setup failed');
    }
}

function serviceAttempt(string $label, callable $invoke): void
{
    $GLOBALS['events'] = [];
    try {
        $result = $invoke();
        $status = is_int($result) ? $result : 'ok';
    } catch (LogicException $error) {
        $status = $error->getMessage();
    }
    echo $label, '|', $status, '|', implode(',', $GLOBALS['events']), PHP_EOL;
}

$root = sys_get_temp_dir() . '/vslim-container-rollback-' . bin2hex(random_bytes(8));
mkdir("$root/web/bootstrap", 0700, true);
mkdir("$root/web/routes");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", <<<'PHP'
<?php
return [
    static fn (VSlim\App $app) => registerPrefixService($app->container()),
    static fn (VSlim\App $app) => updateServices($app->container()),
    static fn (VSlim\App $app) => $app->get('/probe', static fn (): string => 'ready'),
];
PHP);
    file_put_contents("$root/cli/bootstrap/app.php", <<<'PHP'
<?php
return static fn (VSlim\App $app) => registerPrefixService($app->container());
PHP);
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    updateServices($cli->app()->container());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['updated'] = false;
        $GLOBALS['cachedCalls'] = $GLOBALS['coldCalls'] = $GLOBALS['warmCalls'] = 0;
        $cli = new VSlim\Cli\App();
        $app = $mode === 'cli' ? $cli->app() : new VSlim\App();
        $app->register(new ContainerRollbackProvider());
        $container = $app->container();
        $direct = (object) ['label' => 'original'];
        $container->set('direct', $direct);
        $container->set('nullable', null);
        $container->factory('cached', static function (): object {
            return (object) ['attempt' => ++$GLOBALS['cachedCalls']];
        });
        $container->factory('cold', static function (): string {
            ++$GLOBALS['coldCalls'];
            return 'old-factory';
        });
        $container->factory('warm-on-failure', static function (): int {
            return ++$GLOBALS['warmCalls'];
        });
        $cached = $container->get('cached');
        $boot = $mode === 'cli'
            ? static fn () => $cli->runArgv(['vslim', '--bootstrap-dir', "$root/cli", 'probe'])
            : static fn () => $app->bootstrapDir("$root/web");

        serviceAttempt("$mode|1", $boot);
        echo 'boot-residue|', (int) $container->has('boot-residue'), PHP_EOL;
        serviceAttempt("$mode|2", $boot);
        $prefix = $container->get('prefix');
        echo 'restored|', (int) ($container->get('direct') === $direct),
            (int) ($container->get('cached') === $cached),
            (int) ($container->has('nullable') && $container->get('nullable') === null), '|',
            (int) $container->has('new-service'), (int) $container->has('new-factory'), '|',
            $container->get('cold'), '|', $GLOBALS['cachedCalls'], $GLOBALS['coldCalls'], $GLOBALS['warmCalls'], PHP_EOL;
        serviceAttempt("$mode|3", $boot);
        $new = $container->get('new-factory');
        echo 'committed|', (int) ($container->get('prefix') === $prefix), '|',
            $container->get('direct')->label, '|', $container->get('cached')->label, '|',
            $container->get('new-service'), '|', $new->label, '|',
            (int) ($container->get('new-factory') === $new), '|',
            $container->get('warm-on-failure'), '|', (int) $container->get('boot-service'), PHP_EOL;
    }

    $container = new VSlim\Container();
    $attempt = 0;
    $container->factory('throwing-factory', static function () use ($container, &$attempt): int {
        $container->set('nested-service', ++$attempt);
        if ($attempt === 1) {
            throw new LogicException('factory failed');
        }
        return $attempt;
    });
    serviceAttempt('factory', static fn () => $container->get('throwing-factory'));
    echo 'factory-residue|', (int) $container->has('nested-service'), '|',
        $container->get('throwing-factory'), '|', $container->get('nested-service'), PHP_EOL;
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
web|1|boot failed|boot
boot-residue|0
web|2|service setup failed|boot,prefix,failed
restored|111|00|old-factory|111
web|3|ok|ready
committed|1|ready|ready|ready|ready|1|2|1
cli|1|boot failed|prefix,boot
boot-residue|0
cli|2|service setup failed|boot,failed
restored|111|00|old-factory|111
cli|3|7|ready
committed|1|ready|ready|ready|ready|1|2|1
factory|factory failed|
factory-residue|0|2|2
