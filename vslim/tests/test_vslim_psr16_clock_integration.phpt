--TEST--
VSlim PSR-16 cache can use an injected PSR-20 clock for TTL semantics
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

namespace Psr\SimpleCache {
    if (!interface_exists(CacheException::class, false)) {
        interface CacheException extends \Throwable {}
    }
    if (!interface_exists(InvalidArgumentException::class, false)) {
        interface InvalidArgumentException extends CacheException {}
    }
    if (!interface_exists(CacheInterface::class, false)) {
        interface CacheInterface
        {
            public function get(string $key, mixed $default = null): mixed;
            public function set(string $key, mixed $value, null|int|\DateInterval $ttl = null): bool;
            public function delete(string $key): bool;
            public function clear(): bool;
            public function getMultiple(iterable $keys, mixed $default = null): iterable;
            public function setMultiple(iterable $values, null|int|\DateInterval $ttl = null): bool;
            public function deleteMultiple(iterable $keys): bool;
            public function has(string $key): bool;
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
    $cache = new VSlim\Psr16\Cache();

    var_dump($cache->setClock($clock) === $cache);
    var_dump($cache->clock() === $clock);

    var_dump($cache->set('alpha', 'A', 10));
    var_dump($cache->has('alpha'));
    $clock->advance('PT11S');
    var_dump($cache->has('alpha'));
    var_dump($cache->get('alpha', 'expired'));

    $clock = new MutableClock('2024-01-01T00:00:00+00:00');
    $cache->setClock($clock);
    var_dump($cache->set('beta', 'B', new DateInterval('PT5S')));
    var_dump($cache->has('beta'));
    $clock->advance('PT6S');
    var_dump($cache->get('beta', 'expired'));
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(false)
string(7) "expired"
bool(true)
bool(true)
string(7) "expired"
