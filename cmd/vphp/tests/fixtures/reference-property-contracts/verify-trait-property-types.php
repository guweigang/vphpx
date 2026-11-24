<?php
declare(strict_types=1);

trait NativePropertyTypePeer
{
    public mixed $typed_slot;
    public $untyped_slot;
}

class DirectPropertyTypeTraitConsumer
{
    use VPropertyTypeTraitA, VPropertyTypeTraitB, NativePropertyTypePeer;
}

class CombinedPropertyTypeTraitConsumer
{
    use VCombinedPropertyTypeTraits;
}

(static function (): void {
    foreach ([new DirectPropertyTypeTraitConsumer(), new CombinedPropertyTypeTraitConsumer()] as $consumer) {
        $typed = new ReflectionProperty($consumer, 'typed_slot');
        $untyped = new ReflectionProperty($consumer, 'untyped_slot');
        if (!$typed->hasType() || (string) $typed->getType() !== 'mixed' || $typed->hasDefaultValue()
            || $typed->isInitialized($consumer) || $untyped->hasType() || !$untyped->isInitialized($consumer)) {
            throw new RuntimeException('Composing a trait changed whether a PHP property has an explicit type');
        }

        $consumer->typed_slot = [7];
        $consumer->untyped_slot = 11;
        if ($consumer->typed_slot !== [7] || $consumer->untyped_slot !== 11) {
            throw new RuntimeException('Composing a trait changed PHP property access');
        }
    }
})();
