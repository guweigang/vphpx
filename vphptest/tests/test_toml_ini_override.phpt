--TEST--
TOML INI defaults can be overridden by PHP startup configuration
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--INI--
vphptest.system_limit=27
vphptest.enable_cache=0
--FILE--
<?php
echo ini_get('vphptest.system_limit'), ':', ini_get('vphptest.enable_cache'), "\n";
?>
--EXPECT--
27:0
