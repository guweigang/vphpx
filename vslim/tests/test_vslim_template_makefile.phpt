--TEST--
VSlim template Makefile exposes standard HTTP and CLI entry targets
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$makefile = (string) file_get_contents(__DIR__ . '/../templates/app/Makefile');

echo (str_contains($makefile, 'serve:') ? 'serve_yes' : 'serve_no'), '|',
    (str_contains($makefile, 'cli:') ? 'cli_yes' : 'cli_no'), '|',
    (str_contains($makefile, 'cli-help:') ? 'cli_help_yes' : 'cli_help_no'), '|',
    (str_contains($makefile, 'health:') ? 'health_yes' : 'health_no'), '|',
    (str_contains($makefile, 'module:') ? 'module_yes' : 'module_no'), PHP_EOL;
echo (str_contains($makefile, 'public/index.php') ? 'public_yes' : 'public_no'), '|',
    (str_contains($makefile, 'bin/vslim about') ? 'bin_yes' : 'bin_no'), '|',
    (str_contains($makefile, 'EXT ?= ./vslim.so') ? 'ext_yes' : 'ext_no'), PHP_EOL;
?>
--EXPECT--
serve_yes|cli_yes|cli_help_yes|health_yes|module_yes
public_yes|bin_yes|ext_yes
