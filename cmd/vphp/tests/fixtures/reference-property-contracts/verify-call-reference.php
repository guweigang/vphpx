<?php
declare(strict_types=1);

foreach ([
    'referenceFromPhpCallable', 'referenceFromPhpClosure', 'referenceFromNamedPhpFunction',
    'referenceFromPhpMethod', 'referenceFromPhpStaticMethod',
] as $name) {
    $reflection = new ReflectionFunction($name);
    if (!$reflection->returnsReference() || (string) $reflection->getReturnType() !== 'mixed') {
        throw new RuntimeException("Unexpected reference signature on $name");
    }
}
$throwableIdentity = new ReflectionFunction('VPHP\\ReferenceProbe\\echoThrowable');
$appendException = new ReflectionFunction('VPHP\\ReferenceProbe\\appendException');
if ((string) $throwableIdentity->getReturnType() !== 'Throwable'
    || (string) $throwableIdentity->getParameters()[0]->getType() !== 'Throwable'
    || array_map(static fn ($param) => (string) $param->getType(), $appendException->getParameters()) !== ['Throwable', 'Throwable']) {
    throw new RuntimeException('Unexpected Reflection for PhpThrowable exports');
}
foreach (['makeThrowableIdentity', 'makeThrowableSelector'] as $factoryName) {
    $factory = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $factoryName);
    if ((string) $factory->getReturnType() !== 'Closure') {
        throw new RuntimeException("Unexpected Reflection for $factoryName");
    }
}
$closureRef = new ReflectionFunction('VPHP\\ReferenceProbe\\closureReferenceArgs');
if (!$closureRef->returnsReference() || (string) $closureRef->getParameters()[0]->getType() !== 'Closure') {
    throw new RuntimeException('Unexpected Reflection for the named closure reference bridge');
}
foreach (['callPositionalByValue' => 'value', 'callArgsByValue' => 'arguments'] as $name => $parameter) {
    $reflection = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $name);
    if ($reflection->returnsReference() || (string) $reflection->getReturnType() !== 'mixed'
        || array_map(static fn ($p) => $p->getName(), $reflection->getParameters()) !== ['callback', $parameter]) {
        throw new RuntimeException('Unexpected signature for reading a callable result by value');
    }
}
if (!extension_loaded('reference_property_contracts')) {
    return;
}

$capture = new stdClass();
$closure = static fn () => $capture;
$weakClosure = WeakReference::create($closure);
$stored = VPHP\ReferenceProbe\storeRetainedCallable($closure);
if ($stored['callback'] !== $closure || $stored['callback']() !== $capture) {
    throw new RuntimeException('Storing a retained callable lost the PHP closure');
}
unset($stored, $closure);
if ($weakClosure->get() !== null) {
    throw new RuntimeException('Storing a retained callable leaked its temporary request handle');
}

$invokeArray = VPHP\ReferenceProbe\callWithArgumentArray(...);
$forward = VPHP\ReferenceProbe\forwardCallbackArguments(...);
$collect = static fn (string $label = 'default', mixed $payload = null, mixed ...$tail): array
    => [$label, $payload, $tail];
