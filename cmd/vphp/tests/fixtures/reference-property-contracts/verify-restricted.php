<?php
declare(strict_types=1);

if (str_starts_with($mode, '--restricted-')) {
    [, , , $access, $contract] = explode('-', $mode);
    $parent = $contract === 'interface' ? 'implements RefPropertyContract' : 'extends AbstractRefReadWrite';
    $modifier = $access === 'readonly' ? 'readonly' : 'protected(set)';
    eval("class PhpRestrictedRef $parent { public $modifier int \$score; }");
    exit;
}

if (PHP_VERSION_ID < 80400) {
    foreach ([RefGetContract::class, AbstractRefReadWrite::class, VProtectedRefInterface::class,
        VProtectedRefAbstract::class, VPrivateRefInterface::class, VPrivateRefAbstract::class,
        VPrivateRefInterfaceChild::class, VPrivateRefAbstractChild::class] as $class) {
        if ((!class_exists($class) && !interface_exists($class)) || property_exists($class, 'score')) {
            throw new RuntimeException("Unexpected PHP 8.2–8.3 property declaration on $class");
        }
    }
    foreach ([VReadonlyRefInterface::class, VReadonlyRefAbstract::class] as $class) {
        if (!(new ReflectionProperty($class, 'score'))->isReadOnly()) {
            throw new RuntimeException("Missing ordinary readonly property on $class");
        }
    }
    return;
}

foreach ([RefGetContract::class => ['get'], AbstractRefReadWrite::class => ['get', 'set']] as $class => $operations) {
    $hooks = (new ReflectionProperty($class, 'score'))->getHooks();
    if (array_keys($hooks) !== $operations || !$hooks['get']->returnsReference()) {
        throw new RuntimeException("Unexpected reference contract on $class");
    }
}

class PhpReadonlyRefInterface implements RefGetContract
{
    public readonly int $score;
}

class PhpReadonlyRefAbstract extends AbstractRefProperty
{
    public readonly int $score;
}

