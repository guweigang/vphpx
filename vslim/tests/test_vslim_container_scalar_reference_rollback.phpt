--TEST--
VSlim rolls back shared scalar references in place during Web and CLI retries
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class ScalarReferenceService
{
    public int $count;
    public ?string $label;
}

class ScalarReferenceBootProvider
{
    private bool $first = true;

    public function boot(): void
    {
        $GLOBALS['events'][] = 'boot';
        if ($this->first) {
            $this->first = false;
            $GLOBALS['shared']->left = 99;
            $GLOBALS['typed']->label = 'boot attempt';
            throw new LogicException('boot failed');
        }
    }
}

function commitReferencePrefix(): void
{
    $GLOBALS['events'][] = 'prefix';
    $GLOBALS['shared']->right += 3;
    $GLOBALS['typed']->label = 'prefix';
}

function modifyReferences(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'mutate';
    $shared = $app->container()->get('shared');
    $shared->nested['mirror'] += 10;
    $GLOBALS['typed']->label = 'ready';
    if (empty($GLOBALS['retried'])) {
        $GLOBALS['retried'] = true;
        throw new LogicException('mutation failed');
    }
}

function shareReferenceId(array $aliases, string $id): bool
{
    foreach (array_keys($aliases) as $key) {
        if (ReflectionReference::fromArrayElement($aliases, $key)?->getId() !== $id) {
            return false;
        }
    }
    return true;
}

$root = sys_get_temp_dir() . '/vslim-scalar-reference-' . bin2hex(random_bytes(8));
mkdir("$root/web/bootstrap", 0700, true);
mkdir("$root/web/routes");
mkdir("$root/cli/bootstrap", 0700, true);
try {
    file_put_contents("$root/web/bootstrap/runtime.php", '<?php return ["boot" => true];');
    file_put_contents("$root/web/routes/web.php", '<?php return ["commitReferencePrefix", "modifyReferences"];');
    file_put_contents("$root/cli/bootstrap/app.php", '<?php return "commitReferencePrefix";');
    file_put_contents("$root/cli/bootstrap/cli.php", <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): array {
    modifyReferences($cli->app());
    return ['probe' => static fn (): int => 7];
};
PHP);
    foreach (['web', 'cli'] as $mode) {
        $GLOBALS['retried'] = false;
        $number = 2;
        $label = null;
        $GLOBALS['shared'] = $shared = new stdClass();
        $GLOBALS['typed'] = $typed = new ScalarReferenceService();
        $shared->left =& $number;
        $shared->right =& $number;
        $shared->nested = ['mirror' => &$number];
        $typed->count =& $number;
        $typed->label =& $label;
        $id = ReflectionReference::fromArrayElement($shared->nested, 'mirror')->getId();
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $container = $app->container();
        $container->set('shared', $shared)->set('typed', $typed);
        $app->register(new ScalarReferenceBootProvider());

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
            $aliases = [&$shared->left, &$shared->right, &$shared->nested['mirror'], &$typed->count, &$number];
            echo "$mode|$attempt|$result|", implode(',', $GLOBALS['events']), '|',
                (int) ($container->get('shared') === $shared && $container->get('typed') === $typed), '|',
                (int) shareReferenceId($aliases, $id), '|', implode(',', $aliases), '|',
                $label ?? 'null', PHP_EOL;
        }
        ++$typed->count;
        echo 'write-through|', $shared->nested['mirror'], '|', $number, PHP_EOL;
    }

    $app = new VSlim\App();
    $value = 'old string';
    $changesType = 1;
    $state = (object) ['constrained' => &$value, 'nonscalar' => &$changesType];
    $typed = new ScalarReferenceService();
    $app->container()->set('state', $state);
    try {
        $app->bootstrap(['routes' => static function () use ($state, $typed) {
            $state->constrained = 7;
            $typed->count =& $state->constrained;
            $state->nonscalar = ['current'];
            throw new LogicException('unsafe restore skipped');
        }]);
    } catch (LogicException $error) {
        ++$typed->count;
        echo $error->getMessage(), '|', $value, '|', $changesType[0], PHP_EOL;
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
web|1|boot failed|boot|1|1|2,2,2,2,2|null
web|2|mutation failed|boot,prefix,mutate|1|1|5,5,5,5,5|prefix
web|3|ok|mutate|1|1|15,15,15,15,15|ready
write-through|16|16
cli|1|boot failed|prefix,boot|1|1|5,5,5,5,5|prefix
cli|2|mutation failed|boot,mutate|1|1|5,5,5,5,5|prefix
cli|3|7|mutate|1|1|15,15,15,15,15|ready
write-through|16|16
unsafe restore skipped|8|current
