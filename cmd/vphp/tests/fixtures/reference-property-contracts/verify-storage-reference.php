<?php
declare(strict_types=1);

$method = new ReflectionMethod(ZendReferenceStorage::class, 'storageReference');
if (!$method->returnsReference() || (string) $method->getReturnType() !== 'mixed') {
    throw new RuntimeException('Unexpected storage reference signature');
}
if (!extension_loaded('reference_property_contracts')) {
    return;
}

#[AllowDynamicProperties]
class ReferenceStorageUserChild extends ZendReferenceStorage
{
    public static int $shared = 17;
    public ?int $nullable;
    public int $required;
}

$target = new ReferenceStorageUserChild();
$target->dynamic = 19;
$stored =& $target->storageReference(name: 'stored');
$hidden =& $target->storageReference('hidden');
$nullable =& $target->storageReference('nullable');
if ($stored !== 11 || $hidden !== 0 || $nullable !== null) {
    throw new RuntimeException('Unexpected value in declared storage reference');
}
$stored = 23;
$hidden = 29;
$nullable = 31;
if ($target->stored !== 23 || $target->nullable !== 31 || $target->storageReference('hidden') !== 29) {
    throw new RuntimeException('Reference did not write through to its PHP property');
}
try {
    $nullable = [];
    throw new RuntimeException('The property lost its type source after binding');
} catch (TypeError $error) {
    if ($target->nullable !== 31) {
        throw $error;
    }
}

function expectStorageReferenceError(Closure $operation, string $message): void
{
    try {
        $operation();
        throw new RuntimeException("Expected property reference error containing $message");
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), $message)) {
            throw $error;
        }
    }
}

foreach (['missing', 'dynamic', 'mirrored', 'locked', 'shared'] as $unsupported) {
    expectStorageReferenceError(static fn () => $target->storageReference($unsupported), 'expected a writable PHP storage property');
}
expectStorageReferenceError(static fn () => $target->storageReference('required'), 'uninitialized non-nullable property');
expectStorageReferenceError(static fn () => referenceWithoutReceiver(), 'active instance method');
if ($target->dynamic !== 19 || $target->mirrored !== 0 || property_exists($target, 'missing')
    || (new ReflectionProperty($target, 'required'))->isInitialized($target)
    || (new ReflectionProperty($target, 'locked'))->isInitialized($target)) {
    throw new RuntimeException('An invalid storage lookup changed the object');
}

if (PHP_VERSION_ID >= 80400) {
    eval('class ReferenceStorageHookedChild extends ZendReferenceStorage {
        public int $calls = 0;
        public int $hooked { get => ++$this->calls; set { ++$this->calls; } }
    }');
    $hooked = new ReferenceStorageHookedChild();
    expectStorageReferenceError(static fn () => $hooked->storageReference('hooked'), 'expected a writable PHP storage property');
    if ($hooked->calls !== 0) {
        throw new RuntimeException('Storage lookup invoked a PHP property hook');
    }
    foreach ([new VPrivateRefInterfaceChild(), new VPrivateRefAbstractChild()] as $child) {
        $reference =& $child->scoreReference();
        $reference = 37;
        expectStorageReferenceError($child->borrowPrivateScore(...), 'private(set)');
        if ($child->score !== 37) {
            throw new RuntimeException('Binding from a child method changed its private(set) property');
        }
        unset($reference);
    }
}