$probeMethods = privateScoreProbeMethods();
$parentProbe = $probeMethods['checkPrivateScope'] . $probeMethods['sharePrivateScore'] . $probeMethods['scoreReference'];
eval('class PhpProtectedRefInterface implements RefGetContract { public protected(set) int $score = 12; }
      class PhpProtectedRefAbstract extends AbstractRefProperty { public protected(set) int $score = 12; }
      class PhpPrivateRefInterface implements RefGetContract { public private(set) int $score = 13; ' . $parentProbe . ' }
      class PhpPrivateRefAbstract extends AbstractRefProperty { public private(set) int $score = 13; ' . $parentProbe . ' }');

$privateClasses = [
    VPrivateRefInterface::class, VPrivateRefAbstract::class,
    PhpPrivateRefInterface::class, PhpPrivateRefAbstract::class,
];
foreach ($privateClasses as $class) {
    if ($mode === "--redeclaration-$class") {
        eval("class PrivateRefRedeclaration extends $class { public int \$score = 1; }");
        exit;
    }
}

function expectRestrictedPropertyError(Closure $operation, string $message): void
{
    try {
        $operation();
    } catch (Error $error) {
        if (str_contains($error->getMessage(), $message)) {
            return;
        }
        throw $error;
    }
    throw new RuntimeException("Expected Error containing $message");
}

function verifyRestrictedRefProperty(string $class, string $restriction): object
{
    $readonly = $restriction === 'readonly';
    $private = $restriction === 'private(set)';
    $initial = $private ? 13 : 12;
    $property = new ReflectionProperty($class, 'score');
    if (!$property->isPublic() || $property->isProtectedSet() === $private || $property->isPrivateSet() !== $private
        || $property->isFinal() !== $private || $property->isReadOnly() !== $readonly
        || $property->isVirtual() || $property->isAbstract() || $property->getHooks() !== []
        || (string) $property->getType() !== 'int' || $property->getDeclaringClass()->getName() !== $class
        || $property->hasDefaultValue() === $readonly || (!$readonly && $property->getDefaultValue() !== $initial)) {
        throw new RuntimeException("Unexpected restricted property metadata on $class");
    }
    $object = new $class();
    if ($readonly) {
        $property->setValue($object, 12);
    }
    expectRestrictedPropertyError(fn () => $object->score = 3, "Cannot modify $restriction property");
    expectRestrictedPropertyError(function () use ($object) {
        $reference =& $object->score;
    }, "Cannot indirectly modify $restriction property");
    if ($object->score !== $initial) {
        throw new RuntimeException("Restricted property was changed on $class");
    }
    return $object;
}

function expectScoreReferenceTypeError(array &$aliases, string $class): void
{
    try {
        $aliases['score'] = [];
        throw new RuntimeException("Reference lost its int type on $class");
    } catch (TypeError $error) {
        if (!str_contains($error->getMessage(), 'Cannot assign array to reference held by property')) {
            throw $error;
        }
    }
}

function verifyPrivateScoreRoundTrip(object $source, object $copy, array $aliases): void
{
    $class = $source::class;
    $initial = $source->score;
    $originalReference = ReflectionReference::fromArrayElement($aliases, 'score')->getId();
    [$restored, $restoredCopy, $restoredAliases] = unserialize(serialize([$source, $copy, $aliases]));
    if ($restored::class !== $class || $restoredCopy::class !== $class
        || $restored === $source || $restoredCopy === $copy || $restored === $restoredCopy
        || $restored->score !== $initial || $restoredCopy->score !== $initial || $restoredAliases['score'] !== $initial) {
        throw new RuntimeException("Round trip did not restore both child objects on $class");
    }

    // Check the serialized reference before calling a method that could bind one.
    $restoredReference = ReflectionReference::fromArrayElement($restoredAliases, 'score');
    if ($restoredReference === null || $restoredReference->getId() === $originalReference) {
        throw new RuntimeException("Round trip did not create a distinct reference on $class");
    }
    $restoredAliases['score'] = 41;
    if ($restored->score !== 41 || $restoredCopy->score !== 41
        || $source->score !== $initial || $copy->score !== $initial || $aliases['score'] !== $initial) {
        throw new RuntimeException("Round trip did not preserve sharing only among restored objects on $class");
    }
    expectScoreReferenceTypeError($restoredAliases, $class);
    expectRestrictedPropertyError($restored->writePrivateScore(...), 'Cannot modify private(set) property');
    expectRestrictedPropertyError($restoredCopy->bindPrivateScore(...), 'Cannot indirectly modify private(set) property');
    if ($restored->score !== 41 || $restoredCopy->score !== 41) {
        throw new RuntimeException("A rejected write changed the restored reference on $class");
    }
    $restoredCopy->checkPrivateScope();
    if ($restoredAliases['score'] !== 7 || $restored->score !== 7 || $restoredCopy->score !== 7
        || $source->score !== $initial || $copy->score !== $initial) {
        throw new RuntimeException("Parent scope could not update the restored reference on $class");
    }

    $firstOwner = WeakReference::create($restored);
    $lastOwner = WeakReference::create($restoredCopy);
    $escaped =& $restoredAliases['score'];
    unset($restored);
    if ($firstOwner->get() !== null) {
        throw new RuntimeException("An escaped reference kept its restored owner alive on $class");
    }
    expectScoreReferenceTypeError($restoredAliases, $class);
    if ($escaped !== 7 || $restoredCopy->score !== 7) {
        throw new RuntimeException("A rejected write changed the last owner's property on $class");
    }
    $escaped = 43;
    if ($restoredCopy->score !== 43) {
        throw new RuntimeException("The last owner stopped sharing the restored reference on $class");
    }

    unset($restoredCopy);
    if ($lastOwner->get() !== null) {
        throw new RuntimeException("An escaped reference kept its last owner alive on $class");
    }
    $escaped = ['detached'];
    if ($restoredAliases['score'] !== ['detached']
        || ReflectionReference::fromArrayElement($restoredAliases, 'score')?->getId() !== $restoredReference->getId()
        || $source->score !== $initial || $copy->score !== $initial || $aliases['score'] !== $initial) {
        throw new RuntimeException("The escaped reference did not survive its owners independently on $class");
    }
}

foreach ([VReadonlyRefInterface::class, VReadonlyRefAbstract::class,
    PhpReadonlyRefInterface::class, PhpReadonlyRefAbstract::class] as $class) {
    verifyRestrictedRefProperty($class, 'readonly');
}
foreach ([VProtectedRefInterface::class, VProtectedRefAbstract::class,
    PhpProtectedRefInterface::class, PhpProtectedRefAbstract::class] as $class) {
    verifyRestrictedRefProperty($class, 'protected(set)');
    $child = eval('return new class extends ' . $class . ' {
        public function checkReference(): void {
            $alias =& $this->score;
            $alias = 19;
            if ($this->score !== 19) {
                throw new RuntimeException("Subclass reference write did not reach the backing property");
            }
            $this->score = 7;
            if ($alias !== 7) {
                throw new RuntimeException("Subclass write did not reach the reference");
            }
        }
    };');
    $child->checkReference();
}

foreach ($privateClasses as $class) {
    $object = verifyRestrictedRefProperty($class, 'private(set)');
    $object->checkPrivateScope();
    if ($object->score !== 7) {
        throw new RuntimeException("Declaring scope could not mutate the private(set) property on $class");
    }

    $phpChild = $class . 'PhpChild';
    eval("class $phpChild extends $class {" . $probeMethods['bindPrivateScore'] . $probeMethods['writePrivateScore'] . '}');
    $children = [new $phpChild()];
    if ($class === VPrivateRefInterface::class) {
        $children[] = new VPrivateRefInterfaceChild();
    } elseif ($class === VPrivateRefAbstract::class) {
        $children[] = new VPrivateRefAbstractChild();
    }
    foreach ($children as $child) {
        $childClass = $child::class;
        $childProperty = new ReflectionProperty($child, 'score');
        $parentMethod = new ReflectionMethod($child, 'checkPrivateScope');
        if ($childProperty->getDeclaringClass()->getName() !== $class || !$childProperty->isPrivateSet()
            || !$childProperty->isFinal() || $childProperty->getHooks() !== [] || $child->score !== 13
            || $parentMethod->getDeclaringClass()->getName() !== $class
            || (new ReflectionMethod($child, 'writePrivateScore'))->getDeclaringClass()->getName() !== $childClass
            || (new ReflectionMethod($child, 'bindPrivateScore'))->getDeclaringClass()->getName() !== $childClass) {
            throw new RuntimeException("Unexpected inherited property or method from $class");
        }
        $independent = clone $child;
        if ($independent === $child || $independent::class !== $childClass) {
            throw new RuntimeException("Clone did not preserve the child class $childClass");
        }
        $child->checkPrivateScope();
        if ($child->score !== 7 || $independent->score !== 13) {
            throw new RuntimeException("Clone did not preserve independent unbound properties on $childClass");
        }
        expectRestrictedPropertyError($child->writePrivateScore(...), "Cannot modify private(set) property");
        expectRestrictedPropertyError($child->bindPrivateScore(...), "Cannot indirectly modify private(set) property");
        if ($child->score !== 7) {
            throw new RuntimeException("Child scope changed the private(set) property on $childClass");
        }
        $method = new ReflectionMethod($child, 'scoreReference');
        if (!$method->returnsReference() || (string) $method->getReturnType() !== 'int'
            || $method->getNumberOfParameters() !== 0 || $method->getDeclaringClass()->getName() !== $class) {
            throw new RuntimeException("Unexpected inherited reference return signature on $childClass");
        }
        $direct =& $child->scoreReference();
        $direct = 23;
        if ($child->score !== 23) {
            throw new RuntimeException("Inherited reference return lost the property alias on $childClass");
        }
        $direct = 7;
        unset($direct);
        $shared = $child->sharePrivateScore();
        $other = $child->sharePrivateScore();
        $reference = ReflectionReference::fromArrayElement($shared, 'score');
        if ($reference === null || $reference->getId() !== ReflectionReference::fromArrayElement($other, 'score')?->getId()
            || $shared['score'] !== 7 || (string) (new ReflectionMethod($child, 'sharePrivateScore'))->getReturnType() !== 'array') {
            throw new RuntimeException("Parent method did not return references to the same property on $childClass");
        }
        $shared['score'] = 29;
        expectRestrictedPropertyError(static fn () => $child->score = 3, "Cannot modify private(set) property");
        expectRestrictedPropertyError(static function () use (&$shared): void {
            $shared['score'] = [];
        }, 'Cannot assign array to reference held by property');
        if ($child->score !== 29 || $other['score'] !== 29) {
            throw new RuntimeException("Returned reference lost its value or type constraint on $childClass");
        }
        $other['score'] = 31;
        if ($child->score !== 31 || $shared['score'] !== 31) {
            throw new RuntimeException("Returned reference could not be written after a TypeError on $childClass");
        }
        $copy = clone $child;
        $copied = $copy->sharePrivateScore();
        if ($copy === $child || $copy::class !== $childClass || $copy->score !== 31
            || $reference->getId() !== ReflectionReference::fromArrayElement($copied, 'score')?->getId()) {
            throw new RuntimeException("Clone did not preserve the bound property reference on $childClass");
        }
        $copied['score'] = 37;
        if ($copy->score !== 37 || $child->score !== 37 || $independent->score !== 13) {
            throw new RuntimeException("Unexpected shared state after cloning $childClass");
        }
        expectRestrictedPropertyError($copy->writePrivateScore(...), "Cannot modify private(set) property");
        expectRestrictedPropertyError($copy->bindPrivateScore(...), "Cannot indirectly modify private(set) property");
        verifyPrivateScoreRoundTrip($child, $copy, $shared);
    }
}

if (extension_loaded('reference_property_contracts')) {
    foreach ([VPrivateRefStatefulChild::class, VPrivateRefStatefulGrandchild::class] as $class) {
        expectRestrictedPropertyError(static fn () => clone new $class(), 'Trying to clone an uncloneable object');
        try {
            serialize(new $class());
        } catch (Exception $error) {
            if (str_contains($error->getMessage(), 'Serialization of')) {
                continue;
            }
            throw $error;
        }
        throw new RuntimeException("Zend property copy policy was inherited through V state on $class");
    }
}