$item = new stdClass();
$case = VPHP\ReferenceDefaults\ExportedDnfDefault::default_value;
foreach ([
    [],
    ['payload' => $item, 'case' => $case, '' => null, "binary\0key" => $item],
    ['explicit', $item, 17, 'case' => $case, 'empty' => null],
    ['payload' => null, 'label' => 'reordered', 'tail' => $item],
] as $arguments) {
    $expected = call_user_func_array($collect, $arguments);
    if ($invokeArray($collect, $arguments) !== $expected || $forward($collect, ...$arguments) !== $expected) {
        throw new RuntimeException('Callback forwarding changed keys, order, a default, or PHP object identity');
    }
}
$expectFailure = static function (Closure $call): Throwable {
    try {
        $call();
    } catch (Throwable $error) {
        return $error;
    }
    throw new RuntimeException('PHP accepted invalid forwarded arguments');
};
$read = VPHP\ReferenceProbe\readMethodByValue(...);
$holder = new class {
    public mixed $value;
    public function &read(): mixed { return $this->value; }
    public function plain(): string { return "byte\0string"; }
    public function fail(): never { throw $this->value; }
};
$rebind = static function () use ($holder): void { $holder->value = 'replacement'; };
foreach ([$item, ['object' => $item], null, 0] as $original) {
    $holder->value = $original;
    if ($read(receiver: $holder, method: 'read', rebind: $rebind) !== $original
        || $holder->value !== 'replacement') {
        throw new RuntimeException('Reading a PHP method by value lost its snapshot or object identity');
    }
}
if ($read($holder, 'plain', $rebind) !== "byte\0string") {
    throw new RuntimeException('The owned method result did not preserve a binary string');
}
$holder->value = new DomainException('method read failed');
if ($expectFailure(static fn () => $read($holder, 'fail', $rebind)) !== $holder->value) {
    throw new RuntimeException('The owned method result replaced the PHP exception');
}
$asThrowable = VPHP\ReferenceProbe\makeThrowableIdentity();
$selectThrowable = VPHP\ReferenceProbe\makeThrowableSelector();
$identityRef = new ReflectionFunction($asThrowable);
$selectRef = new ReflectionFunction($selectThrowable);
$errorObject = new TypeError('native Error');
$exceptionObject = new RuntimeException('native Exception');
if ((string) $identityRef->getReturnType() !== '?Throwable'
    || (string) $identityRef->getParameters()[0]->getType() !== '?Throwable'
    || $identityRef->getParameters()[0]->getDefaultValue() !== null
    || (string) $selectRef->getReturnType() !== '?Throwable'
    || (string) $selectRef->getParameters()[0]->getType() !== 'Throwable'
    || !$selectRef->getParameters()[0]->isVariadic()
    || VPHP\ReferenceProbe\echoThrowable(value: $exceptionObject) !== $exceptionObject
    || VPHP\ReferenceProbe\echoThrowable($errorObject) !== $errorObject
    || $asThrowable() !== null || $asThrowable(value: null) !== null || $asThrowable(value: $errorObject) !== $errorObject
    || $selectThrowable() !== null || $selectThrowable($exceptionObject, $errorObject) !== $errorObject) {
    throw new RuntimeException('The Throwable signature or round trip changed the PHP value');
}
foreach ([
    static fn () => VPHP\ReferenceProbe\echoThrowable(value: new stdClass()),
    static fn () => $asThrowable(value: new stdClass()),
    static fn () => $selectThrowable($exceptionObject, new stdClass()),
] as $invalidThrowable) {
    if (!$expectFailure($invalidThrowable) instanceof TypeError) {
        throw new RuntimeException('An object outside the Throwable interface did not raise TypeError');
    }
}
$strictTarget = static fn (int $value) => $value;
$diagnostic = static fn (Throwable $error): string => preg_replace('/, called in .+ on line \d+$/D', '', $error->getMessage());
foreach ([
    ['wrong' => 42],
    [17, 'value' => 42],
    ['value' => 42, 17],
    ['value' => $item],
] as $arguments) {
    $expected = $expectFailure(static fn () => call_user_func_array($strictTarget, $arguments));
    $actual = $expectFailure(static fn () => $invokeArray($strictTarget, $arguments));
    if (get_class($actual) !== get_class($expected) || $diagnostic($actual) !== $diagnostic($expected)) {
        throw new RuntimeException('Zend call validation changed while forwarding an argument array', 0, $actual);
    }
}
$sentinel = new DomainException('named callback failed');
$failure = static function (object $payload) use ($sentinel): never { throw $sentinel; };
if ($expectFailure(static fn () => $forward($failure, payload: $item)) !== $sentinel
    || $expectFailure(static fn () => VPHP\ReferenceProbe\callPositionalByValue($failure, $item)) !== $sentinel
    || $expectFailure(static fn () => VPHP\ReferenceProbe\callArgsByValue($failure, ['payload' => $item])) !== $sentinel) {
    throw new RuntimeException('The forwarded callback replaced the PHP exception');
}
$recover = VPHP\ReferenceProbe\recoverCallback(...);
$unexpected = static fn () => throw new RuntimeException('Recovery ran without an exception');
if ($recover(static fn () => $item, $unexpected, false) !== $item) {
    throw new RuntimeException('Exception recovery changed a successful callback result');
}
$previous = new LogicException('previous error');
$captured = new DomainException('captured error', 73, $previous);
$throwCaptured = static fn () => throw $captured;
$identity = static function (Throwable $error) use ($captured, $previous): Throwable {
    if ($error !== $captured || $error->getPrevious() !== $previous
        || $error->getCode() !== 73 || $error->getMessage() !== 'captured error') {
        throw new RuntimeException('Capturing the exception changed the original Throwable');
    }
    return $error;
};
if ($recover($throwCaptured, $identity, false) !== $captured
    || $expectFailure(static fn () => $recover($throwCaptured, $identity, true)) !== $captured
    || $expectFailure(static fn () => $recover($throwCaptured, static fn () => throw $sentinel, true)) !== $sentinel) {
    throw new RuntimeException('Exception capture or rethrow replaced the active Throwable');
}
$weak = null;
try {
    $recover(
        static function () use (&$weak): never {
            $exception = new DomainException('request-owned error');
            $weak = WeakReference::create($exception);
            throw $exception;
        },
        static fn (Throwable $exception) => $exception->getMessage(),
        true,
    );
    throw new RuntimeException('The request-owned Throwable was not rethrown');
} catch (DomainException $error) {
    if ($error !== $weak->get()) {
        throw new RuntimeException('Rethrow lost the request-owned Throwable identity');
    }
}
unset($error);
gc_collect_cycles();
if ($weak->get() !== null || $recover(static fn () => 17, $unexpected, false) !== 17) {
    throw new RuntimeException('The released Throwable leaked or affected a later callback');
}
$chainRoot = new DomainException('root', 0, new LogicException('original cause'));
$chainTail = new RuntimeException('cleanup');
$originalCause = $chainRoot->getPrevious();
$weakTail = WeakReference::create($chainTail);
VPHP\ReferenceProbe\appendException($chainRoot, $chainTail);
VPHP\ReferenceProbe\appendException($chainRoot, $chainTail);
VPHP\ReferenceProbe\appendException($chainTail, $chainRoot);
VPHP\ReferenceProbe\appendException($chainRoot, $chainRoot);
$overlapping = new LogicException('overlapping cause', 0, $originalCause);
VPHP\ReferenceProbe\appendException($chainRoot, $overlapping);
if ($chainRoot->getPrevious() !== $originalCause || $originalCause->getPrevious() !== $chainTail
    || $chainTail->getPrevious() !== null) {
    throw new RuntimeException('Appending a Throwable replaced a cause or created a cycle');
}
unset($chainRoot, $chainTail, $originalCause, $overlapping);
gc_collect_cycles();
if ($weakTail->get() !== null) {
    throw new RuntimeException('Appending the same Throwable leaked a reference');
}
$namedReference = 11;
$byReference = static function &(mixed &$incoming): mixed {
    $incoming++;
    return $incoming;
};
$viaNamedArgs =& VPHP\ReferenceProbe\callReferenceWithArgumentArray($byReference, ['incoming' => &$namedReference]);
if ($namedReference !== 12) {
    throw new RuntimeException('The named callback lost the PHP reference argument');
}
$viaNamedArgs = 19;
if ($namedReference !== 19) {
    throw new RuntimeException('The named callback lost the PHP return reference');
}
$closureAlias =& VPHP\ReferenceProbe\closureReferenceArgs(
    arguments: ['incoming' => &$namedReference],
    callback: $byReference,
);
if ($namedReference !== 20) {
    throw new RuntimeException('Closure invocation lost the named reference argument');
}
$closureAlias = 23;
if ($namedReference !== 23 || $viaNamedArgs !== 23) {
    throw new RuntimeException('Closure invocation returned a different reference group');
}
try {
    VPHP\ReferenceProbe\closureReferenceArgs(static fn () => 1, []);
    throw new LogicException('A by-value closure was accepted as a reference');
} catch (Exception $error) {
    if ($error->getMessage() !== 'PHP callable did not return a reference') {
        throw $error;
    }
}
$closureValue = VPHP\ReferenceProbe\callArgsByValue($byReference, ['incoming' => &$namedReference]);
$closureAlias++;
if ($closureValue !== 24 || $namedReference !== 25) {
    throw new RuntimeException('Reading a closure result by value lost the snapshot or changed the reference group');
}
$objectReference = $item;
$objectCallback = static function &(mixed &$incoming): mixed { return $incoming; };
$snapshot = VPHP\ReferenceProbe\callArgsByValue($objectCallback, ['incoming' => &$objectReference]);
$positional = static function &(object $argument) use (&$objectReference, $item): mixed {
    if ($argument !== $item) {
        throw new RuntimeException('The positional argument changed identity');
    }
    return $objectReference;
};
$positionalSnapshot = VPHP\ReferenceProbe\callPositionalByValue(value: $item, callback: $positional);
$objectReference = null;
if ($snapshot !== $item || $positionalSnapshot !== $item
    || VPHP\ReferenceProbe\callPositionalByValue($positional, $item) !== null
    || VPHP\ReferenceProbe\callArgsByValue($objectCallback, ['incoming' => &$objectReference]) !== null) {
    throw new RuntimeException('Reading by value lost object identity or null');
}
$objectReference = $item;
$snapshot = VPHP\ReferenceProbe\withReferencedObjectResult(
    static function &() use (&$objectReference): object { return $objectReference; },
    static function () use (&$objectReference): void { $objectReference = null; },
);
if ($snapshot !== $item || $objectReference !== null) {
    throw new RuntimeException('A typed result did not retain the original object across reference rebinding');
}

