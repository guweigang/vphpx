<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{collectVFiberHeap, currentFiber, fiberAcrossCollection, fiberContextId, fiberIdentityClosure, fiberReturn, fiberState, makeFiber, resumeFiber, startFiber, startFiberWithValue, suspendFiber, throwIntoFiber};

if (in_array('--exit-with-parked-fiber', $_SERVER['argv'] ?? [], true)) {
    $parked = new Fiber(static function (): void {
        try {
            fiberAcrossCollection('request shutdown');
        } finally {
            echo "closed parked Fiber\n";
        }
    });
    $parked->start();
    collectVFiberHeap();
    exit(41);
}

(static function (): void {
    $factory = new ReflectionFunction('VPHP\ReferenceProbe\makeFiber');
    $current = new ReflectionFunction('VPHP\ReferenceProbe\currentFiber');
    $start = new ReflectionFunction('VPHP\ReferenceProbe\startFiber');
    if ((string) $factory->getReturnType() !== 'Fiber'
        || (string) $current->getReturnType() !== '?Fiber'
        || (string) $start->getParameters()[0]->getType() !== 'Fiber') {
        throw new RuntimeException('Fiber types differ in the extension or stub');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }
    if (currentFiber() !== null || fiberContextId() !== 0) {
        throw new RuntimeException('The PHP main stack was reported as a Fiber');
    }

    $steps = [];
    $fiber = makeFiber(static function (object $first, string $last) use (&$steps): mixed {
        $current = currentFiber();
        $steps = [fiberContextId(), fiberState($current)];
        $resume = suspendFiber([$first, $last, $current]);
        if (currentFiber() !== $current || fiberContextId() !== $steps[0]) {
            throw new RuntimeException('The resumed fiber lost its identity');
        }
        return $resume;
    });
    $echo = fiberIdentityClosure();
    $signature = new ReflectionFunction($echo);
    if ($echo($fiber) !== $fiber || (string) $signature->getParameters()[0]->getType() !== 'Fiber'
        || (string) $signature->getReturnType() !== 'Fiber' || $steps !== []
        || fiberState($fiber) !== [false, false, false, false]) {
        throw new RuntimeException('The VPHP wrapper started the Fiber early or changed its type');
    }
    foreach ([$echo, static fn (object $value) => startFiber($value, [])] as $reject) {
        try {
            $reject(new stdClass());
            throw new RuntimeException('A Fiber bridge accepted an unrelated object');
        } catch (TypeError) {
        }
    }
    $value = new stdClass();
    if (startFiber(fiber: $fiber, args: ['last' => 'named', 'first' => $value]) !== [$value, 'named', $fiber]
        || ($steps[0] ?? 0) === 0 || $steps[1] !== [true, true, false, false]
        || fiberState($fiber) !== [true, false, true, false]) {
        throw new RuntimeException('Named start or V-driven suspend lost the native Fiber state');
    }
    if (resumeFiber($fiber, $value) !== null || fiberReturn($fiber) !== $value
        || fiberState($fiber) !== [true, false, false, true] || fiberContextId() !== 0) {
        throw new RuntimeException('Resume lost the return value or terminated Fiber state');
    }

    $failure = new LogicException('injected');
    $catching = new Fiber(static function ($value) use ($failure): mixed {
        try {
            Fiber::suspend($value);
        } catch (LogicException $caught) {
            if ($caught !== $failure) {
                throw $caught;
            }
            return $caught;
        }
        throw new RuntimeException('The native Fiber did not receive the exception');
    });
    if (startFiberWithValue($catching, null) !== null || throwIntoFiber($catching, $failure) !== null
        || fiberReturn($catching) !== $failure) {
        throw new RuntimeException('The VPHP bridge lost an injected exception');
    }

    $escaping = new Fiber(static fn () => Fiber::suspend());
    startFiber($escaping, []);
    try {
        throwIntoFiber($escaping, $failure);
        throw new RuntimeException('The injected exception did not escape');
    } catch (LogicException $caught) {
        if ($caught !== $failure) {
            throw $caught;
        }
    }
    foreach ([
        [static fn () => $fiber->resume(), static fn () => resumeFiber($fiber, null)],
        [static fn () => Fiber::suspend(), static fn () => suspendFiber(null)],
        [static fn () => (new Fiber(static fn () => null))->getReturn(),
            static fn () => fiberReturn(new Fiber(static fn () => null))],
    ] as [$native, $bridged]) {
        try {
            $native();
            throw new RuntimeException('The native Fiber accepted an invalid operation');
        } catch (FiberError $expected) {
            try {
                $bridged();
                throw new RuntimeException('The VPHP Fiber accepted an invalid operation');
            } catch (FiberError $actual) {
                if ($actual->getMessage() !== $expected->getMessage()) {
                    throw $actual;
                }
            }
        }
    }

    $node = new stdClass();
    $callback = static function () use ($node): void { suspendFiber($node); };
    $waiting = makeFiber($callback);
    $weak = [WeakReference::create($waiting), WeakReference::create($callback), WeakReference::create($node)];
    startFiber($waiting, []);
    unset($waiting, $callback, $node);
    gc_collect_cycles();
    foreach ($weak as $reference) {
        if ($reference->get() !== null) {
            throw new RuntimeException('Dropping the VPHP Fiber retained the callback or its capture');
        }
    }

    $enabled = collectVFiberHeap();
    $stack = new Fiber(static fn (): string => fiberAcrossCollection('live V data '));
    $second = new Fiber(static fn (): string => fiberAcrossCollection('second V stack '));
    $stack->start();
    $second->start();
    $collectsWhileParked = collectVFiberHeap();
    if (PHP_VERSION_ID < 80300 && $collectsWhileParked) {
        throw new RuntimeException('The V collector lost its pause on a Zend build without Fiber stack bounds');
    }
    if (in_array('--require-parked-fiber-gc', $_SERVER['argv'] ?? [], true) && !$collectsWhileParked) {
        throw new RuntimeException('The V collector did not resume while both Fiber stacks were parked');
    }
    for ($gc = 0; $gc < 4; ++$gc) {
        collectVFiberHeap();
    }
    $stack->resume();
    collectVFiberHeap();
    $second->resume();
    if ($stack->getReturn() !== rtrim(str_repeat('live V data ', 800))
        || $second->getReturn() !== rtrim(str_repeat('second V stack ', 800))
        || collectVFiberHeap() !== $enabled) {
        throw new RuntimeException('Collecting across Fiber switches lost native data or collector state');
    }

    $abandoned = new Fiber(static fn (): string => fiberAcrossCollection('abandoned stack'));
    $waiting = new Fiber(static fn (): string => fiberAcrossCollection('waiting stack'));
    $waiting->start();
    $abandoned->start();
    unset($abandoned);
    if (collectVFiberHeap() !== $collectsWhileParked) {
        throw new RuntimeException('Cancelling a Fiber changed collection for the other parked stack');
    }
    unset($waiting);
    if (collectVFiberHeap() !== $enabled) {
        throw new RuntimeException('Abandoning the last Fiber did not restore the V collector');
    }
})();
