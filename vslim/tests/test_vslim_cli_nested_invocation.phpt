--TEST--
VSlim CLI keeps outer argv and command input across nested CLI calls
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function invocationContext(string $label, VSlim\Cli\App $cli): void
{
    echo $label, '|', $cli->commandName(), '|', implode(',', $cli->rawArgs()), PHP_EOL;
}

$cli = new VSlim\Cli\App();
$cli->command('inner', static function (array $args, VSlim\Cli\App $cli): int {
    invocationContext('inner', $cli);
    return 29;
});
$cli->command('failing', static function (): never {
    throw new LogicException('inner failed');
});
$cli->command('outer', static function (array $args, VSlim\Cli\App $cli): int {
    invocationContext('outer', $cli);
    $cli->run('inner', ['direct']);
    invocationContext('after direct', $cli);
    try {
        $cli->runArgv(['vslim', 'failing', 'discarded']);
    } catch (LogicException $error) {
        echo $error->getMessage(), PHP_EOL;
    }
    invocationContext('after failure', $cli);
    return 17;
});

$file = tempnam(sys_get_temp_dir(), 'vslim-nested-argv-');
try {
    file_put_contents($file, <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): void {
    invocationContext('bootstrap', $cli);
    $cli->runArgv(['vslim', 'inner', 'nested']);
    ob_start();
    $cli->runArgv(['vslim', '--version']);
    ob_end_clean();
    invocationContext('after argv', $cli);
};
PHP);
    $code = $cli->runArgv(['vslim', '--bootstrap-file', $file, 'outer', 'original']);
    echo 'exit|', $code, PHP_EOL;
    invocationContext('last', $cli);
} finally {
    unlink($file);
}
?>
--EXPECT--
bootstrap|outer|original
inner|inner|nested
after argv|outer|original
outer|outer|original
inner|inner|direct
after direct|outer|original
inner failed
after failure|outer|original
exit|17
last|outer|original
