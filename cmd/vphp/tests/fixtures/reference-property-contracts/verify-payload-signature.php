<?php
declare(strict_types=1);

use VPHP\ReferenceDefaults\Payload;
use VPHP\ReferenceDefaults\PayloadOwner;
use VPHP\ReferenceProbe\PayloadReader;
use VPHP\ReferenceProbe\PayloadReaderImpl;

require_once __DIR__ . '/scalar-union-weak-call.php';

final class PhpPayloadReader implements PayloadReader
{
    public function read(Payload $payload): int
    {
        return $payload->marker;
    }
}

final readonly class PhpWrappedPayload extends Payload {}

(static function (): void {
    foreach (['makeMixedSumCallback', 'makeMixedPayloadCallback'] as $name) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("$name lost its factory signature");
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }
    $sum = VPHP\ReferenceProbe\makeMixedSumCallback();
    $select = VPHP\ReferenceProbe\makeMixedPayloadCallback();
    foreach ([
        [$sum, ['base', 'offsets'], ['int', 'int'], 1, 'int'],
        [$select, ['fallback', 'payloads'], ['?' . Payload::class, '?' . Payload::class], 0, '?' . Payload::class],
    ] as [$callback, $names, $types, $required, $return]) {
        $signature = new ReflectionFunction($callback);
        $params = $signature->getParameters();
        if (!$signature->isVariadic() || $signature->getNumberOfRequiredParameters() !== $required
            || (string) $signature->getReturnType() !== $return || !$params[1]->isVariadic()
            || array_map(static fn ($p) => $p->getName(), $params) !== $names
            || array_map(static fn ($p) => (string) $p->getType(), $params) !== $types
            || ($required === 0 && $params[0]->getDefaultValue() !== null)) {
            throw new RuntimeException('Unexpected mixed closure signature');
        }
    }
    $fallback = new Payload(11);
    $selected = new PhpWrappedPayload(73);
    if ($sum(base: 10) !== 10 || $sum(3, 4, 5) !== 12 || callClosureWeakly($sum, '3', '4', 5.0) !== 12
        || $select() !== null
        || $select(fallback: $fallback) !== $fallback || $select(null, $fallback, $selected) !== $selected
        || $select($fallback, $selected, null) !== null) {
        throw new RuntimeException('Mixed closure lost a fixed argument, tail order or object identity');
    }
    $unbound = (new ReflectionClass(Payload::class))->newInstanceWithoutConstructor();
    foreach ([
        [static fn () => $sum(), ArgumentCountError::class, 'argument'],
        [static fn () => $sum(1, 2, new stdClass()), TypeError::class, 'Argument #3'],
        [static fn () => $sum(1, 2.5), TypeError::class, 'Argument #2'],
        [static fn () => $sum('1', 2), TypeError::class, 'argument 1 (base): type mismatch'],
        [static fn () => $sum(1, '2'), TypeError::class, 'Argument #2'],
        [static fn () => $select($fallback, $unbound), TypeError::class, 'Argument #2'],
        [static fn () => $sum(base: 1, offset: 2), ArgumentCountError::class, 'named'],
    ] as [$call, $class, $message]) {
        try {
            $call();
            throw new RuntimeException('Mixed closure accepted an invalid call');
        } catch (Throwable $error) {
            if (get_class($error) !== $class || !str_contains($error->getMessage(), $message)) {
                throw $error;
            }
        }
    }
})();

