<?php
declare(strict_types=1);

namespace VPHP\AttributeConstants;

const VPHP_DEFAULT_OPTIONS = -1;
const PHP_INT_SIZE = -1;
define('VPHP_DEFAULT_OPTIONS', 40);

#[\Attribute(\Attribute::TARGET_ALL | \Attribute::IS_REPEATABLE)]
final class Tag
{
    public array $arguments;

    public function __construct(mixed ...$arguments)
    {
        $this->arguments = $arguments;
    }
}

if (isset($argv[1])) {
    require $argv[1];
}

class TraitConsumer
{
    use ComposedTrait;
}

$deprecationSupported = PHP_VERSION_ID >= 80400;
$warnings = [];
set_error_handler(static function (int $severity, string $message) use (&$warnings): bool {
    $warnings[] = [$severity, $message];
    return true;
}, E_DEPRECATED | E_USER_DEPRECATED);
try {
    $values = [];
    for ($pass = 0; $pass < 2; $pass++) {
        $values[] = [Subject::LEGACY_LEVEL, Contract::LEGACY, TraitConsumer::LEGACY, Mode::legacy];
    }
} finally {
    restore_error_handler();
}
$expectedWarnings = [];
foreach ([
    [Subject::class, 'LEGACY_LEVEL', ['message' => 'Use LEVEL', 'since' => '2.0'], ' since 2.0, Use LEVEL'],
    [Contract::class, 'LEGACY', [], ''],
    [TraitConsumer::class, 'LEGACY', ['message' => 'Use the new value'], ', Use the new value'],
    [Mode::class, 'legacy', ['message' => 'Use active'], ', Use active'],
] as [$owner, $name, $arguments, $suffix]) {
    $constant = new \ReflectionClassConstant($owner, $name);
    $attributes = $constant->getAttributes(\Deprecated::class);
    if (count($attributes) !== (int) $deprecationSupported || ($deprecationSupported && (
        !$constant->isDeprecated() || $attributes[0]->getArguments() !== $arguments
    ))) {
        throw new \RuntimeException("Unexpected deprecation metadata for {$owner}::{$name}");
    }
    if ($deprecationSupported) {
        $declaring = $constant->getDeclaringClass();
        $expectedWarnings[] = [
            $declaring->isInternal() ? E_DEPRECATED : E_USER_DEPRECATED,
            ($constant->isEnumCase() ? 'Enum case ' : 'Constant ') . $declaring->getName()
                . "::{$name} is deprecated{$suffix}",
        ];
    }
}
if ($values !== array_fill(0, 2, [7, 5, 6, Mode::cases()[1]])
    || $warnings !== [...$expectedWarnings, ...$expectedWarnings]) {
    throw new \RuntimeException('Unexpected constant deprecation: ' . var_export($warnings, true));
}

// Resolve the dependency only after the stub or extension has declared its attributes.
spl_autoload_register(static function (string $class): void {
    if (in_array($class, ['ExternalLibrary\\Constants', 'ExternalLibrary\\DefaultOptions'], true)) {
        require_once __DIR__ . '/external_constants.php';
    }
});

function expect_attribute(object $owner, array $expected): void
{
    $attributes = $owner->getAttributes(Tag::class);
    if (count($attributes) !== 1 || $attributes[0]->getArguments() !== $expected
        || $attributes[0]->newInstance()->arguments !== $expected) {
        throw new \RuntimeException('Unexpected constant-valued PHP attribute on ' . $owner->getName());
    }
}

