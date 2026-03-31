--TEST--
VSlim CLI command metadata can expose aliases and hide internal commands from help output
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$bootstrapFile = sys_get_temp_dir() . '/vslim_cli_metadata_' . uniqid('', true) . '.php';
file_put_contents($bootstrapFile, <<<'PHP'
<?php
declare(strict_types=1);

return function (VSlim\Cli\App $cli): void {
    $cli->command('inspect', new class {
        public function definition(): array
        {
            return [
                'description' => 'Inspect via aliases.',
                'aliases' => ['scan', 'peek'],
                'arguments' => [
                    ['name' => 'subject', 'required' => true],
                ],
            ];
        }

        public function handle(array $args, VSlim\Cli\App $cli): int
        {
            echo $cli->commandName(), '|', implode(',', $args), PHP_EOL;
            return count($args);
        }
    });

    $cli->command('secret', new class {
        public function description(): string
        {
            return 'Hidden internal command.';
        }

        public function hidden(): bool
        {
            return true;
        }

        public function handle(array $args, VSlim\Cli\App $cli): int
        {
            echo 'secret', PHP_EOL;
            return 0;
        }
    });
};
PHP);

$cli = new VSlim\Cli\App();
$cli->bootstrapFile($bootstrapFile);
$names = $cli->commandNames();
sort($names);
echo implode(',', $names), PHP_EOL;
echo ($cli->hasCommand('scan') ? 'scan_yes' : 'scan_no'), '|',
    ($cli->hasCommand('peek') ? 'peek_yes' : 'peek_no'), PHP_EOL;

$runCli = new VSlim\Cli\App();
ob_start();
$code = $runCli->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'scan', 'neo']);
$output = trim((string) ob_get_clean());
echo $code, '|', $output, PHP_EOL;

$help = $cli->helpText();
echo (str_contains($help, 'inspect') ? 'inspect_yes' : 'inspect_no'), '|',
    (str_contains($help, 'aliases: scan,peek') ? 'aliases_yes' : 'aliases_no'), '|',
    (!str_contains($help, 'secret') ? 'secret_hidden' : 'secret_visible'), PHP_EOL;

$commandHelp = $cli->commandHelp('scan');
echo (str_contains($commandHelp, 'Usage:') ? 'usage_yes' : 'usage_no'), '|',
    (str_contains($commandHelp, 'vslim scan') ? 'alias_usage_yes' : 'alias_usage_no'), PHP_EOL;

echo "list_start", PHP_EOL;
$listCli = new VSlim\Cli\App();
$listCode = $listCli->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, '--list']);
echo "list_exit=", $listCode, PHP_EOL;

@unlink($bootstrapFile);
?>
--EXPECT--
inspect,secret
scan_yes|peek_yes
1|scan|neo
inspect_yes|aliases_yes|secret_hidden
usage_yes|alias_usage_yes
list_start
list_exit=  inspect                     Inspect via aliases. [aliases: scan,peek]
0
