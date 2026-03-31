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

        public function __construct(string $time)
        {
            $this->now = new DateTimeImmutable($time);
        }

        public function now(): DateTimeImmutable
        {
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
