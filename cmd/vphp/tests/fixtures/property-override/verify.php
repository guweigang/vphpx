<?php

if (($argv[1] ?? '') === '--unmatched-interface') {
    interface PropertyOverrideContract {}
    try {
        new PropertyOverrideImplementation();
    } catch (Error $error) {
        if (str_contains($error->getMessage(), 'no matching parent property exists')) {
            echo $error->getMessage(), PHP_EOL;
            exit(0);
        }
        throw $error;
    }
    throw new RuntimeException('Accepted an interface without the matching property');
}

if (PHP_VERSION_ID >= 80500) {
    eval('interface PropertyOverrideContractBase { public string $label { get; set; } }');
    interface PropertyOverrideContract extends PropertyOverrideContractBase {}
}

if (isset($argv[1])) {
    require $argv[1];
}

$child = new PropertyOverrideChild();
$child->current = 27;
PropertyOverrideChild::$shared = 35;
$contract = new PropertyOverrideImplementation();
$contract->label = 'matched';
if ($child->current !== 27 || PropertyOverrideChild::$shared !== 35 || $contract->label !== 'matched') {
    throw new RuntimeException('Unexpected overriding property values');
}
if (PHP_VERSION_ID >= 80500 && !$contract instanceof PropertyOverrideContract) {
    throw new RuntimeException('The interface property contract was not bound');
}

foreach ([
    [PropertyOverrideChild::class, 'current', 'int', false],
    [PropertyOverrideChild::class, 'shared', 'int', true],
    [PropertyOverrideImplementation::class, 'label', 'string', false],
] as [$class, $name, $type, $static]) {
    $property = new ReflectionProperty($class, $name);
    $attributes = $property->getAttributes(Override::class);
    if ($property->getDeclaringClass()->getName() !== $class
        || (string) $property->getType() !== $type || $property->isStatic() !== $static
        || (PHP_VERSION_ID >= 80500
            ? count($attributes) !== 1 || $attributes[0]->getArguments() !== []
                || !($attributes[0]->newInstance() instanceof Override)
            : $attributes !== [])) {
        throw new RuntimeException("Unexpected Override metadata for $class::\$$name");
    }
}