function &namedReferenceCallback(mixed &$value): mixed
{
    return $value;
}

function namedDispatchValue(string $label = 'default', mixed $value = null): array
{
    return [$label, $value];
}

class NamedDispatchTarget
{
    public static int $destructions = 0;

    public function __construct(public string $label = 'default', public mixed $value = null)
    {
        if ($value instanceof Throwable) {
            throw $value;
        }
    }

    public function __destruct() { self::$destructions++; }

    public function instanceValue(string $label = 'default', mixed $value = null): array
    {
        return [$this, $label, $value];
    }

    public static function staticValue(string $label = 'default', mixed $value = null): array
    {
        return [static::class, $label, $value];
    }

    public function __call(string $name, array $args): array { return [$name, $args]; }
    public function &instanceReference(mixed &$value): mixed { return $value; }
    public static function &staticReference(mixed &$value): mixed { return $value; }
}
final class NamedDispatchChild extends NamedDispatchTarget {}
final class NamedDispatchEmpty {}
final class NamedDispatchPrivate { private function __construct() {} }
final class NamedDispatchHidden
{
    private function instanceSecret(): void {}
    private static function staticSecret(): void {}
}

$target = VPHP\ReferenceProbe\constructArgs(NamedDispatchChild::class, ['value' => $item]);
if (get_class($target) !== NamedDispatchChild::class || $target->label !== 'default' || $target->value !== $item
    || VPHP\ReferenceProbe\callFunctionArgs('namedDispatchValue', ['value' => $item]) !== ['default', $item]
    || VPHP\ReferenceProbe\callMethodArgs($target, 'instanceValue', ['value' => $item, 'label' => 'named']) !== [$target, 'named', $item]
    || VPHP\ReferenceProbe\callStaticArgs(NamedDispatchChild::class, 'staticValue', ['value' => $item]) !== [NamedDispatchChild::class, 'default', $item]
    || VPHP\ReferenceProbe\callMethodArgs($target, 'dynamicCall', [17, 'value' => $item]) !== ['dynamicCall', [17, 'value' => $item]]
    || !(VPHP\ReferenceProbe\constructArgs(NamedDispatchEmpty::class, [17]) instanceof NamedDispatchEmpty)) {
    throw new RuntimeException('A named PHP call target lost arguments, dispatch scope, or object identity');
}
foreach ([
    [NamedDispatchEmpty::class, ['value' => 17], 'Unknown named parameter $value'],
    [NamedDispatchPrivate::class, [], 'Call to private NamedDispatchPrivate::__construct()'],
    ['NamedDispatchMissing', [], 'Class "NamedDispatchMissing" not found'],
] as [$class, $arguments, $message]) {
    $error = $expectFailure(static fn () => VPHP\ReferenceProbe\constructArgs($class, $arguments));
    if (!$error instanceof Error || !str_contains($error->getMessage(), $message)) {
        throw $error;
    }
}
$before = NamedDispatchTarget::$destructions;
if ($expectFailure(static fn () => VPHP\ReferenceProbe\constructArgs(NamedDispatchChild::class, ['value' => $sentinel])) !== $sentinel
    || NamedDispatchTarget::$destructions !== $before) {
    throw new RuntimeException('The constructor replaced the PHP exception or destroyed a failed instance');
}
$positional = VPHP\ReferenceProbe\constructPositional(NamedDispatchChild::class, 'positional', $item);
if (!$positional instanceof NamedDispatchChild || $positional->label !== 'positional' || $positional->value !== $item
    || !(VPHP\ReferenceProbe\constructPositional(NamedDispatchEmpty::class, 1, 2) instanceof NamedDispatchEmpty)) {
    throw new RuntimeException('Positional construction changed the PHP argument or return value');
}
foreach ([NamedDispatchPrivate::class, 'NamedDispatchMissing'] as $class) {
    $construct = static fn () => new $class(1, 2);
    $native = $expectFailure($construct);
    $bridged = $expectFailure(static fn () => VPHP\ReferenceProbe\constructPositional($class, 1, 2));
    if (get_class($bridged) !== get_class($native) || $bridged->getMessage() !== $native->getMessage()) {
        throw new RuntimeException('Positional construction changed the PHP exception', 0, $bridged);
    }
}
if ($expectFailure(static fn () => VPHP\ReferenceProbe\constructPositional(NamedDispatchChild::class, 'positional', $sentinel)) !== $sentinel
    || NamedDispatchTarget::$destructions !== $before) {
    throw new RuntimeException('Positional construction destroyed a failed instance or replaced its exception');
}
$sharedReference = 31;
$referenceArguments = ['value' => &$sharedReference];
$functionAlias =& VPHP\ReferenceProbe\functionReferenceArgs('namedReferenceCallback', $referenceArguments);
$methodAlias =& VPHP\ReferenceProbe\methodReferenceArgs($target, 'instanceReference', $referenceArguments);
$staticAlias =& VPHP\ReferenceProbe\staticReferenceArgs(NamedDispatchChild::class, 'staticReference', $referenceArguments);
$functionAlias++;
$methodAlias++;
$staticAlias++;
if ($sharedReference !== 34) {
    throw new RuntimeException('A named function or method call lost the returned reference');
}

