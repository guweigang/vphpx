<?php
declare(strict_types=1);

if (isset($argv[1])) {
    require $argv[1];
}

class PropertyVersionConsumer extends VphpVersionedChild {
    use VphpVersionedTrait;
}

readonly class ReadonlyPropertyVersionConsumer extends VphpVersionedReadonly {}

$supportsCloneWith = PHP_VERSION_ID >= 80500;
if (function_exists('cloneVersionedObjectWith') !== $supportsCloneWith) {
    throw new RuntimeException('The clone-with export has the wrong PHP version boundary');
}
if ($supportsCloneWith && !isset($argv[1])) {
    class CopyWithPropertyConsumer extends VphpVersionedCopyState {
        public readonly int $frozen;
        public string $label = 'original';

        public function __construct() {
            parent::__construct();
            $this->frozen = 9;
        }

        public function copyFrozen(int $value): self {
            $copy = 'clone';
            return $copy($this, ['frozen' => $value]);
        }
    }

    $source = new CopyWithPropertyConsumer();
    $clone = cloneVersionedObjectWith(properties: ['score' => 15, 'label' => 'copy'], object: $source);
    $readonlyClone = $source->copyFrozen(10);
    if ($clone === $source || !$clone instanceof CopyWithPropertyConsumer
        || $clone->readScore() !== 15 || $clone->label !== 'copy' || $clone->frozen !== 9
        || $readonlyClone->readScore() !== 3 || $readonlyClone->frozen !== 10
        || $source->readScore() !== 3 || $source->label !== 'original' || $source->frozen !== 9) {
        throw new RuntimeException('Clone-with did not preserve V state, PHP state or class identity');
    }

    try {
        cloneVersionedObjectWith($source, ['score' => 18, 'frozen' => 10]);
        throw new RuntimeException('Clone-with bypassed readonly set visibility');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'frozen') || $source->readScore() !== 3 || $source->frozen !== 9) {
            throw $error;
        }
    }

    $failure = new LogicException('original clone failure');
    $throwing = new class($failure) extends VphpVersionedCopyState {
        public function __construct(private LogicException $failure) { parent::__construct(); }
        public function __clone() { throw $this->failure; }
    };
    try {
        cloneVersionedObjectWith($throwing, ['score' => 19]);
        throw new RuntimeException('Clone-with swallowed the __clone exception');
    } catch (LogicException $error) {
        if ($error !== $failure || $throwing->readScore() !== 3) {
            throw $error;
        }
    }
}

$supportsReadonlyDefaults = PHP_VERSION_ID >= 80600;
if (class_exists(VphpVersionedReadonlyClass::class, false) !== $supportsReadonlyDefaults) {
    throw new RuntimeException('Unexpected availability of the versioned readonly class');
}
$readonlyProperties = [
    [PropertyVersionConsumer::class, 'readonlyDefault', 86],
    [ReadonlyPropertyVersionConsumer::class, 'payload', null],
];
if ($supportsReadonlyDefaults) {
    $readonlyProperties[] = [VphpVersionedReadonlyClass::class, 'label', 'ready'];
}
foreach ($readonlyProperties as [$owner, $name, $default]) {
    $class = new ReflectionClass($owner);
    if ($class->hasProperty($name) !== $supportsReadonlyDefaults) {
        throw new RuntimeException("Unexpected availability of {$owner}::\${$name}");
    }
    if (!$supportsReadonlyDefaults) {
        continue;
    }
    $property = $class->getProperty($name);
    $object = $class->newInstance();
    if (!$property->isReadOnly() || !$property->hasDefaultValue() || !$property->isInitialized($object)
        || $property->getDefaultValue() !== $default || $object->$name !== $default) {
        throw new RuntimeException("Invalid readonly default for {$owner}::\${$name}");
    }
    try {
        $property->setValue($object, $default);
        throw new RuntimeException('Initialized readonly storage accepted a write');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'readonly property')) {
            throw $error;
        }
    }
}

$contract = new ReflectionClass(VphpVersionedContract::class);
$inherited = new ReflectionClass(VphpInheritedVersionedContract::class);
$abstract = new ReflectionClass(VphpVersionedAbstract::class);
$implementation = new ReflectionClass(VphpVersionedImplementation::class);
$hasPhaseContract = PHP_VERSION_ID >= 80500;
$hasNewContracts = PHP_VERSION_ID >= 80600;
if ($contract->hasProperty('active') !== (PHP_VERSION_ID >= 80400)
    || $inherited->hasProperty('active') !== $contract->hasProperty('active')
    || $contract->hasProperty('phase') !== $hasPhaseContract
    || $inherited->hasProperty('phase') !== $hasPhaseContract
    || $implementation->hasProperty('phase') !== $hasPhaseContract
    || $contract->hasProperty('item') !== $hasNewContracts
    || $inherited->hasProperty('item') !== $hasNewContracts
    || $abstract->hasProperty('token') !== $hasNewContracts
    || $implementation->hasProperty('item') !== $hasNewContracts
    || $implementation->hasProperty('token') !== $hasNewContracts
    || !$implementation->implementsInterface(VphpInheritedVersionedContract::class)) {
    throw new RuntimeException('The interface, abstract class, and implementation disagree on contract availability');
}
if ($hasPhaseContract) {
    $prototype = $inherited->getProperty('phase')->getHook(PropertyHookType::Get);
    $phase = $implementation->getProperty('phase')->getHook(PropertyHookType::Get);
    if (!$prototype->isAbstract() || $phase->isAbstract()
        || count($phase->getAttributes(Override::class)) !== 1) {
        throw new RuntimeException('The PHP 8.5 getter lost its abstract contract or Override attribute');
    }
    if (!isset($argv[1]) && $implementation->newInstance()->phase !== 85) {
        throw new RuntimeException('The PHP 8.5 getter did not execute');
    }
}
if ($hasNewContracts) {
    foreach ([[$contract, 'item', true], [$inherited, 'item', true], [$abstract, 'token', false]]
        as [$owner, $name, $hasSet]) {
        $property = $owner->getProperty($name);
        $hooks = $property->getHooks();
        if ((string) $property->getType() !== 'int'
            || !isset($hooks['get']) || !$hooks['get']->isAbstract() || !$hooks['get']->returnsReference()
            || isset($hooks['set']) !== $hasSet
            || ($hasSet && (!$hooks['set']->isAbstract() || $hooks['set']->returnsReference()))) {
            throw new RuntimeException("Unexpected gated contract on {$owner->getName()}::$name");
        }
    }
    foreach (['item', 'token'] as $name) {
        if ($implementation->getProperty($name)->getHooks() !== []) {
            throw new RuntimeException("The backed implementation of $name acquired a hook");
        }
    }
}
class UserVersionedImplementation extends VphpVersionedAbstract implements VphpInheritedVersionedContract {
    public bool $active = true;
    public int $phase = 85;
    public int $item = 12;
    public int $token = 24;
}
foreach ([$implementation->newInstance(), new UserVersionedImplementation()] as $object) {
    // Stub properties also have defaults and support ordinary storage.
    if (!$object->active) {
        throw new RuntimeException('The interface implementation lost its boolean property');
    }
    if ($hasNewContracts) {
        $item =& $object->item;
        $token =& $object->token;
        $item++;
        $token++;
        if ($object->item !== 13 || $object->token !== 25) {
            throw new RuntimeException('The gated contracts lost PHP reference binding');
        }
        unset($item, $token);
    }
}

