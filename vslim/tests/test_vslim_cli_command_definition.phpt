--TEST--
VSlim CLI command definitions can parse arguments and options into runtime state
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$bootstrapFile = sys_get_temp_dir() . '/vslim_cli_definition_' . uniqid('', true) . '.php';
file_put_contents($bootstrapFile, <<<'PHP'
<?php
declare(strict_types=1);

return function (VSlim\Cli\App $cli): void {
    $cli->command('inspect', new class {
        public function definition(): array
        {
            return [
                'description' => 'Inspect parsed CLI input.',
                'examples' => [
                    'vslim inspect neo --mode=safe',
                    'vslim inspect neo extra --tag=a --tag=b',
                ],
                'epilog' => "Parsed values are exposed through VSlim\\Cli\\App accessors.\nUse commandHelp() for the same rendered text.",
                'arguments' => [
                    ['name' => 'subject', 'required' => true, 'env' => 'VSLIM_SUBJECT', 'placeholder' => 'target', 'value_hint' => 'resource id', 'description' => 'Primary subject'],
                    ['name' => 'extras', 'multiple' => true, 'description' => 'Extra trailing values'],
                ],
                'options' => [
                    ['name' => 'lang', 'short' => 'l', 'type' => 'string', 'default' => 'en', 'env' => 'VSLIM_LANG', 'placeholder' => 'locale', 'value_hint' => 'i18n locale', 'description' => 'Output language'],
                    ['name' => 'mode', 'short' => 'm', 'type' => 'string', 'default' => 'safe', 'choices' => ['safe', 'fast'], 'description' => 'Execution mode'],
                    ['name' => 'legacy-mode', 'type' => 'string', 'deprecated' => true, 'deprecation_message' => 'Use --mode instead of --legacy-mode.'],
                    ['name' => 'ratio', 'short' => 'r', 'type' => 'float', 'default' => 0.5, 'description' => 'Blend ratio'],
                    ['name' => 'verbose', 'short' => 'v', 'type' => 'bool', 'description' => 'Enable verbose mode'],
                    ['name' => 'count', 'short' => 'c', 'type' => 'int', 'default' => 1, 'description' => 'Repeat count'],
                    ['name' => 'internal-token', 'type' => 'string', 'hidden' => true],
                    ['name' => 'tag', 'short' => 't', 'type' => 'string', 'multiple' => true, 'description' => 'Attach tags'],
                ],
            ];
        }

        public function handle(array $args, VSlim\Cli\App $cli): int
        {
            $extras = $cli->argument('extras', []);
            $tags = $cli->option('tag', []);
            $arguments = $cli->arguments();
            $options = $cli->options();
            $warnings = $cli->warnings();

            echo implode('|', [
                implode(',', $args),
                (string) $cli->argument('subject'),
                implode(',', is_array($extras) ? $extras : []),
                (string) $cli->option('lang'),
                (string) $cli->option('mode'),
                (string) $cli->option('ratio'),
                $cli->option('verbose') ? 'verbose' : 'quiet',
                (string) $cli->option('count'),
                implode(',', is_array($tags) ? $tags : []),
                $cli->hasOption('verbose') ? 'seen' : 'unseen',
                $cli->inputParsed() ? 'parsed' : 'raw',
                implode(',', $cli->rawArgs()),
                isset($arguments['subject']) ? 'argmap_yes' : 'argmap_no',
                isset($options['lang']) ? 'optmap_yes' : 'optmap_no',
                implode(',', is_array($warnings) ? $warnings : []),
            ]), PHP_EOL;

            return count($args);
        }
    });
};
PHP);

putenv('VSLIM_LANG=fr');
putenv('VSLIM_SUBJECT=env-subject');

$cli = new VSlim\Cli\App();
ob_start();
$code = $cli->runArgv([
    'bin/vslim',
    '--bootstrap-file',
    $bootstrapFile,
    'inspect',
    'neo',
    'first',
    '-l',
    'zh',
    '--legacy-mode',
    'safe',
    '--internal-token',
    's3cr3t',
    '--mode=fast',
    '--ratio',
    '1.25',
    '-v',
    '--count=3',
    '--tag=a',
    '-t',
    'b',
    'second',
]);
$output = trim((string) ob_get_clean());
echo $code, '|', $output, PHP_EOL;
echo implode('|', $cli->warnings()), PHP_EOL;