$subject = new \ReflectionClass(Subject::class);
$expectedDefault = ['subject value', 8, 42, 42, 40, 40, 'nested' => [Mode::active, 42]];
$parameter = $subject->getMethod('defaultOptions')->getParameters()[0];
if ($parameter->isDefaultValueConstant() || $parameter->getDefaultValue() !== $expectedDefault) {
    throw new \RuntimeException('The compound default lost its declaration scope');
}
if (\ExternalLibrary\DefaultOptions::$created !== 0) {
    throw new \RuntimeException('Declaring the object default ran its constructor');
}
$objectFunction = new \ReflectionFunction(__NAMESPACE__ . '\\defaultObject');
expect_attribute($objectFunction, [42]);
$constructorDefault = $objectFunction->getParameters()[0];
$object = $constructorDefault->getDefaultValue();
if (!$object instanceof \ExternalLibrary\DefaultOptions || $object->label !== 'literal'
    || $object->limit !== \PHP_INT_SIZE || \ExternalLibrary\DefaultOptions::$created !== 1) {
    throw new \RuntimeException('Reflection changed the declared object default');
}
if (extension_loaded('attribute_constants_probe')) {
    $instance = new Subject();
    if ($instance->defaultOptions() !== $expectedDefault
        || $instance->defaultOptions(tail: 'named') !== $expectedDefault
        || $instance->defaultOptions(options: null) !== null
        || defaultObject(null) !== null || \ExternalLibrary\DefaultOptions::$created !== 1) {
        throw new \RuntimeException('Position, named or explicit defaults did not agree');
    }
    $first = defaultObject();
    $second = defaultObject(tail: 'named');
    if (!$first instanceof \ExternalLibrary\DefaultOptions || !$second instanceof \ExternalLibrary\DefaultOptions
        || $first === $second || $first->label !== 'literal' || $second->limit !== \PHP_INT_SIZE
        || \ExternalLibrary\DefaultOptions::$created !== 3) {
        throw new \RuntimeException('Omitted object defaults were not constructed independently');
    }
}
expect_attribute($subject, [
    'subject value',
    8,
    Subject::class,
    ParentType::class,
    \DateTimeInterface::class,
    'option' => ['format' => [Mode::active, \DateTimeInterface::ATOM]],
]);
$method = $subject->getMethod('inspect');
expect_attribute($method, ['subject value', 42]);
expect_attribute($method->getParameters()[0], ['caseValue' => Mode::active, 'externalCase' => Mode::active]);
$sensitiveMethod = $subject->getMethod('inspectSensitive');
$sensitiveFunction = new \ReflectionFunction(__NAMESPACE__ . '\\inspectSecrets');
$sensitiveOptions = new \ReflectionFunction(__NAMESPACE__ . '\\inspectSensitiveOptions');
foreach ([[$sensitiveMethod, 'apiKey', false], [$sensitiveFunction, 'secrets', true],
    [$sensitiveOptions, 'apiKey', false]] as [$callable, $name, $variadic]) {
    [$public, $secret] = $callable->getParameters();
    $metadata = $secret->getAttributes(\SensitiveParameter::class);
    if ($callable->getNumberOfParameters() !== 2 || $public->getName() !== 'label'
        || $public->getAttributes(\SensitiveParameter::class) !== [] || $secret->getName() !== $name
        || $secret->isVariadic() !== $variadic || count($metadata) !== 1
        || !$metadata[0]->newInstance() instanceof \SensitiveParameter) {
        throw new \RuntimeException('Unexpected PHP-sensitive parameter metadata');
    }
}

if (PHP_VERSION_ID >= 80600) {
    $parameter = (new \ReflectionFunction(__NAMESPACE__ . '\\partialOptions'))->getParameters()[1];
    $descriptor = $parameter->getDefaultValue();
    if (!is_object($descriptor) || !method_exists($descriptor, 'isDynamic')
        || (!isset($argv[1]) && !$descriptor->isDynamic())) {
        throw new \RuntimeException('Reflection lost the deferred partial option');
    }
    $partial = eval('return \\VPHP\\AttributeConstants\\partialOptions("fixed", enabled: ?);');
    $parameters = (new \ReflectionFunction($partial))->getParameters();
    if (count($parameters) !== 1 || $parameters[0]->getName() !== 'enabled'
        || (string) $parameters[0]->getType() !== 'bool' || $parameters[0]->isOptional()) {
        throw new \RuntimeException('Unexpected signature for the named partial placeholder');
    }
    $sensitive = eval('return (new \\VPHP\\AttributeConstants\\Subject())->inspectSensitive("visible", ?);');
    $attributes = (new \ReflectionFunction($sensitive))->getParameters()[0]->getAttributes(\SensitiveParameter::class);
    if (count($attributes) !== 1 || !$attributes[0]->newInstance() instanceof \SensitiveParameter) {
        throw new \RuntimeException('Partial application lost the sensitive parameter');
    }
    if (!isset($argv[1]) && ($partial(enabled: false) !== 'fixed:1:false' || $partial(enabled: true) !== 'fixed:2:true')) {
        throw new \RuntimeException('The partial application failed to reevaluate the V default');
    }
}

