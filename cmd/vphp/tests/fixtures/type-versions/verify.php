<?php
declare(strict_types=1);

namespace VphpTypeGate;

if (isset($argv[1])) {
    require $argv[1];
}

function expect(bool $condition, string $message): void
{
    if (!$condition) {
        throw new \RuntimeException($message);
    }
}

$php85 = PHP_VERSION_ID >= 80500;
$php86 = PHP_VERSION_ID >= 80600;
expect(interface_exists(Contract::class, false) === $php85, 'interface version');
expect(interface_exists(ChildContract::class, false) === $php85, 'interface inherits the version');
expect(class_exists(Base::class, false) === $php85, 'implementation inherits the version');
expect(class_exists(Child::class, false) === $php85, 'subclass inherits the version');
expect(class_exists(Future::class, false) === $php86, 'class version');
expect(class_exists(FutureStream::class, false) === $php86, 'class with newer native parent');
expect(function_exists(__NAMESPACE__ . '\\acceptChild') === $php85, 'function follows an inherited type version');
foreach (['createFuture', 'acceptFuture', 'acceptCompound', 'createConfigured', 'configuredValue'] as $function) {
    expect(function_exists(__NAMESPACE__ . '\\' . $function) === $php86, $function . ' version');
}
expect(trait_exists(Source::class, false) === $php86, 'trait version');
expect(trait_exists(Combined::class, false) === $php86, 'trait composition inherits the version');
expect(enum_exists(Kind::class, false) === $php86, 'enum version');

$host = new \ReflectionClass(AliasHost::class);
expect($host->hasConstant('READY') === $php86, 'always available class gates the case alias');
expect($host->hasMethod('configuredValue') === $php86, 'explicit method version');
if ($php85) {
    expect(is_subclass_of(Child::class, Base::class), 'PHP class inheritance');
    expect(is_subclass_of(Child::class, Contract::class), 'PHP interface inheritance');
    $child = new \ReflectionFunction(__NAMESPACE__ . '\\acceptChild');
    expect((string) $child->getParameters()[0]->getType() === Child::class, 'inferred subclass parameter');
    if (!isset($argv[1])) {
        expect(acceptChild(value: new Child()) === 85, 'gated inherited type can be passed from PHP');
    }
}
if ($php86) {
    expect(is_subclass_of(FutureStream::class, \StreamException::class), 'new native parent is inherited');
    expect(AliasHost::READY === Kind::ready, 'enum case alias preserves identity');
    expect((new \ReflectionClass(Future::class))->implementsInterface(\Countable::class), 'external interface binding');
    expect((string) (new \ReflectionFunction(__NAMESPACE__ . '\\createFuture'))->getReturnType() === Future::class, 'factory return type');
    $accept = new \ReflectionFunction(__NAMESPACE__ . '\\acceptFuture');
    expect((string) $accept->getParameters()[0]->getType() === Future::class, 'inferred factory object parameter');
    $compound = new \ReflectionFunction(__NAMESPACE__ . '\\acceptCompound');
    expect((string) $compound->getParameters()[0]->getType() === '(' . Future::class . '&Countable)|int', 'DNF parameter type');
    $defaults = [
        (new \ReflectionFunction(__NAMESPACE__ . '\\createConfigured'))->getParameters()[0],
        (new \ReflectionFunction(__NAMESPACE__ . '\\configuredValue'))->getParameters()[1],
        (new \ReflectionMethod(Future::class, 'configuredValue'))->getParameters()[0],
        $host->getMethod('configuredValue')->getParameters()[0],
    ];
    foreach ($defaults as $parameter) {
        expect($parameter->getName() === 'value' && $parameter->getDefaultValue()->isDynamic(), 'computed default reflection');
    }
    class Consumer { use Combined; }
    if (!isset($argv[1])) {
        $future = createFuture();
        expect(count($future) === 86, 'gated class can be returned to PHP');
        expect(acceptFuture(value: $future) === 86, 'gated type can be passed from PHP');
        expect(acceptCompound(value: $future) === $future && acceptCompound(7) === 7, 'gated DNF members work in PHP');
        expect(count(createConfigured()) === 42 && count(createConfigured(increment: 1)) === 43, 'gated factory resolves computed defaults');
        expect(count(createConfigured(value: 7, increment: 1)) === 8, 'gated factory preserves explicit values');
        expect($future->configuredValue() === 42 && $future->configuredValue(value: 7) === 7, 'method on gated class resolves defaults');
        $aliasHost = new AliasHost();
        expect($aliasHost->configuredValue() === 42 && $aliasHost->configuredValue(value: 7) === 7, 'explicitly gated method resolves defaults');
        expect(configuredValue(new Base()) === 42 && configuredValue(base: new Base(), increment: 1) === 43, 'explicitly gated function resolves defaults');
        expect((new Consumer())->label() === 'trait', 'gated trait method works in PHP');
    }
}