$cli2 = new VSlim\Cli\App();
$cli2->bootstrapFile($bootstrapFile);
ob_start();
$code2 = $cli2->run('inspect', []);
$output2 = trim((string) ob_get_clean());
echo $code2, '|', $output2, PHP_EOL;

$helpCli = new VSlim\Cli\App();
$helpCode = $helpCli->runArgv(['bin/vslim', '--bootstrap-file', $bootstrapFile, 'inspect', '--help']);
$help = $helpCli->commandHelp('inspect');
echo $helpCode, '|',
    (str_contains($help, 'Inspect parsed CLI input.') ? 'desc_yes' : 'desc_no'), '|',
    (str_contains($help, '<target>') ? 'subject_yes' : 'subject_no'), '|',
    (str_contains($help, '--lang <locale>') ? 'lang_yes' : 'lang_no'), '|',
    (str_contains($help, 'choices: safe,fast') ? 'choices_yes' : 'choices_no'), '|',
    (str_contains($help, '-h, --help') ? 'help_yes' : 'help_no'), '|',
    (!str_contains($help, '--internal-token') ? 'hidden_yes' : 'hidden_no'), '|',
    (str_contains($help, 'deprecated: Use --mode instead of --legacy-mode.') ? 'deprecated_yes' : 'deprecated_no'), '|',
    (str_contains($help, 'env: VSLIM_LANG') ? 'env_yes' : 'env_no'), '|',
    (str_contains($help, 'hint: i18n locale') ? 'hint_yes' : 'hint_no'), '|',
    (str_contains($help, 'Examples:') ? 'examples_yes' : 'examples_no'), '|',
    (str_contains($help, 'vslim inspect neo --mode=safe') ? 'example_line_yes' : 'example_line_no'), '|',
    (str_contains($help, 'Parsed values are exposed through VSlim\Cli\App accessors.') ? 'epilog_yes' : 'epilog_no'), PHP_EOL;

@unlink($bootstrapFile);
putenv('VSLIM_LANG');
putenv('VSLIM_SUBJECT');
?>
--EXPECT--
Use --mode instead of --legacy-mode.
3|neo,first,second|neo|first,second|zh|fast|1.25|verbose|3|a,b|seen|parsed|neo,first,-l,zh,--legacy-mode,safe,--internal-token,s3cr3t,--mode=fast,--ratio,1.25,-v,--count=3,--tag=a,-t,b,second|argmap_yes|optmap_yes|Use --mode instead of --legacy-mode.
Use --mode instead of --legacy-mode.
1|env-subject|env-subject||fr|safe|0.5|quiet|1||unseen|parsed||argmap_yes|optmap_yes|
Usage:
  vslim inspect [options] <target> [<extras>...]

Description:
  Inspect parsed CLI input.

Arguments:
  <target>                    Primary subject [required] [env: VSLIM_SUBJECT] [hint: resource id]
  [<extras>...]               Extra trailing values [multiple]

Options:
  -l, --lang <locale>         Output language [default: en] [env: VSLIM_LANG] [hint: i18n locale]
  -m, --mode <string>         Execution mode [default: safe; choices: safe,fast]
  --legacy-mode <string>      [deprecated: Use --mode instead of --legacy-mode.]
  -r, --ratio <float>         Blend ratio [default: 0.5]
  -v, --verbose               Enable verbose mode
  -c, --count <int>           Repeat count [default: 1]
  -t, --tag <string>...       Attach tags [multiple]
  -h, --help                  Show this help message

Examples:
  vslim inspect neo --mode=safe
  vslim inspect neo extra --tag=a --tag=b

Notes:
  Parsed values are exposed through VSlim\Cli\App accessors.
  Use commandHelp() for the same rendered text.
0|desc_yes|subject_yes|lang_yes|choices_yes|help_yes|hidden_yes|deprecated_yes|env_yes|hint_yes|examples_yes|example_line_yes|epilog_yes
