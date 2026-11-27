<?php
declare(strict_types=1);

use VPHP\ReferenceDefaults\UnitKind;
use VPHP\ReferenceProbe\EnumSelector;
use VPHP\ReferenceProbe\EnumSelectorImpl;
use VPHP\ReferenceProbe\OptionsContract;
use VPHP\ReferenceProbe\OptionsContractImpl;
use VPHP\ReferenceProbe\TypedValueContract;
use VPHP\ReferenceProbe\InheritedTypedValueContract;
use VPHP\ReferenceProbe\ContractBroker;
use VPHP\ReferenceProbe\ContractBrokerImpl;

#[Attribute(Attribute::TARGET_METHOD | Attribute::TARGET_PARAMETER)]
final class VphpInterfaceProbeTag
{
    public function __construct(public string $kind, public array $metadata = []) {}
}

final class PhpTypedValueContract implements InheritedTypedValueContract
{
    public function typedValue(mixed $value): (Countable&ArrayAccess)|int|null
    {
        return $value;
    }
}

final class PhpContractBroker implements ContractBroker
{
    public function forward(TypedValueContract $source, ?TypedValueContract $fallback, TypedValueContract ...$rest): TypedValueContract
    {
        return $rest === [] ? ($fallback ?? $source) : $rest[array_key_last($rest)];
    }
}

function vphp_contract_computed_value(): string
{
    return 'computed-' . ++$GLOBALS['vphp_contract_default_calls'];
}

final class PhpOptionsContract implements OptionsContract
{
    public function external_options(?UnitKind $selected = UnitKind::Second, string $label = 'external'): array
    {
        return ['selected' => $selected, 'label' => $label];
    }

    public function computed_options(string $value = 'manual', string $label = 'contract'): string
    {
        return "$value:$label";
    }

    public static function renamedOptions(int $request, ?UnitKind $selected = UnitKind::Second, string $message = 'external'): string
    {
        return "$request:$message";
    }
}

final class PhpEnumSelector implements EnumSelector
{
    public function select(UnitKind $x, UnitKind ...$alternatives): UnitKind
    {
        return $alternatives === [] ? $x : $alternatives[array_key_last($alternatives)];
    }

    public function pick(UnitKind $x = UnitKind::Second, string $label = 'default'): UnitKind
    {
        return $x;
    }
}

foreach ([EnumSelector::class, EnumSelectorImpl::class, PhpEnumSelector::class] as $owner) {
    $select = new ReflectionMethod($owner, 'select');
    [$first, $rest] = $select->getParameters();
    $pick = new ReflectionMethod($owner, 'pick');
    [$default, $label] = $pick->getParameters();
    if ($select->getNumberOfRequiredParameters() !== 1 || $first->getName() !== 'x'
        || (string) $first->getType() !== UnitKind::class || !$rest->isVariadic()
        || (string) $rest->getType() !== UnitKind::class || (string) $select->getReturnType() !== UnitKind::class
        || $pick->getNumberOfRequiredParameters() !== 0 || $default->getName() !== 'x'
        || (string) $default->getType() !== UnitKind::class || (string) $pick->getReturnType() !== UnitKind::class
        || $default->getDefaultValueConstantName() !== UnitKind::class . '::Second'
        || $default->getDefaultValue() !== UnitKind::Second || $label->getDefaultValue() !== 'default') {
        throw new RuntimeException("Unexpected enum interface signature on $owner");
    }
}

$selectors = [new PhpEnumSelector()];
if (extension_loaded('reference_property_contracts')) {
    $selectors[] = new EnumSelectorImpl();
}
foreach ($selectors as $selector) {
    if (!$selector instanceof EnumSelector || $selector->select(x: UnitKind::first) !== UnitKind::first
        || $selector->select(UnitKind::first, UnitKind::Second) !== UnitKind::Second
        || $selector->pick() !== UnitKind::Second || $selector->pick(label: 'named') !== UnitKind::Second
        || $selector->pick(x: UnitKind::first) !== UnitKind::first) {
        throw new RuntimeException('Enum interface call changed case identity');
    }
    try {
        $selector->select(x: 'first');
        throw new RuntimeException('Enum interface method accepted a string');
    } catch (TypeError) {
    }
}

