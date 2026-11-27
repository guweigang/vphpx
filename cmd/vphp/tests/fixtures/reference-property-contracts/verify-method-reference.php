<?php
declare(strict_types=1);

if ($mode === '--value-method-interface' || $mode === '--value-method-abstract') {
    $parent = $mode === '--value-method-interface' ? 'implements RefMethodContract' : 'extends RefMethodBase';
    eval("class PhpValueRefMethod $parent { public function slot(mixed &\$value): mixed { return \$value; } }");
    exit;
}

class PhpRefMethodImplementation extends RefMethodBase implements RefMethodContract
{
    public function &slot(mixed &$value): mixed
    {
        return $value;
    }
}

class PhpTraitRefMethodImplementation extends RefMethodBase implements RefMethodContract
{
    use ComposedRefMethodTrait;
}

foreach ([
    [RefMethodContract::class, 'slot', true],
    [RefMethodBase::class, 'slot', true],
    [RefMethodImplementation::class, 'slot', false],
    [RefMethodTrait::class, 'slot', false],
    [ComposedRefMethodTrait::class, 'trait_slot', false],
    [PhpRefMethodImplementation::class, 'slot', false],
    [PhpTraitRefMethodImplementation::class, 'slot', false],
    [PhpTraitRefMethodImplementation::class, 'trait_slot', false],
] as [$class, $name, $abstract]) {
    $method = new ReflectionMethod($class, $name);
    if ($method->isAbstract() !== $abstract || !$method->returnsReference() || (string) $method->getReturnType() !== 'mixed'
        || $method->getNumberOfParameters() !== 1 || !$method->getParameters()[0]->isPassedByReference()
        || $method->getParameters()[0]->getName() !== 'value') {
        throw new RuntimeException("Unexpected method contract for $class::$name");
    }
}
foreach ([RefMethodImplementation::class, PhpRefMethodImplementation::class, PhpTraitRefMethodImplementation::class] as $class) {
    if (!is_a($class, RefMethodContract::class, true) || !is_subclass_of($class, RefMethodBase::class)) {
        throw new RuntimeException("Missing reference return contract on $class");
    }
}
$targets = [new PhpRefMethodImplementation()];
if (extension_loaded('reference_property_contracts')) {
    $targets[] = new RefMethodImplementation();
    $targets[] = new PhpTraitRefMethodImplementation();
}
foreach ($targets as $target) {
    $value = 11;
    $alias =& $target->slot(value: $value);
    if ($target instanceof PhpTraitRefMethodImplementation) {
        $traitAlias =& $target->trait_slot(value: $value);
        $traitAlias = 13;
        if ($alias !== 13 || $value !== 13) {
            throw new RuntimeException('The composed trait alias lost the original reference');
        }
        unset($traitAlias);
    }
    $alias = 19;
    if ($value !== 19) {
        throw new RuntimeException('The method lost its reference return');
    }
    unset($alias);
}