$hidden = new NamedDispatchHidden();
foreach ([
    ['noSuchNamedDispatchFunction',
        static fn () => VPHP\ReferenceProbe\callFunctionArgs('noSuchNamedDispatchFunction', []),
        static fn () => VPHP\ReferenceProbe\callFunctionPositional('noSuchNamedDispatchFunction', null)],
    [[new NamedDispatchEmpty(), 'missing'],
        static fn () => VPHP\ReferenceProbe\callMethodArgs(new NamedDispatchEmpty(), 'missing', []),
        static fn () => VPHP\ReferenceProbe\callMethodPositional(new NamedDispatchEmpty(), 'missing', null)],
    [[$hidden, 'instanceSecret'],
        static fn () => VPHP\ReferenceProbe\callMethodArgs($hidden, 'instanceSecret', []),
        static fn () => VPHP\ReferenceProbe\callMethodPositional($hidden, 'instanceSecret', null)],
    ['NamedDispatchMissing::method',
        static fn () => VPHP\ReferenceProbe\callStaticArgs('NamedDispatchMissing', 'method', []),
        static fn () => VPHP\ReferenceProbe\callStaticPositional('NamedDispatchMissing', 'method', null)],
    [NamedDispatchHidden::class . '::staticSecret',
        static fn () => VPHP\ReferenceProbe\callStaticArgs(NamedDispatchHidden::class, 'staticSecret', []),
        static fn () => VPHP\ReferenceProbe\callStaticPositional(NamedDispatchHidden::class, 'staticSecret', null)],
    [NamedDispatchTarget::class . '::instanceValue',
        static fn () => VPHP\ReferenceProbe\callStaticArgs(NamedDispatchTarget::class, 'instanceValue', []),
        static fn () => VPHP\ReferenceProbe\callStaticPositional(NamedDispatchTarget::class, 'instanceValue', null)],
] as [$callable, $namedInvoke, $positionalInvoke]) {
    $nativeError = $expectFailure(static fn () => call_user_func_array($callable, []));
    $reason = substr($nativeError->getMessage(), strpos($nativeError->getMessage(), 'valid callback, ') + strlen('valid callback, '));
    foreach ([$namedInvoke, $positionalInvoke] as $invoke) {
        $error = $expectFailure($invoke);
        if (!$error instanceof TypeError || !str_ends_with($error->getMessage(), $reason)) {
            throw new RuntimeException('Call target resolution lost the Zend diagnostic', 0, $error);
        }
    }
}
$loader = static function (string $class) use ($sentinel): void {
    if ($class === 'NamedDispatchAutoloadFailure') {
        throw $sentinel;
    }
};
spl_autoload_register($loader);
try {
    foreach ([
        static fn () => VPHP\ReferenceProbe\callStaticArgs('NamedDispatchAutoloadFailure', 'run', []),
        static fn () => VPHP\ReferenceProbe\callStaticPositional('NamedDispatchAutoloadFailure', 'run', null),
        static fn () => VPHP\ReferenceProbe\constructArgs('NamedDispatchAutoloadFailure', []),
    ] as $invoke) {
        if ($expectFailure($invoke) !== $sentinel) {
            throw new RuntimeException('Resolving the named call target replaced the autoload exception');
        }
    }
} finally {
    spl_autoload_unregister($loader);
}
if (VPHP\ReferenceProbe\callFunctionArgs('namedDispatchValue', ['value' => $item]) !== ['default', $item]) {
    throw new RuntimeException('A failed named dispatch contaminated a later valid call');
}
if (VPHP\ReferenceProbe\callFunctionPositional('namedDispatchValue', 'positional') !== ['positional', null]
    || VPHP\ReferenceProbe\callMethodPositional($target, 'instanceValue', 'positional') !== [$target, 'positional', null]
    || VPHP\ReferenceProbe\callMethodPositional($target, 'dynamicCall', $item) !== ['dynamicCall', [$item]]
    || VPHP\ReferenceProbe\callStaticPositional(NamedDispatchChild::class, 'staticValue', 'positional') !== [NamedDispatchChild::class, 'positional', null]) {
    throw new RuntimeException('Positional dispatch lost object identity, late static binding, or magic method dispatch');
}
foreach ([false, true] as $named) {
    $out = VPHP\ReferenceProbe\inspectCallbackOutcome(static fn ($value) => throw $sentinel, $named);
    if ($out !== ['valid' => false, 'exception' => $sentinel]) {
        throw new RuntimeException('A failed PHP callback exposed a return value or lost its Throwable');
    }
    foreach ([null, false, 0] as $expectedValue) {
        $out = VPHP\ReferenceProbe\inspectCallbackOutcome(static fn ($value) => $value === 7 ? $expectedValue : 'wrong', $named);
        if ($out !== ['valid' => true, 'value' => $expectedValue]) {
            throw new RuntimeException('A successful PHP callback changed a null, false, or zero result');
        }
    }
}

