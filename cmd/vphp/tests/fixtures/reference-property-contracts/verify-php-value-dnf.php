<?php
declare(strict_types=1);

require __DIR__ . '/dnf-default-enum.php';

(static function (): void {
    $both = new ArrayObject([7]);
    $countable = new class implements Countable {
        public function count(): int { return 0; }
    };
    $arrayAccess = new class implements ArrayAccess {
        public function offsetExists(mixed $offset): bool { return false; }
        public function offsetGet(mixed $offset): mixed { return null; }
        public function offsetSet(mixed $offset, mixed $value): void {}
        public function offsetUnset(mixed $offset): void {}
    };

    $expectTypeError = static function (Closure $reject, string $expectedError): void {
        try {
            $reject();
            throw new RuntimeException('The bridge accepted a value outside the declared DNF type');
        } catch (TypeError $error) {
            $message = $error->getMessage();
            if (!str_contains($message, $expectedError) || !str_contains($message, 'Countable')
                || !str_contains($message, 'ArrayAccess')) {
                throw $error;
            }
        }
    };

    $instance = new VPhpValueScalarUnion();
    foreach ([
        [vphpFixtureDnf(...), new ReflectionFunction('vphpFixtureDnf'), false],
        [$instance->dnfValue(...), new ReflectionMethod($instance, 'dnfValue'), false],
        [VPhpValueScalarUnion::staticDnfValue(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticDnfValue'), false],
        [vphpFixtureNullableDnf(...), new ReflectionFunction('vphpFixtureNullableDnf'), true],
        [$instance->nullableDnfValue(...), new ReflectionMethod($instance, 'nullableDnfValue'), true],
        [VPhpValueScalarUnion::staticNullableDnfValue(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticNullableDnfValue'), true],
    ] as [$call, $metadata, $nullable]) {
        $parameters = $metadata->getParameters();
        $expectedType = '(ArrayAccess&Countable)|int' . ($nullable ? '|null' : '');
        if (array_map(static fn (ReflectionParameter $param): string => $param->getName(), $parameters) !== ['value', 'replacement']
            || composedStaticPropertyType($parameters[0]->getType()) !== $expectedType
            || $parameters[0]->allowsNull() !== $nullable
            || (string) $parameters[1]->getType() !== 'mixed'
            || composedStaticPropertyType($metadata->getReturnType()) !== $expectedType
            || $metadata->getReturnType()->allowsNull() !== $nullable) {
            throw new RuntimeException('Unexpected PHP signature for the PhpValue DNF bridge');
        }
        if (!extension_loaded('reference_property_contracts')) {
            continue;
        }

        foreach ([23, $both] as $value) {
            if ($call($value, null) !== $value || $call(replacement: null, value: $value) !== $value
                || $call(value: 17, replacement: $value) !== $value) {
                throw new RuntimeException('The PhpValue DNF bridge changed a valid integer or object');
            }
        }
        $invalidArguments = [$countable, $arrayAccess];
        $invalidReturns = [$countable, $arrayAccess];
        if ($nullable) {
            if ($call(value: null, replacement: 17) !== 17 || $call(null, null) !== null
                || $call(value: 17, replacement: false) !== null) {
                throw new RuntimeException('The nullable DNF bridge did not accept null independently for input and output');
            }
        } else {
            $invalidArguments[] = null;
            $invalidReturns[] = false;
        }
        foreach ($invalidArguments as $invalid) {
            $expectTypeError(static fn (): mixed => $call(value: $invalid, replacement: 17), 'Argument #1 ($value) must be of type');
        }
        foreach ($invalidReturns as $invalid) {
            $expectTypeError(static fn (): mixed => $call(value: 17, replacement: $invalid), 'Return value must be of type');
        }
    }

    $constantType = PHP_VERSION_ID >= 80300 ? 'int ' : '';
    eval("class PhpChildDnfDefaults extends VPhpValueScalarUnion { public const {$constantType}DEFAULT_VALUE = 91; }");
    $child = new PhpChildDnfDefaults();
    eval("class PhpChildParentDnfDefaults extends VPhpParentDnfDefaults { public const {$constantType}DEFAULT_VALUE = 109; }");
    $declaring = new VPhpParentDnfDefaults();
    $parentDefaultChild = new PhpChildParentDnfDefaults();
    if (VPhpValueScalarUnion::DEFAULT_VALUE !== 53 || VPhpParentDnfDefaults::DEFAULT_VALUE !== 71
        || PhpChildParentDnfDefaults::DEFAULT_VALUE !== 109) {
        throw new RuntimeException('The parent default fixture requires a different integer at each inheritance level');
    }
    $namespaced = new VPHP\ReferenceProbe\DnfDefaults();
    $qualifiedDefault = 'VPHP\ReferenceDefaults\Limits::DEFAULT_VALUE';
    $qualifiedGlobalDefault = 'VPHP\ReferenceDefaults\DNF_DEFAULT';
    $enumDefault = VPHP\ReferenceDefaults\DnfDefault::DefaultValue;
    $qualifiedEnumDefault = 'VPHP\ReferenceDefaults\DnfDefault::DefaultValue';
    $exportedEnumDefault = VPHP\ReferenceDefaults\ExportedDnfDefault::default_value;
    $qualifiedExportedEnumDefault = 'VPHP\ReferenceDefaults\ExportedDnfDefault::default_value';
    $exportedEnum = new ReflectionEnum($exportedEnumDefault);
    if (!$exportedEnum->implementsInterface(Countable::class) || !$exportedEnum->implementsInterface(ArrayAccess::class)
        || $exportedEnum->getCase('default_value')->getValue() !== $exportedEnumDefault
        || $exportedEnum->getCase('default_value')->getBackingValue() !== 37) {
        throw new RuntimeException('The exported enum lost its interfaces, backing value, or case identity');
    }
    foreach (['count' => Countable::class, 'offsetExists' => ArrayAccess::class, 'offsetGet' => ArrayAccess::class,
        'offsetSet' => ArrayAccess::class, 'offsetUnset' => ArrayAccess::class] as $methodName => $interface) {
        $method = $exportedEnum->getMethod($methodName);
        if ($method->getDeclaringClass()->getName() !== $exportedEnum->getName()
            || $method->getPrototype()->getDeclaringClass()->getName() !== $interface) {
            throw new RuntimeException("Unexpected interface binding for the exported enum method $methodName");
        }
    }
    $otherCase = VPHP\ReferenceDefaults\ExportedDnfDefault::other_value;
    $nextCase = VPHP\ReferenceDefaults\ExportedDnfDefault::next_value;
    $negativeCase = VPHP\ReferenceDefaults\ExportedDnfDefault::negative_value;
    $cases = [$exportedEnumDefault, $nextCase, $otherCase, $negativeCase];
    if (VPHP\ReferenceDefaults\ExportedDnfDefault::cases() !== $cases) {
        throw new RuntimeException('PHP native enum methods lost the original case order');
    }
    foreach ([37, 38, 51, -16] as $index => $backingValue) {
        $case = $cases[$index];
        if ($exportedEnum->getCase($case->name)->getBackingValue() !== $backingValue
            || VPHP\ReferenceDefaults\ExportedDnfDefault::from($backingValue) !== $case
            || (extension_loaded('reference_property_contracts') && $case->count() !== $backingValue)) {
            throw new RuntimeException("Unexpected value or identity for the exported enum case $case->name");
        }
    }
    if (extension_loaded('reference_property_contracts')) {
        try {
            VPHP\ReferenceProbe\convertDnfDiscriminant(99);
            throw new LogicException('VPHP converted a discriminant with no declared enum case');
        } catch (Exception $error) {
            if (!str_contains($error->getMessage(), 'failed to get php enum case')) {
                throw $error;
            }
        }
        if (VPHP\ReferenceProbe\convertDnfDiscriminant(38) !== $nextCase) {
            throw new RuntimeException('A failed V enum conversion prevented a subsequent valid conversion');
        }
    }
    if (extension_loaded('reference_property_contracts')
        && (count($exportedEnumDefault) !== 37 || count($otherCase) !== 51
            || !isset($exportedEnumDefault[37]) || isset($otherCase[37]) || $otherCase[$both] !== $both)) {
        throw new RuntimeException('The generated enum method bridge lost its V receiver or arguments');
    }
    $lastDnf = VPHP\ReferenceProbe\lastDnfArgument(...);
    $lastDnfMetadata = new ReflectionFunction($lastDnf);
    [$values] = $lastDnfMetadata->getParameters();
    $dnfType = '(ArrayAccess&Countable)|int|null';
    if ($lastDnfMetadata->getNumberOfRequiredParameters() !== 0 || !$values->isVariadic()
        || $values->getName() !== 'values' || composedStaticPropertyType($values->getType()) !== $dnfType
        || composedStaticPropertyType($lastDnfMetadata->getReturnType()) !== $dnfType) {
        throw new RuntimeException('Unexpected Reflection for the variadic PhpValue DNF bridge');
    }
    foreach ([$countable, $arrayAccess] as $invalid) {
        $expectTypeError(static fn (): mixed => $lastDnf(17, $invalid), 'Argument #2 must be of type');
    }
    if (extension_loaded('reference_property_contracts')) {
        if ($lastDnf() !== null || $lastDnf(23) !== 23 || $lastDnf(17, $both) !== $both
            || $lastDnf($both, $exportedEnumDefault) !== $exportedEnumDefault
            || $lastDnf($otherCase, null) !== null) {
            throw new RuntimeException('The variadic PhpValue DNF bridge changed a value or lost object identity');
        }
        try {
            $lastDnf(17, named: 42);
            throw new RuntimeException('The positional-only variadic bridge silently discarded a named argument');
        } catch (ArgumentCountError $error) {
            if (!str_contains($error->getMessage(), 'named')) {
                throw $error;
            }
        }
        if (VPHP\ReferenceProbe\countArrayArguments() !== 0
            || VPHP\ReferenceProbe\countArrayArguments([1], [], [2, 3]) !== 3
            || VPHP\ReferenceProbe\countEnumArguments(null, $exportedEnumDefault, $otherCase) !== 2) {
            throw new RuntimeException('The variadic bridge lost a PHP array, nullable argument, or enum case');
        }
        try {
            VPHP\ReferenceProbe\countEnumArguments(null, $both);
            throw new RuntimeException('The variadic PhpEnumCase bridge accepted an ordinary PHP object');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), 'Argument #2 must be of type ?UnitEnum')) {
                throw $error;
            }
        }
    }
    $capture = VPHP\ReferenceProbe\captureNamedDnf(...);
    $captureMetadata = new ReflectionFunction($capture);
    [$prefix, $values] = $captureMetadata->getParameters();
    if ($captureMetadata->getNumberOfRequiredParameters() !== 0 || !$values->isVariadic()
        || $values->getName() !== 'values' || composedStaticPropertyType($values->getType()) !== $dnfType
        || $prefix->getName() !== 'prefix' || $prefix->getDefaultValue() !== 'default'
        || (string) $captureMetadata->getReturnType() !== 'array') {
        throw new RuntimeException('Unexpected Reflection for the named variadic bridge');
    }
    if (extension_loaded('reference_property_contracts')) {
        $native = static fn (string $prefix = 'default', (Countable&ArrayAccess)|int|null ...$values): array
            => compact('prefix', 'values');
        foreach ([
            [],
            ['first' => $exportedEnumDefault, 'prefix' => 'named', 'second' => $both, 'tail' => null],
            ['mixed', 17, null, 'case' => $exportedEnumDefault, '' => $both, 'values' => $otherCase],
        ] as $arguments) {
            $expected = $native(...$arguments);
            if ($capture(...$arguments) !== $expected || $captureMetadata->invokeArgs($arguments) !== $expected) {
                throw new RuntimeException('The named variadic bridge changed keys, values or object identity');
            }
        }
    }
    foreach ([$countable, $arrayAccess] as $invalid) {
        $expectTypeError(static fn (): mixed => $capture(named: $invalid), 'Argument #2 must be of type');
    }
    foreach (['makeNamedTail', 'makeNamedTailWithPrefix'] as $name) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("Unexpected factory signature for $name");
        }
        if (!extension_loaded('reference_property_contracts')) {
            continue;
        }
        $closure = $factory->invoke();
        $metadata = new ReflectionFunction($closure);
        $parameters = $metadata->getParameters();
        $variadic = $parameters[count($parameters) - 1];
        $hasPrefix = $name === 'makeNamedTailWithPrefix';
        if (!$metadata->isVariadic() || $metadata->getNumberOfRequiredParameters() !== 0
            || count($parameters) !== ($hasPrefix ? 2 : 1)
            || $variadic->getName() !== 'values' || (string) $variadic->getType() !== 'mixed'
            || (string) $metadata->getReturnType() !== 'array'
            || ($hasPrefix && ($parameters[0]->getName() !== 'prefix' || $parameters[0]->getDefaultValue() !== null))) {
            throw new RuntimeException("Unexpected Reflection for $name");
        }
        $named = ['values' => $exportedEnumDefault, '' => null, 'second' => $both];
        if ($closure() !== ['prefix' => 'default', 'values' => []]
            || $closure(...$named) !== ['prefix' => 'default', 'values' => $named]
            || $metadata->invokeArgs($named) !== ['prefix' => 'default', 'values' => $named]) {
            throw new RuntimeException("The named variadic closure changed order, keys, or PHP values for $name");
        }
        $mixed = $hasPrefix ? ['prefixed', 17, ...$named] : [17, ...$named];
        if ($closure(...$mixed) !== ['prefix' => $hasPrefix ? 'prefixed' : 'default', 'values' => [17, ...$named]]) {
            throw new RuntimeException("The named variadic closure changed mixed arguments for $name");
        }
        if ($hasPrefix && $closure(second: $both, prefix: 'named', last: null)
            !== ['prefix' => 'named', 'values' => ['second' => $both, 'last' => null]]) {
            throw new RuntimeException('The named variadic closure consumed a fixed parameter as a tail item');
        }
    }
    $stringEnum = new ReflectionEnum(VPHP\ReferenceDefaults\StringBacked::class);
    if ((string) $stringEnum->getBackingType() !== 'string') {
        throw new RuntimeException('The exported string-backed enum lost its backing type');
    }
    foreach (['empty' => ['', 13], 'escaped' => ["雪\\'\"\0", 29]] as $case => [$backing, $discriminant]) {
        $reflected = $stringEnum->getCase($case);
        $value = $reflected->getValue();
        if ($reflected->getBackingValue() !== $backing || $value->value !== $backing
            || VPHP\ReferenceDefaults\StringBacked::from($backing) !== $value) {
            throw new RuntimeException("Unexpected backing value or case identity for $case");
        }
        if (extension_loaded('reference_property_contracts')
            && ($value->discriminant() !== $discriminant
                || VPHP\ReferenceProbe\roundTripStringEnum(value: $value) !== $value)) {
            throw new RuntimeException("Unexpected V round trip for string enum case $case");
        }
    }
    $unit = new ReflectionEnum(VPHP\ReferenceDefaults\UnitKind::class);
    $firstUnitCase = VPHP\ReferenceDefaults\UnitKind::first;
    $secondUnitCase = VPHP\ReferenceDefaults\UnitKind::Second;
    $echoCase = new ReflectionFunction('VPHP\\ReferenceProbe\\echoEnumCase');
    $caseParameter = $echoCase->getParameters()[0];
    $caseTail = (new ReflectionFunction('VPHP\\ReferenceProbe\\countEnumArguments'))->getParameters()[0];
    if ((string) $caseParameter->getType() !== 'UnitEnum'
        || (string) $echoCase->getReturnType() !== 'UnitEnum'
        || !$caseParameter->isDefaultValueConstant()
        || $caseParameter->getDefaultValueConstantName() !== 'VPHP\\ReferenceDefaults\\UnitKind::first'
        || $caseParameter->getDefaultValue() !== $firstUnitCase
        || !$caseTail->isVariadic() || (string) $caseTail->getType() !== '?UnitEnum') {
        throw new RuntimeException('The PhpEnumCase signature lost its UnitEnum type or default case');
    }
    foreach (['makeEnumCaseIdentity', 'makeEnumCaseSelector'] as $factory) {
        if ((string) (new ReflectionFunction('VPHP\\ReferenceProbe\\' . $factory))->getReturnType() !== Closure::class) {
            throw new RuntimeException("Unexpected factory signature for $factory");
        }
    }
    if (extension_loaded('reference_property_contracts')) {
        $identity = VPHP\ReferenceProbe\makeEnumCaseIdentity();
        $selector = VPHP\ReferenceProbe\makeEnumCaseSelector();
        $identityInfo = new ReflectionFunction($identity);
        $selectorInfo = new ReflectionFunction($selector);
        if ((string) $identityInfo->getParameters()[0]->getType() !== '?UnitEnum'
            || $identityInfo->getParameters()[0]->getDefaultValue() !== null
            || (string) $identityInfo->getReturnType() !== '?UnitEnum'
            || !$selectorInfo->isVariadic() || (string) $selectorInfo->getParameters()[0]->getType() !== 'UnitEnum'
            || (string) $selectorInfo->getReturnType() !== '?UnitEnum'
            || VPHP\ReferenceProbe\echoEnumCase() !== $firstUnitCase
            || VPHP\ReferenceProbe\echoEnumCase(value: $exportedEnumDefault) !== $exportedEnumDefault
            || $identity() !== null || $identity(value: null) !== null || $identity(value: $secondUnitCase) !== $secondUnitCase
            || $selector() !== null || $selector($secondUnitCase, $exportedEnumDefault) !== $exportedEnumDefault) {
            throw new RuntimeException('A generated PhpEnumCase entry changed metadata or enum case identity');
        }
        foreach ([static fn () => $identity(value: $both), static fn () => $selector($firstUnitCase, $both)] as $invalid) {
            try {
                $invalid();
                throw new RuntimeException('A PhpEnumCase closure accepted an ordinary object');
            } catch (TypeError $error) {
                if (!str_contains($error->getMessage(), 'enum case')) {
                    throw $error;
                }
            }
        }
    }
    $unitDefault = (new ReflectionFunction('VPHP\ReferenceProbe\roundTripUnitEnum'))->getParameters()[0];
    if ($unit->isBacked() || $unit->getBackingType() !== null || $unit->hasProperty('value')
        || $unit->implementsInterface(BackedEnum::class) || !$unit->implementsInterface(Countable::class)
        || $unit->hasMethod('tryFrom') || !$unit->hasMethod('from')
        || $unit->getCase('first')->getValue() !== $firstUnitCase
        || !$unit->hasCase('Second') || $unit->hasCase('second')
        || $unit->getCase('Second')->getValue() !== $secondUnitCase
        || VPHP\ReferenceDefaults\UnitKind::second !== $secondUnitCase
        || VPHP\ReferenceDefaults\UnitKind::ALIAS !== $firstUnitCase
        || VPHP\ReferenceDefaults\UnitKind::cases() !== [$firstUnitCase, $secondUnitCase]
        || $unitDefault->getDefaultValueConstantName() !== 'VPHP\ReferenceDefaults\UnitKind::first'
        || $unitDefault->getDefaultValue() !== $firstUnitCase) {
        throw new RuntimeException('The exported unit enum lost its cases, methods, alias or default');
    }
    if (extension_loaded('reference_property_contracts')
        && (count($firstUnitCase) !== 3 || count($secondUnitCase) !== 7
            || VPHP\ReferenceDefaults\UnitKind::from($secondUnitCase) !== $secondUnitCase
            || VPHP\ReferenceProbe\roundTripUnitEnum() !== $firstUnitCase
            || VPHP\ReferenceProbe\roundTripUnitEnum(label: 'named') !== $firstUnitCase
            || VPHP\ReferenceProbe\roundTripUnitEnum(value: $secondUnitCase) !== $secondUnitCase)) {
        throw new RuntimeException('The exported unit enum changed a case crossing the V bridge');
    }
    foreach ([
        [vphpFixtureDefaultedNullableDnf(...), new ReflectionFunction('vphpFixtureDefaultedNullableDnf'), null, null],
        [$instance->defaultedNullableDnf(...), new ReflectionMethod($instance, 'defaultedNullableDnf'), null, null],
        [VPhpValueScalarUnion::staticDefaultedNullableDnf(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticDefaultedNullableDnf'), null, null],
        [vphpFixtureIntegerDefaultDnf(...), new ReflectionFunction('vphpFixtureIntegerDefaultDnf'), 37, null],
        [$instance->integerDefaultDnf(...), new ReflectionMethod($instance, 'integerDefaultDnf'), 37, null],
        [VPhpValueScalarUnion::staticIntegerDefaultDnf(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticIntegerDefaultDnf'), 37, null],
        [vphpFixtureConstantDefaultDnf(...), new ReflectionFunction('vphpFixtureConstantDefaultDnf'), PHP_INT_SIZE, 'PHP_INT_SIZE'],
        [$instance->constantDefaultDnf(...), new ReflectionMethod($instance, 'constantDefaultDnf'), PHP_INT_SIZE, 'PHP_INT_SIZE'],
        [VPhpValueScalarUnion::staticConstantDefaultDnf(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticConstantDefaultDnf'), PHP_INT_SIZE, 'PHP_INT_SIZE'],
        [$instance->selfConstantDefaultDnf(...), new ReflectionMethod($instance, 'selfConstantDefaultDnf'), 53, 'self::DEFAULT_VALUE'],
        [VPhpValueScalarUnion::staticSelfConstantDefaultDnf(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticSelfConstantDefaultDnf'), 53, 'self::DEFAULT_VALUE'],
        [$child->selfConstantDefaultDnf(...), new ReflectionMethod($child, 'selfConstantDefaultDnf'), 53, 'self::DEFAULT_VALUE'],
        [PhpChildDnfDefaults::staticSelfConstantDefaultDnf(...), new ReflectionMethod(PhpChildDnfDefaults::class, 'staticSelfConstantDefaultDnf'), 53, 'self::DEFAULT_VALUE'],
        [$declaring->parentConstantDefaultDnf(...), new ReflectionMethod($declaring, 'parentConstantDefaultDnf'), 53, 'parent::DEFAULT_VALUE'],
        [VPhpParentDnfDefaults::staticParentConstantDefaultDnf(...), new ReflectionMethod(VPhpParentDnfDefaults::class, 'staticParentConstantDefaultDnf'), 53, 'parent::DEFAULT_VALUE'],
        [$parentDefaultChild->parentConstantDefaultDnf(...), new ReflectionMethod($parentDefaultChild, 'parentConstantDefaultDnf'), 53, 'parent::DEFAULT_VALUE'],
        [PhpChildParentDnfDefaults::staticParentConstantDefaultDnf(...), new ReflectionMethod(PhpChildParentDnfDefaults::class, 'staticParentConstantDefaultDnf'), 53, 'parent::DEFAULT_VALUE'],
        [VPHP\ReferenceProbe\namespacedConstantDefaultDnf(...), new ReflectionFunction('VPHP\ReferenceProbe\namespacedConstantDefaultDnf'), 127, $qualifiedDefault],
        [$namespaced->namespacedConstantDefaultDnf(...), new ReflectionMethod($namespaced, 'namespacedConstantDefaultDnf'), 127, $qualifiedDefault],
        [VPHP\ReferenceProbe\DnfDefaults::staticNamespacedConstantDefaultDnf(...), new ReflectionMethod(VPHP\ReferenceProbe\DnfDefaults::class, 'staticNamespacedConstantDefaultDnf'), 127, $qualifiedDefault],
        [VPHP\ReferenceProbe\namespacedGlobalDefaultDnf(...), new ReflectionFunction('VPHP\ReferenceProbe\namespacedGlobalDefaultDnf'), 149, $qualifiedGlobalDefault],
        [$namespaced->namespacedGlobalDefaultDnf(...), new ReflectionMethod($namespaced, 'namespacedGlobalDefaultDnf'), 149, $qualifiedGlobalDefault],
        [VPHP\ReferenceProbe\DnfDefaults::staticNamespacedGlobalDefaultDnf(...), new ReflectionMethod(VPHP\ReferenceProbe\DnfDefaults::class, 'staticNamespacedGlobalDefaultDnf'), 149, $qualifiedGlobalDefault],
        [VPHP\ReferenceProbe\enumCaseDefaultDnf(...), new ReflectionFunction('VPHP\ReferenceProbe\enumCaseDefaultDnf'), $enumDefault, $qualifiedEnumDefault],
        [$namespaced->enumCaseDefaultDnf(...), new ReflectionMethod($namespaced, 'enumCaseDefaultDnf'), $enumDefault, $qualifiedEnumDefault],
        [VPHP\ReferenceProbe\DnfDefaults::staticEnumCaseDefaultDnf(...), new ReflectionMethod(VPHP\ReferenceProbe\DnfDefaults::class, 'staticEnumCaseDefaultDnf'), $enumDefault, $qualifiedEnumDefault],
        [VPHP\ReferenceProbe\exportedEnumCaseDefaultDnf(...), new ReflectionFunction('VPHP\ReferenceProbe\exportedEnumCaseDefaultDnf'), $exportedEnumDefault, $qualifiedExportedEnumDefault],
        [$namespaced->exportedEnumCaseDefaultDnf(...), new ReflectionMethod($namespaced, 'exportedEnumCaseDefaultDnf'), $exportedEnumDefault, $qualifiedExportedEnumDefault],
        [VPHP\ReferenceProbe\DnfDefaults::staticExportedEnumCaseDefaultDnf(...), new ReflectionMethod(VPHP\ReferenceProbe\DnfDefaults::class, 'staticExportedEnumCaseDefaultDnf'), $exportedEnumDefault, $qualifiedExportedEnumDefault],
    ] as [$call, $metadata, $default, $constant]) {
        [$value, $label] = $metadata->getParameters();
        $returnsValue = $default instanceof UnitEnum;
        $dnfType = '(ArrayAccess&Countable)|int|null';
        if ($metadata->getNumberOfParameters() !== 2 || $metadata->getNumberOfRequiredParameters() !== 0
            || $value->getName() !== 'value' || !$value->isOptional() || !$value->allowsNull()
            || composedStaticPropertyType($value->getType()) !== $dnfType
            || !$value->isDefaultValueAvailable() || $value->getDefaultValue() !== $default
            || $value->isDefaultValueConstant() !== ($constant !== null)
            || $value->getDefaultValueConstantName() !== $constant
            || $label->getName() !== 'label' || (string) $label->getType() !== 'string'
            || !$label->isDefaultValueAvailable() || $label->getDefaultValue() !== 'default'
            || composedStaticPropertyType($metadata->getReturnType()) !== ($returnsValue ? $dnfType : 'string')) {
            throw new RuntimeException("Unexpected Reflection for the defaulted PhpValue DNF bridge {$metadata->getName()}");
        }
        foreach ([$countable, $arrayAccess] as $invalid) {
            $expectTypeError(static fn (): mixed => $call($invalid), 'Argument #1 ($value) must be of type');
            $expectTypeError(static fn (): mixed => $call(value: $invalid), 'Argument #1 ($value) must be of type');
        }
        if (!extension_loaded('reference_property_contracts')) {
            continue;
        }

        if ($returnsValue) {
            if ($call() !== $default || $call(label: 'named') !== $default
                || $call(null) !== null || $call(label: 'explicit', value: null) !== null
                || $call(17) !== 17 || $call(label: 'both', value: $both) !== $both
                || $call(value: $default) !== $default) {
                throw new RuntimeException('The defaulted DNF bridge changed the enum case or an explicit argument');
            }
            if ($default === $exportedEnumDefault) {
                if ($call($otherCase) !== $otherCase || $call(label: 'other', value: $otherCase) !== $otherCase) {
                    throw new RuntimeException('The defaulted DNF bridge replaced an explicitly passed exported case');
                }
                if (call_user_func_array($call, ['label' => 'named']) !== $default
                    || call_user_func_array($call, ['label' => 'explicit', 'value' => null]) !== null
                    || call_user_func_array($call, []) !== $default) {
                    throw new RuntimeException('Array-based dispatch changed the exported enum default or explicit null');
                }
                $invoke = static fn (array $args): mixed => $metadata instanceof ReflectionMethod
                    ? $metadata->invokeArgs($metadata->isStatic() ? null : $namespaced, $args)
                    : $metadata->invokeArgs($args);
                if ($invoke([]) !== $default || $invoke(['label' => 'named']) !== $default
                    || $invoke(['label' => 'explicit', 'value' => null]) !== null) {
                    throw new RuntimeException('Reflection invocation changed the exported enum default or explicit null');
                }
            }
        } else {
            $defaultResult = $default === null ? 'null' : "int:$default";
            if ($call() !== "$defaultResult:default" || $call(label: 'named') !== "$defaultResult:named"
                || $call(null) !== 'null:default' || $call(label: 'explicit', value: null) !== 'null:explicit'
                || $call(17) !== 'int:17:default' || $call(label: 'both', value: $both) !== 'object:both') {
                throw new RuntimeException('The defaulted DNF bridge changed a PHP argument or its default');
            }
        }
    }
})();
