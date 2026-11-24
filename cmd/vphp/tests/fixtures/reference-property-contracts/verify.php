<?php
declare(strict_types=1);

require __DIR__ . '/private-scope.php';

$mode = $argv[2] ?? $argv[1] ?? '';
if (isset($argv[1]) && !str_starts_with($argv[1], '--')) {
    if (isset($argv[2])) {
        require $argv[1];
    } else {
        loadReferenceContractStub($argv[1]);
    }
}
if ($mode === '--invalid-interface') {
    eval('class PhpValueInterfaceImplementation implements InheritedRefPropertyContract {
        public int $score { get => 1; set {} }
    }');
    exit;
}
if ($mode === '--capture-unwind-exit') {
    VPHP\ReferenceProbe\recoverCallback(
        static fn () => exit(37),
        static fn () => print("recovery called\n"),
        false,
    );
    echo "continued after exit\n";
    exit(1);
}
if ($mode === '--external-interface-is-class') {
    eval('namespace VPHP\\ReferenceExternal; class Contract {}');
    $value = new VPHP\ReferenceExternal\Contract();
    $broker = new VPHP\ReferenceProbe\ContractBrokerImpl();
    foreach ([
        static fn () => VPHP\ReferenceProbe\echoExternalContract($value),
        static fn () => VPHP\ReferenceProbe\echoExternalAlias(value: $value),
        static fn () => VPHP\ReferenceProbe\externalContractOption(value: $value),
        static fn () => $broker->externalContractTail(null, $value),
    ] as $invoke) {
        try {
            $invoke();
            throw new RuntimeException('A class was accepted as an external interface');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), 'expected PHP object implementing')) {
                throw $error;
            }
        }
    }
    exit;
}
if ($mode === '--invalid-interface-static') {
    eval('class PhpNonStaticEnumSelector implements \VPHP\ReferenceProbe\InheritedEnumSelectorFactory {
        public function choose(\VPHP\ReferenceDefaults\UnitKind $x = \VPHP\ReferenceDefaults\UnitKind::Second): \VPHP\ReferenceDefaults\UnitKind { return $x; }
        public function keep(\VPHP\ReferenceDefaults\UnitKind $x): \VPHP\ReferenceDefaults\UnitKind { return $x; }
    }');
    exit;
}
if ($mode === '--invalid-interface-type') {
    eval('class PhpNarrowValueContract implements \\VPHP\\ReferenceProbe\\TypedValueContract {
        public function typedValue(int $value): int { return $value; }
    }');
    exit;
}
if ($mode === '--invalid-abstract') {
    eval('class PhpValueAbstractImplementation extends AbstractRefProperty { public int $score { get => 1; } }');
    exit;
}
if ($mode === '--invalid-class-mixed') {
    eval('class PhpClassUnexpectedMixed extends VClassUntypedBase { public mixed $slot; }');
    exit;
}
if ($mode === '--invalid-class-untyped') {
    eval('class PhpClassUnexpectedUntyped extends VClassMixedInherited { public $slot; }');
    exit;
}
if ($mode === '--invalid-class-typed') {
    eval('class PhpClassUnexpectedTyped extends VClassTypedInherited { public int|float $choice = 7; }');
    exit;
}

if (extension_loaded('reference_property_contracts')) {
    // Exercise the default before the checks below read the enum case or reflect the parameter.
    $namedDefault = VPHP\ReferenceProbe\exportedEnumCaseDefaultDnf(label: 'first call');
    $namespaced = new VPHP\ReferenceProbe\DnfDefaults();
    $positionalDefault = $namespaced->exportedEnumCaseDefaultDnf();
    $staticDefault = VPHP\ReferenceProbe\DnfDefaults::staticExportedEnumCaseDefaultDnf();
    $case = VPHP\ReferenceDefaults\ExportedDnfDefault::default_value;
    if ($namedDefault !== $case || $positionalDefault !== $case || $staticDefault !== $case) {
        throw new RuntimeException('An initial call did not resolve the exported enum default to its original case');
    }
}

require __DIR__ . '/verify-method-reference.php';
require __DIR__ . '/verify-return-reference.php';
require __DIR__ . '/verify-closure-reference.php';
require __DIR__ . '/verify-call-reference.php';
require __DIR__ . '/verify-iterable.php';
require __DIR__ . '/verify-generator.php';
require __DIR__ . '/verify-fiber.php';
require __DIR__ . '/verify-stream-open.php';
require __DIR__ . '/verify-weak-reference.php';
require __DIR__ . '/verify-weak-map.php';
require __DIR__ . '/verify-array-access.php';
require __DIR__ . '/verify-countable.php';
require __DIR__ . '/verify-stringable.php';
require __DIR__ . '/verify-json-serializable.php';
require __DIR__ . '/verify-storage-reference.php';
require __DIR__ . '/verify-static-storage-reference.php';
require __DIR__ . '/verify-late-static-storage.php';
require __DIR__ . '/verify-static-trait-storage.php';
require __DIR__ . '/verify-native-trait-static-storage.php';
require __DIR__ . '/verify-combined-native-trait-storage.php';
require __DIR__ . '/verify-trait-signatures.php';
require __DIR__ . '/verify-trait-constants.php';
require __DIR__ . '/verify-trait-property-types.php';
require __DIR__ . '/verify-class-property-types.php';
require __DIR__ . '/verify-class-typed-inheritance.php';
require __DIR__ . '/verify-php-value-scalar-union.php';
require __DIR__ . '/verify-php-value-dnf.php';
require __DIR__ . '/verify-enum-interface.php';
require __DIR__ . '/verify-payload-signature.php';

