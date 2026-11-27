<?php

if (isset($argv[1]) && !str_starts_with($argv[1], '--')) {
    require $argv[1];
}
$mode = $argv[2] ?? $argv[1] ?? '';
if ($mode === '--missing-get') {
    eval('class PhpMissingAbstractGet extends AbstractRead {}');
    exit;
}
if ($mode === '--missing-set') {
    eval('class PhpMissingAbstractSet extends AbstractWrite { public int $score { get => 1; } }');
    exit;
}
if ($mode === '--invalid-override') {
    eval('class PhpWrongAbstractOverride extends AbstractRead { public int $score { get => 1; #[\\Override] set {} } }');
    exit;
}

if (PHP_VERSION_ID < 80400) {
    foreach ([AbstractRead::class, AbstractWrite::class, ConcreteGet::class, ConcreteSet::class,
        NativeRead::class, NativeWrite::class, NativeMixedRead::class] as $class) {
        if (property_exists($class, 'score')) {
            throw new RuntimeException("Hooked property $class appeared before PHP 8.4");
        }
    }
    if ((new NativeBackedWrite())->score !== 7) {
        throw new RuntimeException('The ordinary subclass property was lost');
    }
    exit;
}

foreach ([
    AbstractRead::class => ['get' => true],
    AbstractWrite::class => ['set' => true],
    ConcreteGet::class => ['get' => false, 'set' => true],
    ConcreteSet::class => ['get' => true, 'set' => false],
] as $class => $expected) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if (!$property->isAbstract() || !$property->isVirtual() || !$property->isPublic()
        || (string) $property->getType() !== 'int' || array_keys($hooks) !== array_keys($expected)) {
        throw new RuntimeException("Unexpected abstract property metadata for $class");
    }
    foreach ($hooks as $kind => $hook) {
        $setter = $kind === 'set';
        if ($hook->isAbstract() !== $expected[$kind] || !$hook->isPublic()
            || $hook->getName() !== '$score::' . $kind || $hook->getDeclaringClass()->getName() !== $class
            || (string) $hook->getReturnType() !== ($setter ? 'void' : 'int')
            || $hook->getNumberOfRequiredParameters() !== (int) $setter
            || ($setter && (string) $hook->getParameters()[0]->getType() !== 'int')) {
            throw new RuntimeException("Unexpected $kind signature for $class");
        }
    }
}

foreach ([
    NativeRead::class => ['get', AbstractRead::class],
    NativeWrite::class => ['set', AbstractWrite::class],
    NativeMixedRead::class => ['get', ConcreteSet::class],
] as $class => [$kind, $parent]) {
    $property = new ReflectionProperty($class, 'score');
    $hook = $property->getHooks()[$kind];
    $attributes = $hook->getAttributes(Override::class);
    if ($property->isAbstract() || $hook->isAbstract()
        || $hook->getPrototype()->getDeclaringClass()->getName() !== $parent
        || (PHP_VERSION_ID >= 80500
            ? count($attributes) !== 1 || !($attributes[0]->newInstance() instanceof Override)
            : $attributes !== [])) {
        throw new RuntimeException("Unexpected implementation metadata for $class");
    }
}

$override = PHP_VERSION_ID >= 80500 ? '#[\\Override] ' : '';
eval('class PhpConcreteRead extends AbstractRead { public int $score { ' . $override . 'get => 23; } }');
eval('class PhpConcreteWrite extends AbstractWrite {
    public int $received = 0;
    public int $score { ' . $override . 'set { $this->received = $value; } }
}');
class PhpBackedWrite extends ConcreteGet {
    public int $score = 9;
}
$writer = new PhpConcreteWrite();
$writer->score = 36;
if ((new PhpConcreteRead())->score !== 23 || $writer->received !== 36) {
    throw new RuntimeException('PHP implementations did not satisfy the abstract accessors');
}

foreach ([NativeBackedWrite::class, NativeFieldWrite::class, PhpBackedWrite::class] as $class) {
    $object = new $class();
    $property = new ReflectionProperty($object, 'score');
    $hooks = $property->getHooks();
    $object->score = 19;
    if ($property->isVirtual() || $property->isAbstract() || array_keys($hooks) !== ['get']
        || $hooks['get']->isAbstract() || $hooks['get']->getDeclaringClass()->getName() !== ConcreteGet::class
        || $property->getRawValue($object) !== 19
        || (extension_loaded('abstract_properties') && $object->score !== 41)) {
        throw new RuntimeException("Backed implementation did not inherit the concrete getter for $class");
    }
}

$mixed = new NativeMixedRead();
$mixed->score = 11;
$mixedHooks = (new ReflectionProperty($mixed, 'score'))->getHooks();
if ($mixedHooks['set']->getDeclaringClass()->getName() !== ConcreteSet::class
    || $mixedHooks['set']->isAbstract()
    || (extension_loaded('abstract_properties') && ($mixed->score !== 51 || (new NativeRead())->score !== 17))) {
    throw new RuntimeException('The native getter or inherited concrete setter was lost');
}
