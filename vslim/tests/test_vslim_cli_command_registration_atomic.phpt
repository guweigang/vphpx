--TEST--
VSlim CLI publishes command registration only after metadata and aliases are validated
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
final class RegistrationProbeCommand
{
    public function __construct(
        private string $label,
        private array $aliases,
        private bool $hidden = false,
    ) {}

    public function definition(): array
    {
        return ['aliases' => $this->aliases, 'hidden' => $this->hidden];
    }

    public function handle(): int
    {
        echo $this->label, PHP_EOL;
        return 0;
    }
}

$cli = new VSlim\Cli\App();
$cli->command('original', new RegistrationProbeCommand('old-handler', ['shared', 'old-alias']));
$cli->command('taken', static fn (): int => 0);

foreach (['candidate', 'original'] as $name) {
    try {
        $cli->command($name, new RegistrationProbeCommand('unexpected-handler', ['available', 'taken'], true));
        echo "unexpected-success\n";
    } catch (InvalidArgumentException $error) {
        echo $name, '|', $error->getMessage(), PHP_EOL;
    }
}
echo 'registry|', implode(',', $cli->commandNames()), '|',
    (int) $cli->hasCommand('candidate'), (int) $cli->hasCommand('available'), '|',
    (int) str_contains($cli->helpText(), 'original'), PHP_EOL;
$cli->run('original', []);
$cli->run('shared', []);
$cli->run('old-alias', []);

try {
    $cli->command('original', new class {
        public function hidden(): bool { return true; }
        public function aliases(): array { throw new LogicException('aliases failed'); }
        public function handle(): int { return 0; }
    });
    echo "unexpected-success\n";
} catch (LogicException $error) {
    echo $error->getMessage(), '|', (int) str_contains($cli->helpText(), 'original'), PHP_EOL;
}
$cli->run('old-alias', []);

$cli->command('original', new RegistrationProbeCommand('new-handler', ['shared', 'new-alias']));
echo 'replacement|', implode(',', $cli->commandNames()), '|',
    (int) $cli->hasCommand('old-alias'), PHP_EOL;
$cli->run('shared', []);
$cli->run('new-alias', []);

final class FirstPositionalCommand
{
    public static int $registrations = 0;
    public function aliases(): array { ++self::$registrations; return []; }
    public function handle(): int { return 0; }
}
final class SecondPositionalCommand
{
    public static ?LogicException $failure = null;
    public function aliases(): array
    {
        if (self::$failure !== null) {
            $failure = self::$failure;
            self::$failure = null;
            throw $failure;
        }
        return [];
    }
    public function handle(): int { return 0; }
}
$generate = static function (): Generator {
    yield 8 => new FirstPositionalCommand();
    yield 8 => new SecondPositionalCommand();
};
$bulk = new VSlim\Cli\App();
$bulk->commandMany($generate());
if ($bulk->commandNames() !== ['first-positional', 'second-positional']) {
    throw new RuntimeException('A repeated integer key replaced an earlier command');
}
$openCount = 0;
$path = tempnam(sys_get_temp_dir(), 'vslim-cli-entry-order');
try {
    file_put_contents($path, '<?php return $GLOBALS["vslimCommandEntries"];');
    $GLOBALS['vslimCommandEntries'] = (static function () use (&$openCount, $generate): Generator {
        ++$openCount;
        yield from $generate();
    })();
    $boot = new VSlim\Cli\App();
    SecondPositionalCommand::$failure = $failure = new LogicException('retry second command');
    try {
        $boot->bootstrapFile($path);
        throw new RuntimeException('CLI bootstrap did not stop at the failing command');
    } catch (LogicException $error) {
        if ($error !== $failure || $boot->commandNames() !== ['first-positional']) {
            throw $error;
        }
    }
    $boot->bootstrapFile($path);
    if ($openCount !== 1 || FirstPositionalCommand::$registrations !== 2
        || $boot->commandNames() !== $bulk->commandNames()) {
        throw new RuntimeException('CLI bootstrap replayed an earlier command or lost a pending command');
    }
} finally {
    unset($GLOBALS['vslimCommandEntries']);
    unlink($path);
}

$cli->command('123', static fn (): int => 4);
if (!$cli->hasCommand('123') || $cli->run('123', []) !== 4) {
    throw new RuntimeException('An integer-shaped command name changed during storage');
}

$refs = (static function (): array {
    $cli = new VSlim\Cli\App();
    $command = new class ($cli) {
        public function __construct(private VSlim\Cli\App $owner) {}
        public function aliases(): array { return ['old']; }
        public function handle(): int { return 7; }
    };
    $cli->command('cycle', $command);
    if ($cli->run('old', []) !== 7) {
        throw new RuntimeException('The alias failed to dispatch the command');
    }
    $commandRef = WeakReference::create($command);
    unset($command);
    $handler = static fn (): int => $cli->hasCommand('cycle') ? 9 : 1;
    $cli->command('cycle', $handler);
    if ($cli->hasCommand('old') || $cli->run('cycle', []) !== 9 || $commandRef->get() !== null) {
        throw new RuntimeException('Replacing the command retained its old handler or alias');
    }
    return [WeakReference::create($cli), WeakReference::create($handler)];
})();
gc_collect_cycles();
foreach ($refs as $ref) {
    if ($ref->get() !== null) {
        throw new RuntimeException('A CLI command callback escaped cycle collection');
    }
}
?>
--EXPECT--
candidate|CLI alias "taken" conflicts with registered command "taken"
original|CLI alias "taken" conflicts with registered command "taken"
registry|original,taken|00|1
old-handler
old-handler
old-handler
aliases failed|1
old-handler
replacement|original,taken|0
new-handler
new-handler