(static function (): void {
    foreach (['makeFixedPayloadCallback', 'makeUnnamedCallback', 'makeMixedNameCallback', 'makeZeroArgumentCallback'] as $name) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("$name lost its factory signature");
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $fixed = VPHP\ReferenceProbe\makeFixedPayloadCallback();
    $unnamed = VPHP\ReferenceProbe\makeUnnamedCallback();
    $mixedNames = VPHP\ReferenceProbe\makeMixedNameCallback();
    $zero = VPHP\ReferenceProbe\makeZeroArgumentCallback();
    $reflection = new ReflectionFunction($fixed);
    $params = $reflection->getParameters();
    if ($reflection->isVariadic() || (string) $reflection->getReturnType() !== 'string'
        || $reflection->getNumberOfRequiredParameters() !== 2
        || array_map(static fn ($arg) => $arg->getName(), $params) !== ['payload', 'prefix', 'offset']
        || array_map(static fn ($arg) => (string) $arg->getType(), $params) !== [Payload::class, 'string', '?int']
        || $params[2]->getDefaultValue() !== null
        || array_map(static fn ($arg) => $arg->getName(), (new ReflectionFunction($unnamed))->getParameters()) !== ['arg1', 'arg2']
        || array_map(static fn ($arg) => $arg->getName(), (new ReflectionFunction($mixedNames))->getParameters()) !== ['arg1_', 'arg1']
        || (new ReflectionFunction($zero))->getNumberOfParameters() !== 0) {
        throw new RuntimeException('Unexpected fixed closure signature');
    }
    $payload = new PhpWrappedPayload(73);
    if ($fixed($payload, 'pos') !== 'pos:73'
        || $fixed(prefix: 'named', payload: $payload) !== 'named:73'
        || $fixed(offset: 2, prefix: 'offset', payload: $payload) !== 'offset:75'
        || $fixed(offset: null, prefix: 'null', payload: $payload) !== 'null:73'
        || callClosureWeakly($fixed, offset: '2', prefix: 10, payload: $payload) !== '10:75'
        || $unnamed(arg2: true, arg1: 17) !== '17:true' || $mixedNames(arg1: 5, arg1_: 2) !== 7 || $zero() !== 13) {
        throw new RuntimeException('Unexpected fixed closure invocation');
    }
    $unbound = (new ReflectionClass(Payload::class))->newInstanceWithoutConstructor();
    foreach ([
        [static fn () => $fixed($payload), ArgumentCountError::class],
        [static fn () => $fixed($payload, 'prefix', null, 2), ArgumentCountError::class],
        [static fn () => $zero(13), ArgumentCountError::class],
        [static fn () => $fixed($payload, new stdClass()), TypeError::class],
        [static fn () => $fixed($payload, 'strict', 2.0), TypeError::class],
        [static fn () => $fixed($unbound, 'prefix'), TypeError::class],
        [static fn () => $fixed($payload, ''), Exception::class],
    ] as [$call, $class]) {
        try {
            $call();
            throw new RuntimeException('A fixed closure accepted an invalid call');
        } catch (Throwable $error) {
            if (get_class($error) !== $class) {
                throw $error;
            }
        }
    }
})();

(static function (): void {
    $factories = [
        'makeMarkerListCallback' => 'array',
        'makeCheckedMarkerCallback' => 'int',
        'makeVoidCallback' => 'void',
        'makePayloadSumCallback' => 'int',
    ];
    foreach ($factories as $name => $type) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("$name lost its factory signature");
        }
        if (extension_loaded('reference_property_contracts')
            && (string) (new ReflectionFunction($factory->invoke()))->getReturnType() !== $type) {
            throw new RuntimeException("$name lost its callback return type $type");
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }
    $list = VPHP\ReferenceProbe\makeMarkerListCallback();
    $checked = VPHP\ReferenceProbe\makeCheckedMarkerCallback();
    $void = VPHP\ReferenceProbe\makeVoidCallback();
    if ($list() !== [23] || $list(marker: 9) !== [9] || callClosureWeakly($list, marker: '9') !== [9]
        || $checked(1, 7) !== 7 || $void() !== null) {
        throw new RuntimeException('Unexpected return from typed callbacks');
    }
    foreach ([
        [static fn () => $checked(), Exception::class, 'marker required'],
        [static fn () => $list(marker: '9'), TypeError::class, 'expected i64'],
        [static fn () => $void(marker: -1), DomainException::class, 'invalid void callback marker'],
    ] as [$call, $class, $message]) {
        try {
            $call();
            throw new RuntimeException('The typed callback swallowed an error');
        } catch (Throwable $error) {
            if (get_class($error) !== $class || !str_contains($error->getMessage(), $message)) {
                throw $error;
            }
        }
    }
})();

