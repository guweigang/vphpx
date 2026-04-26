--TEST--
PhpClassMeta snapshots class metadata from a PhpClass reference
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
class PhpUnifiedBase {}
class PhpUnifiedBox extends PhpUnifiedBase {}

echo v_php_class_meta_api() . PHP_EOL;
?>
--EXPECT--
meta=PhpUnifiedBox:PhpUnifiedBox:PhpUnifiedBase:true:false:0
