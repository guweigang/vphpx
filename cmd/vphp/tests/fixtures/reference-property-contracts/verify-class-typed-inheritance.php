<?php
declare(strict_types=1);

class PhpClassTypedRedeclared extends VClassTypedInherited
{
    public string|int $choice = 11;
    public int|null $optional;
}

(static function (): void {
    foreach ([
        [VClassTypedBase::class, VClassTypedBase::class, 7],
        [VClassTypedInherited::class, VClassTypedBase::class, 7],
        [VClassTypedRedeclared::class, VClassTypedRedeclared::class, 9],
        [PhpClassTypedRedeclared::class, PhpClassTypedRedeclared::class, 11],
    ] as [$class, $owner, $default]) {
        $object = new $class();
        $choice = new ReflectionProperty($class, 'choice');
        $optional = new ReflectionProperty($class, 'optional');
        if (composedStaticPropertyType($choice->getType()) !== 'int|string'
            || composedStaticPropertyType($optional->getType()) !== '?int'
            || $choice->getDeclaringClass()->getName() !== $owner
            || $optional->getDeclaringClass()->getName() !== $owner
            || $choice->getDefaultValue() !== $default || $object->choice !== $default
            || $optional->hasDefaultValue() || $optional->isInitialized($object)) {
            throw new RuntimeException("Unexpected backed property metadata for $class");
        }

        $object->choice = 'string branch';
        $object->optional = null;
        if ($object->choice !== 'string branch' || !$optional->isInitialized($object) || $object->optional !== null) {
            throw new RuntimeException("Could not write compatible properties on $class");
        }
        try {
            $object->choice = 1.5;
            throw new RuntimeException("Incorrect union member accepted on $class");
        } catch (TypeError) {
        }
    }
})();