(static function (): void {
    $reader = new PayloadReaderImpl();
    foreach ([
        [new ReflectionFunction('VPHP\ReferenceProbe\directPayload'), Payload::class],
        [new ReflectionFunction('VPHP\ReferenceProbe\borrowPayload'), Payload::class],
        [new ReflectionFunction('VPHP\ReferenceProbe\contextFunctionPayload'), Payload::class],
        [new ReflectionMethod(Payload::class, 'contextSelf'), Payload::class],
        [new ReflectionMethod(Payload::class, 'borrowedSelf'), Payload::class],
        [new ReflectionMethod(Payload::class, 'borrowFromOwner'), Payload::class],
        [new ReflectionMethod($reader, 'contextPayload'), Payload::class],
        [new ReflectionFunction('VPHP\ReferenceProbe\buildPayload'), Payload::class],
        [new ReflectionMethod($reader, 'maybePayload'), '?' . Payload::class],
        [new ReflectionMethod($reader, 'checkedPayload'), Payload::class],
    ] as [$callable, $type]) {
        if ((string) $callable->getReturnType() !== $type) {
            throw new RuntimeException($callable->getName() . ' lost its PHP object return declaration');
        }
    }
    foreach ([
        new ReflectionFunction('VPHP\ReferenceProbe\contextFunctionPayload'),
        new ReflectionMethod(Payload::class, 'contextSelf'),
        new ReflectionMethod($reader, 'contextPayload'),
    ] as $callable) {
        if (!$callable->isVariadic() || $callable->getNumberOfRequiredParameters() !== 0) {
            throw new RuntimeException($callable->getName() . ' lost its Context argument handling');
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $payload = new PhpWrappedPayload(73);
    $direct = VPHP\ReferenceProbe\directPayload(marker: 17);
    $fromContext = PayloadReaderImpl::contextPayload();
    if (get_class($direct) !== Payload::class || $reader->read($direct) !== 17
        || get_class($fromContext) !== Payload::class || $reader->read($fromContext) !== 31
        || $reader->read(VPHP\ReferenceProbe\contextFunctionPayload(1, 2)) !== 2
        || $payload->contextSelf() !== $payload
        || Payload::borrowedSelf(payload: $payload) !== $payload
        || VPHP\ReferenceProbe\borrowPayload(payload: $payload) !== $payload) {
        throw new RuntimeException('The direct V object return lost its class, value, or PHP identity');
    }
    $owner = new PayloadOwner();
    $borrowed = Payload::borrowFromOwner(owner: $owner);
    $wrapper = WeakReference::create($borrowed);
    if ($reader->read($borrowed) !== 47 || Payload::borrowFromOwner(owner: $owner) !== $borrowed) {
        throw new RuntimeException('The static borrowed return lost the owner payload');
    }
    unset($borrowed);
    if ($wrapper->get() !== null || $owner->releaseCount() !== 0
        || $reader->read(Payload::borrowFromOwner(owner: $owner)) !== 47) {
        throw new RuntimeException('The static borrowed return transferred ownership to PHP');
    }
    $built = VPHP\ReferenceProbe\buildPayload(marker: 19);
    $checked = PayloadReaderImpl::checkedPayload(marker: 29);
    if (get_class($built) !== Payload::class || $reader->read($built) !== 19
        || get_class($checked) !== Payload::class || $reader->read($checked) !== 29
        || $reader->maybePayload() !== null || $reader->maybePayload(payload: null) !== null
        || $reader->maybePayload(payload: $payload) !== $payload || $reader->read($payload) !== 73) {
        throw new RuntimeException('The wrapped V object return lost its value, null, or PHP identity');
    }
    try {
        VPHP\ReferenceProbe\buildPayload(marker: -1);
        throw new RuntimeException('The bridge ignored the V result error');
    } catch (Exception $error) {
        if (get_class($error) !== Exception::class || $error->getMessage() !== 'negative payload marker') {
            throw $error;
        }
    }
    try {
        PayloadReaderImpl::checkedPayload(marker: -1);
        throw new RuntimeException('The bridge ignored the pending PHP exception');
    } catch (DomainException $error) {
        if ($error->getMessage() !== 'PHP rejected the payload') {
            throw $error;
        }
    }
})();

(static function (): void {
    foreach (['makePayloadSumCallback', 'makeLastPayloadCallback'] as $name) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("$name lost its Closure return type");
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $sum = VPHP\ReferenceProbe\makePayloadSumCallback();
    $last = VPHP\ReferenceProbe\makeLastPayloadCallback();
    foreach ([[$sum, Payload::class], [$last, '?' . Payload::class]] as [$callback, $expected]) {
        $metadata = new ReflectionFunction($callback);
        [$arg] = $metadata->getParameters();
        if (!$metadata->isVariadic() || $metadata->getNumberOfRequiredParameters() !== 0
            || !$arg->isVariadic() || (string) $arg->getType() !== $expected) {
            throw new RuntimeException('Unexpected PHP signature for variadic bound objects');
        }
    }
    $payload = new PhpWrappedPayload(73);
    $other = new Payload(18);
    if ($sum() !== 0 || $sum($payload, $other) !== 91 || $last() !== null
        || $last(null, $other, $payload) !== $payload || $last($payload, null) !== null) {
        throw new RuntimeException('Variadic bound objects lost their values, order, or identity');
    }
    $unbound = (new ReflectionClass(Payload::class))->newInstanceWithoutConstructor();
    foreach ([
        [static fn () => $sum($payload, null), 'expected object'],
        [static fn () => $sum($payload, $unbound), 'object not bound to V pointer'],
        [static fn () => $last(null, new stdClass(), $payload), 'type mismatch'],
        [static fn () => $last($payload, $unbound), 'object not bound to V pointer'],
    ] as [$call, $message]) {
        try {
            $call();
            throw new RuntimeException('A variadic closure accepted an invalid bound object argument');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), 'Argument #2') || !str_contains($error->getMessage(), $message)) {
                throw $error;
            }
        }
    }
    try {
        $sum(object: $payload);
        throw new RuntimeException('A variadic closure accepted a named variadic argument');
    } catch (ArgumentCountError $error) {
        if (!str_contains($error->getMessage(), 'named')) {
            throw $error;
        }
    }
})();

