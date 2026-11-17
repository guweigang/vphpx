--TEST--
VPHP object copying requires a declared policy and preserves PHP and V state
--FILE--
<?php
$ordinary = new VPHP\Compiler\ModuleProbeBox;
$ordinary->name = 'saved';
$ordinary->count = 42;
echo $ordinary->label(), PHP_EOL;
var_dump((new ReflectionObject($ordinary))->isCloneable());
try {
    clone $ordinary;
} catch (Error $e) {
    echo "clone denied\n";
}
try {
    serialize($ordinary);
} catch (Exception $e) {
    echo "serialization denied\n";
}
try {
    $type = $ordinary::class;
    unserialize('O:' . strlen($type) . ':"' . $type . '":0:{}');
} catch (Exception $e) {
    echo "deserialization denied\n";
}

$box = new VPHP\Compiler\CopyableBox;
$box->bump(4);
$copy = clone $box;
$restored = unserialize(serialize($box));
foreach ([$box, $copy, $restored] as $value) {
    echo $value->count, ':', $value->state(), PHP_EOL;
}
$copy->bump(3);
$restored->bump(1);
echo $box->state(), ' ', $copy->state(), ' ', $restored->state(), PHP_EOL;

class ChildBox extends VPHP\Compiler\CopyableBox {
    public string $note = 'original';

    public function __clone() {
        $this->bump(3);
        $this->note = 'copy';
    }
}
$child = new ChildBox;
$child->bump(4);
$childCopy = clone $child;
echo $child->note, ' ', $child->state(), PHP_EOL;
echo $childCopy->note, ' ', $childCopy->state(), PHP_EOL;
?>
--EXPECT--
saved:42
bool(false)
clone denied
serialization denied
deserialization denied
4:4:8
4:4:8
4:4:8
4:8 7:14 5:10
original 4:8
copy 7:14
