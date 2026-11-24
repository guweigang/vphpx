<?php
declare(strict_types=1);

class VCombinedSignatureConsumer
{
    use VCombinedSignatureRequirements;

    public function selectValue(string|int $value): (Countable&ArrayAccess)|int
    {
        return is_int($value) ? $value : new ArrayObject([$value]);
    }

    public function numericValue(int $value): int
    {
        return $value;
    }
}

$select = new ReflectionMethod(VCombinedSignatureRequirements::class, 'selectValue');
$numeric = new ReflectionMethod(VCombinedSignatureRequirements::class, 'numericValue');
if (!$select->isAbstract() || !$numeric->isAbstract()
    || composedStaticPropertyType($select->getParameters()[0]->getType()) !== 'int|string'
    || composedStaticPropertyType($select->getReturnType()) !== '(ArrayAccess&Countable)|int'
    || (string) $numeric->getParameters()[0]->getType() !== 'int'
    || (string) $numeric->getReturnType() !== 'int') {
    throw new RuntimeException('The composed requirements changed their exported signatures');
}

$signatureConsumer = new VCombinedSignatureConsumer();
if ($signatureConsumer->selectValue(value: 7) !== 7
    || $signatureConsumer->selectValue(value: 'value')[0] !== 'value'
    || $signatureConsumer->numericValue(value: 11) !== 11) {
    throw new RuntimeException('The composed requirements changed PHP named calls');
}
