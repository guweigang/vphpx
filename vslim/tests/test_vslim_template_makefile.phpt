--TEST--
VSlim template Makefile exposes standard HTTP and CLI entry targets
--FILE--
<?php
$makefile = (string) file_get_contents(__DIR__ . '/../templates/app/Makefile');

echo (str_contains($makefile, 'serve:') ? 'serve_yes' : 'serve_no'), '|',
    (str_contains($makefile, 'vhttpd:') ? 'vhttpd_yes' : 'vhttpd_no'), '|',
    (str_contains($makefile, 'smoke-vhttpd:') ? 'smoke_yes' : 'smoke_no'), '|',
    (str_contains($makefile, 'cli:') ? 'cli_yes' : 'cli_no'), '|',
    (str_contains($makefile, 'cli-help:') ? 'cli_help_yes' : 'cli_help_no'), '|',
    (str_contains($makefile, 'health:') ? 'health_yes' : 'health_no'), '|',
    (str_contains($makefile, 'module:') ? 'module_yes' : 'module_no'), PHP_EOL;
echo (str_contains($makefile, 'public/index.php') ? 'public_yes' : 'public_no'), '|',
    (str_contains($makefile, 'public/worker.php') ? 'worker_yes' : 'worker_no'), '|',
    (str_contains($makefile, '/module/ping') ? 'smoke_route_yes' : 'smoke_route_no'), '|',
    (str_contains($makefile, 'bin/vslim about') ? 'bin_yes' : 'bin_no'), '|',
    (str_contains($makefile, 'VHTTPD_ROOT ?=') ? 'vhttpd_root_yes' : 'vhttpd_root_no'), '|',
    (str_contains($makefile, 'EXT ?= ./vslim.so') ? 'ext_yes' : 'ext_no'), PHP_EOL;
$launcher = (string) file_get_contents(__DIR__ . '/../templates/app/bin/vslim');
echo (str_contains($makefile, 'bin/vslim serve') ? 'serve_entry_yes' : 'serve_entry_no'), '|',
    (str_contains($launcher, "=== 'serve'") ? 'serve_dispatch_yes' : 'serve_dispatch_no'), '|',
    (str_contains($launcher, "'--engine=embedded'") || str_contains($launcher, "'embedded'") ? 'embedded_optin_yes' : 'embedded_optin_no'), '|',
    (is_file(__DIR__ . '/../templates/app/vslim.yaml') ? 'config_yes' : 'config_no'), PHP_EOL;
echo (str_contains($makefile, 'build-app:') ? 'build_target_yes' : 'build_target_no'), '|',
    (str_contains($launcher, "=== 'build'") ? 'build_dispatch_yes' : 'build_dispatch_no'), '|',
    (is_file(__DIR__ . '/../templates/app/bin/vslim-build') ? 'builder_yes' : 'builder_no'), PHP_EOL;
?>
--EXPECT--
serve_yes|vhttpd_yes|smoke_yes|cli_yes|cli_help_yes|health_yes|module_yes
public_yes|worker_yes|smoke_route_yes|bin_yes|vhttpd_root_yes|ext_yes
serve_entry_yes|serve_dispatch_yes|embedded_optin_yes|config_yes
build_target_yes|build_dispatch_yes|builder_yes
