--TEST--
VSlim rolls back safe branches within mixed Web and CLI service object graphs
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
if (PHP_VERSION_ID >= 80400) {
    eval('class MixedHook {
        public int $stored = 1;
        public int $value {
            get => $this->stored;
            set { ++$GLOBALS["hookWrites"]; $this->stored = $value; }
        }
    }');
} else {
    class MixedHook
    {
        private int $stored = 1;
        public function __get(string $name): int { return $this->stored; }
        public function __set(string $name, mixed $value): void { ++$GLOBALS['hookWrites']; $this->stored = $value; }
    }
}

class MixedGraphBootProvider
{
    private bool $first = true;
    public function boot(): void
    {
        $GLOBALS['events'][] = 'boot';
        if ($this->first) {
            $this->first = false;
            throw new LogicException('boot failed');
        }
    }
}

function mixedPrefix(): void
{
    $GLOBALS['events'][] = 'prefix';
    ++$GLOBALS['child']->count;
    $GLOBALS['graph']->phase = $GLOBALS['graph']->items['phase'] = 'prefix';
}

function mixedMutation(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'mutate';
    $graph = $app->container()->get('graph');
    $graph->left->count += 10;
    $graph->phase = $graph->items['phase'] = 'ready';
    ++$graph->branch->linked;
    ++$graph->items['hook']->value;
    if (empty($GLOBALS['failed'])) {
        $GLOBALS['failed'] = true;
        $graph->left->back = null;
        $graph->left = $graph->items['child'] = $graph->branch->child = (object) ['count' => 999];
        unset($graph->items['cycle'], $graph->items['keep']);
        $graph->items['temporary'] = 'discard';
        $graph->items['newReference'] =& $GLOBALS['late'];
        throw new LogicException('mutation failed');
    }
}

$root = sys_get_temp_dir() . '/vslim-mixed-graph-' . bin2hex(random_bytes(8));
mkdir("$root/web/bootstrap", 0700, true);
mkdir("$root/web/routes");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", '<?php return ["mixedPrefix", "mixedMutation"];');
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return "mixedPrefix";');
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    mixedMutation($cli->app());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['failed'] = false;
        $GLOBALS['hookWrites'] = 0;
        $GLOBALS['late'] = 8;
        $external = 1;
        $hook = new MixedHook();
        $branch = new stdClass();
        $branch->linked =& $external;
        $GLOBALS['child'] = $child = (object) ['count' => 1];
        $GLOBALS['graph'] = $graph = (object) [
            'left' => $child, 'right' => $child, 'branch' => $branch, 'phase' => 'initial',
        ];
        $graph->items = ['child' => $child, 'hook' => $hook, 'cycle' => $graph, 'phase' => 'initial', 'keep' => 3];
        $graph->items['reference'] =& $external;
        $graph->items[15] = 'removed before bootstrap';
        unset($graph->items[15]);
        $referenceId = ReflectionReference::fromArrayElement($graph->items, 'reference')->getId();
        $branch->child = $child;
        $child->back = $graph;
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $app->container()->set('graph', $graph);
        $app->register(new MixedGraphBootProvider());
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
                (int) ($app->container()->get('graph') === $graph),
                (int) ($graph->left === $child && $graph->right === $child && $branch->child === $child && $graph->items['child'] === $child),
                (int) ($child->back === $graph && ($graph->items['cycle'] ?? null) === $graph),
                (int) (ReflectionReference::fromArrayElement($graph->items, 'reference')->getId() === $referenceId),
                (int) ($graph->items['hook'] === $hook), '|',
                $child->count, '|', $graph->phase, ',', $graph->items['phase'], '|',
                $graph->items['keep'] ?? '-', '|', (int) isset($graph->items['temporary']),
                (int) isset($graph->items['newReference']), '|',
                $external, ',', $graph->items['reference'], ',', $hook->value, ',', $GLOBALS['hookWrites'], PHP_EOL;
        }
        ++$GLOBALS['late'];
        $graph->items[] = 'appended';
        echo 'new-reference|', $graph->items['newReference'], '|next-key|', array_key_last($graph->items), PHP_EOL;
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
web|1|boot failed|boot|11111|1|initial,initial|3|00|1,1,1,0
web|2|mutation failed|boot,prefix,mutate|11111|2|prefix,prefix|3|01|1,1,2,1
web|3|ok|mutate|11111|12|ready,ready|3|01|2,2,3,2
new-reference|9|next-key|16
cli|1|boot failed|prefix,boot|11111|2|prefix,prefix|3|00|1,1,1,0
cli|2|mutation failed|boot,mutate|11111|2|prefix,prefix|3|01|1,1,2,1
cli|3|7|mutate|11111|12|ready,ready|3|01|2,2,3,2
new-reference|9|next-key|16