final class ReferenceCallbackBox
{
    public int $counter = 11;

    public function &counterReference(): int
    {
        return $this->counter;
    }

    public function counterValue(): int
    {
        return $this->counter;
    }

    public function &failReference(Throwable &$error): mixed
    {
        throw $error;
    }
}

class StaticReferenceCallbackBox
{
    public static int $counter = 31;

    public static function &counterReference(): int
    {
        return static::$counter;
    }

    public static function counterValue(): int
    {
        return static::$counter;
    }

    public static function &failReference(Throwable &$error): mixed
    {
        throw $error;
    }
}

class InheritedStaticReferenceCallbackBox extends StaticReferenceCallbackBox {}

class SeparateStaticReferenceCallbackBox extends StaticReferenceCallbackBox
{
    public static int $counter = 37;
}

$counter = new ReferenceCallbackBox();
$method = [$counter, 'counterReference'];
$alias =& referenceFromPhpCallable(callback: $method);
$alias = 13;
writePhpCallbackReference($method, 17);
if ($counter->counter !== 17 || $alias !== 17) {
    throw new RuntimeException('The callable did not retain the typed property reference');
}
try {
    writePhpCallbackReference($method, []);
    throw new RuntimeException('The callback reference lost its property type');
} catch (TypeError $error) {
    if (!str_contains($error->getMessage(), 'Cannot assign array to reference held by property') || $counter->counter !== 17) {
        throw $error;
    }
}
writePhpCallbackReference($method, 19);
if ($alias !== 19 || $counter->counter !== 19) {
    throw new RuntimeException('The typed callback reference could not be updated after a TypeError');
}

