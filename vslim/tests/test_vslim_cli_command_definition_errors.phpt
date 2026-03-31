--TEST--
VSlim CLI command definitions report invalid choice and float errors clearly
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$bootstrapFile = sys_get_temp_dir() . '/vslim_cli_definition_err_' . uniqid('', true) . '.php';
file_put_contents($bootstrapFile, <<<'PHP'
<?php
declare(strict_types=1);

return function (VSlim\Cli\App $cli): void {
    $cli->command('inspect', new class {
        public function definition(): array
        {
            return [
                'arguments' => [
                    ['name' => 'subject', 'required' => true],
                ],
                'options' => [
                    ['name' => 'mode', 'type' => 'string', 'choices' => ['safe', 'fast'], 'required' => true],
                    ['name' => 'ratio', 'type' => 'float'],
                ],
            ];
        }

        public function handle(array $args, VSlim\Cli\App $cli): int
        {
            echo 'should-not-run', PHP_EOL;
            return 0;
        }
    });
};
PHP);

$cli = new VSlim\Cli\App();
$badChoice = $cli->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', 'neo', '--mode', 'turbo']);
echo $badChoice, PHP_EOL;

$cli2 = new VSlim\Cli\App();
$badFloat = $cli2->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', 'neo', '--mode', 'safe', '--ratio', 'abc']);
echo $badFloat, PHP_EOL;

$cli3 = new VSlim\Cli\App();
$missingArg = $cli3->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', '--mode', 'safe']);
echo $missingArg, PHP_EOL;

$cli4 = new VSlim\Cli\App();
$missingMode = $cli4->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', 'neo']);
echo $missingMode, PHP_EOL;

$cli5 = new VSlim\Cli\App();
$extraArg = $cli5->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', 'neo', 'extra', '--mode', 'safe']);
echo $extraArg, PHP_EOL;

@unlink($bootstrapFile);
?>
--EXPECT--
CLI option `--mode` must be one of: safe, fast
Usage:
  vslim inspect [options] <subject>
1
CLI option `--ratio` expects a float value
Usage:
  vslim inspect [options] <subject>
1
CLI argument `subject` is required
Usage:
  vslim inspect [options] <subject>
1
CLI option `--mode` is required
Usage:
  vslim inspect [options] <subject>
1
too many CLI arguments
Usage:
  vslim inspect [options] <subject>
1
