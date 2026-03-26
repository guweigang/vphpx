--TEST--
vphp exports class-level PHP attributes for internal classes
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
#[Attribute(Attribute::TARGET_CLASS)]
class PhpDispatchable
{
    public function __construct(public string $kind) {}
}

$rc = new ReflectionClass(DispatchableSample::class);
$attrs = $rc->getAttributes(PhpDispatchable::class);

echo "count=" . count($attrs) . PHP_EOL;
if ($attrs !== []) {
    echo "name=" . $attrs[0]->getName() . PHP_EOL;
    $args = $attrs[0]->getArguments();
    echo "arg0=" . ($args[0] ?? '') . PHP_EOL;
    $instance = $attrs[0]->newInstance();
    echo "kind=" . $instance->kind . PHP_EOL;
}
?>
--EXPECT--
count=1
name=PhpDispatchable
arg0=worker
kind=worker
