<?php
declare(strict_types=1);

if (isset($argv[1]) && !str_starts_with($argv[1], '--')) {
    require $argv[1];
}
$mode = $argv[2] ?? $argv[1] ?? '';
if ($mode === '--value-override') {
    eval('class PhpRefValueOverride extends RefHookBackedChild { public int $score { get => 1; } }');
    exit;
}
if ($mode === '--backed-pair') {
    eval('class PhpRefBackedPair extends VirtualRefHook { public int $score = 3; }');
    exit;
}

if (PHP_VERSION_ID < 80400) {
    foreach ([RefHookBase::class, RefHookChild::class, RefHookOverride::class,
        VirtualRefHook::class, VirtualRefHookChild::class] as $class) {
        if (property_exists($class, 'score')) {
            throw new RuntimeException("A reference hook appeared before PHP 8.4 on $class");
        }
    }
    if ((new RefHookBackedChild())->score !== 5) {
        throw new RuntimeException('The ordinary subclass property was lost');
    }
    exit;
}

class PhpRefChild extends RefHookBase {}
class PhpRefBackedChild extends RefHookBase {
    public int $score = 8;
}

$copyValue = static fn (mixed $value): mixed => $value;
foreach ([
    [RefHookBase::class, RefHookBase::class, 3],
    [RefHookChild::class, RefHookBase::class, 3],
    [RefHookBackedChild::class, RefHookBase::class, 5],
    [RefHookOverride::class, RefHookOverride::class, 7],
    [PhpRefChild::class, RefHookBase::class, 3],
    [PhpRefBackedChild::class, RefHookBase::class, 8],
] as [$class, $owner, $default]) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if ($property->isVirtual() || array_keys($hooks) !== ['get'] || !$hooks['get']->returnsReference()
        || $hooks['get']->getDeclaringClass()->getName() !== $owner
        || (string) $hooks['get']->getReturnType() !== 'int') {
        throw new RuntimeException("Unexpected reference hook metadata for $class");
    }

    $object = new $class();
    $other = new $class();
    $ref =& $object->score;
    if ($ref !== $default) {
        throw new RuntimeException("Unexpected initial reference value for $class");
    }
    $ref = 21;
    if ($object->score !== 21 || $other->score !== $default) {
        throw new RuntimeException("The reference did not update only its backing object for $class");
    }
    $object->score = 37;
    $raw = $copyValue($property->getRawValue($object));
    if ($ref !== 37 || $raw !== 37) {
        throw new RuntimeException("The property write did not reach the reference for $class");
    }
    try {
        $ref = 'bad';
        throw new RuntimeException("The typed reference accepted a string for $class");
    } catch (TypeError) {
    }
    unset($object);
    $ref = 'no longer typed by the freed property';
    unset($ref);
}

class PhpVirtualRefHookChild extends VirtualRefHook {
    public int $storage = 99;
}

foreach ([VirtualRefHook::class, VirtualRefHookChild::class, PhpVirtualRefHookChild::class] as $class) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if (!$property->isVirtual() || $property->hasDefaultValue() || array_keys($hooks) !== ['get', 'set']
        || !$hooks['get']->returnsReference() || $hooks['set']->returnsReference()
        || (string) $hooks['get']->getReturnType() !== 'int'
        || (string) $hooks['set']->getParameters()[0]->getType() !== 'int'
        || $hooks['get']->getDeclaringClass()->getName() !== VirtualRefHook::class
        || $hooks['set']->getDeclaringClass()->getName() !== VirtualRefHook::class) {
        throw new RuntimeException("Unexpected virtual hook metadata for $class");
    }
    if (extension_loaded('reference_property_hooks')) {
        $object = new $class();
        $other = new $class();
        $ref =& $object->score;
        $ref = 21;
        if ($object->score !== 21 || $other->score !== 3) {
            throw new RuntimeException("A reference write did not update storage directly for $class");
        }
        $object->score = 7;
        if ($ref !== 70 || $object->score !== 70) {
            throw new RuntimeException("The setter did not update the existing reference for $class");
        }
        $ref = 36;
        if ($object->score !== 36
            || ($object instanceof PhpVirtualRefHookChild && $object->storage !== 99)) {
            throw new RuntimeException("The getter no longer referenced the original storage for $class");
        }
        try {
            $ref = 'bad';
            throw new RuntimeException("The storage reference accepted a string for $class");
        } catch (TypeError) {
        }
        unset($ref);
    }
}
