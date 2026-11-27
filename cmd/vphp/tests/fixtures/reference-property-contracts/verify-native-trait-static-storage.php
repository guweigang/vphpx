<?php
declare(strict_types=1);

trait ReferenceNativeStaticComposition
{
    use VNativeStaticStorageTrait;
}

class ReferenceNativeStaticAncestor
{
    public static int $trait_count = 0;
}

class ReferenceNativeStaticParent extends ReferenceNativeStaticAncestor
{
    use ReferenceNativeStaticComposition;
}

class ReferenceNativeStaticChild extends ReferenceNativeStaticParent
{
    use VNativeStaticStorageTrait;
}

class ReferenceNativeStaticInherited extends ReferenceNativeStaticParent {}

class ReferenceNativeStaticConsumer
{
    use VNativeStaticStorageTrait;
}

class ReferenceNativeStaticUnrelated
{
    public static int $trait_count = 31;
}

(static function (): void {
    $independent = PHP_VERSION_ID >= 80300;
    $parentOwner = $independent ? ReferenceNativeStaticParent::class : ReferenceNativeStaticAncestor::class;
    $childOwner = $independent ? ReferenceNativeStaticChild::class : ReferenceNativeStaticAncestor::class;
    foreach ([
        [ReferenceNativeStaticParent::class, $parentOwner],
        [ReferenceNativeStaticInherited::class, $parentOwner],
        [ReferenceNativeStaticChild::class, $childOwner],
        [ReferenceNativeStaticConsumer::class, ReferenceNativeStaticConsumer::class],
    ] as [$class, $owner]) {
        $property = new ReflectionProperty($class, 'trait_count');
        $required = new ReflectionProperty($class, 'trait_required');
        $method = new ReflectionMethod($class, 'traitCounterReference');
        if (!$property->isStatic() || !$property->isPublic() || (string) $property->getType() !== 'int'
            || $property->getDefaultValue() !== 0 || $property->getDeclaringClass()->getName() !== $owner
            || !$required->isStatic() || (string) $required->getType() !== 'int' || $required->hasDefaultValue()
            || !$method->isStatic() || !$method->returnsReference()) {
            throw new RuntimeException('Unexpected Reflection for native trait static storage');
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    ReferenceNativeStaticAncestor::$trait_count = 37;
    $parent =& ReferenceNativeStaticInherited::traitCounterReference();
    $child =& ReferenceNativeStaticChild::traitCounterReference();
    $direct =& ReferenceNativeStaticConsumer::traitCounterReference();
    [$parent, $child, $direct] = [41, 43, 47];
    ReferenceNativeStaticConsumer::$trait_required = 67;
    $values = static fn (): array => [
        ReferenceNativeStaticAncestor::$trait_count,
        ReferenceNativeStaticParent::$trait_count,
        ReferenceNativeStaticInherited::$trait_count,
        ReferenceNativeStaticChild::$trait_count,
        ReferenceNativeStaticConsumer::$trait_count,
        ReferenceNativeStaticUnrelated::$trait_count,
    ];
    $outside = $independent ? [37, 41, 41, 43, 47, 31] : [43, 43, 43, 43, 47, 31];
    $defaults = [$independent ? 37 : 0, 0, 0, 0, 0, 31];
    if ($values() !== $outside) {
        throw new RuntimeException('A native trait reference selected the wrong class slot');
    }

    $failure = new DomainException('fail in a request using a native trait');
    foreach ([false, true] as $fails) {
        try {
            vphp_reference_property_contracts_with_static_request(static function () use ($values, $defaults, $independent, $fails, $failure, &$parent, &$direct): void {
                if ($values() !== $defaults || isset(ReferenceNativeStaticConsumer::$trait_required)) {
                    throw new RuntimeException('Native trait statics did not start at their request defaults');
                }
                ReferenceNativeStaticConsumer::$trait_required = 71;
                $inside =& ReferenceNativeStaticChild::traitCounterReference();
                $inside = 53;
                [$parent, $direct] = [59, 61];
                $expected = $independent ? [37, 0, 0, 53, 0, 31] : [53, 53, 53, 53, 0, 31];
                if ($values() !== $expected) {
                    throw new RuntimeException('A request wrote a different native trait slot from PHP');
                }
                if ($fails) {
                    throw $failure;
                }
            });
            if ($fails) {
                throw new RuntimeException('The native trait request swallowed its exception');
            }
        } catch (DomainException $error) {
            if (!$fails || $error !== $failure) {
                throw $error;
            }
        }
        if ($values() !== $outside || [$parent, $child, $direct] !== [$outside[1], $outside[3], 47]
            || ReferenceNativeStaticConsumer::$trait_required !== 67) {
            throw new RuntimeException('The native trait request did not restore its outer references');
        }
    }
})();
