<?php
declare(strict_types=1);

if (isset($argv[1])) {
    require $argv[1];
}

$constantExports = extension_loaded('lazy_objects_probe')
    ? (new ReflectionExtension('lazy_objects_probe'))->getConstants() : null;
foreach (['VALUE85' => [80500, '雪'], 'VALUE86' => [80600, 86]] as $name => [$version, $value]) {
    $fullName = 'VphpProbe\\' . $name;
    $available = PHP_VERSION_ID >= $version;
    if (defined($fullName) !== $available || ($available && constant($fullName) !== $value)
        || ($constantExports !== null && array_key_exists($fullName, $constantExports) !== $available)
        || ($available && $constantExports !== null && $constantExports[$fullName] !== $value)) {
        throw new RuntimeException("Unexpected availability or value for $fullName");
    }
}
if (PHP_VERSION_ID >= 80600) {
    $constant = new ReflectionConstant('VphpProbe\\VALUE86');
    $attributes = $constant->getAttributes('VphpLazyTag');
    if ($constant->getValue() !== 86 || count($attributes) !== 1
        || $attributes[0]->getTarget() !== Attribute::TARGET_CONSTANT
        || $attributes[0]->getArguments() !== ['version' => 86]) {
        throw new RuntimeException('The gated constant lost its value or attribute');
    }
}

class VersionedConstantChild extends VphpProbe\VersionedClass implements VphpProbe\Contract {
    use VphpProbe\OuterTrait;
}

$ready = VphpProbe\Mode::ready;
if (VphpProbe\Mode::cases() !== [$ready]) {
    throw new RuntimeException('The enum alias changed the native case list');
}
foreach ([
    [VphpProbe\Mode::class, 'ALIAS', 80600, $ready],
    [VphpProbe\Contract::class, 'FEATURE', 80600, $ready],
    [VphpProbe\VersionedClass::class, 'LEVEL', 80500, 85],
    [VphpProbe\SourceTrait::class, 'OPTION', 80500, $ready],
    [VphpProbe\CombinedTrait::class, 'OPTION', 80500, $ready],
    [VphpProbe\OuterTrait::class, 'OPTION', 80500, $ready],
    [VersionedConstantChild::class, 'FEATURE', 80600, $ready],
    [VersionedConstantChild::class, 'LEVEL', 80500, 85],
    [VersionedConstantChild::class, 'OPTION', 80500, $ready],
] as [$owner, $name, $version, $value]) {
    $member = (new ReflectionClass($owner))->getReflectionConstant($name);
    if (($member !== false) !== (PHP_VERSION_ID >= $version)) {
        throw new RuntimeException("Unexpected availability of $owner::$name");
    }
    if ($member === false) {
        continue;
    }
    if ($member->getValue() !== $value || $member->isEnumCase()
        || (string) $member->getType() !== (is_int($value) ? 'int' : VphpProbe\Mode::class)) {
        throw new RuntimeException("Unexpected value or type of $owner::$name");
    }
    if ($name === 'LEVEL' && (!$member->isFinal() || !$member->isProtected()
        || $member->getDeclaringClass()->getName() !== VphpProbe\VersionedClass::class)) {
        throw new RuntimeException("Unexpected metadata on $owner::$name");
    }
    if ($name === 'OPTION') {
        $attrs = $member->getAttributes('VphpLazyTag');
        $source = PHP_VERSION_ID >= 80600 && $owner !== VphpProbe\SourceTrait::class
            ? 'combined' : 'base';
        if (count($attrs) !== 1 || $attrs[0]->getArguments() !== ['source' => $source]) {
            throw new RuntimeException("Unexpected trait metadata on $owner::$name");
        }
    }
}

foreach (['baseline' => 80200, 'since85' => 80500, 'since86' => 80600] as $name => $version) {
    $fullName = 'VphpProbe\\' . $name;
    if (function_exists($fullName) !== (PHP_VERSION_ID >= $version)) {
        throw new RuntimeException("Unexpected availability of $fullName");
    }
}
if (PHP_VERSION_ID >= 80600) {
    $function = new ReflectionFunction('VphpProbe\\since86');
    $parameter = $function->getParameters()[0];
    $types = array_map(strval(...), $parameter->getType()->getTypes());
    sort($types);
    $returnTypes = array_map(strval(...), $function->getReturnType()->getTypes());
    sort($returnTypes);
    if ($function->getName() !== 'VphpProbe\\since86'
        || $function->getNumberOfRequiredParameters() !== 0 || $parameter->getName() !== 'value'
        || !in_array($types, [['ArrayAccess&Countable', 'int'], ['Countable&ArrayAccess', 'int']], true)
        || $returnTypes !== $types
        || !$parameter->isDefaultValueConstant()
        || ltrim($parameter->getDefaultValueConstantName(), '\\') !== 'VphpProbe\\VALUE86'
        || $parameter->getDefaultValue() !== 86 || count($function->getAttributes('VphpLazyTag')) !== 1) {
        throw new RuntimeException('The gated function lost its signature, default, or attribute');
    }
}
if (!isset($argv[1])) {
    $exports = get_extension_funcs('lazy_objects_probe');
    if (\VphpProbe\baseline() !== 82
        || (PHP_VERSION_ID >= 80500 && \VphpProbe\since85() !== 85)
        || in_array('VphpProbe\\since86', $exports, true) !== (PHP_VERSION_ID >= 80600)) {
        throw new RuntimeException('The function table does not match the PHP SDK');
    }
    if (PHP_VERSION_ID >= 80600) {
        $value = new ArrayObject();
        if (\VphpProbe\since86() !== 86 || \VphpProbe\since86(value: $value) !== $value) {
            throw new RuntimeException('The gated function lost its default or object identity');
        }
        try {
            \VphpProbe\since86(value: new class implements Countable {
                public function count(): int { return 0; }
            });
            throw new RuntimeException('The gated function accepted an incompatible argument');
        } catch (TypeError) {
        }
    }
}