$holder = new class {
    public object $value;

    public function &alias(): object
    {
        return $this->value;
    }
};
$replacement = new stdClass();
$observed = false;
$holder->value = new class(static function () use ($holder, $replacement, &$observed): void {
    $observed = $holder->value === $replacement;
}) {
    public function __construct(private Closure $inspect) {}

    public function __destruct()
    {
        ($this->inspect)();
    }
};
writePhpCallbackReference($holder->alias(...), $replacement);
if (!$observed || $holder->value !== $replacement) {
    throw new RuntimeException('A destructor did not see the committed reference value');
}

$value = 23;
$closure = static function &(mixed &$incoming): mixed {
    $incoming++;
    return $incoming;
};
$fromClosure =& referenceFromPhpClosure(value: $value, callback: $closure);
$fromFunction =& referenceFromNamedPhpFunction(value: $value, name: 'namedReferenceCallback');
$fromFunction = 29;
if ($value !== 29 || $fromClosure !== 29) {
    throw new RuntimeException('The reference argument and returned reference stopped aliasing');
}
$local = 5;
$fromExportedClosure =& referenceFromPhpClosure(directStructReferenceClosure(), $local);
if ($local !== 8 || $fromExportedClosure !== 8) {
    throw new RuntimeException('Calling a VPHP-generated closure from V lost the reference');
}
$fromExportedClosure = 9;
if ($local !== 9) {
    throw new RuntimeException('The generated closure returned a different caller slot');
}
$callback = static function &() use (&$value): mixed {
    return $value;
};
if (referenceFromPhpCallable($callback) !== 29) {
    throw new RuntimeException('The closure callback did not return its captured variable');
}
try {
    referenceFromPhpCallable(static fn () => 11);
    throw new RuntimeException('A by-value callback returned an alias');
} catch (Exception $error) {
    if ($error->getMessage() !== 'PHP callable did not return a reference') {
        throw $error;
    }
}

