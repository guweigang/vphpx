<?php
declare(strict_types=1);

class FiberIntegerChild extends VPHP\Smoke\IntegerCounter
{
    public static int $count = 100;
}

class FiberLegacyChild extends VPHP\Smoke\LegacyIntegerCounter
{
    public static int $count = 200;
}

function verifyWorkerStaticFibers(): void
{
    foreach ([
        [VPHP\Smoke\IntegerCounter::class, FiberIntegerChild::class, 5, 100, 'default'],
        [VPHP\Smoke\LegacyIntegerCounter::class, FiberLegacyChild::class, 0, 200, ''],
    ] as [$base, $child, $baseDefault, $childDefault, $labelDefault]) {
        if ([$base::$count, $child::$count, $child::$label] !== [$baseDefault, $childDefault, $labelDefault]) {
            throw new RuntimeException('Worker did not enter the Fiber test with its static defaults');
        }
        $outerCount = 300;
        $outerLabel = 'root';
        $base::$count =& $outerCount;
        $child::$count =& $outerCount;
        $base::$label =& $outerLabel;
        $failure = new DomainException('second Fiber');
        $make = static function (int $count, string $label, bool $fail) use (
            $base, $child, $baseDefault, $childDefault, $labelDefault, $failure
        ): Fiber {
            return new Fiber(static function () use (
                $base, $child, $baseDefault, $childDefault, $labelDefault, $count, $label, $fail, $failure
            ): array {
                return vphp_standalone_probe_with_static_request(static function () use (
                    $base, $child, $baseDefault, $childDefault, $labelDefault, $count, $label, $fail, $failure
                ): array {
                    if ([$base::$count, $child::$count, $child::$label]
                        !== [$baseDefault, $childDefault, $labelDefault]) {
                        throw new RuntimeException('Fiber inherited another worker scope');
                    }
                    $child::$count =& $count;
                    $base::$label =& $label;
                    $actual = $child::reenterWorkerStatics(static function () use (
                        $base, $child, $baseDefault, $childDefault, $labelDefault, &$count, &$label
                    ): void {
                        Fiber::suspend([$child::$count, $child::$label]);
                        vphp_standalone_probe_with_static_request(static function () use (
                            $base, $child, $baseDefault, $childDefault, $labelDefault, &$count, &$label
                        ): void {
                            if ([$base::$count, $child::$count, $child::$label]
                                !== [$baseDefault, $childDefault, $labelDefault]) {
                                throw new RuntimeException('Nested Fiber scope lost its defaults');
                            }
                            $child::$count = 900;
                            Fiber::suspend($child::$count);
                            if ($child::$count !== 900) {
                                throw new RuntimeException('Nested Fiber scope lost its static state');
                            }
                            $count = 800;
                            $label = 'discarded';
                        });
                        if ($child::$count !== $count || $child::$label !== $label || $count === 800) {
                            throw new RuntimeException('Nested Fiber scope lost its parent reference binding');
                        }
                    });
                    if ($fail) {
                        throw $failure;
                    }
                    return [$actual, $count, $label, $base::$count];
                });
            });
        };

        $a = $make(11, 'A', false);
        $b = $make(22, 'B', true);
        if ($a->start() !== [21, 'A:outer'] || $b->start() !== [32, 'B:outer']
            || [$base::$count, $child::$count, $child::$label] !== [300, 300, 'root']) {
            throw new RuntimeException('Suspended workers leaked static state into their caller');
        }
        $outerCount = 301;
        $outerLabel = 'changed in main';
        if ($a->resume() !== 900 || $b->resume() !== 900
            || [$base::$count, $child::$count, $child::$label] !== [301, 301, 'changed in main']) {
            throw new RuntimeException('Nested workers leaked static state into their caller');
        }
        $a->resume();
        if ($a->getReturn() !== ['21:A:outer', 22, 'A:outer:resumed', $baseDefault]) {
            throw new RuntimeException('Reentrant V method resumed with another Fiber’s static state');
        }
        try {
            $b->resume();
            throw new RuntimeException('Expected the Fiber exception');
        } catch (DomainException $caught) {
            if ($caught !== $failure) {
                throw $caught;
            }
        }
        $abandoned = $make(33, 'C', false);
        if ($abandoned->start() !== [43, 'C:outer']) {
            throw new RuntimeException('The last worker did not suspend');
        }
        unset($abandoned);
        $child::$count = 302;
        $base::$label = 'restored';
        if ([$outerCount, $outerLabel, $base::$count, $child::$label] !== [302, 'restored', 302, 'restored']) {
            throw new RuntimeException('The caller lost its original static reference bindings');
        }
    }
}