$signature = new ReflectionClass(VphpLazyProbe::class);
foreach (['ghost' => 80400, 'proxy' => 80400, 'pending' => 80400, 'initialize' => 80400, 'since85' => 80500, 'since86' => 80600] as $method => $version) {
    if ($signature->hasMethod($method) !== (PHP_VERSION_ID >= $version)) {
        throw new RuntimeException("Unexpected availability of $method");
    }
}
if (PHP_VERSION_ID >= 80500) {
    $method = $signature->getMethod('since85');
    $branches = array_map(strval(...), $method->getParameters()[0]->getType()->getTypes());
    sort($branches);
    if (count($method->getAttributes('VphpLazyTag')) !== 1 || $branches !== ['int', 'string']) {
        throw new RuntimeException('The gated method lost its arginfo or attribute');
    }
    if (!isset($argv[1]) && VphpLazyProbe::since85(value: 85) !== '85') {
        throw new RuntimeException('The 8.5 method did not accept a named argument');
    }
}
if (PHP_VERSION_ID >= 80600) {
    $method = $signature->getMethod('since86');
    $parameter = $method->getParameters()[0];
    $branches = array_map(strval(...), $parameter->getType()->getTypes());
    sort($branches);
    if ($branches !== ['int', 'string'] || $parameter->getName() !== 'value'
        || $parameter->getDefaultValue() !== 42 || (string) $method->getReturnType() !== 'string'
        || count($method->getAttributes('VphpLazyTag')) !== 1) {
        throw new RuntimeException('The 8.6 method lost its signature, default, or attribute');
    }
    if (!isset($argv[1]) && (VphpLazyProbe::since86() !== '42'
        || VphpLazyProbe::since86(value: 'named') !== 'named')) {
        throw new RuntimeException('The 8.6 method did not accept a default or named argument');
    }
}
if (PHP_VERSION_ID >= 80400) {
    $ghost = $signature->getMethod('ghost');
    if ($ghost->getParameters()[0]->getName() !== 'className' || (string) $ghost->getReturnType() !== 'object') {
        throw new RuntimeException('The ghost export lost its signature');
    }
}
if (isset($argv[1])) {
    return;
}
if (VphpLazyProbe::supported() !== (PHP_VERSION_ID >= 80400)) {
    throw new RuntimeException('The lazy-object capability disagrees with the compiled PHP target');
}
if (PHP_VERSION_ID < 80400) {
    return;
}

class VphpUserLazyService {
    public string $name;
}

$attempts = 0;
$failure = new RuntimeException('first initializer attempt');
$ghost = VphpLazyProbe::ghost(className: VphpUserLazyService::class, initializer:
    static function (VphpUserLazyService $instance) use (&$attempts, $failure): void {
        if (++$attempts === 1) {
            $instance->name = 'partial';
            throw $failure;
        }
        $instance->name = 'ready';
    }
);
if (!$ghost instanceof VphpUserLazyService || !VphpLazyProbe::pending($ghost) || $attempts !== 0) {
    throw new RuntimeException('Creating a ghost ran its initializer');
}
try {
    VphpLazyProbe::initialize($ghost);
    throw new RuntimeException('Expected the initializer exception');
} catch (RuntimeException $error) {
    if ($error !== $failure || !VphpLazyProbe::pending($ghost)) {
        throw $error;
    }
}
if (VphpLazyProbe::initialize($ghost) !== $ghost || VphpLazyProbe::pending($ghost)
    || $ghost->name !== 'ready' || $attempts !== 2 || VphpLazyProbe::initialize($ghost) !== $ghost) {
    throw new RuntimeException('The ghost did not preserve identity or retry through Zend');
}
try {
    VphpLazyProbe::ghost(ArrayObject::class, static function (): void {});
    throw new RuntimeException('An unsupported native class accepted a ghost');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'internal')) {
        throw $error;
    }
}

$instance = new VphpUserLazyService();
$instance->name = 'proxy instance';
$proxy = VphpLazyProbe::proxy(static fn (VphpUserLazyService $self): VphpUserLazyService => $instance);
if ($proxy === $instance || !VphpLazyProbe::pending($proxy)
    || VphpLazyProbe::initialize($proxy) !== $instance || VphpLazyProbe::pending($proxy)
    || $proxy->name !== 'proxy instance') {
    throw new RuntimeException('Explicit initialization did not return the proxy backing object');
}

$invalid = VphpLazyProbe::proxy(static fn () => new stdClass());
try {
    VphpLazyProbe::initialize($invalid);
    throw new RuntimeException('Expected the native proxy type check to fail');
} catch (TypeError) {
    if (!VphpLazyProbe::pending($invalid)) {
        throw new RuntimeException('An incompatible backing object left an initialized proxy');
    }
}
