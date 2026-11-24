<?php
declare(strict_types=1);

trait ReferenceStaticCounterTrait
{
    public static int $counter = 0;
}

class ReferenceStaticTraitParent extends VStaticReferenceStorage
{
    use ReferenceStaticCounterTrait;

    public static function &nativeCounterReference(): int
    {
        return static::$counter;
    }
}

class ReferenceStaticTraitChild extends ReferenceStaticTraitParent
{
    use ReferenceStaticCounterTrait;

    public static function &forwardedCounterReference(): mixed
    {
        return parent::staticStorageReference(name: 'counter');
    }
}

class ReferenceStaticTraitInherited extends ReferenceStaticTraitParent {}

(static function (): void {
    $independent = PHP_VERSION_ID >= 80300;
    $parentOwner = $independent ? ReferenceStaticTraitParent::class : VStaticReferenceStorage::class;
    $childOwner = $independent ? ReferenceStaticTraitChild::class : VStaticReferenceStorage::class;
    foreach ([
        [ReferenceStaticTraitParent::class, $parentOwner],
        [ReferenceStaticTraitInherited::class, $parentOwner],
        [ReferenceStaticTraitChild::class, $childOwner],
    ] as [$class, $owner]) {
        $property = new ReflectionProperty($class, 'counter');
        if ($property->getDeclaringClass()->getName() !== $owner || $property->getDefaultValue() !== 0) {
            throw new RuntimeException('Unexpected Reflection for the inherited trait static property');
        }
    }

    $nativeParent =& ReferenceStaticTraitInherited::nativeCounterReference();
    $nativeChild =& ReferenceStaticTraitChild::nativeCounterReference();
    $rootValue = VStaticReferenceStorage::$counter;
    $nativeParent = 241;
    $nativeChild = 251;
    $expected = $independent ? [$rootValue, 241, 241, 251] : [251, 251, 251, 251];
    $counters = static fn (): array => [
        VStaticReferenceStorage::$counter,
        ReferenceStaticTraitParent::$counter,
        ReferenceStaticTraitInherited::$counter,
        ReferenceStaticTraitChild::$counter,
    ];
    if ($counters() !== $expected) {
        throw new RuntimeException('Unexpected PHP trait static property sharing');
    }

    if (extension_loaded('reference_property_contracts')) {
        $parent =& ReferenceStaticTraitInherited::staticStorageReference('counter');
        $child =& ReferenceStaticTraitChild::forwardedCounterReference();
        $references = [&$nativeParent, &$nativeChild, &$parent, &$child];
        $parentId = ReflectionReference::fromArrayElement($references, 0)->getId();
        $childId = ReflectionReference::fromArrayElement($references, 1)->getId();
        if (ReflectionReference::fromArrayElement($references, 2)->getId() !== $parentId
            || ReflectionReference::fromArrayElement($references, 3)->getId() !== $childId
            || ($parentId !== $childId) !== $independent) {
            throw new RuntimeException('VPHP bound a different trait static slot from PHP');
        }

        $failure = new DomainException('fail in trait static request');
        foreach ([false, true] as $fails) {
            try {
                vphp_reference_property_contracts_with_static_request(static function () use ($fails, $failure, $counters, $independent, &$child): void {
                    if ($counters() !== [0, 0, 0, 0]) {
                        throw new RuntimeException('A new request retained a trait static value');
                    }
                    $inside =& ReferenceStaticTraitChild::forwardedCounterReference();
                    $inside = 257;
                    $child = 263;
                    if ($counters() !== ($independent ? [0, 0, 0, 257] : [257, 257, 257, 257])) {
                        throw new RuntimeException('A request wrote the wrong trait static slot');
                    }
                    if ($fails) {
                        throw $failure;
                    }
                });
                if ($fails) {
                    throw new RuntimeException('The trait static request swallowed its exception');
                }
            } catch (DomainException $error) {
                if (!$fails || $error !== $failure) {
                    throw $error;
                }
            }
            if ($counters() !== $expected || [$parent, $child] !== [$expected[1], $expected[3]]) {
                throw new RuntimeException('The request did not restore trait static values and references');
            }
        }
    }

    VStaticReferenceStorage::$counter = $rootValue;
})();
