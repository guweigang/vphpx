--TEST--
PhpObject wraps object zvals with borrowed and persistent lifecycle semantics
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
class PhpObjectApiBox {
    public string $name = 'codex';

    public function greet(): string {
        return 'hi:' . $this->name;
    }
}

echo v_php_object_api(new PhpObjectApiBox()) . PHP_EOL;
?>
--EXPECT--
object=PhpObjectApiBox:true:codex:hi:codex:persistent_owned:hi:codex