$unnamed = new ReflectionMethod(VPHP\ReferenceProbe\UnnamedEnumArgs::class, 'pair');
if (array_map(static fn (ReflectionParameter $p): string => $p->getName(), $unnamed->getParameters()) !== ['arg1_', 'arg1']) {
    throw new RuntimeException('Unnamed interface parameters collided with declared parameter names');
}

final class PhpEnumSelectorFactory implements VPHP\ReferenceProbe\InheritedEnumSelectorFactory
{
    public static function choose(UnitKind $x = UnitKind::Second): UnitKind
    {
        return $x;
    }

    public function keep(UnitKind $x): UnitKind
    {
        return $x;
    }
}

$baseFactory = VPHP\ReferenceProbe\EnumSelectorFactory::class;
$subFactory = VPHP\ReferenceProbe\InheritedEnumSelectorFactory::class;
$nativeFactory = VPHP\ReferenceProbe\EnumSelectorFactoryImpl::class;
foreach ([$baseFactory, $subFactory, $nativeFactory, PhpEnumSelectorFactory::class] as $factory) {
    $choose = new ReflectionMethod($factory, 'choose');
    $x = $choose->getParameters()[0];
    if (!$choose->isStatic() || $choose->isAbstract() !== interface_exists($factory, false)
        || (new ReflectionMethod($factory, 'keep'))->isStatic()
        || $choose->getNumberOfRequiredParameters() !== 0 || $x->getName() !== 'x'
        || (string) $x->getType() !== UnitKind::class || (string) $choose->getReturnType() !== UnitKind::class
        || $x->getDefaultValueConstantName() !== UnitKind::class . '::Second'
        || $x->getDefaultValue() !== UnitKind::Second) {
        throw new RuntimeException("Unexpected static interface signature on $factory");
    }
}
if ((new ReflectionMethod($subFactory, 'choose'))->getDeclaringClass()->getName() !== $baseFactory) {
    throw new RuntimeException('The inherited static method lost its declaring interface');
}

$factories = [PhpEnumSelectorFactory::class];
if (extension_loaded('reference_property_contracts')) {
    $factories[] = $nativeFactory;
}
foreach ($factories as $factory) {
    if (!is_subclass_of($factory, $subFactory) || $factory::choose() !== UnitKind::Second
        || $factory::choose(x: UnitKind::first) !== UnitKind::first
        || (new $factory())->keep(x: UnitKind::Second) !== UnitKind::Second) {
        throw new RuntimeException('Static interface dispatch changed a default or explicit case');
    }
}

