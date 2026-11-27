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
if (!$copy->cloneInitialized() || $box->cloneInitialized() || $restored->cloneInitialized()) {
    throw new RuntimeException('PHP state was not initialized specifically for the clone');
}
foreach ([$box, $copy, $restored] as $value) {
    echo $value->count, ':', $value->state(), PHP_EOL;
}
$copy->bump(3);
$restored->bump(1);
echo $box->state(), ' ', $copy->state(), ' ', $restored->state(), PHP_EOL;

class ChildBox extends VPHP\Compiler\CopyableBox {
    public string $note = 'original';

    public function __clone() {
        if (!$this->cloneInitialized()) {
            throw new RuntimeException('PHP state was not ready before __clone()');
        }
        $this->bump(3);
        $this->note = 'copy';
    }
}
$child = new ChildBox;
$child->bump(4);
$childCopy = clone $child;
echo $child->note, ' ', $child->state(), PHP_EOL;
echo $childCopy->note, ' ', $childCopy->state(), PHP_EOL;

$tracked = new stdClass;
$weak = WeakReference::create($tracked);
$numbered = new VPHP\Compiler\NumberedBox;
$numbered->bump(4);
$numbered->tag = 'original';
$numbered->number = 23;
$numbered->hold($tracked);
$numberedCopy = clone $numbered;
$numberedCopy->count = 9;
$numberedCopy->tag = 'changed';
$numberedCopy->number = 7;
if (!$numberedCopy->cloneInitialized() || $numberedCopy->state() !== '9:8'
    || $numbered->state() !== '4:8' || $numbered->tag !== 'original' || $numbered->number !== 23
    || $numberedCopy->tag !== 'changed' || $numberedCopy->number !== 7) {
    throw new RuntimeException('The native descendant clone did not copy all embedded V layers');
}
unset($tracked, $numbered);
if ($weak->get() === null) {
    throw new RuntimeException('The cloned ancestor did not retain its PHP value');
}
unset($numberedCopy);
gc_collect_cycles();
if ($weak->get() !== null) {
    throw new RuntimeException('Freeing a native descendant leaked a PHP value held by its ancestor');
}

$tagged = new VPHP\Compiler\TaggedBox;
$tagged->bump(6);
$tagged->tag = "tag\0value";
[$restored, $alias] = unserialize(serialize([$tagged, $tagged]));
if ($restored !== $alias || $restored === $tagged || $restored::class !== $tagged::class
    || $restored->state() !== '6:12' || $restored->tag !== "tag\0value") {
    throw new RuntimeException('Serialization lost the derived V payload or object identity');
}
$restored->count = 7;
try {
    $restored->__unserialize(['count' => 10, 'hidden' => 20, 'tag' => []]);
    throw new LogicException('Invalid child state was accepted');
} catch (UnexpectedValueException) {
    if ($restored->state() !== '7:12' || $restored->tag !== "tag\0value" || $tagged->state() !== '6:12') {
        throw new RuntimeException('A failed restore changed the parent or child payload');
    }
}
try {
    serialize(new VPHP\Compiler\NumberedBox);
    throw new LogicException('The native subclass inherited serialization without opting in');
} catch (Exception $error) {
    if (!str_contains($error->getMessage(), 'Serialization of')) {
        throw $error;
    }
}
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
