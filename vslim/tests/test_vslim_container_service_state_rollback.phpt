--TEST--
VSlim restores plain service state in place after Web and CLI bootstrap callback failures
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class PlainTypedService
{
    public int $count = 10;
    public string $label = 'keep';
}

class ServiceStateBootProvider
{
    private int $attempt = 0;
    public function __construct(private stdClass $state, private PlainTypedService $typed) {}
    public function boot(): void
    {
        $GLOBALS['events'][] = 'boot';
        $this->state->count += 10;
        $this->typed->count += 10;
        if (++$this->attempt === 1) {
            throw new LogicException('boot failed');
        }
    }
}

function commitServicePrefix(): void
{
    $GLOBALS['events'][] = 'prefix';
    ++$GLOBALS['state']->count;
    $GLOBALS['state']->data['nested'][] = 'prefix';
    ++$GLOBALS['typed']->count;
}

function mutateServices(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'mutate';
    $state = $app->container()->get('state');
    $state->count += 100;
    $state->data['nested'][] = 'attempt';
    unset($state->label);
    $state->added = true;
    $GLOBALS['typed']->count += 100;
    unset($GLOBALS['typed']->label);
    $app->container()->get('cold')->count++;
    if (empty($GLOBALS['retried'])) {
        $GLOBALS['retried'] = true;
        throw new LogicException('mutation failed');
    }
}

$root = sys_get_temp_dir() . '/vslim-service-state-' . bin2hex(random_bytes(8));
mkdir("$root/web/bootstrap", 0700, true);
mkdir("$root/web/routes");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", '<?php return ["commitServicePrefix", "mutateServices"];');
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return "commitServicePrefix";');
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    mutateServices($cli->app());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['retried'] = false;
        $GLOBALS['typed'] = $typed = new PlainTypedService();
        $cold = (object) ['count' => 0];
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $container = $app->container();
        $container->factory('state', static fn () => (object) [
            'count' => 0, 'label' => 'keep', 'data' => ['nested' => ['original']],
        ]);
        $GLOBALS['state'] = $state = $container->get('state');
        $container->set('alias', $state);
        $container->set('typed', $typed);
        $container->factory('cold', static fn () => $cold);
        $app->register(new ServiceStateBootProvider($state, $typed));

        for ($attempt = 1; $attempt <= 3; ++$attempt) {
            $GLOBALS['events'] = [];
            try {
                if ($mode === 'web') {
                    $app->bootstrapDir("$root/web");
                    $result = 'ok';
                } else {
                    $result = $cli->runArgv(['vslim', '--bootstrap-dir', "$root/cli", 'probe']);
                }
            } catch (LogicException $error) {
                $result = $error->getMessage();
            }
            echo "$mode|$attempt|$result|", implode(',', $GLOBALS['events']), '|',
                (int) ($state === $container->get('state') && $state === $container->get('alias')),
                (int) ($typed === $container->get('typed')), '|',
                $state->count, ',', $typed->count, ',', $cold->count, '|',
                (int) isset($state->label), (int) isset($typed->label), (int) isset($state->added), '|',
                implode(',', $state->data['nested']), PHP_EOL;
        }
    }

    $container = new VSlim\Container();
    $external = [1];
    $alias = new stdClass();
    $alias->linked =& $external;
    $plain = (object) ['count' => 1];
    $container->set('reference', $alias)->set('plain', $plain);
    $container->factory('fails', static function () use ($alias, $plain): void {
        $alias->linked[0] = 2;
        $plain->count = 2;
        throw new LogicException('factory failed');
    });
    try {
        $container->get('fails');
    } catch (LogicException $error) {
        echo $error->getMessage(), '|', $external[0], '|', $plain->count, PHP_EOL;
    }
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
web|1|boot failed|boot|11|0,10,0|110|original
web|2|mutation failed|boot,prefix,mutate|11|11,21,0|110|original,prefix
web|3|ok|mutate|11|111,121,1|001|original,prefix,attempt
cli|1|boot failed|prefix,boot|11|1,11,0|110|original,prefix
cli|2|mutation failed|boot,mutate|11|11,21,0|110|original,prefix
cli|3|7|mutate|11|111,121,1|001|original,prefix,attempt
factory failed|2|1
