--TEST--
VSlim PSR-6 cache item pool can use an injected PSR-20 clock for expiration semantics
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
namespace Psr\Clock {
    if (!interface_exists(ClockInterface::class, false)) {
        interface ClockInterface {
            public function now(): \DateTimeImmutable;
        }
    }
}

namespace Psr\Cache {
    if (!interface_exists(CacheException::class, false)) {
        interface CacheException extends \Throwable {}
    }

    if (!interface_exists(InvalidArgumentException::class, false)) {
        interface InvalidArgumentException extends CacheException {}
    }

    if (!interface_exists(CacheItemInterface::class, false)) {
        interface CacheItemInterface
        {
            public function getKey(): string;
            public function get(): mixed;
            public function isHit(): bool;
            public function set(mixed $value): static;
            public function expiresAt(?\DateTimeInterface $expiration): static;
            public function expiresAfter(int|\DateInterval|null $time): static;
        }
    }

    if (!interface_exists(CacheItemPoolInterface::class, false)) {
        interface CacheItemPoolInterface
        {
            public function getItem(string $key): CacheItemInterface;
            public function getItems(array $keys = []): iterable;
            public function hasItem(string $key): bool;
            public function clear(): bool;
            public function deleteItem(string $key): bool;
            public function deleteItems(array $keys): bool;
            public function save(CacheItemInterface $item): bool;
            public function saveDeferred(CacheItemInterface $item): bool;
            public function commit(): bool;
        }
    }
}

namespace {
    final class MutableClock implements Psr\Clock\ClockInterface
    {
        private DateTimeImmutable $now;
        public int $reads = 0;

        public function __construct(string $time)
        {
            $this->now = new DateTimeImmutable($time);
        }

        public function now(): DateTimeImmutable
        {
            ++$this->reads;
            return $this->now;
        }

        public function advance(string $intervalSpec): void
        {
            $this->now = $this->now->add(new DateInterval($intervalSpec));
        }
    }

    $clock = new MutableClock('2024-01-01T00:00:00+00:00');
    $pool = new VSlim\Psr6\CacheItemPool();

    var_dump($pool->setClock($clock) === $pool);
    var_dump($pool->clock() === $clock);
    if ($pool->setClock(clock: $clock) !== $pool || $pool->clock() !== $clock) {
        throw new RuntimeException('PSR-6 pool did not retain the clock through a named call');
    }
    foreach (['save', 'saveDeferred'] as $method) {
        $parameter = (new ReflectionMethod($pool, $method))->getParameters()[0];
        if ($parameter->getName() !== 'item' || (string) $parameter->getType() !== Psr\Cache\CacheItemInterface::class
            || !$pool->$method(item: $pool->getItem($method)->set($method))) {
            throw new RuntimeException("Unexpected cache item contract for $method");
        }
        try {
            $pool->$method(item: new stdClass());
            throw new RuntimeException("Unexpected cache item accepted by $method");
        } catch (TypeError) {
        }
    }

    $item = $pool->getItem('alpha')->set('A')->expiresAfter(10);
    var_dump($pool->save($item));
    var_dump($pool->hasItem('alpha'));
    var_dump($pool->getItem('alpha')->isHit());
    $clock->advance('PT11S');
    var_dump($pool->hasItem('alpha'));
    var_dump($pool->getItem('alpha')->isHit());

    $clock = new MutableClock('2024-01-01T00:00:00+00:00');
    $pool->setClock($clock);
    $abs = $pool->getItem('beta')->set('B')->expiresAt(
        $clock->now()->add(new DateInterval('PT5S'))
    );
    var_dump($pool->save($abs));
    var_dump($pool->hasItem('beta'));
    $clock->advance('PT6S');
    var_dump($pool->hasItem('beta'));

    $clock = new MutableClock('2024-03-30 12:00:00 Europe/Paris');
    $pool->setClock($clock);
    $item = $pool->getItem('dst')->set('day');
    $reads = $clock->reads;
    $item->expiresAfter(new DateInterval('P1D'));
    if ($clock->reads !== $reads + 1 || !$pool->save($item)) {
        throw new RuntimeException('The interval must use a single clock snapshot');
    }
    $clock->advance('PT22H59M59S');
    if (!$pool->hasItem('dst')) {
        throw new RuntimeException('The interval expired before the DST boundary');
    }
    $clock->advance('PT1S');
    if ($pool->hasItem('dst')) {
        throw new RuntimeException('The spring DST calendar day lasted longer than 23 elapsed hours');
    }

    $clock = new MutableClock('2024-01-01T00:00:00+00:00');
    $pool->setClock($clock);
    $item = $pool->getItem('mutable')->set('M');
    $expiration = (new ReflectionMethod($item, 'expiresAt'))->getParameters()[0];
    if ($expiration->getName() !== 'expiration' || (string) $expiration->getType() !== '?DateTimeInterface'
        || !$expiration->allowsNull() || $expiration->isOptional() || $expiration->isDefaultValueAvailable()
        || $item->expiresAt(expiration: null) !== $item) {
        throw new RuntimeException('expiresAt must accept null without permitting omission');
    }
    try {
        $item->expiresAt();
        throw new RuntimeException('expiresAt accepted an omitted argument');
    } catch (ArgumentCountError) {
    }
    $item->expiresAt(expiration: new DateTime('2024-01-01T00:00:05+00:00'));
    $broken = new class extends DateTime {
        public RuntimeException $failure;
        public function getTimestamp(): int
        {
            throw $this->failure;
        }
    };
    $broken->failure = new RuntimeException('expiration timestamp failed');
    try {
        $item->expiresAt($broken);
        throw new RuntimeException('Expected the DateTime exception');
    } catch (RuntimeException $error) {
        if ($error !== $broken->failure) {
            throw $error;
        }
    }
    if (!$pool->save($item) || !$pool->hasItem('mutable')) {
        throw new RuntimeException('Mutable DateTime was unavailable as the expiration');
    }
    $clock->advance('PT6S');
    if ($pool->hasItem('mutable')) {
        throw new RuntimeException('A failed expiresAt call discarded the previous expiration');
    }
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(false)
bool(false)
bool(true)
bool(true)
bool(false)
