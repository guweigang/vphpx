<?php
declare(strict_types=1);

$reflection = new ReflectionMethod(VStaticReferenceStorage::class, 'staticStorageReference');
if (!$reflection->returnsReference() || !$reflection->isStatic() || (string) $reflection->getReturnType() !== 'mixed') {
    throw new RuntimeException('Unexpected static storage reference signature');
}
if (!extension_loaded('reference_property_contracts')) {
    return;
}

class ReferenceStaticBase extends VStaticReferenceStorage
{
    public static int $counter = 11;
    public static ?int $nullable;
    public static int $required;
    protected static int $guarded = 7;
    private static int $hidden = 13;

    public static function &nativeStaticReference(string $name): mixed
    {
        return static::$$name;
    }
}

class ReferenceStaticInherited extends ReferenceStaticBase {}

class ReferenceStaticSeparate extends ReferenceStaticBase
{
    public static int $counter = 17;
}

class ReferenceStaticShadowChild extends VStaticReferenceShadow
{
    public static int $mirrored = 23;
}

$base =& ReferenceStaticBase::staticStorageReference('counter');
$inherited =& ReferenceStaticInherited::staticStorageReference(name: 'counter');
$separate =& ReferenceStaticSeparate::staticStorageReference('counter');
$instance = new ReferenceStaticSeparate();
$late =& $instance->lateStaticReference('counter');
$inherited = 29;
$late = 31;
if ($base !== 29 || ReferenceStaticBase::$counter !== 29 || ReferenceStaticInherited::$counter !== 29
    || $separate !== 31 || ReferenceStaticSeparate::$counter !== 31) {
    throw new RuntimeException('Static storage references did not honor the called class');
}

$nullable =& ReferenceStaticBase::staticStorageReference('nullable');
if ($nullable !== null) {
    throw new RuntimeException('A nullable static property did not initialize to null');
}
$nullable = 37;
try {
    $nullable = [];
    throw new RuntimeException('A static storage reference lost its typed property constraint');
} catch (TypeError $error) {
    if (ReferenceStaticBase::$nullable !== 37 || !str_contains($error->getMessage(), 'reference held by property')) {
        throw $error;
    }
}
$nullable = 41;
if (ReferenceStaticInherited::$nullable !== 41) {
    throw new RuntimeException('A static type error broke the inherited reference');
}

expectStorageReferenceError(static fn () => ReferenceStaticBase::staticStorageReference('required'), 'uninitialized non-nullable property');

$guarded =& ReferenceStaticInherited::staticStorageReference('guarded');
$nativeGuarded =& ReferenceStaticBase::nativeStaticReference('guarded');
$guarded = 43;
if ($nativeGuarded !== 43) {
    throw new RuntimeException('The VPHP method did not borrow the protected slot visible to the parent scope');
}
$nativeHidden =& ReferenceStaticInherited::nativeStaticReference('hidden');
$nativeHidden = 47;
expectStorageReferenceError(static fn () => ReferenceStaticBase::staticStorageReference('hidden'), 'Cannot access private property');
if ($nativeHidden !== 47) {
    throw new RuntimeException('A denied reference changed the private static slot');
}
expectStorageReferenceError(static fn () => ReferenceStaticBase::staticStorageReference('missing'), 'expected a writable PHP static storage property');
expectStorageReferenceError(static fn () => staticReferenceWithoutScope(), 'active class method');
expectStorageReferenceError(static fn () => VStaticReferenceShadow::shadowReference(), 'expected a writable PHP static storage property');
expectStorageReferenceError(static fn () => ReferenceStaticShadowChild::shadowReference(), 'expected a writable PHP static storage property');
if (VStaticReferenceShadow::$mirrored !== 17 || ReferenceStaticShadowChild::$mirrored !== 23) {
    throw new RuntimeException('The static reference helper modified a V shadow table property');
}

if (PHP_VERSION_ID >= 80500) {
    $restricted =& VStaticReferenceStorageChild::staticStorageReference('restricted');
    if ($restricted !== 19) {
        throw new RuntimeException('Declaring class could not bind its private(set) static property');
    }
    $restricted = 43;
    expectStorageReferenceError(VStaticReferenceStorageChild::borrowRestrictedStatic(...), 'private(set)');
    if (VStaticReferenceStorage::$restricted !== 43) {
        throw new RuntimeException('Unexpected private(set) static storage after a denied reference');
    }
} elseif (property_exists(VStaticReferenceStorage::class, 'restricted')) {
    throw new RuntimeException('Asymmetric static storage appeared before PHP 8.5');
}

