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
