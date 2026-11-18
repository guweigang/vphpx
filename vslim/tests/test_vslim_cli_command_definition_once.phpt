--TEST--
VSlim reads a dynamic command definition once per registration, help rendering or execution
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
final class DynamicDefinitionCommand
{
    public int $calls = 0;
    public bool $hiddenDuringAliases = false;

    public function __construct(private WeakReference $cli) {}

    public function definition(): array
    {
        $revision = ++$this->calls;
        return [
            'hidden' => true,
            'aliases' => ['shortcut'],
            'description' => "description $revision",
            'examples' => ["example $revision"],
            'epilog' => "epilog $revision",
            'arguments' => [['name' => "arg$revision", 'required' => true]],
        ];
    }

    public function aliases(): array
    {
        $this->hiddenDuringAliases = !str_contains($this->cli->get()->helpText(), 'dynamic');
        return ['shortcut', 'legacy'];
    }

    public function handle(array $args, VSlim\Cli\App $cli): int
    {
        echo 'parsed|', $cli->argument('arg' . $this->calls), PHP_EOL;
        return 0;
    }
}

$cli = new VSlim\Cli\App();
$dynamic = new DynamicDefinitionCommand(WeakReference::create($cli));
$cli->command('dynamic', $dynamic);
echo 'register|', $dynamic->calls, '|', (int) $cli->hasCommand('shortcut'), '|',
    (int) $cli->hasCommand('legacy'), '|', (int) $dynamic->hiddenDuringAliases, '|',
    (int) !str_contains($cli->helpText(), 'dynamic'), PHP_EOL;

$help = $cli->commandHelp('dynamic');
echo 'help|', $dynamic->calls, '|', (int) str_contains($help, 'description 2'), '|',
    (int) str_contains($help, 'example 2'), '|', (int) str_contains($help, 'epilog 2'), PHP_EOL;

$cli->run('shortcut', ['value']);
echo 'run|', $dynamic->calls, PHP_EOL;
try {
    $cli->run('dynamic', []);
    echo "unexpected-success\n";
} catch (RuntimeException $error) {
    echo 'parse-error|', $dynamic->calls, '|', (int) str_contains($error->getMessage(), '<arg4>'), PHP_EOL;
}

$invalid = new class {
    public int $calls = 0;
    public function definition(): int { ++$this->calls; return 0; }
    public function handle(): int { return 0; }
};
$cli->command('invalid', $invalid);
$help = $cli->commandHelp('invalid');
echo 'invalid-help|', $invalid->calls, '|', (int) str_contains($help, 'invalid [args...]'), PHP_EOL;
try {
    $cli->run('invalid', []);
    echo "unexpected-success\n";
} catch (RuntimeException $error) {
    echo 'invalid-run|', $invalid->calls, '|', (int) str_contains($error->getMessage(), 'invalid [args...]'), PHP_EOL;
}
?>
--EXPECT--
register|1|1|1|1|1
help|2|1|1|1
parsed|value
run|3
parse-error|4|1
invalid-help|2|1
invalid-run|3|1
