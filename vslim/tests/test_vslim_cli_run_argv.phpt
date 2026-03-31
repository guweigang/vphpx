--TEST--
VSlim CLI runtime can parse argv style input, bootstrap commands, and print help
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = __DIR__ . '/../templates/app';

$cli = new VSlim\Cli\App();
$cli->bootstrapDir($root);

ob_start();
$code = $cli->runArgv(['bin/vslim', 'about', 'foo', 'bar']);
$output = trim((string) ob_get_clean());
echo $code, '|', $output, PHP_EOL;

$helpCli = new VSlim\Cli\App();
$helpCode = $helpCli->runArgv(['bin/vslim', '--bootstrap-dir', $root, '--help']);
$help = $helpCli->helpText();
echo $helpCode, '|',
    (str_contains($help, 'Usage:') ? 'usage_yes' : 'usage_no'), '|',
    (str_contains($help, 'about') ? 'about_yes' : 'about_no'), '|',
    (str_contains($help, 'template:about') ? 'template_yes' : 'template_no'), '|',
    (str_contains($help, 'Show template bootstrap status.') ? 'desc_yes' : 'desc_no'), PHP_EOL;

$listCli = new VSlim\Cli\App();
$listCode = $listCli->runArgv(['bin/vslim', '--bootstrap-dir', $root, '--list']);
echo 'list_exit=', $listCode, PHP_EOL;

$helpCommandCli = new VSlim\Cli\App();
$commandHelpCode = $helpCommandCli->runArgv(['bin/vslim', '--bootstrap-dir', $root, 'about', '--help']);
$commandHelp = $helpCommandCli->commandHelp('about');
echo $commandHelpCode, '|',
    (str_contains($commandHelp, '<topic>') ? 'topic_yes' : 'topic_no'), '|',
    (str_contains($commandHelp, '--format <kind>') ? 'format_yes' : 'format_no'), '|',
    (str_contains($commandHelp, 'Examples:') ? 'examples_yes' : 'examples_no'), '|',
    (str_contains($commandHelp, 'same app container') ? 'epilog_yes' : 'epilog_no'), PHP_EOL;

$bootstrapFile = sys_get_temp_dir() . '/vslim_cli_bootstrap_' . uniqid('', true) . '.php';
file_put_contents($bootstrapFile, <<<'PHP'
<?php
declare(strict_types=1);

return function (VSlim\Cli\App $cli): void {
    $cli->command('inline:echo', function (array $args, VSlim\Cli\App $runtime): int {
        echo 'inline|', implode(',', $args), '|', ($runtime->hasCommand('inline:echo') ? 'registered' : 'missing'), PHP_EOL;
        return count($args);
    });
};
PHP);

$fileCli = new VSlim\Cli\App();
ob_start();
$fileCode = $fileCli->runArgv(['php', '--bootstrap-file', $bootstrapFile, 'inline:echo', 'x', 'y']);
$fileOutput = trim((string) ob_get_clean());
echo $fileCode, '|', $fileOutput, PHP_EOL;
@unlink($bootstrapFile);
?>
--EXPECT--
2|vslim-template|provider-ready|foo,bar
0Usage:
  vslim [--bootstrap-dir <path> | --bootstrap-file <path>] <command> [args...]
  vslim --help

Options:
  --bootstrap-dir <path>   Bootstrap shared app + CLI conventions from a project root
  --bootstrap-file <path>  Bootstrap from a specific app.php or cli.php file
  -h, --help               Show this help message
  --list                   List registered commands
  -V, --version            Show runtime banner

Commands:
  General:
    about                       Show template bootstrap status.

  template:
    template:about              Show template bootstrap status.

Notes:
  Runtime options are parsed before the command name and remaining args are passed through unchanged.
|usage_yes|about_yes|template_yes|desc_yes
list_exit=General:
  about                       Show template bootstrap status.

template:
  template:about              Show template bootstrap status.
0
0Usage:
  vslim about [options] [<topic>] [<details>...]

Description:
  Show template bootstrap status.

Arguments:
  [<topic>]                   Bootstrap topic to inspect [default: status] [hint: status or subsystem name]
  [<details>...]              Extra detail tokens [multiple]

Options:
  -f, --format <kind>         Output format [default: text; choices: text,json] [env: VSLIM_TEMPLATE_FORMAT] [hint: text or json]
  -v, --verbose               Print parsed topic and warning metadata
  -h, --help                  Show this help message

Examples:
  vslim about
  vslim about services cache --format=json

Notes:
  This command runs against the same app container and config graph as HTTP bootstrap.
|topic_yes|format_yes|examples_yes|epilog_yes
2|inline|x,y|registered
