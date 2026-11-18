--TEST--
VSlim CLI batch command registration stops on failure and preserves successful registrations
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class BatchPrefixCommand
{
    public function aliases(): array { return ['prefix-alias']; }
    public function handle(): int { return 11; }
}
class BatchBrokenCommand
{
    public function aliases(): array { return ['partial-alias', 'taken']; }
    public function handle(): int { return 99; }
}
class BatchThrowingCommand
{
    public function definition(): array { throw new LogicException('definition failed'); }
    public function handle(): int { return 99; }
}
class BatchSuffixCommand
{
    public function aliases(): array { echo "unexpected suffix callback\n"; return []; }
    public function handle(): int { return 99; }
}

function checkBatch(string $label, callable $register): void
{
    $cli = new VSlim\Cli\App();
    $cli->command('taken', static fn (): int => 7);
    try {
        $register($cli);
        echo "unexpected success\n";
    } catch (Throwable $error) {
        echo $label, '|', get_class($error), '|', $error->getMessage(), PHP_EOL;
    }
    echo implode(',', $cli->commandNames()), '|',
        (int) $cli->hasCommand(name: 'partial-alias'), '|', $cli->run('taken', []), '|',
        $cli->hasCommand('prefix-alias') ? $cli->run('prefix-alias', []) : '-', '|',
        (int) $cli->app()->booted(), PHP_EOL;
}

checkBatch('map', static function ($cli): void {
    $cli->commandMany(commands: [
        'prefix' => new BatchPrefixCommand(),
        'broken' => new BatchBrokenCommand(),
        'suffix' => new BatchSuffixCommand(),
    ]);
});
checkBatch('list', static function ($cli): void {
    $cli->commandMany([BatchPrefixCommand::class, BatchThrowingCommand::class, BatchSuffixCommand::class]);
});
checkBatch('iterator', static function ($cli): void {
    $cli->commandMany((static function (): Generator {
        yield 'prefix' => new BatchPrefixCommand();
        throw new LogicException('iterator failed');
    })());
});

$file = tempnam(sys_get_temp_dir(), 'vslim-cli-batch-');
try {
    file_put_contents($file, <<<'PHP'
<?php
return [
    'commands' => ['prefix' => BatchPrefixCommand::class, 'broken' => BatchBrokenCommand::class],
    'boot' => true,
];
PHP);
    checkBatch('bootstrap', static fn ($cli) => $cli->bootstrapFile($file));
} finally {
    unlink($file);
}
?>
--EXPECT--
map|InvalidArgumentException|CLI alias "taken" conflicts with registered command "taken"
taken,prefix|0|7|11|0
list|LogicException|definition failed
taken,batch-prefix|0|7|11|0
iterator|LogicException|iterator failed
taken|0|7|-|0
bootstrap|InvalidArgumentException|CLI alias "taken" conflicts with registered command "taken"
taken,prefix|0|7|11|0
