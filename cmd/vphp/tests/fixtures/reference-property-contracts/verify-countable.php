<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{countableIdentity, countableSize, countedOffsetSet};

(static function (): void {
    $size = new ReflectionFunction(countableSize(...));
    $write = new ReflectionFunction(countedOffsetSet(...));
    $intersection = $write->getParameters()[0]->getType();
    $interfaces = $intersection instanceof ReflectionIntersectionType
        ? array_map(static fn (ReflectionNamedType $type): string => $type->getName(), $intersection->getTypes())
        : [];
    sort($interfaces);
    if ((string) $size->getParameters()[0]->getType() !== Countable::class
        || (string) $size->getReturnType() !== 'int'
        || (string) $write->getReturnType() !== 'int'
        || $interfaces !== [ArrayAccess::class, Countable::class]) {
        throw new RuntimeException('Unexpected Countable or intersection signature');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $entries = new class([1, 2]) extends ArrayObject {
        public int $calls = 0;

        public function count(): int
        {
            ++$this->calls;
            return 10 + parent::count();
        }
    };
    if (countableSize(value: $entries) !== 12 || $entries->calls !== 1
        || countedOffsetSet(value: 3, entries: $entries, key: 'third') !== 13
        || $entries['third'] !== 3 || $entries->calls !== 2) {
        throw new RuntimeException('Countable ignored an override or lost ArrayAccess mutation');
    }
    $echo = countableIdentity();
    $signature = new ReflectionFunction($echo);
    if ($echo($entries) !== $entries || (string) $signature->getReturnType() !== Countable::class
        || (string) $signature->getParameters()[0]->getType() !== Countable::class) {
        throw new RuntimeException('Countable was not recognized in the closure bridge');
    }
    $failure = new DomainException('count failure');
    $throws = new class($failure) implements Countable {
        public function __construct(private Throwable $failure) {}
        public function count(): int { throw $this->failure; }
    };
    foreach ([
        static fn () => countableSize(new stdClass()),
        static fn () => countedOffsetSet($throws, 'third', 3),
    ] as $reject) {
        try {
            $reject();
            throw new LogicException('An object missing a required interface was accepted');
        } catch (TypeError) {
        }
    }
    try {
        countableSize($throws);
        throw new LogicException('The count exception did not escape');
    } catch (DomainException $caught) {
        if ($caught !== $failure) { throw $caught; }
    }
})();
