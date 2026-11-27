<?php
declare(strict_types=1);

if (isset($argv[1])) {
    require $argv[1];
}

$interface = new ReflectionClass(VphpVersionedMethods::class);
$inherited = new ReflectionClass(VphpInheritedVersionedMethods::class);
$base = new ReflectionClass(VphpVersionedMethodBase::class);
$implementation = new ReflectionClass(VphpVersionedMethodImplementation::class);
$php85 = PHP_VERSION_ID >= 80500;
$php86 = PHP_VERSION_ID >= 80600;

$deprecationSupported = PHP_VERSION_ID >= 80400;
$legacyFunction = new ReflectionFunction('VphpVersioned\\legacyValue');
$legacyMethod = $implementation->getMethod('legacyValue');
foreach ([
    [$legacyFunction, ['message' => 'Use currentValue()', 'since' => '2.0']],
    [$legacyMethod, ['Use currentValue()']],
] as [$callable, $expectedArguments]) {
    $attributes = $callable->getAttributes(Deprecated::class);
    if ($callable->isDeprecated() !== $deprecationSupported
        || count($attributes) !== (int) $deprecationSupported
        || ($deprecationSupported && ($attributes[0]->getArguments() !== $expectedArguments
            || $attributes[0]->newInstance()->message !== 'Use currentValue()'))) {
        throw new RuntimeException('Unexpected Deprecated metadata on ' . $callable->getName());
    }
}

if (!isset($argv[1])) {
    $warnings = [];
    set_error_handler(static function (int $severity, string $message) use (&$warnings): bool {
        $warnings[] = [$severity, $message];
        return true;
    }, E_DEPRECATED | E_USER_DEPRECATED);
    try {
        $results = [VphpVersioned\legacyValue(value: 42), VphpVersionedMethodImplementation::legacyValue(value: 43)];
    } finally {
        restore_error_handler();
    }
    if ($results !== [42, 43] || $warnings !== ($deprecationSupported ? [
        [E_DEPRECATED, 'Function VphpVersioned\\legacyValue() is deprecated since 2.0, Use currentValue()'],
        [E_DEPRECATED, 'Method VphpVersionedMethodBase::legacyValue() is deprecated, Use currentValue()'],
    ] : [])) {
        throw new RuntimeException('Unexpected callable deprecation behavior: ' . var_export($warnings, true));
    }
}

foreach ([$interface, $inherited, $implementation] as $type) {
    if ($type->hasMethod('phase') !== $php85 || $type->hasMethod('pick') !== $php86) {
        throw new RuntimeException("Unexpected method availability on {$type->getName()}");
    }
}
if ($base->hasMethod('revision') !== $php86 || $base->isAbstract() !== $php86
    || $implementation->hasMethod('revision') !== $php86 || $implementation->isAbstract()
    || !$implementation->implementsInterface(VphpInheritedVersionedMethods::class)) {
    throw new RuntimeException('Unexpected abstract method registration or class flags');
}
if (!$php86 && !$base->newInstance() instanceof VphpVersionedMethodBase) {
    throw new RuntimeException('A hidden abstract method prevented instantiation');
}

if ($php85) {
    $phase = $inherited->getMethod('phase');
    $attributes = $phase->getAttributes(NoDiscard::class);
    if (!$phase->isStatic() || !$phase->isAbstract() || (string) $phase->getReturnType() !== 'int'
        || count($attributes) !== 1 || $attributes[0]->getArguments() !== ['message' => 'Use the phase']) {
        throw new RuntimeException('The versioned static interface method lost metadata');
    }
    if (!isset($argv[1]) && VphpVersionedMethodImplementation::phase() !== 85) {
        throw new RuntimeException('The implementation of phase cannot be called');
    }
}

if ($php86) {
    $pick = $inherited->getMethod('pick');
    $parameter = $pick->getParameters()[0];
    $prototype = $implementation->getMethod('pick')->getPrototype();
    $types = array_map(strval(...), $parameter->getType()->getTypes());
    sort($types);
    $returnTypes = array_map(strval(...), $pick->getReturnType()->getTypes());
    sort($returnTypes);
    $tags = $parameter->getAttributes('VphpMethodTag');
    $revision = $base->getMethod('revision');
    if ($pick->isStatic() || !$pick->isAbstract() || $parameter->getName() !== 'value'
        || !$parameter->isOptional() || $parameter->getDefaultValue() !== 86
        || !in_array($types, [['ArrayAccess&Countable', 'int'], ['Countable&ArrayAccess', 'int']], true)
        || $returnTypes !== $types || count($tags) !== 1 || $tags[0]->getArguments() !== ['slot' => 'value']
        || $prototype->getDeclaringClass()->getName() !== VphpVersionedMethods::class
        || count($implementation->getMethod('pick')->getAttributes(Override::class)) !== 1
        || !$revision->isStatic() || !$revision->isAbstract()
        || $implementation->getMethod('revision')->getPrototype()->getDeclaringClass()->getName() !== $base->getName()) {
        throw new RuntimeException('The PHP 8.6 methods lost their signatures or prototypes');
    }
    if (!isset($argv[1])) {
        $receiver = $implementation->newInstance();
        $value = new ArrayObject();
        if ($receiver->pick() !== 86 || $receiver->pick(value: $value) !== $value
            || VphpVersionedMethodImplementation::revision() !== 86) {
            throw new RuntimeException('The PHP 8.6 implementations lost defaults or named calls');
        }
    }
}
