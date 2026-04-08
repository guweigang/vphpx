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
echo ($cli->hasCommand("app:doctor") ? "doctor_yes" : "doctor_no"), PHP_EOL;
echo ($cli->hasCommand("about") ? "about_yes" : "about_no"), PHP_EOL;
echo ($cli->hasCommand("config:check") ? "config_yes" : "config_no"), PHP_EOL;
echo ($cli->hasCommand("route:list") ? "route_yes" : "route_no"), PHP_EOL;
echo ($cli->hasCommand("template:about") ? "template_yes" : "template_no"), PHP_EOL;
echo ($cli->hasCommand("db-migrate") ? "migrate_alias_yes" : "migrate_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db-rollback") ? "rollback_alias_yes" : "rollback_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db-seed") ? "seed_alias_yes" : "seed_alias_no"), PHP_EOL;
echo ($cli->hasCommand("db:migrate") ? "migrate_yes" : "migrate_no"), PHP_EOL;
echo ($cli->hasCommand("db:rollback") ? "rollback_yes" : "rollback_no"), PHP_EOL;
echo ($cli->hasCommand("db:seed") ? "seed_yes" : "seed_no"), PHP_EOL;
echo ($cli->hasCommand("make:command") ? "make_command_yes" : "make_command_no"), PHP_EOL;
echo ($cli->hasCommand("make:controller") ? "make_controller_yes" : "make_controller_no"), PHP_EOL;
echo ($cli->hasCommand("make:migration") ? "make_migration_yes" : "make_migration_no"), PHP_EOL;
echo ($cli->hasCommand("make:middleware") ? "make_middleware_yes" : "make_middleware_no"), PHP_EOL;
echo ($cli->hasCommand("make:provider") ? "make_provider_yes" : "make_provider_no"), PHP_EOL;
echo ($cli->hasCommand("make:seed") ? "make_seed_yes" : "make_seed_no"), PHP_EOL;
echo ($cli->hasCommand("make:test") ? "make_test_yes" : "make_test_no"), PHP_EOL;

ob_start();
$code = $cli->run("about", ["foo", "bar"]);
$output = trim((string) ob_get_clean());
echo $code, "|", $output, PHP_EOL;

ob_start();
$aliasCode = $cli->run("template:about", ["baz"]);
$aliasOutput = trim((string) ob_get_clean());
echo $aliasCode, "|", $aliasOutput, PHP_EOL;

ob_start();
$routeCode = $cli->run("route:list", []);
$routeOutput = trim((string) ob_get_clean());
$routeLines = array_values(array_filter(explode(PHP_EOL, $routeOutput), static fn (string $line): bool => $line !== ''));
echo $routeCode, "|", count($routeLines), "|", $routeLines[0], PHP_EOL;

ob_start();
$configCode = $cli->run("config:check", []);
$configOutput = trim((string) ob_get_clean());
echo $configCode, "|",
    (str_contains($configOutput, 'app.name=vslim-template') ? 'config_app_yes' : 'config_app_no'), "|",
    (str_contains($configOutput, 'database.transport=direct') ? 'config_db_transport_yes' : 'config_db_transport_no'), "|",
    (str_contains($configOutput, 'session.secret_configured=true') ? 'config_session_secret_yes' : 'config_session_secret_no'), "|",
    (str_contains($configOutput, 'session.secret_placeholder=true') ? 'config_session_placeholder_yes' : 'config_session_placeholder_no'), PHP_EOL;

ob_start();
$doctorCode = $cli->run("app:doctor", []);
$doctorOutput = trim((string) ob_get_clean());
echo $doctorCode, "|",
    (str_contains($doctorOutput, 'config_loaded=true') ? 'doctor_config_yes' : 'doctor_config_no'), "|",
    (str_contains($doctorOutput, 'session_secret_configured=true') ? 'doctor_session_secret_yes' : 'doctor_session_secret_no'), "|",
    (str_contains($doctorOutput, 'session_secret_placeholder=true') ? 'doctor_session_placeholder_yes' : 'doctor_session_placeholder_no'), "|",
    (str_contains($doctorOutput, 'database_transport=direct') ? 'doctor_db_transport_yes' : 'doctor_db_transport_no'), "|",
    (str_contains($doctorOutput, 'issues=session_secret_placeholder,auth_user_provider_missing') ? 'doctor_issues_yes' : 'doctor_issues_no'), PHP_EOL;

$help = $cli->commandHelp("about");
echo (str_contains($help, 'Usage:') ? 'usage_yes' : 'usage_no'), '|',
    (str_contains($help, '--format <kind>') ? 'format_yes' : 'format_no'), '|',
    (str_contains($help, 'env: VSLIM_TEMPLATE_FORMAT') ? 'env_yes' : 'env_no'), '|',
    (str_contains($help, 'hint: text or json') ? 'hint_yes' : 'hint_no'), '|',
    (str_contains($help, 'Examples:') ? 'examples_yes' : 'examples_no'), PHP_EOL;
?>
--EXPECT--
about,app-doctor,app:doctor,config-check,config:check,db-migrate,db-rollback,db-seed,db:migrate,db:rollback,db:seed,make-command,make-controller,make-middleware,make-migration,make-provider,make-seed,make-test,make:command,make:controller,make:middleware,make:migration,make:provider,make:seed,make:test,route-list,route:list,template:about
doctor_yes
about_yes
config_yes
route_yes
template_yes
migrate_alias_yes
rollback_alias_yes
seed_alias_yes
migrate_yes
rollback_yes
seed_yes
make_command_yes
make_controller_yes
make_migration_yes
make_middleware_yes
make_provider_yes
make_seed_yes
make_test_yes
2|vslim-template|provider-ready|foo,bar
1|vslim-template|provider-ready|baz
4|4|GET|/|template.home|php_callable
0|config_app_yes|config_db_transport_yes|config_session_secret_yes|config_session_placeholder_yes
1|doctor_config_yes|doctor_session_secret_yes|doctor_session_placeholder_yes|doctor_db_transport_yes|doctor_issues_yes
usage_yes|format_yes|env_yes|hint_yes|examples_yes
