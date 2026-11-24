<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{lookupWeakMap, makeWeakMap, removeWeakMapKey, weakMapEntries, weakMapIdentityClosure, weakMapThroughCallback, writeWeakMap};
use function VPHP\ReferenceProbe\{bindWeakMapReference, updateWeakMapReference};

(static function (): void {
    $make = new ReflectionFunction(makeWeakMap(...));
    $lookup = new ReflectionFunction(lookupWeakMap(...));
    $callback = new ReflectionFunction(weakMapThroughCallback(...));
    $binding = new ReflectionFunction(bindWeakMapReference(...));
    if ((string) $make->getReturnType() !== 'WeakMap'
        || (string) $lookup->getParameters()[0]->getType() !== 'WeakMap'
        || (string) $callback->getReturnType() !== 'WeakMap'
        || (string) $binding->getReturnType() !== 'void'
        || !$binding->getParameters()[2]->isPassedByReference()) {
        throw new RuntimeException('Native WeakMap signatures differ in the extension or stub');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $map = makeWeakMap();
    $key = (object) ['id' => 1];
    $other = clone $key;
    $value = new stdClass();
    writeWeakMap(value: $value, key: $key, map: $map);
    $map[$other] = null;
    if ($map[$key] !== $value || lookupWeakMap(key: $key, map: $map) !== ['count' => 2, 'value' => $value]
        || lookupWeakMap($map, $other) !== ['count' => 2, 'value' => null]
        || lookupWeakMap($map, clone $key) !== ['count' => 2]
        || weakMapEntries($map) !== [[$key, $value], [$other, null]]) {
        throw new RuntimeException('WeakMap lookup lost object identity or confused null with an absent key');
    }
    $alias =& $map[$other];
    $alias = 41;
    $snapshot = lookupWeakMap($map, $other);
    $alias = null;
    if ($snapshot !== ['count' => 2, 'value' => 41]
        || ReflectionReference::fromArrayElement($snapshot, 'value') !== null) {
        throw new RuntimeException('A by-value WeakMap lookup leaked the native reference');
    }
    unset($alias);
    unset($key);
    if (count($map) !== 1) {
        throw new RuntimeException('WeakMap kept an otherwise unreachable key alive');
    }
    removeWeakMapKey($map, $other);
    removeWeakMapKey($map, $other);
    if (lookupWeakMap($map, $other) !== ['count' => 0]) {
        throw new RuntimeException('WeakMap key removal did not update the native map');
    }

    $source = 10;
    if (updateWeakMapReference($map, $other, 11) || count($map) !== 0) {
        throw new RuntimeException('Reference lookup inserted a missing key');
    }
    if (PHP_VERSION_ID < 80600) {
        try {
            bindWeakMapReference($map, $other, $source);
            throw new LogicException('Reference assignment inserted a key before PHP 8.6');
        } catch (Exception $error) {
            if ($error->getMessage() !== 'PHP WeakMap reference assignment failed' || count($map) !== 0) {
                throw $error;
            }
            unset($error);
        }
        $map[$other] = null;
        if (updateWeakMapReference($map, $other, 11) || $map[$other] !== null) {
            throw new RuntimeException('Reference lookup modified a non-reference entry');
        }
    }
    bindWeakMapReference(value: $source, key: $other, entries: $map);
    $alias =& $map[$other];
    if (!updateWeakMapReference($map, $other, 12) || $source !== 12 || $alias !== 12) {
        throw new RuntimeException('V update did not preserve the PHP reference');
    }
    $replacement = null;
    bindWeakMapReference($map, $other, $replacement);
    if (lookupWeakMap($map, $other) !== ['count' => 1, 'value' => null]
        || !updateWeakMapReference($map, $other, 13) || $replacement !== 13 || $source !== 12) {
        throw new RuntimeException('Rebinding overwrote the old group or lost the new reference');
    }
    unset($other);
    if (count($map) !== 0 || $replacement !== 13) {
        throw new RuntimeException('A reference prevented WeakMap key collection');
    }

    $key = new stdClass();
    $source = 20;
    $map[$key] = new class(static function () use ($map, $key): void {
        if (!updateWeakMapReference($map, $key, 21)) {
            throw new RuntimeException('The new reference was not installed before the destructor ran');
        }
    }) {
        public function __construct(private Closure $onDestroy) {}
        public function __destruct() { ($this->onDestroy)(); }
    };
    bindWeakMapReference($map, $key, $source);
    if ($source !== 21 || $map[$key] !== 21) {
        throw new RuntimeException('A destructor could not reenter V and write the new reference');
    }
    unset($key);

    $cycle = new stdClass();
    $cycle->self = $cycle;
    $weakValue = WeakReference::create($value);
    writeWeakMap($map, $cycle, $value);
    unset($cycle, $value);
    gc_collect_cycles();
    if (count($map) !== 0 || $weakValue->get() !== null) {
        throw new RuntimeException('WeakMap failed to discard a collected cyclic key and release its value');
    }

    $echo = weakMapIdentityClosure();
    $signature = new ReflectionFunction($echo);
    if ($echo($map) !== $map || weakMapThroughCallback($map, $echo) !== $map
        || (string) $signature->getParameters()[0]->getType() !== 'WeakMap'
        || (string) $signature->getReturnType() !== 'WeakMap') {
        throw new RuntimeException('The closure bridge lost WeakMap identity or typing');
    }
    foreach ([$echo, static fn (object $value) => lookupWeakMap($value, new stdClass())] as $reject) {
        try {
            $reject(new stdClass());
            throw new RuntimeException('The WeakMap bridge accepted an unrelated object');
        } catch (TypeError) {
        }
    }
})();
