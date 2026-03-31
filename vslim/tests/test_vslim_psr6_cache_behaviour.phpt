--TEST--
VSlim PSR-6 cache item pool stores values, supports deferred writes, and applies expiration semantics
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
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
    $pool = new VSlim\Psr6\CacheItemPool();

    $miss = $pool->getItem('alpha');
    var_dump($miss instanceof Psr\Cache\CacheItemInterface);
    var_dump($miss->getKey());
    var_dump($miss->isHit());
    var_dump($miss->get());

    $miss->set('A');
    var_dump($pool->save($miss));

    $hit = $pool->getItem('alpha');
    var_dump($hit->isHit());
    var_dump($hit->get());

    $beta = $pool->getItem('beta')->set(['nested' => true]);
    var_dump($pool->saveDeferred($beta));
    var_dump($pool->hasItem('beta'));
    var_dump($pool->getItem('beta')->isHit());
    var_dump($pool->getItem('beta')->get());
    var_dump($pool->commit());

    $many = $pool->getItems(['alpha', 'beta', 'missing']);
    var_dump($many['alpha']->get(), $many['beta']->get(), $many['missing']->isHit());

    $ttl = $pool->getItem('ttl')->set('soon')->expiresAfter(1);
    var_dump($pool->save($ttl));
    var_dump($pool->hasItem('ttl'));
    sleep(2);
    var_dump($pool->hasItem('ttl'));
    var_dump($pool->getItem('ttl')->isHit());
    var_dump($pool->getItem('ttl')->get());

    $abs = $pool->getItem('abs')->set('later')->expiresAt(
        (new DateTimeImmutable('now'))->add(new DateInterval('PT1S'))
    );
    var_dump($pool->save($abs));
    var_dump($pool->hasItem('abs'));
    sleep(2);
    var_dump($pool->hasItem('abs'));

    var_dump($pool->deleteItem('alpha'));
    var_dump($pool->hasItem('alpha'));
    var_dump($pool->deleteItems(['beta', 'abs']));
    var_dump($pool->hasItem('beta'));
    var_dump($pool->hasItem('abs'));

    $pool->save($pool->getItem('gamma')->set('G'));
    var_dump($pool->clear());
    var_dump($pool->hasItem('gamma'));

    try {
        $pool->getItem('bad{key}');
        echo "invalid-key-missed\n";
    } catch (Psr\Cache\InvalidArgumentException $e) {
        echo get_class($e) . "|invalid-key\n";
    }

    try {
        $pool->getItems(['ok', new stdClass()]);
        echo "invalid-array-key-missed\n";
    } catch (Psr\Cache\InvalidArgumentException $e) {
        echo get_class($e) . "|invalid-array-key\n";
    }
}
?>
--EXPECT--
bool(true)
string(5) "alpha"
bool(false)
NULL
bool(true)
bool(true)
string(1) "A"
bool(true)
bool(true)
bool(true)
array(1) {
  ["nested"]=>
  bool(true)
}
bool(true)
string(1) "A"
array(1) {
  ["nested"]=>
  bool(true)
}
bool(false)
bool(true)
bool(true)
bool(false)
bool(false)
NULL
bool(true)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(false)
bool(true)
bool(false)
VSlim\Psr6\InvalidArgumentException|invalid-key
VSlim\Psr6\InvalidArgumentException|invalid-array-key
