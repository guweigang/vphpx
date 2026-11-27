<?php
declare(strict_types=1);

class DirectConstantTraitConsumer
{
    use VConstantTraitA, VConstantTraitB;
}

class CombinedConstantTraitConsumer
{
    use VCombinedConstantTraits;
}

(static function (): void {
    foreach ([DirectConstantTraitConsumer::class, CombinedConstantTraitConsumer::class] as $class) {
        foreach ([
            'LIMIT' => [16, 'int'],
            'RATIO' => [1.25, 'float'],
            'MODE' => [VTraitConstantCase::ready, VTraitConstantCase::class],
        ] as $name => [$value, $type]) {
            $constant = new ReflectionClassConstant($class, $name);
            if ($constant->getValue() !== $value || constant($class . '::' . $name) !== $value
                || $constant->getDeclaringClass()->getName() !== $class || !$constant->isPublic()) {
                throw new RuntimeException("Unexpected composed trait constant $class::$name");
            }
            if (PHP_VERSION_ID >= 80300 && (!$constant->hasType() || (string) $constant->getType() !== $type)) {
                throw new RuntimeException("Unexpected composed trait constant type for $class::$name");
            }
        }
    }
})();
