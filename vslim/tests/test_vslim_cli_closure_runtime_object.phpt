--TEST--
VSlim CLI closure handlers can receive the runtime App object without ownership crashes
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$bootstrapFile = sys_get_temp_dir() . '/vslim_cli_closure_runtime_' . uniqid('', true) . '.php';
file_put_contents($bootstrapFile, <<<'PHP'
<?php
declare(strict_types=1);

return function (VSlim\Cli\App $cli): void {
    $cli->command('inline:probe', function (array $args, VSlim\Cli\App $runtime): int {
        $sameApp = $runtime->app() instanceof VSlim\App ? 'app_yes' : 'app_no';
        echo implode('|', [
            $runtime->commandName(),
            implode(',', $args),
            $runtime->hasCommand('inline:probe') ? 'registered' : 'missing',
            $sameApp,
            $runtime->inputParsed() ? 'parsed' : 'raw',
        ]), PHP_EOL;
        return count($args);
    });
};
PHP);

$cli = new VSlim\Cli\App();
ob_start();
$code = $cli->runArgv(['php', '--bootstrap-file', $bootstrapFile, 'inline:probe', 'x', 'y']);
$output = trim((string) ob_get_clean());
echo $code, '|', $output, PHP_EOL;

ob_start();
$code2 = $cli->run('inline:probe', ['solo']);
$output2 = trim((string) ob_get_clean());
echo $code2, '|', $output2, PHP_EOL;

@unlink($bootstrapFile);
?>
--EXPECT--
2|inline:probe|x,y|registered|app_yes|raw
1|inline:probe|solo|registered|app_yes|raw
