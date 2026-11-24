<?php
declare(strict_types=1);

foreach ([
    'referenceStructClosure', 'checkedReferenceStructClosure',
    'referenceVariadicClosure', 'checkedReferenceVariadicClosure',
    'directStructReferenceClosure', 'directVariadicReferenceClosure', 'updateVariadicReferenceClosure',
] as $factory) {
    $reflection = new ReflectionFunction($factory);
    if ($reflection->returnsReference() || $reflection->getNumberOfParameters() !== 0) {
        throw new RuntimeException("Incorrect exported closure factory signature: $factory");
    }
}

if (!extension_loaded('reference_property_contracts')) {
    return;
}

$structured = referenceStructClosure();
$checkedStructured = checkedReferenceStructClosure();
$variadic = referenceVariadicClosure();
$checkedVariadic = checkedReferenceVariadicClosure();
foreach ([$structured, $checkedStructured] as $structCallback) {
    $reflection = new ReflectionFunction($structCallback);
    [$bagParameter, $failParameter] = $reflection->getParameters();
    if (!$reflection->returnsReference() || (string) $reflection->getReturnType() !== 'mixed'
        || $reflection->getNumberOfRequiredParameters() !== 1
        || $bagParameter->getName() !== 'bag' || (string) $bagParameter->getType() !== 'array'
        || !$failParameter->isOptional() || $failParameter->getDefaultValue() !== false) {
        throw new RuntimeException('Incorrect arginfo on reference struct closure');
    }
}
foreach ([$variadic, $checkedVariadic] as $varCallback) {
    $reflection = new ReflectionFunction($varCallback);
    if (!$reflection->returnsReference() || (string) $reflection->getReturnType() !== 'mixed'
        || !$reflection->isVariadic() || $reflection->getNumberOfRequiredParameters() !== 0
        || $reflection->getNumberOfParameters() !== 1 || $reflection->getParameters()[0]->getName() !== 'args') {
        throw new RuntimeException('Incorrect arginfo on reference variadic closure');
    }
}

$value = 11;
$bag = ['score' => &$value];
$byReference =& $structured(bag: $bag);
$byCheckedReference =& $checkedStructured(fail: false, bag: $bag);
$byVariadicReference =& $variadic($bag, 1, 2);
$byCheckedVariadicReference =& $checkedVariadic($bag);
$byReference = 13;
$byCheckedReference = 17;
$byVariadicReference = 19;
$byCheckedVariadicReference = 23;
if ($value !== 23 || $byReference !== 23 || $byCheckedReference !== 23 || $byVariadicReference !== 23) {
    throw new RuntimeException('Reference closures did not preserve one caller slot');
}
$byValue = $structured($bag);
$byValue = 5;
if ($value !== 23) {
    throw new RuntimeException('An ordinary closure call unexpectedly bound a reference');
}
$fromInvoke =& $checkedStructured->__invoke($bag);
$fromInvoke = 27;
if ($value !== 27 || $byReference !== 27) {
    throw new RuntimeException('Closure::__invoke() did not preserve the caller slot');
}

foreach ([
    [static fn () => $structured(['score' => 11]), Error::class, 'must return a reference'],
    [static fn () => $variadic(), Error::class, 'must return a reference'],
    [static fn () => $checkedStructured(bag: $bag, fail: true), Exception::class, 'struct reference callback failed'],
    [static fn () => $checkedVariadic(), Exception::class, 'variadic reference callback requires a bag'],
    [static fn () => $structured(123), TypeError::class, 'argument 1 (bag)'],
] as [$call, $class, $message]) {
    try {
        $call();
        throw new RuntimeException("Expected $class containing $message");
    } catch (Throwable $error) {
        if ($error::class !== $class || !str_contains($error->getMessage(), $message)) {
            throw $error;
        }
    }
}
$byReference = 29;
if ($value !== 29) {
    throw new RuntimeException('A failed closure call destroyed the caller reference');
}

$structReferenceParams = directStructReferenceClosure();
$variadicReferenceParams = directVariadicReferenceClosure();
$updateVariadic = updateVariadicReferenceClosure();
$reflection = new ReflectionFunction($structReferenceParams);
[$valueParameter, $otherParameter, $stepParameter] = $reflection->getParameters();
if (!$reflection->returnsReference() || $reflection->getNumberOfRequiredParameters() !== 1
    || !$valueParameter->isPassedByReference() || !$otherParameter->isPassedByReference()
    || $stepParameter->isPassedByReference() || (string) $valueParameter->getType() !== 'mixed'
    || !$otherParameter->isOptional() || $otherParameter->getDefaultValue() !== null
    || $stepParameter->getDefaultValue() !== 3) {
    throw new RuntimeException('Incorrect reference parameter metadata on struct closure');
}
foreach ([[$variadicReferenceParams, true], [$updateVariadic, false]] as [$callback, $returnsReference]) {
    $reflection = new ReflectionFunction($callback);
    if ($reflection->returnsReference() !== $returnsReference || !$reflection->isVariadic()
        || $reflection->getNumberOfRequiredParameters() !== 0 || $reflection->getNumberOfParameters() !== 1
        || !$reflection->getParameters()[0]->isPassedByReference()) {
        throw new RuntimeException('Incorrect reference parameter metadata on variadic closure');
    }
}

$value = 7;
$alternate = null;
$alias =& $structReferenceParams(value: $value);
if ($value !== 10 || $alias !== 10) {
    throw new RuntimeException('Struct closure did not write through its reference parameter');
}
$withOptional =& $structReferenceParams(step: 4, other: $alternate, value: $value);
if ($value !== 14 || $alternate !== 100 || $alias !== 14 || $withOptional !== 14) {
    throw new RuntimeException('Named reference parameter lost its original slot');
}
$structReferenceParams(step: 2, value: $value);
if ($value !== 16 || $alternate !== 100) {
    throw new RuntimeException('An omitted named reference parameter mutated a previous caller slot');
}

$variadicAlias =& $variadicReferenceParams($value, $alternate, $value);
if ($value !== 18 || $alternate !== 101 || $variadicAlias !== 18) {
    throw new RuntimeException('Variadic reference parameters did not preserve repeated aliases');
}
$invokeAlias =& $variadicReferenceParams->__invoke($alternate, $value);
$invokeAlias = 103;
if ($value !== 19 || $alias !== 19 || $alternate !== 103) {
    throw new RuntimeException('Closure::__invoke() did not preserve reference parameters');
}
if ($updateVariadic() !== null || $updateVariadic($value, $alternate) !== null || $value !== 20 || $alternate !== 104) {
    throw new RuntimeException('A void variadic closure lost its reference parameters');
}

foreach ([static fn () => $structReferenceParams(1), static fn () => $variadicReferenceParams(1)] as $invalid) {
    try {
        $invalid();
        throw new RuntimeException('A literal was accepted as a reference argument');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'be passed by reference')) {
            throw $error;
        }
    }
}
try {
    $updateVariadic(extra: $value);
    throw new RuntimeException('An unknown named variadic reference was silently ignored');
} catch (Error $error) {
    if (!preg_match('/named (?:parameter|variadic arguments)/', $error->getMessage())) {
        throw $error;
    }
}
try {
    $variadicReferenceParams();
    throw new RuntimeException('The callback accepted no reference arguments');
} catch (Exception $error) {
    if ($error->getMessage() !== 'reference closure needs a variable') {
        throw $error;
    }
}
$variadicAlias = 25;
if ($value !== 25 || $withOptional !== 25 || $alternate !== 104) {
    throw new RuntimeException('The returned alias no longer points to the same variable');
}
