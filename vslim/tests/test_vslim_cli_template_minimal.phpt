--TEST--
VSlim CLI app template directory can bootstrap shared services and command conventions
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = __DIR__ . '/../templates/app';

$cli = new VSlim\Cli\App();
$cli->bootstrapDir($root);

$names = $cli->commandNames();
sort($names);
echo implode(",", $names), PHP_EOL;
echo ($cli->hasCommand("about") ? "about_yes" : "about_no"), PHP_EOL;
echo ($cli->hasCommand("template:about") ? "template_yes" : "template_no"), PHP_EOL;
echo ($cli->hasCommand("db-migrate") ? "migrate_alias_yes" : "migrate_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db-rollback") ? "rollback_alias_yes" : "rollback_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db-seed") ? "seed_alias_yes" : "seed_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db:migrate") ? "migrate_yes" : "migrate_no"), PHP_EOL;
echo ($cli->hasCommand("db:rollback") ? "rollback_yes" : "rollback_no"), PHP_EOL;
echo ($cli->hasCommand("db:seed") ? "seed_yes" : "seed_no"), PHP_EOL;

ob_start();
$code = $cli->run("about", ["foo", "bar"]);
$output = trim((string) ob_get_clean());
echo $code, "|", $output, PHP_EOL;

ob_start();
$aliasCode = $cli->run("template:about", ["baz"]);
$aliasOutput = trim((string) ob_get_clean());
echo $aliasCode, "|", $aliasOutput, PHP_EOL;

$help = $cli->commandHelp("about");
echo (str_contains($help, 'Usage:') ? 'usage_yes' : 'usage_no'), '|',
    (str_contains($help, '--format <kind>') ? 'format_yes' : 'format_no'), '|',
    (str_contains($help, 'env: VSLIM_TEMPLATE_FORMAT') ? 'env_yes' : 'env_no'), '|',
    (str_contains($help, 'hint: text or json') ? 'hint_yes' : 'hint_no'), '|',
    (str_contains($help, 'Examples:') ? 'examples_yes' : 'examples_no'), PHP_EOL;
?>
--EXPECT--
about,db-migrate,db-rollback,db-seed,db:migrate,db:rollback,db:seed,template:about
about_yes
template_yes
migrate_alias_yes
rollback_alias_yes
seed_alias_yes
migrate_yes
rollback_yes
seed_yes
2|vslim-template|provider-ready|foo,bar
1|vslim-template|provider-ready|baz
usage_yes|format_yes|env_yes|hint_yes|examples_yes