(static function (): void {
    $fixture = new VPHP\ReferenceProbe\DnfDefaults();
    $options = [
        [VPHP\ReferenceProbe\enumOptions(...), UnitKind::Second, 'maybeMode'],
        [$fixture->enumOptions(...), UnitKind::first, 'maybeMode'],
    ];
    $loaded = extension_loaded('reference_property_contracts');
    if ((string) (new ReflectionFunction('VPHP\ReferenceProbe\makeEnumOptions'))->getReturnType() !== Closure::class) {
        throw new RuntimeException('The enum options factory lost its Closure return type');
    }
    if ($loaded) {
        $options[] = [VPHP\ReferenceProbe\makeEnumOptions(), UnitKind::Second, 'maybe_mode'];
    }
    foreach ($options as [$call, $default, $maybeName]) {
        $reflection = new ReflectionFunction($call);
        [$mode, $maybe, $label] = $reflection->getParameters();
        if ($reflection->getNumberOfRequiredParameters() !== 0
            || $mode->getName() !== 'mode' || (string) $mode->getType() !== UnitKind::class
            || $mode->getDefaultValueConstantName() !== UnitKind::class . '::' . $default->name
            || $mode->getDefaultValue() !== $default
            || $maybe->getName() !== $maybeName || (string) $maybe->getType() !== '?' . UnitKind::class
            || $maybe->getDefaultValueConstantName() !== UnitKind::class . '::Second'
            || $maybe->getDefaultValue() !== UnitKind::Second || $label->getDefaultValue() !== 'default') {
            throw new RuntimeException('Unexpected enum defaults for flattened V params');
        }
        if (!$loaded) {
            continue;
        }
        if ($call() !== ['mode' => $default, 'maybe' => UnitKind::Second, 'label' => 'default']
            || $call(label: 'named') !== ['mode' => $default, 'maybe' => UnitKind::Second, 'label' => 'named']
            || $call(...[$maybeName => null]) !== ['mode' => $default, 'maybe' => null, 'label' => 'default']
            || $call(mode: UnitKind::first, label: 'explicit') !== ['mode' => UnitKind::first, 'maybe' => UnitKind::Second, 'label' => 'explicit']) {
            throw new RuntimeException('Flattened V params changed a default, explicit case, or null');
        }
        foreach ([7, stdClass::class, VPHP\ReferenceDefaults\ExportedDnfDefault::default_value] as $wrong) {
            try {
                $call(mode: $wrong);
                throw new RuntimeException('Flattened V enum params accepted an incompatible value');
            } catch (TypeError) {
            }
        }
    }

    $externalOptions = [
        VPHP\ReferenceDefaults\localOptions(...),
        VPHP\ReferenceProbe\externalOptions(...),
        $fixture->externalOptions(...),
    ];
    if ($loaded) {
        $externalOptions[] = VPHP\ReferenceProbe\makeExternalOptions();
    }
    foreach ($externalOptions as $call) {
        $signature = new ReflectionFunction($call);
        [$selected, $label] = $signature->getParameters();
        if ($signature->getNumberOfParameters() !== 2 || $signature->getNumberOfRequiredParameters() !== 0
            || $selected->getName() !== 'selected' || (string) $selected->getType() !== '?' . UnitKind::class
            || $selected->getDefaultValueConstantName() !== UnitKind::class . '::Second'
            || $selected->getDefaultValue() !== UnitKind::Second
            || $label->getName() !== 'label' || $label->getDefaultValue() !== 'external') {
            throw new RuntimeException('Cross-module options used metadata from the wrong declaration');
        }
        if ($loaded && ($call() !== ['selected' => UnitKind::Second, 'label' => 'external']
            || $call(label: 'named') !== ['selected' => UnitKind::Second, 'label' => 'named']
            || $call(label: 'explicit', selected: UnitKind::first) !== ['selected' => UnitKind::first, 'label' => 'explicit']
            || $call(selected: null) !== ['selected' => null, 'label' => 'external'])) {
            throw new RuntimeException('Cross-module options changed a default, explicit case, or null');
        }
        try {
            $call(selected: VPHP\ReferenceDefaults\ExportedDnfDefault::default_value);
            throw new RuntimeException('Cross-module options accepted a case of another enum');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), UnitKind::class)) {
                throw $error;
            }
        }
    }

    $manual = new PhpOptionsContract();
    $optionsImpl = new OptionsContractImpl();
    $contract = new ReflectionMethod(OptionsContract::class, 'external_options');
    [$caseParam, $labelParam] = $contract->getParameters();
    if (!$optionsImpl instanceof OptionsContract || !$contract->isAbstract()
        || $contract->getNumberOfRequiredParameters() !== 0
        || $caseParam->getName() !== 'selected' || (string) $caseParam->getType() !== '?' . UnitKind::class
        || $caseParam->getDefaultValueConstantName() !== UnitKind::class . '::Second'
        || $caseParam->getDefaultValue() !== UnitKind::Second || $labelParam->getDefaultValue() !== 'external'
        || $manual->external_options(label: 'named') !== ['selected' => UnitKind::Second, 'label' => 'named']
        || ($loaded && $optionsImpl->external_options(label: 'named') !== ['selected' => UnitKind::Second, 'label' => 'named'])) {
        throw new RuntimeException('Interface options lost their case default, signature, or implementation');
    }

    $GLOBALS['vphp_contract_default_calls'] = 0;
    foreach ([OptionsContract::class => 'contract', OptionsContractImpl::class => 'tail'] as $owner => $expectedLabel) {
        $method = new ReflectionMethod($owner, 'computed_options');
        [$value, $label] = $method->getParameters();
        $marker = $value->getDefaultValue();
        if ($method->getNumberOfRequiredParameters() !== 0 || (string) $value->getType() !== 'string'
            || !is_object($marker) || !$marker->isDynamic() || $label->getDefaultValue() !== $expectedLabel
            || $GLOBALS['vphp_contract_default_calls'] !== 0) {
            throw new RuntimeException('Interface or implementation lost its inert default or explicit override');
        }
    }
    if ($loaded && ($optionsImpl->computed_options() !== 'computed-1:tail'
        || $optionsImpl->computed_options(label: 'named') !== 'computed-2:named'
        || $optionsImpl->computed_options(value: 'explicit') !== 'explicit:tail'
        || $GLOBALS['vphp_contract_default_calls'] !== 2)) {
        throw new RuntimeException('Interface-backed dispatch changed how a computed default is evaluated');
    }

    foreach ([OptionsContract::class, OptionsContractImpl::class, PhpOptionsContract::class] as $owner) {
        $method = new ReflectionMethod($owner, 'renamedOptions');
        [$request, $selected, $message] = $method->getParameters();
        if (!$method->isStatic() || $method->getName() !== 'renamedOptions'
            || $method->isAbstract() !== ($owner === OptionsContract::class)
            || $method->getNumberOfRequiredParameters() !== 1 || $request->getName() !== 'request'
            || $selected->getDefaultValue() !== UnitKind::Second || $message->getName() !== 'message'
            || $message->getDefaultValue() !== 'external' || method_exists($owner, 'renamed_options')) {
            throw new RuntimeException("Unexpected rewritten interface signature for $owner");
        }
        if (($owner === PhpOptionsContract::class || ($loaded && $owner === OptionsContractImpl::class))
            && ($owner::renamedOptions(message: 'named', request: 7) !== '7:named'
                || $owner::renamedOptions(request: 8) !== '8:external')) {
            throw new RuntimeException("Named call failed for $owner");
        }
    }

    $method = new ReflectionMethod(TypedValueContract::class, 'typedValue');
    $inherited = new ReflectionMethod(InheritedTypedValueContract::class, 'typedValue');
    if ((new ReflectionClass(InheritedTypedValueContract::class))->getInterfaceNames() !== [TypedValueContract::class]
        || $inherited->getDeclaringClass()->getName() !== TypedValueContract::class
        || !$optionsImpl instanceof InheritedTypedValueContract
        || !is_subclass_of(PhpTypedValueContract::class, TypedValueContract::class)
        || count($inherited->getAttributes(VphpInterfaceProbeTag::class)) !== 1) {
        throw new RuntimeException('V interface embedding did not preserve the PHP parent or inherited metadata');
    }
    $methodTags = $method->getAttributes(VphpInterfaceProbeTag::class);
    $discard = $method->getAttributes('NoDiscard');
    if (count($methodTags) !== 1 || $methodTags[0]->getArguments() !== ['method', 'metadata' => ['types' => ['int', 'null']]]
        || $methodTags[0]->newInstance()->kind !== 'method'
        || count($discard) !== (int) (PHP_VERSION_ID >= 80500)
        || ($discard !== [] && $discard[0]->newInstance()->message !== 'Use the contract result')
        || (new ReflectionMethod(OptionsContractImpl::class, 'typedValue'))->getAttributes() !== []) {
        throw new RuntimeException('Interface method attributes changed in Reflection');
    }
    [$request, $selected, $message] = (new ReflectionMethod(OptionsContract::class, 'renamedOptions'))->getParameters();
    $parameterTags = $message->getAttributes(VphpInterfaceProbeTag::class);
    if ($request->getAttributes() !== [] || $selected->getAttributes() !== [] || count($parameterTags) !== 1
        || $parameterTags[0]->getArguments() !== ['parameter'] || $parameterTags[0]->newInstance()->kind !== 'parameter') {
        throw new RuntimeException('Interface attribute did not follow the renamed flattened field');
    }

    $expectedType = '(ArrayAccess&Countable)|int|null';
    foreach ([ContractBroker::class, ContractBrokerImpl::class, PhpContractBroker::class] as $owner) {
        $forward = new ReflectionMethod($owner, 'forward');
        [$source, $fallback, $rest] = $forward->getParameters();
        if ((string) $source->getType() !== TypedValueContract::class
            || (string) $fallback->getType() !== '?' . TypedValueContract::class
            || !$rest->isVariadic() || (string) $rest->getType() !== TypedValueContract::class
            || (string) $forward->getReturnType() !== TypedValueContract::class) {
            throw new RuntimeException("Unexpected inferred interface signature for $owner");
        }
    }
    $phpValue = new PhpTypedValueContract();
    $externalName = 'VPHP\\ReferenceExternal\\Contract';
    $echoExternal = new ReflectionFunction('VPHP\\ReferenceProbe\\echoExternalContract');
    $echoAlias = new ReflectionFunction('VPHP\\ReferenceProbe\\echoExternalAlias');
    if (interface_exists($externalName, false) || class_exists($externalName, false)
        || (string) $echoExternal->getParameters()[0]->getType() !== $externalName
        || (string) $echoExternal->getReturnType() !== $externalName
        || (string) $echoAlias->getParameters()[0]->getType() !== $externalName
        || (string) $echoAlias->getReturnType() !== $externalName) {
        throw new RuntimeException('An external PHP interface was registered or lost its signature');
    }
    $option = new ReflectionFunction('VPHP\\ReferenceProbe\\externalContractOption');
    $tailMethod = new ReflectionMethod(ContractBrokerImpl::class, 'externalContractTail');
    if ((string) $option->getParameters()[0]->getType() !== '?' . $externalName
        || !$option->getParameters()[0]->isDefaultValueAvailable()
        || $option->getParameters()[0]->getDefaultValue() !== null
        || !$tailMethod->getParameters()[0]->isVariadic()
        || (string) $tailMethod->getParameters()[0]->getType() !== '?' . $externalName) {
        throw new RuntimeException('A nullable external interface argument lost its signature');
    }
    eval('namespace VPHP\\ReferenceExternal; interface Contract {}');
    if ($loaded) {
        $external = new class implements \VPHP\ReferenceExternal\Contract {};
        $broker = new ContractBrokerImpl();
        if (VPHP\ReferenceProbe\echoExternalContract(value: $external) !== $external
            || VPHP\ReferenceProbe\echoExternalAlias(value: $external) !== $external
            || VPHP\ReferenceProbe\externalContractOption() !== null
            || VPHP\ReferenceProbe\externalContractOption(value: null) !== null
            || VPHP\ReferenceProbe\externalContractOption(value: $external) !== $external
            || $broker->externalContractTail() !== null
            || $broker->externalContractTail(null, $external) !== $external
            || $broker->externalContractTail($external, null) !== null
            || VPHP\ReferenceProbe\tryExternalContract($external) !== $external
            || VPHP\ReferenceProbe\tryExternalContract(new stdClass()) !== null) {
            throw new RuntimeException('External interface conversion changed object identity or accepted an unrelated class');
        }
        foreach ([$echoExternal, $echoAlias] as $function) {
            try {
                ($function->getName())(new stdClass());
                throw new RuntimeException('External interface arginfo accepted an unrelated object');
            } catch (TypeError $error) {
                if (!str_contains($error->getMessage(), $externalName)) {
                    throw $error;
                }
            }
        }
        $tail = VPHP\ReferenceProbe\makeExternalAliasTail();
        $reflection = new ReflectionFunction($tail);
        $parameter = $reflection->getParameters()[0];
        if (!$parameter->isVariadic()
            || (string) $parameter->getType() !== '?' . $externalName
            || (string) $reflection->getReturnType() !== '?' . $externalName
            || $tail() !== null || $tail(null, $external) !== $external
            || $tail($external, null) !== null) {
            throw new RuntimeException('A nullable interface alias lost its variadic closure type or value');
        }
        try {
            $tail(new stdClass());
            throw new RuntimeException('A variadic interface alias accepted an unrelated object');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), 'Argument #1:')) {
                throw $error;
            }
        }
    }
    foreach (['makeContractIdentity', 'makeContractOptions', 'makeContractTail', 'makeContractChoice'] as $factory) {
        $function = 'VPHP\\ReferenceProbe\\' . $factory;
        if ((string) (new ReflectionFunction($function))->getReturnType() !== Closure::class) {
            throw new RuntimeException('A typed interface closure factory lost its Closure signature');
        }
    }
    if ($loaded) {
        $identity = VPHP\ReferenceProbe\makeContractIdentity();
        $optionsCallback = VPHP\ReferenceProbe\makeContractOptions();
        $tail = VPHP\ReferenceProbe\makeContractTail();
        $choice = VPHP\ReferenceProbe\makeContractChoice();
        foreach ([$identity, $optionsCallback, $tail] as $callback) {
            $reflection = new ReflectionFunction($callback);
            $parameter = $reflection->getParameters()[0];
            $type = ($callback === $identity ? '' : '?') . TypedValueContract::class;
            if ((string) $parameter->getType() !== $type || (string) $reflection->getReturnType() !== $type
                || $parameter->isVariadic() !== ($callback === $tail)) {
                throw new RuntimeException('A typed interface closure lost its parameter or return type');
            }
            try {
                $callback(new stdClass());
                throw new RuntimeException('A typed interface closure accepted an unrelated object');
            } catch (TypeError) {
            }
        }
        if ($identity(value: $phpValue) !== $phpValue || $optionsCallback(value: $optionsImpl) !== $optionsImpl
            || $optionsCallback() !== null || $tail() !== null || $tail($phpValue, null) !== null
            || $tail(null, $phpValue, $optionsImpl) !== $optionsImpl) {
            throw new RuntimeException('A typed interface closure changed an object or nullable argument');
        }
        $rest = (new ReflectionFunction($choice))->getParameters()[1];
        if (!$rest->isVariadic() || (string) $rest->getType() !== TypedValueContract::class
            || $choice(first: $phpValue) !== $phpValue || $choice($phpValue, $optionsImpl) !== $optionsImpl) {
            throw new RuntimeException('A typed interface variadic tail changed its type or selected object');
        }
        try {
            $choice($phpValue, null);
            throw new RuntimeException('A non-nullable interface variadic tail accepted null');
        } catch (TypeError) {
        }
    }
    $cast = new ReflectionFunction('VPHP\ReferenceProbe\tryValueContract');
    if ((string) $cast->getReturnType() !== '?' . TypedValueContract::class
        || ($loaded && (VPHP\ReferenceProbe\tryValueContract($phpValue) !== $phpValue
            || VPHP\ReferenceProbe\tryValueContract(new stdClass()) !== null))) {
        throw new RuntimeException('Explicit conversion to a typed PHP interface lost its PHP type or identity');
    }
    $brokers = [new PhpContractBroker()];
    if ($loaded) {
        $brokers[] = new ContractBrokerImpl();
    }
    foreach ($brokers as $broker) {
        if ($broker->forward(fallback: null, source: $phpValue) !== $phpValue
            || $broker->forward($optionsImpl, $phpValue) !== $phpValue
            || $broker->forward($phpValue, null, $optionsImpl) !== $optionsImpl) {
            throw new RuntimeException('An interface-typed call changed the original PHP object');
        }
        try {
            $broker->forward(new stdClass(), null);
            throw new RuntimeException('An interface-typed call accepted an unrelated object');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), TypedValueContract::class)) {
                throw $error;
            }
        }
    }
    foreach ([TypedValueContract::class, OptionsContractImpl::class, PhpTypedValueContract::class] as $owner) {
        $typed = new ReflectionMethod($owner, 'typedValue');
        $inputType = $owner === PhpTypedValueContract::class ? 'mixed' : $expectedType;
        if (!$optionsImpl instanceof TypedValueContract
            || $typed->getParameters()[0]->getName() !== 'value'
            || composedStaticPropertyType($typed->getParameters()[0]->getType()) !== $inputType
            || composedStaticPropertyType($typed->getReturnType()) !== $expectedType) {
            throw new RuntimeException("Unexpected declared interface types for $owner");
        }
    }
    $case = VPHP\ReferenceDefaults\ExportedDnfDefault::default_value;
    $bridged = [new PhpTypedValueContract()];
    if ($loaded) {
        $bridged[] = $optionsImpl;
    }
    foreach ($bridged as $implementation) {
        foreach ([$case, 37, null] as $valid) {
            if ($implementation->typedValue(value: $valid) !== $valid) {
                throw new RuntimeException('Interface DNF dispatch changed an accepted value');
            }
        }
    }
    try {
        $optionsImpl->typedValue(value: new class implements Countable {
            public function count(): int { return 0; }
        });
        throw new RuntimeException('Interface DNF dispatch accepted a single-interface object');
    } catch (TypeError $error) {
        if (!str_contains($error->getMessage(), 'Countable') || !str_contains($error->getMessage(), 'ArrayAccess')) {
            throw $error;
        }
    }
})();