(static function (): void {
    $factory = new ReflectionFunction('VPHP\ReferenceProbe\makeBoundPayloadCallback');
    if ((string) $factory->getReturnType() !== Closure::class) {
        throw new RuntimeException('The bound-object factory lost its Closure return type');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $callback = VPHP\ReferenceProbe\makeBoundPayloadCallback();
    $signature = new ReflectionFunction($callback);
    [$payloadParam, $overrideParam] = $signature->getParameters();
    if ($signature->getNumberOfRequiredParameters() !== 1
        || $payloadParam->getName() !== 'payload' || (string) $payloadParam->getType() !== Payload::class
        || $overrideParam->getName() !== 'override' || (string) $overrideParam->getType() !== '?' . Payload::class
        || !$overrideParam->isDefaultValueAvailable() || $overrideParam->getDefaultValue() !== null) {
        throw new RuntimeException('Unexpected PHP signature for bound closure arguments');
    }
    $payload = new PhpWrappedPayload(73);
    $override = new Payload(18);
    if ($callback($payload) !== $payload || $callback(prefer: false, payload: $payload) !== $payload
        || $callback(override: null, payload: $payload) !== $payload
        || $callback(override: $override, payload: $payload) !== $override) {
        throw new RuntimeException('The closure lost a bound identity or a nullable argument');
    }
    $unbound = (new ReflectionClass(Payload::class))->newInstanceWithoutConstructor();
    foreach ([
        [[$unbound], 'Argument #1', 'object not bound to V pointer'],
        [[$payload, $unbound], 'Argument #2', 'object not bound to V pointer'],
        [[new stdClass()], 'Argument #1', 'type mismatch'],
        [[null], 'Argument #1', 'expected object'],
    ] as [$args, $position, $message]) {
        try {
            $callback(...$args);
            throw new RuntimeException('A closure accepted an invalid bound object argument');
        } catch (TypeError $error) {
            if (!str_contains($error->getMessage(), $position) || !str_contains($error->getMessage(), $message)) {
                throw $error;
            }
        }
    }
})();

(static function (): void {
    foreach (['makeBorrowedPayloadCallback', 'makeOptionalPayloadCallback', 'makeVariadicPayloadCallback'] as $name) {
        $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
        if ((string) $factory->getReturnType() !== Closure::class) {
            throw new RuntimeException("$name lost its Closure return type");
        }
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $owner = new PayloadOwner();
    $borrowed = VPHP\ReferenceProbe\makeBorrowedPayloadCallback(owner: $owner);
    $optional = VPHP\ReferenceProbe\makeOptionalPayloadCallback();
    $variadic = VPHP\ReferenceProbe\makeVariadicPayloadCallback();
    foreach ([$borrowed, $optional, $variadic] as $callback) {
        $metadata = new ReflectionFunction($callback);
        if ((string) $metadata->getReturnType() !== ($callback === $optional ? '?' : '') . Payload::class
            || $metadata->returnsReference() || $metadata->isVariadic() !== ($callback === $variadic)
            || $metadata->getNumberOfRequiredParameters() !== 0) {
            throw new RuntimeException('The object closure lost its PHP signature');
        }
    }
    $borrowedPayload = $borrowed();
    if ($borrowedPayload !== Payload::borrowFromOwner($owner)
        || $borrowed(marker: 53) !== $borrowedPayload) {
        throw new RuntimeException('The borrowed closure did not preserve PHP identity');
    }
    $wrapper = WeakReference::create($borrowedPayload);
    unset($borrowedPayload);
    if ($wrapper->get() !== null || $owner->releaseCount() !== 0) {
        throw new RuntimeException('The borrowed closure transferred ownership to PHP');
    }
    if ($optional()->marker !== 23 || $optional(marker: 31)->marker !== 31 || $optional(marker: -1) !== null
        || $variadic()->marker !== 0 || $variadic(2, 3)->marker !== 5) {
        throw new RuntimeException('The object closure returned a wrong object or null');
    }
    foreach ([
        [static fn () => $variadic(-1), Exception::class, 'negative payload marker'],
        [static fn () => $variadic(-2), DomainException::class, 'PHP rejected the callback payload'],
        [static fn () => $variadic(new stdClass()), Exception::class, 'expected V scalar'],
        [static fn () => $variadic(named: 9), ArgumentCountError::class, 'named'],
        [static fn () => $borrowed(marker: 0), TypeError::class, 'Return value must be of type'],
    ] as [$fail, $exception, $message]) {
        try {
            $fail();
            throw new RuntimeException('The object closure accepted a failing call');
        } catch (Throwable $error) {
            if (get_class($error) !== $exception || !str_contains($error->getMessage(), $message)) {
                throw $error;
            }
        }
    }
})();

foreach ([PayloadReader::class, PayloadReaderImpl::class, PhpPayloadReader::class] as $owner) {
    $read = new ReflectionMethod($owner, 'read');
    if ((string) $read->getParameters()[0]->getType() !== Payload::class) {
        throw new RuntimeException("Unexpected payload parameter on $owner");
    }
}
$many = (new ReflectionMethod(PayloadReaderImpl::class, 'readMany'))->getParameters()[0];
$nullableMany = (new ReflectionMethod(PayloadReaderImpl::class, 'readManyNullable'))->getParameters()[0];
$paramOptions = (new ReflectionMethod(PayloadReaderImpl::class, 'readOptions'))->getParameters()[0];
$optional = (new ReflectionMethod(PayloadReaderImpl::class, 'readOptional'))->getParameters()[0];
if (!$many->isVariadic() || (string) $many->getType() !== Payload::class
    || !$nullableMany->isVariadic() || (string) $nullableMany->getType() !== '?' . Payload::class
    || (string) $paramOptions->getType() !== '?' . Payload::class
    || $paramOptions->getDefaultValue() !== null
    || (string) $optional->getType() !== '?' . Payload::class
    || !$optional->isDefaultValueAvailable() || $optional->getDefaultValue() !== null
    || (string) (new ReflectionMethod(PayloadReaderImpl::class, 'readObject'))->getParameters()[0]->getType() !== 'object') {
    throw new RuntimeException('The nullable payload type or explicit type override was lost');
}

if (extension_loaded('reference_property_contracts')) {
    $reader = new PayloadReaderImpl();
    $payload = new Payload(73);
    if ($reader->read(payload: $payload) !== 73 || (new PhpPayloadReader())->read(payload: $payload) !== 73
        || $reader->readObject(payload: $payload) !== 73 || $reader->readOptional(payload: $payload) !== 73
        || $reader->readOptional() !== -1 || $reader->readOptional(payload: null) !== -1
        || $reader->readMany() !== 0 || $reader->readMany($payload, new Payload(3)) !== 76
        || $reader->readManyNullable(null, $payload, null) !== 73
        || $reader->readOptions() !== 5 || $reader->readOptions(fallback: 9) !== 9
        || $reader->readOptions(payload: null, fallback: 9) !== 9
        || $reader->readOptions(payload: $payload) !== 73) {
        throw new RuntimeException('The object argument bridge lost a V payload');
    }
    try {
        $reader->read(payload: new stdClass());
        throw new RuntimeException('The object argument bridge accepted a different PHP class');
    } catch (TypeError $error) {
        if (!str_contains($error->getMessage(), Payload::class)) {
            throw $error;
        }
    }
    $unbound = (new ReflectionClass(Payload::class))->newInstanceWithoutConstructor();
    foreach ([
        'read' => [$unbound],
        'readOptional' => [$unbound],
        'readOptions' => [$unbound],
        'readMany' => [$payload, $unbound],
        'readManyNullable' => [$payload, null, $unbound],
    ] as $method => $args) {
        try {
            $reader->$method(...$args);
            throw new RuntimeException("$method accepted an unbound instance");
        } catch (TypeError $error) {
            $argument = '#' . count($args);
            if (!str_contains($error->getMessage(), "Argument $argument")
                || !str_contains($error->getMessage(), 'object not bound to V pointer')) {
                throw $error;
            }
        }
    }
}
