<?php
declare(strict_types=1);

(static function (): void {
    $check = static function (ReflectionFunction $reflection, array $params, array $result, bool $variadic = false): void {
        $members = static function (?ReflectionType $type): array {
            $items = $type instanceof ReflectionUnionType ? array_map('strval', $type->getTypes()) : [(string) $type];
            sort($items);
            return $items;
        };
        if ($members($reflection->getParameters()[0]->getType()) !== $params
            || $members($reflection->getReturnType()) !== $result
            || $reflection->isVariadic() !== $variadic) {
            throw new RuntimeException('Unexpected iterable Reflection for ' . $reflection->getName());
        }
    };
    $check(new ReflectionFunction('VPHP\\ReferenceProbe\\echoIterable'), ['Traversable', 'array'], ['Traversable', 'array']);
    $check(new ReflectionFunction('VPHP\\ReferenceProbe\\echoIterator'), ['Traversable'], ['Traversable']);
    $check(new ReflectionFunction('VPHP\\ReferenceProbe\\visitIterableValues'), ['Traversable', 'array'], ['array']);
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $generator = (static function (): Generator { yield 'lazy' => 7; })();
    $aggregate = new class implements IteratorAggregate {
        public int $opened = 0;
        public function getIterator(): Traversable { ++$this->opened; yield 'key' => 17; }
    };
    $values = ['array' => 13];
    $echo = VPHP\ReferenceProbe\makeIterableIdentity();
    $select = VPHP\ReferenceProbe\makeIteratorSelector();
    $check(new ReflectionFunction($echo), ['Traversable', 'array', 'null'], ['Traversable', 'array', 'null']);
    $check(new ReflectionFunction($select), ['Traversable'], ['?Traversable'], true);
    if (VPHP\ReferenceProbe\echoIterable(value: $values) !== $values
        || VPHP\ReferenceProbe\echoIterable($generator) !== $generator
        || VPHP\ReferenceProbe\echoIterator(value: $aggregate) !== $aggregate
        || $echo() !== null || $echo(value: null) !== null || $echo(value: $aggregate) !== $aggregate
        || $select() !== null || $select($generator, $aggregate) !== $aggregate || $aggregate->opened !== 0) {
        throw new RuntimeException('Iterable decoding consumed a lazy argument or replaced its identity');
    }
    foreach ([static fn () => $echo(new stdClass()), static fn () => $select($aggregate, [])] as $invalid) {
        try {
            $invalid();
            throw new RuntimeException('An invalid iterable closure argument was accepted');
        } catch (TypeError $error) {
            if (!str_contains(strtolower($error->getMessage()), 'argument')) {
                throw $error;
            }
        }
    }

    $failure = new DomainException('iteration failed');
    $throwing = (static function () use ($failure): Generator {
        yield 'discarded' => 1;
        throw $failure;
    })();
    $recover = static fn (Throwable $error) => $error;
    if (VPHP\ReferenceProbe\materializeIterable($throwing, $recover) !== $failure
        || VPHP\ReferenceProbe\materializeIterable($aggregate, $recover) !== ['key' => 17]
        || $aggregate->opened !== 1) {
        throw new RuntimeException('Materialization lost the original exception or exposed a partial array');
    }
    $collectWithDiagnostics = static function (Closure $collect): array {
        $diagnostics = [];
        set_error_handler(static function (int $level, string $message) use (&$diagnostics): bool {
            $diagnostics[] = [$level, $message];
            return true;
        });
        try {
            $result = $collect();
            return [$result, $diagnostics];
        } finally {
            restore_error_handler();
        }
    };
    $object = new stdClass();
    $cast = VPHP\ReferenceProbe\castValueToString(...);
    $stringable = new class {
        public function __toString(): string { return "a\0雪"; }
    };
    $precision = ini_set('precision', '4');
    try {
        foreach ([null, true, false, PHP_INT_MIN, PHP_INT_MAX, 1.234567, -0.0, INF, NAN, [], $stringable] as $input) {
            if ($collectWithDiagnostics(static fn () => $cast($input))
                !== $collectWithDiagnostics(static fn () => (string) $input)) {
                throw new RuntimeException('VPHP string conversion diverged from the PHP cast');
            }
        }
    } finally {
        ini_set('precision', $precision);
    }
    $castFailure = new LogicException('original __toString exception');
    $unstringable = new class ($castFailure) {
        public function __construct(private LogicException $failure) {}
        public function __toString(): string { throw $this->failure; }
    };
    try {
        $cast($unstringable);
        throw new RuntimeException('VPHP accepted a failed string conversion');
    } catch (LogicException $error) {
        if ($error !== $castFailure) {
            throw $error;
        }
    }
    $find = VPHP\ReferenceProbe\findArrayKey(...);
    $findString = VPHP\ReferenceProbe\findArrayStringKey(...);
    $write = VPHP\ReferenceProbe\writeArrayIndex(...);
    if (VPHP\ReferenceProbe\writeScalarArrayFields('42', "before\0雪") !== [
        42 => 'base',
        "42\0s" => "before\0雪",
        "42\0i" => 23,
        "42\0b" => true,
        "42\0d" => 1.25,
    ]) {
        throw new RuntimeException('A typed array write truncated a string key or value');
    }
    $shared = ['name' => str_repeat('original', 1), 0 => null, 1 => $object];
    $alias = $shared;
    foreach ([
        'string' => ['name', 'changed'],
        'int' => ['name', 17],
        'double' => ['name', 1.25],
        'bool' => ['name', true],
        'index' => [0, $object],
        'append' => [2, $object],
        'append-string' => [2, 'changed'],
        'append-int' => [2, 17],
        'append-double' => [2, 1.25],
        'self' => ['self', $shared],
        'zval' => ['name', $object],
    ] as $operation => [$key, $replacement]) {
        $expected = $shared;
        $expected[$key] = $replacement;
        if (VPHP\ReferenceProbe\changeSharedArray($shared, $operation) !== $expected
            || $shared !== ['name' => 'original', 0 => null, 1 => $object] || $alias !== $shared) {
            throw new RuntimeException("Array write $operation changed a shared input");
        }
    }
    $full = [1 => $object, PHP_INT_MAX => 'occupied'];
    $alias = $full;
    try {
        $full[] = null;
        throw new RuntimeException('PHP accepted an append to an occupied maximum index');
    } catch (Error $nativeError) {
        $appendError = $nativeError->getMessage();
    }
    foreach (['append', 'append-string', 'append-int', 'append-double'] as $operation) {
        try {
            VPHP\ReferenceProbe\changeSharedArray($full, $operation);
            throw new RuntimeException("Array operation $operation silently discarded the append");
        } catch (Error $error) {
            if ($error->getMessage() !== $appendError || $full !== $alias) {
                throw $error;
            }
        }
    }
    unset($full[PHP_INT_MAX]);
    if (VPHP\ReferenceProbe\changeSharedArray($full, 'append-int')
        !== [1 => $object, PHP_INT_MAX => 17] || $full !== [1 => $object]) {
        throw new RuntimeException('Append did not recover after the maximum index was removed');
    }
    foreach ([PHP_INT_MIN, -1, 0, PHP_INT_MAX] as $integer) {
        if (VPHP\ReferenceProbe\roundTripIntegerStorage($integer)
            !== [$integer, $integer, 'assoc' => $integer, 'updated' => $integer]) {
            throw new RuntimeException('Integer storage narrowed a PHP integer');
        }
    }
    $keys = [-1 => null, 1 => 'small', '01' => 'leading zero', "binary\0key" => $object];
    if (PHP_INT_SIZE === 8) {
        $keys[4294967297] = $object;
        $keys[PHP_INT_MIN] = 'minimum';
        $keys[PHP_INT_MAX] = 'maximum';
    }
    foreach ($keys as $key => $value) {
        if ($find($keys, $key) !== [$value] || $find($keys, (string) $key) !== [$value]
            || $findString($keys, (string) $key) !== [$value]
            || (is_int($key) && $write($key, $value) !== [$key => $value])) {
            throw new RuntimeException('Array key lookup or write lost a key, null, or object identity');
        }
    }
    if ($findString($keys, 'absent') !== [] || $findString([], '0') !== []) {
        throw new RuntimeException('String array lookup did not distinguish a missing key from null');
    }
    $future = PHP_INT_SIZE === 8 ? '9223372036854775808' : '2147483648';
    $arrayWithHistory = ['-0' => 'zero string', $future => 'wide string', PHP_INT_MIN => 'smallest integer'];
    $arrayWithHistory[8] = 'removed';
    unset($arrayWithHistory[8]);
    $emptied = [25 => 'removed'];
    unset($emptied[25]);
    foreach ([$arrayWithHistory, $emptied, [-7 => 'negative only'], []] as $source) {
        $restored = VPHP\ReferenceProbe\roundTripRetainedArray($source);
        if ($restored !== $source) {
            throw new RuntimeException('Retained array changed key types, order or existing values');
        }
        $source[] = 'tail';
        $restored[] = 'tail';
        if ($restored !== $source) {
            throw new RuntimeException('Retained array changed the next PHP append index');
        }
    }
    $bound = 'original';
    $source = ['left' => &$bound, 'nested' => ['right' => &$bound], 'object' => $object];
    $source['self'] = &$source;
    $snapshot = VPHP\ReferenceProbe\snapshotArray($source);
    $snapshot['left'] = 'snapshot';
    if ($bound !== 'original' || $snapshot['nested']['right'] !== 'snapshot'
        || $snapshot['self']['left'] !== 'snapshot' || $snapshot['object'] !== $object) {
        throw new RuntimeException('Array snapshot changed the source, alias group, cycle or object identity');
    }
    $snapshot['self']['nested']['right'] = 'cycle';
    if ($snapshot['left'] !== 'cycle' || $source['nested']['right'] !== 'original') {
        throw new RuntimeException('Array snapshot did not retain the original cycle topology');
    }
    foreach (['set', 'push', 'values'] as $operation) {
        $weak = null;
        $array = VPHP\ReferenceProbe\storeArrayObject(static function () use (&$weak): object {
            $value = new stdClass();
            $weak = WeakReference::create($value);
            return $value;
        }, $operation);
        $key = $operation === 'set' ? 'entry' : 0;
        if ($weak->get() === null || $array[$key] !== $weak->get()) {
            throw new RuntimeException("Array operation $operation lost object identity");
        }
        unset($array[$key]);
        if ($weak->get() !== null) {
            throw new RuntimeException("Array operation $operation kept an extra reference");
        }
    }
    $removable = [-17 => null, '017' => 'keep distinct', "binary\0key" => $object, 8 => 'last index'];
    if (PHP_INT_SIZE === 8) {
        $removable[4294967304] = 'wide index';
    }
    $unchanged = $removable;
    $alias = $removable;
    foreach ([-17, '-17', '017', "binary\0key", array_key_last($removable), 1024, 'absent'] as $key) {
        $expected = $removable;
        $removed = array_key_exists($key, $expected);
        unset($expected[$key]);
        $appended = $expected;
        $appended[] = 'tail';
        if (VPHP\ReferenceProbe\removeArrayEntry($removable, $key)
            !== ['removed' => $removed, 'array' => $expected, 'appended' => $appended]
            || $removable !== $unchanged || $alias !== $unchanged) {
            throw new RuntimeException('Array removal changed keys, the next append index, or a shared input');
        }
    }
    foreach ([-2, 'missing', new stdClass()] as $missing) {
        if ($find($keys, $missing) !== []) {
            throw new RuntimeException('Array key lookup returned a value for an absent or unsupported key');
        }
    }
    $sparse = static function () use ($object): Generator {
        yield 8 => 'first';
        yield -1 => null;
        yield 8 => $object;
        yield "binary\0key" => $object;
        yield '12' => 'numeric string';
    };
    $keyed = iterator_to_array($sparse());
    $pairs = static function (iterable $items): array {
        $out = [];
        foreach ($items as $key => $value) {
            $out[] = [$key, $value];
        }
        return $out;
    };
    if (VPHP\ReferenceProbe\materializeIterable($sparse(), $recover) !== $keyed
        || VPHP\ReferenceProbe\materializeIterable($keyed, $recover) !== $keyed
        || VPHP\ReferenceProbe\iterableEntries($sparse()) !== $pairs($sparse())
        || VPHP\ReferenceProbe\iterableEntries($keyed) !== $pairs($keyed)
        || VPHP\ReferenceProbe\materializeIteratorList($sparse()) !== iterator_to_array($sparse(), false)) {
        throw new RuntimeException('Materialization changed PHP keys, list order, or object identity');
    }
    $phpKeyConversions = static function (): Generator {
        yield null => 'null key';
        yield false => 'false key';
        yield true => 'true key';
        yield 3.5 => 'float key';
    };
    if ($collectWithDiagnostics(static fn () => VPHP\ReferenceProbe\materializeIterable($phpKeyConversions(), $recover))
        !== $collectWithDiagnostics(static fn () => iterator_to_array($phpKeyConversions()))) {
        throw new RuntimeException('The keyed collector changed PHP key coercion or diagnostics');
    }
    $badKey = (static function (): Generator {
        yield 8 => 'partial';
        yield [] => 'invalid key';
    })();
    if (!(VPHP\ReferenceProbe\materializeIterable($badKey, $recover) instanceof TypeError)) {
        throw new RuntimeException('The keyed collector accepted an invalid array key');
    }
    $throwingList = static function () use ($failure): Generator {
        yield 8 => 'discarded';
        throw $failure;
    };
    $unreadableKeys = new class extends ArrayIterator {
        public function key(): string|int|null { throw new LogicException('key() must not be called'); }
    };
    $unreadableKeys->append($object);
    $unreadableKeys->append(null);
    $bound = 3;
    $listedReferences = VPHP\ReferenceProbe\iterableList([8 => &$bound]);
    $bound = 4;
    if (VPHP\ReferenceProbe\iterableList($unreadableKeys) !== [$object, null] || $listedReferences !== [4]) {
        throw new RuntimeException('List materialization read a key or lost a PHP reference');
    }
    $slot = $object;
    $advanced = 0;
    $referenceItems = static function &() use (&$slot, &$advanced): Generator {
        yield $slot;
        ++$advanced;
        yield 'unvisited';
    };
    foreach ([false, true] as $lazy) {
        $slot = $object;
        $source = $lazy ? $referenceItems() : [&$slot, null];
        $snapshots = VPHP\ReferenceProbe\visitIterableValues(
            value: $source,
            visit: static function (mixed $value) use ($object, &$slot): bool {
                if ($value !== $object) {
                    throw new RuntimeException('The iterable visitor lost object identity');
                }
                $slot = null;
                return false;
            },
        );
        if ($snapshots !== [0 => $object, 'completed' => false] || $slot !== null || $advanced !== 0) {
            throw new RuntimeException('The iterable visitor lost a snapshot or advanced early');
        }
    }
    if (VPHP\ReferenceProbe\visitIterableValues($unreadableKeys, static fn () => true)
        !== [0 => $object, 1 => null, 'completed' => true]) {
        throw new RuntimeException('The iterable visitor changed values or read a key');
    }
    try {
        VPHP\ReferenceProbe\visitIterableValues($throwingList(), static fn () => true);
        throw new RuntimeException('The iterable visitor suppressed an iteration error');
    } catch (DomainException $error) {
        if ($error !== $failure) {
            throw $error;
        }
    }
    $countOnly = new class extends ArrayIterator {
        public function key(): string|int|null { throw new LogicException('count called key()'); }
        public function current(): mixed { throw new LogicException('count called current()'); }
    };
    $countOnly->append($object);
    $countOnly->append(null);
    if (VPHP\ReferenceProbe\countIterable($keyed) !== count($keyed)
        || VPHP\ReferenceProbe\countIterable($countOnly) !== iterator_count($countOnly)
        || VPHP\ReferenceProbe\countIterator($countOnly) !== 2
        || VPHP\ReferenceProbe\countIterable($sparse()) !== 5) {
        throw new RuntimeException('Iterable count lost positions or read a key or value');
    }
    try {
        VPHP\ReferenceProbe\countIterator($throwingList());
        throw new RuntimeException('Iterator counting accepted a partial count');
    } catch (DomainException $error) {
        if ($error !== $failure) {
            throw $error;
        }
    }
    foreach (['materializeIteratorList', 'iterableEntries'] as $method) {
        $materialize = 'VPHP\\ReferenceProbe\\' . $method;
        try {
            $materialize($throwingList());
            throw new RuntimeException('Materialization accepted an incomplete iteration');
        } catch (DomainException $error) {
            if ($error !== $failure) {
                throw $error;
            }
        }
    }
})();