require __DIR__ . '/verify-restricted.php';

class PhpBackedInterfaceImplementation implements InheritedRefPropertyContract
{
    public int $score = 10;
}

class PhpBackedAbstractImplementation extends AbstractRefProperty
{
    public int $score = 11;
}

foreach ([
    [VBackedInterfaceImplementation::class, 8],
    [VBackedAbstractImplementation::class, 9],
    [PhpBackedInterfaceImplementation::class, 10],
    [PhpBackedAbstractImplementation::class, 11],
] as [$class, $default]) {
    $property = new ReflectionProperty($class, 'score');
    if (!$property->isPublic() || $property->isStatic() || (string) $property->getType() !== 'int'
        || $property->getDeclaringClass()->getName() !== $class || $property->getDefaultValue() !== $default
        || (PHP_VERSION_ID >= 80400 && ($property->isVirtual() || $property->isAbstract()
            || $property->getHooks() !== []))) {
        throw new RuntimeException("Unexpected backed property metadata for $class");
    }
    $object = new $class();
    if ($object->score !== $default) {
        throw new RuntimeException("Unexpected backed property initial value for $class");
    }
    $ref =& $object->score;
    $ref = 19;
    if ($object->score !== 19) {
        throw new RuntimeException("Reference write did not reach the backing property in $class");
    }
    $object->score = 7;
    if ($ref !== 7) {
        throw new RuntimeException("Backing property write did not reach the reference in $class");
    }
    unset($ref);
}

if (PHP_VERSION_ID < 80400) {
    foreach ([RefPropertyContract::class, InheritedRefPropertyContract::class, AbstractRefProperty::class,
        VRefContractImplementation::class, VRefAbstractImplementation::class] as $class) {
        if (!class_exists($class) && !interface_exists($class)) {
            throw new RuntimeException("Missing declaration for $class");
        }
        if (property_exists($class, 'score')) {
            throw new RuntimeException("The reference property contract appeared before PHP 8.4 on $class");
        }
    }
    exit;
}

foreach ([
    [RefPropertyContract::class, RefPropertyContract::class, ['get', 'set']],
    [InheritedRefPropertyContract::class, RefPropertyContract::class, ['get', 'set']],
    [AbstractRefProperty::class, AbstractRefProperty::class, ['get']],
] as [$class, $owner, $operations]) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if (!$property->isVirtual() || !$property->isAbstract() || array_keys($hooks) !== $operations
        || !$hooks['get']->isAbstract() || !$hooks['get']->returnsReference()
        || $hooks['get']->getDeclaringClass()->getName() !== $owner
        || (string) $hooks['get']->getReturnType() !== 'int'
        || (isset($hooks['set']) && (!$hooks['set']->isAbstract() || $hooks['set']->returnsReference()))) {
        throw new RuntimeException("Unexpected reference contract metadata for $class");
    }
}

eval('class PhpRefInterfaceImplementation implements InheritedRefPropertyContract {
    private int $storage = 3;
    public int $score {
        &get { return $this->storage; }
        set { $this->storage = $value * 10; }
    }
}');
eval('class PhpRefAbstractImplementation extends AbstractRefProperty {
    public int $score = 6 { &get { return $this->score; } }
}');

foreach ([
    [VRefContractImplementation::class, RefPropertyContract::class, 70],
    [PhpRefInterfaceImplementation::class, RefPropertyContract::class, 70],
    [VRefAbstractImplementation::class, AbstractRefProperty::class, 7],
    [PhpRefAbstractImplementation::class, AbstractRefProperty::class, 7],
] as [$class, $contract, $assigned]) {
    $property = new ReflectionProperty($class, 'score');
    $get = $property->getHooks()['get'];
    if ($get->isAbstract() || !$get->returnsReference()
        || $get->getPrototype()->getDeclaringClass()->getName() !== $contract
        || (string) $get->getReturnType() !== 'int') {
        throw new RuntimeException("Unexpected reference getter for $class");
    }
    // The virtual V getter in the stub declares its signature as a placeholder.
    if ($class === VRefContractImplementation::class && !extension_loaded('reference_property_contracts')) {
        continue;
    }
    $object = new $class();
    $ref =& $object->score;
    $ref = 19;
    if ($object->score !== 19) {
        throw new RuntimeException("Reference write did not reach $class");
    }
    $object->score = 7;
    if ($ref !== $assigned) {
        throw new RuntimeException("Property write did not reach the reference in $class");
    }
    unset($ref);
}