$original = new DomainException('callback failed', 43);
$failure = static function &() use ($original): mixed {
    throw $original;
};
foreach ([
    static fn () => referenceFromPhpCallable($failure),
    static fn () => writePhpCallbackReference($failure, 5),
] as $invoke) {
    try {
        $invoke();
        throw new RuntimeException('The callback exception was lost');
    } catch (Throwable $error) {
        if ($error !== $original) {
            throw $error;
        }
    }
}
$fromClosure = 31;
if ($value !== 31 || $fromFunction !== 31 || $counter->counter !== 19) {
    throw new RuntimeException('A failed callback changed an existing reference');
}

$instanceAlias =& referenceFromPhpMethod(target: $counter, name: 'counterReference');
$instanceAlias = 41;
if ($counter->counter !== 41 || $alias !== 41) {
    throw new RuntimeException('Direct instance call lost the typed property reference');
}

$baseAlias =& referenceFromPhpStaticMethod(StaticReferenceCallbackBox::class, 'counterReference');
$inheritsAlias =& referenceFromPhpStaticMethod(InheritedStaticReferenceCallbackBox::class, 'counterReference');
$separateAlias =& referenceFromPhpStaticMethod(SeparateStaticReferenceCallbackBox::class, 'counterReference');
$inheritsAlias = 43;
$separateAlias = 47;
if ($baseAlias !== 43 || StaticReferenceCallbackBox::$counter !== 43
    || InheritedStaticReferenceCallbackBox::$counter !== 43 || SeparateStaticReferenceCallbackBox::$counter !== 47) {
    throw new RuntimeException('Static method reference lost late static binding or class storage identity');
}
try {
    $separateAlias = [];
    throw new RuntimeException('Static method reference lost its property type');
} catch (TypeError $error) {
    if ($separateAlias !== 47 || $baseAlias !== 43
        || !str_contains($error->getMessage(), 'Cannot assign array to reference held by property')) {
        throw $error;
    }
}
$separateAlias = 53;
if (SeparateStaticReferenceCallbackBox::$counter !== 53) {
    throw new RuntimeException('The static reference was invalidated after a TypeError');
}

