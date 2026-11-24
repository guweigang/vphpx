<?php
declare(strict_types=1);

class PhpClassMixedRedeclared extends VClassMixedInherited
{
    public mixed $slot = 9;
}

class PhpClassUntypedRedeclared extends VClassUntypedBase
{
    public $slot;
}

(static function (): void {
    foreach ([
        [VClassMixedBase::class, VClassMixedBase::class, true, false, null],
        [VClassMixedInherited::class, VClassMixedBase::class, true, false, null],
        [VClassMixedRedeclared::class, VClassMixedRedeclared::class, true, true, 7],
        [PhpClassMixedRedeclared::class, PhpClassMixedRedeclared::class, true, true, 9],
        [VClassUntypedBase::class, VClassUntypedBase::class, false, true, null],
        [VClassUntypedRedeclared::class, VClassUntypedRedeclared::class, false, true, null],
        [PhpClassUntypedRedeclared::class, PhpClassUntypedRedeclared::class, false, true, null],
    ] as [$class, $owner, $typed, $initialized, $value]) {
        $property = new ReflectionProperty($class, 'slot');
        $instance = new $class();
        if ($property->hasType() !== $typed || ($typed && (string) $property->getType() !== 'mixed')
            || $property->getDeclaringClass()->getName() !== $owner
            || $property->hasDefaultValue() !== $initialized || $property->isInitialized($instance) !== $initialized
            || ($initialized && ($property->getDefaultValue() !== $value || $instance->slot !== $value))) {
            throw new RuntimeException("Unexpected type or initialization for $class::\$slot");
        }
        if ($typed) {
            $nullable = new ReflectionProperty($class, 'nullable_slot');
            if ((string) $nullable->getType() !== 'mixed' || !$nullable->hasDefaultValue()
                || !$nullable->isInitialized($instance) || $nullable->getDefaultValue() !== null) {
                throw new RuntimeException('An explicit null default was lost during inheritance');
            }
        }

        $instance->slot = [17];
        if ($instance->slot !== [17]) {
            throw new RuntimeException("Could not write $class::\$slot");
        }
    }
})();
