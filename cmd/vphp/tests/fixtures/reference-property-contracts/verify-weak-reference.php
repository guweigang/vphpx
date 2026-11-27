<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{makeWeakReference, readWeakReference, weakReferenceIdentityClosure};

(static function (): void {
    $make = new ReflectionFunction('VPHP\ReferenceProbe\makeWeakReference');
    $read = new ReflectionFunction('VPHP\ReferenceProbe\readWeakReference');
    if ((string) $make->getReturnType() !== 'WeakReference'
        || (string) $read->getParameters()[0]->getType() !== 'WeakReference'
        || (string) $read->getReturnType() !== '?object') {
        throw new RuntimeException('Native weak-reference types differ in the extension or stub');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $target = new stdClass();
    $reference = makeWeakReference(target: $target);
    $echo = weakReferenceIdentityClosure();
    $signature = new ReflectionFunction($echo);
    if ($reference !== WeakReference::create($target) || $echo($reference) !== $reference
        || (string) $signature->getParameters()[0]->getType() !== 'WeakReference'
        || (string) $signature->getReturnType() !== 'WeakReference') {
        throw new RuntimeException('VPHP did not preserve the native weak-reference handle');
    }
    $pinned = readWeakReference(reference: $reference);
    if ($pinned !== $target) {
        throw new RuntimeException('Resolving the weak reference lost target identity');
    }
    unset($target);
    if ($reference->get() !== $pinned) {
        throw new RuntimeException('The returned object did not pin its target');
    }
    unset($pinned);
    if (readWeakReference($reference) !== null || $reference->get() !== null) {
        throw new RuntimeException('The weak handle retained its target');
    }

    $cycle = new stdClass();
    $cycle->self = $cycle;
    $reference = makeWeakReference($cycle);
    unset($cycle);
    gc_collect_cycles();
    if (readWeakReference($reference) !== null) {
        throw new RuntimeException('The weak handle held a cyclic target alive');
    }

    foreach ([$echo, readWeakReference(...)] as $reject) {
        try {
            $reject(new stdClass());
            throw new RuntimeException('The weak-reference bridge accepted an unrelated object');
        } catch (TypeError) {
        }
    }
})();
