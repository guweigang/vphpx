--TEST--
VSlim restores nested service objects, shared identities and cycles after Web and CLI bootstrap failures
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class GraphService
{
    public string $stage = 'initial';
    public stdClass $left;
    public stdClass $right;
    public array $index;

    public function __construct(stdClass $child)
    {
        $this->left = $this->right = $child;
        $this->index = ['nested' => [$child, $this]];
    }
}

class GraphBootProvider
{
    private int $attempt = 0;
    public function __construct(private GraphService $root, private stdClass $child) {}
    public function boot(): void
    {
        $this->child->count += 10;
        $GLOBALS['events'][] = 'boot';
        if (++$this->attempt === 1) {
            $this->child->back = null;
            $this->root->right = (object) ['count' => 0];
            throw new LogicException('boot failed');
        }
    }
}

function graphPrefix(): void
{
    ++$GLOBALS['child']->count;
    $GLOBALS['graph']->stage = 'prefix';
    $GLOBALS['events'][] = 'prefix';
}

function mutateGraph(VSlim\App $app): void
{
    $root = $app->container()->get('graph');
    $child = $root->left;
    $child->count += 100;
    $root->stage = 'ready';
    $GLOBALS['events'][] = 'mutate';
    if (empty($GLOBALS['failed'])) {
        $GLOBALS['failed'] = true;
        $replacement = (object) ['count' => 999];
        $root->left = $root->right = $replacement;
        $root->index['nested'] = [$replacement];
        $child->back = $child->self = null;
        throw new LogicException('mutation failed');
    }
}

$root = sys_get_temp_dir() . '/vslim-graph-rollback-' . bin2hex(random_bytes(8));
mkdir("$root/web/bootstrap", 0700, true);
mkdir("$root/web/routes");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", '<?php return ["graphPrefix", "mutateGraph"];');
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return "graphPrefix";');
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    mutateGraph($cli->app());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['failed'] = false;
        $GLOBALS['child'] = $child = (object) ['count' => 1];
        $GLOBALS['graph'] = $graph = new GraphService($child);
        $child->back = $graph;
        $child->self = $child;
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $container = $app->container();
        $container->factory('graph', static fn () => $graph);
        $container->get('graph');
        $container->set('also-child', $child);
        $app->register(new GraphBootProvider($graph, $child));

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
                (int) ($container->get('graph') === $graph && $container->get('also-child') === $child),
                (int) ($graph->left === $child && $graph->right === $child),
                (int) (($graph->index['nested'][0] ?? null) === $child && ($graph->index['nested'][1] ?? null) === $graph),
                (int) ($child->back === $graph && $child->self === $child), '|',
                $graph->stage, '|', $child->count, PHP_EOL;
        }
    }

    $app = new VSlim\App();
    $value = [1];
    $byReference = new stdClass();
    $byReference->link =& $value;
    $refGraph = (object) ['nested' => [$byReference]];
    $safe = (object) ['nested' => (object) ['count' => 1]];
    $app->container()->set('reference', $refGraph)->set('safe', $safe);
    try {
        $app->bootstrap(['routes' => static function () use ($refGraph, $safe) {
            $refGraph->nested[0]->link[0] = 2;
            $safe->nested->count = 2;
            throw new LogicException('reference skipped');
        }]);
    } catch (LogicException $error) {
        echo $error->getMessage(), '|', $value[0], '|', $safe->nested->count, PHP_EOL;
    }

    if (PHP_VERSION_ID >= 80400) {
        eval('class GraphHookedService {
            public int $stored = 1;
            public int $value {
                get => $this->stored;
                set { ++$GLOBALS["hookWrites"]; $this->stored = $value; }
            }
        }');
        $GLOBALS['hookWrites'] = 0;
        $hook = new GraphHookedService();
    } else {
        $GLOBALS['hookWrites'] = 0;
        $hook = new class {
            private int $state = 1;
            public function __get(string $key): int { return $this->state; }
            public function __set(string $key, mixed $value): void { ++$GLOBALS['hookWrites']; $this->state = $value; }
        };
    }
    $hookGraph = (object) ['child' => $hook];
    $app->container()->set('hook', $hookGraph);
    try {
        $app->bootstrap(['routes' => static function () use ($hookGraph, $safe) {
            $hookGraph->child->value = 2;
            $safe->nested->count = 2;
            throw new LogicException('hook skipped');
        }]);
    } catch (LogicException $error) {
        echo $error->getMessage(), '|', $hook->value, '|', $GLOBALS['hookWrites'], '|',
            $safe->nested->count, PHP_EOL;
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
web|1|boot failed|boot|1111|initial|1
web|2|mutation failed|boot,prefix,mutate|1111|prefix|12
web|3|ok|mutate|1111|ready|112
cli|1|boot failed|prefix,boot|1111|prefix|2
cli|2|mutation failed|boot,mutate|1111|prefix|12
cli|3|7|mutate|1111|ready|112
reference skipped|2|1
hook skipped|2|1|1
