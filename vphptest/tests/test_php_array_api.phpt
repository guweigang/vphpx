--TEST--
PhpArray wraps array zvals and can detach into DynValue
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_array_api([
    'name' => 'codex',
    'score' => 42,
]) . PHP_EOL;
?>
--EXPECT--
array=2:name,score:codex:map_:map_:dyn_data
