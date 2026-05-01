--TEST--
PhpClosure retains persistent-owned callable lifecycle and releases it explicitly
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_php_closure_persistent_api(function (string $name, int $count): string {
    return strtoupper($name) . ':' . $count;
}) . PHP_EOL;
?>
--EXPECT--
persistent=persistent_owned:true:KEEP:2:LIFE:4:retained=true:released=true