$class = new ReflectionClass(PropertyVersionConsumer::class);
$hasPropertyHooks = PHP_VERSION_ID >= 80400;
foreach ([
    'lateRead' => [$hasNewContracts ? ['get'] : [], 7],
    'staggered' => [$hasNewContracts ? ['get', 'set'] : ($hasPhaseContract ? ['get'] : []), 4],
] as $name => [$expectedHooks, $defaultValue]) {
    if ($class->hasProperty($name) !== $hasPropertyHooks) {
        throw new RuntimeException("Unexpected property availability for $name");
    }
    if ($hasPropertyHooks) {
        $property = $class->getProperty($name);
        if (array_keys($property->getHooks()) !== $expectedHooks
            || $property->getDefaultValue() !== $defaultValue) {
            throw new RuntimeException("Unexpected hooks or default for $name");
        }
    }
}
$label = $class->getProperty('label');
$childLabel = PHP_VERSION_ID >= 80600;
if ($label->getDeclaringClass()->getName() !== ($childLabel ? VphpVersionedChild::class : VphpVersionedBase::class)
    || $label->getDefaultValue() !== ($childLabel ? 'child' : 'base')) {
    throw new RuntimeException('The conditional redeclaration did not preserve inherited metadata');
}
foreach ([
    'count' => [80500, 'int', 85],
    'shared' => [80500, 'int', 5],
    'derived' => [80600, 'int', null],
    'fromTrait' => [80500, 'string', 'ready'],
] as $name => [$version, $type, $default]) {
    if ($class->hasProperty($name) !== (PHP_VERSION_ID >= $version)) {
        throw new RuntimeException("Unexpected availability of $name");
    }
    if (PHP_VERSION_ID < $version) {
        continue;
    }
    $property = $class->getProperty($name);
    if ((string) $property->getType() !== $type
        || ($name !== 'derived' && $property->getDefaultValue() !== $default)) {
        throw new RuntimeException("Unexpected type or default of $name");
    }
    if ($name === 'shared' && (!$property->isStatic() || !$property->isProtectedSet())) {
        throw new RuntimeException('The PHP 8.5 static setter restriction was lost');
    }
    if ($name === 'derived' && !$property->hasHook(PropertyHookType::Get)) {
        throw new RuntimeException('The conditional get hook was lost');
    }
}

if (!isset($argv[1])) {
    $instance = new PropertyVersionConsumer();
    if ($instance->label !== ($childLabel ? 'child' : 'base')) {
        throw new RuntimeException('The conditional redeclaration did not initialize storage');
    }
    $instance->label = 'updated';
    if ($instance->label !== 'updated') {
        throw new RuntimeException('The conditional redeclaration lost writable storage');
    }
    if (PHP_VERSION_ID >= 80500) {
        $instance->count = 17;
        $instance->fromTrait = 'changed';
        if ($instance->count !== 17 || $instance->fromTrait !== 'changed' || PropertyVersionConsumer::$shared !== 5) {
            throw new RuntimeException('The conditional properties lost PHP storage');
        }
        try {
            PropertyVersionConsumer::$shared = 6;
            throw new RuntimeException('External code wrote a protected-set static property');
        } catch (Error $error) {
            if (!str_contains($error->getMessage(), 'protected(set)')) {
                throw $error;
            }
        }
    }
    if ($childLabel && $instance->derived !== 86) {
        throw new RuntimeException('The conditional hook did not execute');
    }
    if ($hasPropertyHooks) {
        if ($instance->lateRead !== ($hasNewContracts ? 86 : 7)
            || $instance->staggered !== ($hasPhaseContract ? 11 : 4)) {
            throw new RuntimeException('The getter did not respect its compilation boundary');
        }
        $instance->staggered = 10;
        if ($instance->hookValue !== ($hasNewContracts ? 20 : 11)
            || $instance->staggered !== ($hasNewContracts ? 20 : ($hasPhaseContract ? 11 : 10))) {
            throw new RuntimeException('The setter did not respect its compilation boundary');
        }
    }
}