$referenceArgument = 59;
$instance = new RefMethodImplementation();
$instanceArgumentAlias =& referenceFromPhpMethod($instance, 'slot', $referenceArgument);
$staticArgumentAlias =& referenceFromPhpStaticMethod(RefReturnBox::class, 'staticAlias', $referenceArgument);
$staticArgumentAlias = 61;
if ($referenceArgument !== 61 || $instanceArgumentAlias !== 61) {
    throw new RuntimeException('Reentry through a VPHP method copied the caller reference');
}

foreach ([
    static fn () => referenceFromPhpMethod($counter, 'counterValue'),
    static fn () => referenceFromPhpStaticMethod(StaticReferenceCallbackBox::class, 'counterValue'),
] as $invoke) {
    try {
        $invoke();
        throw new RuntimeException('A method returning by value unexpectedly returned a reference');
    } catch (Exception $error) {
        if ($error->getMessage() !== 'PHP callable did not return a reference') {
            throw $error;
        }
    }
}
foreach ([
    static fn () => referenceFromPhpMethod($counter, 'failReference', $original),
    static fn () => referenceFromPhpStaticMethod(StaticReferenceCallbackBox::class, 'failReference', $original),
] as $invoke) {
    try {
        $invoke();
        throw new RuntimeException('The method exception was lost');
    } catch (Throwable $error) {
        if ($error !== $original) {
            throw $error;
        }
    }
}

foreach ([false, true] as $persistent) {
    foreach ([false, true] as $throws) {
        $failure = new LogicException('receiver method failed');
        $receiver = new class ($throws ? $failure : null) {
            public int $value = 17;

            public function __construct(private ?Throwable $failure) {}

            public function readValue(int $value): int
            {
                if ($this->failure !== null) {
                    throw $this->failure;
                }
                return $value + 1;
            }
        };
        $weak = WeakReference::create($receiver);
        try {
            $result = VPHP\ReferenceProbe\inspectValueReceiver($receiver, $persistent);
            if ($throws || $result !== 18) {
                throw new RuntimeException('PhpValue did not read and call the receiver');
            }
        } catch (LogicException $caught) {
            if (!$throws || $caught !== $failure) {
                throw $caught;
            }
        }
        unset($receiver, $failure, $caught);
        gc_collect_cycles();
        if ($weak->get() !== null) {
            throw new RuntimeException('PhpValue retained a temporary receiver');
        }
    }
}