$root =& VStaticReferenceStorage::staticStorageReference('counter');
$root = 57;
$failure = new DomainException('end ordinary static request');
foreach ([false, true] as $fails) {
    try {
        vphp_reference_property_contracts_with_static_request(static function () use ($fails, $failure, &$root, &$base, &$separate): void {
            if ([VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, ReferenceStaticSeparate::$counter] !== [0, 11, 17]) {
                throw new RuntimeException('Logical request did not start with ordinary static defaults');
            }
            if (PHP_VERSION_ID >= 80500 && VStaticReferenceStorage::$restricted !== 19) {
                throw new RuntimeException('Logical request did not reset a version-gated static property');
            }
            $requestRoot =& VStaticReferenceStorage::staticStorageReference('counter');
            $requestShared =& ReferenceStaticInherited::staticStorageReference('counter');
            $requestSeparate =& ReferenceStaticSeparate::staticStorageReference('counter');
            [$requestRoot, $requestShared, $requestSeparate] = [61, 67, 71];
            [$root, $base, $separate] = [73, 79, 83];

            vphp_reference_property_contracts_with_static_request(static function () use (&$requestShared): void {
                if ([VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, ReferenceStaticSeparate::$counter] !== [0, 11, 17]) {
                    throw new RuntimeException('Nested logical request did not reset ordinary statics');
                }
                $nested =& ReferenceStaticBase::staticStorageReference('counter');
                $nested = 89;
                $requestShared = 97;
            });
            if ([$requestRoot, $requestShared, $requestSeparate, ReferenceStaticBase::$counter] !== [61, 67, 71, 67]) {
                throw new RuntimeException('Nested scope lost an ordinary static reference');
            }
            if ($fails) {
                throw $failure;
            }
        });
        if ($fails) {
            throw new RuntimeException('The ordinary static request lost its exception');
        }
    } catch (DomainException $error) {
        if (!$fails || $error !== $failure) {
            throw $error;
        }
    }
    if ([$root, $base, $separate, VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, ReferenceStaticSeparate::$counter]
        !== [57, 29, 31, 57, 29, 31]) {
        throw new RuntimeException('Ordinary static properties did not restore their outer references');
    }
}
$inherited = 101;
if ($base !== 101 || ReferenceStaticInherited::$counter !== 101 || ReferenceStaticSeparate::$counter !== 31) {
    throw new RuntimeException('The outer ordinary static reference was detached');
}

(static function (DomainException $failure): void {
    $shared = 103;
    VStaticReferenceStorage::$counter =& $shared;
    ReferenceStaticBase::$counter =& $shared;
    $outerAlias =& ReferenceStaticInherited::staticStorageReference('counter');
    foreach ([false, true] as $fails) {
        $requestAlias = null;
        $destructorStates = [];
        vphp_reference_property_contracts_with_static_request(static function () use ($fails, $failure, &$shared, &$requestAlias, &$destructorStates): void {
            $requestAlias = 107;
            VStaticReferenceStorage::$counter =& $requestAlias;
            ReferenceStaticBase::$counter =& $requestAlias;
            try {
                vphp_reference_property_contracts_with_static_request(static function () use ($fails, $failure, &$shared, &$requestAlias, &$destructorStates): void {
                    if ([VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter] !== [0, 11]) {
                        throw new RuntimeException('The nested request inherited the shared reference');
                    }
                    VStaticReferenceStorage::$counter =& $requestAlias;
                    ReferenceStaticBase::$counter =& $shared;
                    $requestAlias = 109;
                    $shared = 113;
                    VStaticReferenceStorage::$payload = new class($destructorStates, $requestAlias, $fails) {
                        public function __construct(private array &$states, private int &$alias, private bool $fails) {}

                        public function __destruct()
                        {
                            $this->states[] = [VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, VStaticReferenceStorage::$payload];
                            $failure = new DomainException('fail in a scope started by the destructor');
                            try {
                                vphp_reference_property_contracts_with_static_request(function () use ($failure): void {
                                    $this->states[] = [VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, VStaticReferenceStorage::$payload];
                                    VStaticReferenceStorage::$counter =& $this->alias;
                                    VStaticReferenceStorage::$counter = 139;
                                    if ($this->fails) {
                                        throw $failure;
                                    }
                                });
                                if ($this->fails) {
                                    throw new RuntimeException('Destructor reentry swallowed its exception');
                                }
                            } catch (DomainException $error) {
                                if (!$this->fails || $error !== $failure || $error->getPrevious() !== null) {
                                    throw new RuntimeException('Destructor reentry changed its exception chain', previous: $error);
                                }
                            }
                            $this->states[] = [VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter, $this->alias];
                        }
                    };
                    if ($fails) {
                        throw $failure;
                    }
                });
                if ($fails) {
                    throw new RuntimeException('The nested request swallowed the exception');
                }
            } catch (DomainException $error) {
                if (!$fails || $error !== $failure) {
                    throw $error;
                }
            }

            if ($destructorStates !== [[107, 107, null], [0, 11, null], [107, 107, 107]]) {
                throw new RuntimeException('A destructor or its nested request observed incorrect static properties');
            }
            $requestAlias = 127;
            if ([VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter] !== [127, 127]) {
                throw new RuntimeException('The nested request broke the shared reference');
            }
            try {
                $requestAlias = 'invalid';
                throw new RuntimeException('The nested request lost the shared reference type constraints');
            } catch (TypeError) {
            }
        });
        if ([$shared, $outerAlias, VStaticReferenceStorage::$counter, ReferenceStaticBase::$counter] !== [103, 103, 103, 103]) {
            throw new RuntimeException('The outer shared reference was not restored');
        }
        $requestAlias = 'released';
        $outerAlias = 131;
        if ([$shared, VStaticReferenceStorage::$counter, ReferenceStaticInherited::$counter] !== [131, 131, 131]) {
            throw new RuntimeException('The outer aliases were detached');
        }
        $outerAlias = 103;
    }
})($failure);

(static function (): void {
    $callbackFailure = new DomainException('request failed before cleanup');
    $cleanupFailure = new DomainException('cleanup failed during request exit');
    try {
        vphp_reference_property_contracts_with_static_request(static function () use ($callbackFailure, $cleanupFailure): never {
            VStaticReferenceStorage::$payload = new class($cleanupFailure) {
                public function __construct(private DomainException $failure) {}

                public function __destruct()
                {
                    throw $this->failure;
                }
            };
            throw $callbackFailure;
        });
        throw new RuntimeException('Request cleanup swallowed both exceptions');
    } catch (DomainException $error) {
        if ($error !== $cleanupFailure || $error->getPrevious() !== $callbackFailure
            || VStaticReferenceStorage::$payload !== null) {
            throw new RuntimeException('Request cleanup changed exception chaining or left its static value behind', previous: $error);
        }
    }
})();
