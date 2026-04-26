--TEST--
PhpClass reference API wraps class-string interop without replacing php_class
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
class PhpUnifiedBox {
    public const LABEL = 'UNIFIED';
    public string $name;
    public int $score;

    public function __construct(string $name, int $score) {
        $this->name = $name;
        $this->score = $score;
    }

    public function doubleScore(): int {
        return $this->score * 2;
    }

    public static function triple(int $x): int {
        return $x * 3;
    }
}

echo v_php_class_ref_api() . PHP_EOL;
?>
--EXPECT--
class=PhpUnifiedBox;exists=true;method=true;prop=true;const=true;value=ref:18:9:UNIFIED;missing=missing
