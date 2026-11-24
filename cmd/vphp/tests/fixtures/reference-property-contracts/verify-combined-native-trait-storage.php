<?php
declare(strict_types=1);

trait PhpCombinedNativeStaticStorage
{
    use VNativeStaticStorageTrait, VNumericNativeStaticStorageTrait, VAdditionalNativeStaticStorageTrait;
    use VNativeUnionStaticStorageTrait, VReorderedUnionStaticStorageTrait;
    use VNativeDnfStaticStorageTrait, VReorderedDnfStaticStorageTrait;
}

class PhpCombinedStaticConsumer
{
    use PhpCombinedNativeStaticStorage;
}

class VCombinedStaticConsumer
{
    use VCombinedNativeStaticStorageTrait;
}

class VCombinedStaticChild extends VCombinedStaticConsumer {}

function composedStaticPropertyType(ReflectionType $type): string
{
    if ($type instanceof ReflectionNamedType) {
        return (string) $type;
    }
    $members = array_map(composedStaticPropertyType(...), $type->getTypes());
    sort($members, SORT_STRING);
    if ($type instanceof ReflectionIntersectionType) {
        return '(' . implode('&', $members) . ')';
    }
    return implode('|', $members);
}

(static function (): void {
    $trait = new ReflectionClass(VCombinedNativeStaticStorageTrait::class);
    if ($trait->getTraitNames() !== [
        VNativeStaticStorageTrait::class, VNumericNativeStaticStorageTrait::class, VAdditionalNativeStaticStorageTrait::class,
        VNativeUnionStaticStorageTrait::class, VReorderedUnionStaticStorageTrait::class,
        VNativeDnfStaticStorageTrait::class, VReorderedDnfStaticStorageTrait::class,
    ]
        || $trait->getTraitAliases() !== ['combinedCounterReference' => VNativeStaticStorageTrait::class . '::traitCounterReference']) {
        throw new RuntimeException('Unexpected Reflection for the typed trait composition');
    }
    foreach ([PhpCombinedStaticConsumer::class, VCombinedStaticConsumer::class, VCombinedStaticChild::class] as $class) {
        $property = new ReflectionProperty($class, 'trait_rate');
        $owner = $class === VCombinedStaticChild::class ? VCombinedStaticConsumer::class : $class;
        if (!$property->isStatic() || (string) $property->getType() !== 'float'
            || $property->getDefaultValue() !== 1.0 || $property->getDeclaringClass()->getName() !== $owner
            || $class::$trait_rate !== 1.0) {
            throw new RuntimeException('The composition did not preserve the native static property declaration');
        }
        foreach ([
            'trait_choice' => ['int|string', 7, true],
            'trait_nullable' => ['?int', null, false],
            'trait_dnf' => ['(ArrayAccess&Countable)|int', 11, true],
        ] as $name => [$type, $default, $hasDefault]) {
            $member = new ReflectionProperty($class, $name);
            if (composedStaticPropertyType($member->getType()) !== $type || !$member->isStatic()
                || $member->hasDefaultValue() !== $hasDefault || ($hasDefault && $member->getDefaultValue() !== $default)
                || $member->getDeclaringClass()->getName() !== $owner) {
                throw new RuntimeException("The composition changed the declaration of $class::\$$name");
            }
        }
    }
    if (!(new ReflectionMethod(VCombinedStaticChild::class, 'combinedCounterReference'))->returnsReference()) {
        throw new RuntimeException('The composed alias lost its reference return');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $alias =& VCombinedStaticChild::combinedCounterReference();
    $original =& VCombinedStaticConsumer::traitCounterReference();
    $php =& PhpCombinedStaticConsumer::traitCounterReference();
    $alias = 91;
    $php = 93;
    VCombinedStaticConsumer::$trait_rate = 2.5;
    PhpCombinedStaticConsumer::$trait_rate = 3.5;
    VCombinedStaticConsumer::$trait_choice = 'outer';
    VCombinedStaticConsumer::$trait_nullable = 13;
    VCombinedStaticConsumer::$trait_dnf = new ArrayObject();
    $state = static fn (): array => [
        VCombinedStaticConsumer::$trait_count,
        VCombinedStaticChild::$trait_count,
        PhpCombinedStaticConsumer::$trait_count,
        VCombinedStaticConsumer::$trait_rate,
        PhpCombinedStaticConsumer::$trait_rate,
    ];
    $failure = new DomainException('throw after writing composed trait storage');
    foreach ([false, true] as $fails) {
        try {
            vphp_reference_property_contracts_with_static_request(static function () use ($fails, $failure, $state, &$alias): void {
                if ($state() !== [0, 0, 0, 1.0, 1.0]) {
                    throw new RuntimeException('The composed traits did not start at their request defaults');
                }
                if (VCombinedStaticChild::$trait_choice !== 7 || isset(VCombinedStaticChild::$trait_nullable)
                    || VCombinedStaticChild::$trait_dnf !== 11) {
                    throw new RuntimeException('The request did not reset the composed compound properties');
                }
                VCombinedStaticChild::$trait_choice = 'inner';
                VCombinedStaticChild::$trait_nullable = null;
                VCombinedStaticChild::$trait_dnf = 17;
                $inside =& VCombinedStaticChild::combinedCounterReference();
                $inside = 97;
                $alias = 99;
                VCombinedStaticConsumer::$trait_rate = 4.5;
                if ($state() !== [97, 97, 0, 4.5, 1.0]) {
                    throw new RuntimeException('The composed alias wrote the wrong static slot');
                }
                if ($fails) {
                    throw $failure;
                }
            });
            if ($fails) {
                throw new RuntimeException('The composed trait request swallowed its exception');
            }
        } catch (DomainException $error) {
            if (!$fails || $error !== $failure) {
                throw $error;
            }
        }
        if ($state() !== [91, 91, 93, 2.5, 3.5] || [$alias, $original, $php] !== [91, 91, 93]) {
            throw new RuntimeException('The composed trait request lost an outer static value or reference');
        }
        if (VCombinedStaticChild::$trait_choice !== 'outer' || VCombinedStaticChild::$trait_nullable !== 13
            || !(VCombinedStaticChild::$trait_dnf instanceof ArrayObject)) {
            throw new RuntimeException('The request lost the outer compound property values');
        }
    }
})();
