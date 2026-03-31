--TEST--
VSlim PSR-16 cache stores mixed values, validates keys, and applies TTL semantics
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
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
    $cache = new VSlim\Psr16\Cache();

    var_dump($cache->set('alpha', 'A'));
    var_dump($cache->get('alpha'));
    var_dump($cache->has('alpha'));

    var_dump($cache->set('nullish', null));
    var_dump($cache->has('nullish'));
    var_dump($cache->get('nullish', 'fallback'));
    var_dump($cache->get('missing', 'fallback'));

    var_dump($cache->setMultiple([
        'one' => 1,
        'two' => ['nested' => true],
    ]));
    $many = $cache->getMultiple(['one', 'two', 'three'], 'miss');
    var_dump($many['one'], $many['two'], $many['three']);

    var_dump($cache->setMultiple(new ArrayIterator([
        'iter-a' => 'A',
        'iter-b' => 'B',
    ])));
    $iterMany = $cache->getMultiple(new ArrayIterator(['iter-a', 'iter-b', 'iter-c']), 'na');
    var_dump($iterMany['iter-a'], $iterMany['iter-b'], $iterMany['iter-c']);

    var_dump($cache->deleteMultiple(['one', 'iter-a']));
    var_dump($cache->has('one'));
    var_dump($cache->has('iter-a'));
    var_dump($cache->has('iter-b'));

    var_dump($cache->set('zero-ttl', 'gone', 0));
    var_dump($cache->has('zero-ttl'));

    var_dump($cache->set('interval', 'soon', new DateInterval('PT1S')));
    var_dump($cache->has('interval'));
    sleep(2);
    var_dump($cache->get('interval', 'expired'));
    var_dump($cache->has('interval'));

    try {
        $cache->set('bad{key}', 'x');
        echo "invalid-key-missed\n";
    } catch (Psr\SimpleCache\InvalidArgumentException $e) {
        echo get_class($e) . "|invalid-key\n";
    }

    try {
        $cache->getMultiple(new ArrayIterator([new stdClass()]));
        echo "invalid-iterable-key-missed\n";
    } catch (Psr\SimpleCache\InvalidArgumentException $e) {
        echo get_class($e) . "|invalid-iterable-key\n";
    }

    var_dump($cache->clear());
    var_dump($cache->has('alpha'));
    var_dump($cache->has('iter-b'));
}
?>
--EXPECT--
bool(true)
string(1) "A"
bool(true)
bool(true)
bool(true)
NULL
string(8) "fallback"
bool(true)
int(1)
array(1) {
  ["nested"]=>
  bool(true)
}
string(4) "miss"
bool(true)
string(1) "A"
string(1) "B"
string(2) "na"
bool(true)
bool(false)
bool(false)
bool(true)
bool(true)
bool(false)
bool(true)
bool(true)
string(7) "expired"
bool(false)
VSlim\Psr16\InvalidArgumentException|invalid-key
VSlim\Psr16\InvalidArgumentException|invalid-iterable-key
bool(true)
bool(false)
bool(false)
