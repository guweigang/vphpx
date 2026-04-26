--TEST--
PersistentPhpClosure retains callable lifecycle and releases it explicitly
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_closure_persistent_api(function (string $name, int $count): string {
    return strtoupper($name) . ':' . $count;
}) . PHP_EOL;
?>
--EXPECT--
persistent=dyn_data:true:KEEP:2:LIFE:4:retained=true:released=true