if (!isset($argv[1])) {
    ini_set('zend.exception_ignore_args', '0');
    $firstClosure = makeSensitiveClosure();
    $closure = makeSensitiveClosure();
    unset($firstClosure);
    $parameter = (new \ReflectionFunction($closure))->getParameters()[0];
    $attributes = $parameter->getAttributes(\SensitiveParameter::class);
    if (count($attributes) !== 1 || !$attributes[0]->newInstance() instanceof \SensitiveParameter
        || $parameter->getDefaultValue() !== '' || $closure() !== '') {
        throw new \RuntimeException('The struct closure lost its parameter metadata or default');
    }
    try {
        $closure(...[$parameter->getName() => 'synthetic-closure']);
        throw new \LogicException('Expected the sensitive argument to reach the closure');
    } catch (\Exception $error) {
        $redacted = $error->getTrace()[0]['args'][0] ?? null;
        if ($error->getMessage() !== 'closure trace' || !$redacted instanceof \SensitiveParameterValue
            || $redacted->getValue() !== 'synthetic-closure') {
            throw new \RuntimeException('The closure trace did not mask the sensitive field');
        }
    }
    $parameters = ['roundtrip', 'synthetic-positional', 'named' => 'synthetic-named'];
    if (call_user_func_array(__NAMESPACE__ . '\\inspectSecrets', $parameters) !== 'synthetic-positional|synthetic-named'
        || $parameters !== ['roundtrip', 'synthetic-positional', 'named' => 'synthetic-named']) {
        throw new \RuntimeException('Redaction changed the actual variadic arguments');
    }
    foreach ([
        [static fn () => (new Subject())->inspectSensitive(apiKey: 'synthetic-key', label: 'visible'), [1 => 'synthetic-key']],
        [static fn () => inspectSecrets('visible', 'synthetic-positional', named: 'synthetic-named'),
            [1 => 'synthetic-positional', 'named' => 'synthetic-named']],
        [static fn () => inspectSensitiveOptions(apiKey: 'synthetic-option', label: 'visible'), [1 => 'synthetic-option']],
    ] as [$call, $secretValues]) {
        try {
            $call();
            throw new \LogicException('Expected an exception from the native bridge');
        } catch (\Exception $error) {
            $args = $error->getTrace()[0]['args'] ?? [];
            if ($error->getMessage() !== 'test trace' || ($args[0] ?? null) !== 'visible') {
                throw new \RuntimeException('Unexpected PHP-sensitive trace frame');
            }
            foreach ($secretValues as $key => $value) {
                if (!($args[$key] ?? null) instanceof \SensitiveParameterValue
                    || $args[$key]->getValue() !== $value || str_contains($error->getTraceAsString(), $value)) {
                    throw new \RuntimeException('PHP did not redact a sensitive value in the trace');
                }
            }
        }
    }

    try {
        inspectSecrets(12, named: 'synthetic-before-dispatch');
        throw new \LogicException('Expected the visible parameter type to be checked');
    } catch (\TypeError $error) {
        $secret = $error->getTrace()[0]['args']['named'] ?? null;
        if (!$secret instanceof \SensitiveParameterValue || $secret->getValue() !== 'synthetic-before-dispatch') {
            throw new \RuntimeException('Argument validation exposed a sensitive named value');
        }
    }
}
expect_attribute(new \ReflectionFunction(__NAMESPACE__ . '\\plain'), [
    \DateTimeInterface::ATOM,
    'caseValue' => Mode::active,
]);


expect_attribute($subject->getProperty('value'), [42]);
expect_attribute($subject->getReflectionConstant('LABEL'), [42]);
expect_attribute((new \ReflectionEnum(Mode::class))->getCase('active'), [42]);
if (PHP_VERSION_ID >= 80500) {
    expect_attribute(new \ReflectionConstant(__NAMESPACE__ . '\\VERSION'), [42]);
}

$repeated = new \ReflectionClass(Repeated::class);
$actual = array_map(static fn (\ReflectionAttribute $attribute) => $attribute->getArguments(), $repeated->getAttributes());
if ($actual !== [[1], [2, 'option' => ['before', 4 => ['雪', 42], 5 => 'after']]]) {
    throw new \RuntimeException('Unexpected repeated attribute order or array keys');
}

if (PHP_VERSION_ID >= 80400) {
    $hook = (new \ReflectionProperty(HookOwner::class, 'score'))->getHooks()['set'];
    expect_attribute($hook, [42]);
    expect_attribute($hook->getParameters()[0], [4]);
} elseif (property_exists(HookOwner::class, 'score')) {
    throw new \RuntimeException('Property hooks must stay hidden before PHP 8.4');
}

expect_attribute(new \ReflectionMethod(TraitConsumer::class, 'label'), [42]);
