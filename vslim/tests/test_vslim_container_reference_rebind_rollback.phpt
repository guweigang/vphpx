--TEST--
VSlim reconnects explicitly rebound service properties on Web and CLI bootstrap failure
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
declare(strict_types=1);

class ReboundService
{
    public int $count;
    public ?string $label;
}

class RebindBootProvider
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

function commitRebindPrefix(): void
{
    $GLOBALS['events'][] = 'prefix';
    $shared = $GLOBALS['shared'];
    $shared->right =& $shared->left;
    $shared->right += 3;
}

function rebindForBootstrap(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'callback';
    $service = $app->container()->get('shared');
    $service->right += 10;
    if (!$GLOBALS['failed']) {
        $GLOBALS['failed'] = true;
        $service->left =& $GLOBALS['replacement'];
        $service->typed->count =& $GLOBALS['replacement'];
        $service->typed->label =& $GLOBALS['replacementLabel'];
        $service->unsafe =& $GLOBALS['replacementArray'];
        $service->left = 70;
        throw new LogicException('callback failed');
    }
}

function sameRebindGroup(array $aliases, string $id): bool
{
    foreach (array_keys($aliases) as $key) {
        if (ReflectionReference::fromArrayElement($aliases, $key)?->getId() !== $id) {
            return false;
        }
    }
    return true;
}

$root = sys_get_temp_dir() . '/vslim-ref-rebind-' . bin2hex(random_bytes(8));
mkdir("$root/web/routes", 0700, true);
mkdir("$root/web/bootstrap");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", '<?php return ["commitRebindPrefix", "rebindForBootstrap"];');
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return "commitRebindPrefix";');
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    rebindForBootstrap($cli->app());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['events'] = [];
        $GLOBALS['failed'] = false;
        $GLOBALS['replacement'] = 30;
        $GLOBALS['replacementLabel'] = 'replacement';
        $GLOBALS['replacementArray'] = ['array'];
        $count = 2;
        $label = null;
        $unsafe = 3;
        $GLOBALS['shared'] = $shared = new stdClass();
        $typed = $shared->typed = new ReboundService();
        $shared->left =& $count;
        $shared->right = 0;
        $shared->nested = ['count' => &$count, 'label' => &$label];
        $shared->unsafe =& $unsafe;
        $typed->count =& $count;
        $typed->label =& $label;
        $countId = ReflectionReference::fromArrayElement($shared->nested, 'count')->getId();
        $labelId = ReflectionReference::fromArrayElement($shared->nested, 'label')->getId();
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $app->container()->set('shared', $shared);
        $app->register(new RebindBootProvider());
        $boot = static function () use ($mode, $root, $app, $cli): int|string {
            if ($mode === 'cli') {
                return $cli->runArgv(['vslim', '--bootstrap-dir', "$root/cli", 'probe']);
            }
            $app->bootstrapDir("$root/web");
            return 'ok';
        };

        try {
            $boot();
        } catch (LogicException $error) {
            echo "$mode|", $error->getMessage(), '|', implode(',', $GLOBALS['events']), PHP_EOL;
        }
        $GLOBALS['events'] = [];
        try {
            $boot();
        } catch (LogicException $error) {
            echo "$mode|", $error->getMessage(), '|', implode(',', $GLOBALS['events']), PHP_EOL;
        }
        echo 'restored|', (int) ($app->container()->get('shared') === $shared && $shared->typed === $typed), '|',
            (int) sameRebindGroup([&$shared->left, &$shared->right, &$typed->count, &$count], $countId), '|',
            (int) sameRebindGroup([&$typed->label, &$label], $labelId), '|',
            $count, '|', $label ?? 'null', '|', $shared->unsafe[0], '|', $unsafe, PHP_EOL;

        try {
            $count = 'wrong type';
        } catch (TypeError) {
            echo 'original group still typed', PHP_EOL;
        }
        $GLOBALS['replacement'] = 'detached';
        $GLOBALS['replacementLabel'] = 42;
        $typed->count++;
        $typed->label = 'through';
        echo 'write-through|', $shared->left, '|', $label, '|',
            $GLOBALS['replacement'], '|', $GLOBALS['replacementLabel'], PHP_EOL;

        $GLOBALS['events'] = [];
        $result = $boot();
        echo "retry|$result|", implode(',', $GLOBALS['events']), '|', $count, '|', $label, PHP_EOL;
    }
} finally {
    unlink("$root/web/routes/web.php");
    unlink("$root/web/bootstrap/runtime.php");
    unlink("$root/cli/bootstrap/app.php");
    unlink("$root/cli/bootstrap/cli.php");
    rmdir("$root/web/routes");
    rmdir("$root/web/bootstrap");
    rmdir("$root/cli/bootstrap");
    rmdir("$root/web");
    rmdir("$root/cli");
    rmdir($root);
}
?>
--EXPECT--
web|boot failed|boot
web|callback failed|boot,prefix,callback
restored|1|1|1|5|null|array|3
original group still typed
write-through|6|through|detached|42
retry|ok|callback|16|through
cli|boot failed|prefix,boot
cli|callback failed|boot,callback
restored|1|1|1|5|null|array|3
original group still typed
write-through|6|through|detached|42
retry|7|callback|16|through
