<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\alias;
use function VPHP\ReferenceProbe\checkedAlias;
use function VPHP\ReferenceProbe\compoundAlias;
use function VPHP\ReferenceProbe\invalidAlias;

foreach ([
    [new ReflectionFunction('VPHP\\ReferenceProbe\\alias'), 'mixed'],
    [new ReflectionFunction('VPHP\\ReferenceProbe\\checkedAlias'), 'int'],
    [new ReflectionFunction('VPHP\\ReferenceProbe\\compoundAlias'), '(Iterator&Countable)|int'],
    [new ReflectionFunction('VPHP\\ReferenceProbe\\invalidAlias'), 'mixed'],
    [new ReflectionMethod(RefReturnBox::class, 'staticAlias'), 'mixed'],
    [new ReflectionMethod(RefReturnChild::class, 'compoundMethod'), '(Iterator&Countable)|int'],
] as [$reflection, $type]) {
    if (!$reflection->returnsReference() || (string) $reflection->getReturnType() !== $type) {
        throw new RuntimeException("Unexpected reference return signature on {$reflection->getName()}");
    }
    if ($reflection->getNumberOfParameters() && !$reflection->getParameters()[0]->isPassedByReference()) {
        throw new RuntimeException("Reference return changed the reference parameter on {$reflection->getName()}");
    }
}
$method = new ReflectionMethod(RefReturnChild::class, 'compoundMethod');
if ((string) $method->getParameters()[0]->getType() !== '(Iterator&Countable)|int'
    || $method->getPrototype()->getDeclaringClass()->getName() !== RefReturnBox::class) {
    throw new RuntimeException('Compound reference method has an unexpected inherited signature');
}

// Generated function and static method stubs have empty bodies.
if (!extension_loaded('reference_property_contracts')) {
    return;
}

$value = 5;
$direct =& alias(value: $value);
$direct = 7;
$checked =& checkedAlias(fail: false, value: $value);
$checked = 9;
$compound =& compoundAlias($value);
$compound = 11;
$static =& RefReturnBox::staticAlias(value: $value);
$static = 13;
if ($value !== 13 || $direct !== 13 || $checked !== 13 || $compound !== 13) {
    throw new RuntimeException('Reference aliases did not reach the caller');
}
$byValue = alias($value);
$byValue = 15;
if ($value !== 13) {
    throw new RuntimeException('An ordinary call unexpectedly bound a reference');
}

$object = new ArrayIterator();
$objectAlias =& compoundAlias($object);
$objectAlias = new ArrayIterator([1]);
if ($object !== $objectAlias || count($object) !== 1) {
    throw new RuntimeException('Compound reference return lost the original object slot');
}
$box = new RefReturnChild();
$methodAlias =& $box->compoundMethod($object);
$methodAlias = 17;
if ($object !== 17 || $objectAlias !== 17) {
    throw new RuntimeException('Inherited compound reference method lost the caller slot');
}

$wrong = [];
try {
    checkedAlias($wrong, false);
    throw new RuntimeException('A non-int passed reference return validation');
} catch (TypeError $error) {
    if ($wrong !== [] || !str_contains($error->getMessage(), 'Return value must be of type int')) {
        throw $error;
    }
}

try {
    checkedAlias($value, true);
    throw new RuntimeException('The V reference return error was ignored');
} catch (Exception $error) {
    if ($error->getMessage() !== 'reference callback failed') {
        throw $error;
    }
}

try {
    invalidAlias();
    throw new RuntimeException('An invalid PhpReference passed return validation');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'invalidAlias() must return a reference')) {
        throw $error;
    }
}
