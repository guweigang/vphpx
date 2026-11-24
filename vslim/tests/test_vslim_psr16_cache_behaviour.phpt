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
    var_dump($cache->get(defaultValue: 'fallback', key: 'missing'));

    var_dump($cache->setMultiple([
        'one' => 1,
        'two' => ['nested' => true],
    ]));
    $many = $cache->getMultiple(['one', 'two', 'three'], 'miss');
    var_dump($many['one'], $many['two'], $many['three']);

    $missingValue = new stdClass();
    $weak = WeakReference::create($missingValue);
    $missing = $cache->getMultiple(['unowned-miss'], $missingValue);
    if ($missing['unowned-miss'] !== $missingValue) {
        throw new RuntimeException('getMultiple replaced the default object');
    }
    unset($missing, $missingValue);
    if ($weak->get() !== null) {
        throw new RuntimeException('getMultiple kept an extra reference to the default object');
    }
    $largeKey = PHP_INT_SIZE === 8 ? '9223372036854775808' : '2147483648';
    $payload = ['-0' => 'zero string', $largeKey => 'wide string', PHP_INT_MIN => 'minimum'];
    $payload[42] = 'removed';
    unset($payload[42]);
    $cache->set('array-history', ['nested' => $payload]);
    $restored = $cache->get('array-history')['nested'];
    if ($restored !== $payload) {
        throw new RuntimeException('Cache detach and restore changed PHP array keys');
    }
    $payload[] = 'tail';
    $restored[] = 'tail';
    if ($restored !== $payload) {
        throw new RuntimeException('Cache detach and restore changed the next PHP append index');
    }
    $cache->set('array-full', [PHP_INT_MAX => 'occupied']);
    $full = $cache->get('array-full');
    try {
        $full[] = 'extra';
        throw new RuntimeException('Cache restore let an append overwrite the maximum index');
    } catch (Error $error) {
        if ($full !== [PHP_INT_MAX => 'occupied']) {
            throw $error;
        }
    }
    unset($full[PHP_INT_MAX]);
    $full[] = 'replacement';
    if ($full !== [PHP_INT_MAX => 'replacement'] || $cache->get('array-full') !== [PHP_INT_MAX => 'occupied']) {
        throw new RuntimeException('Append recovery changed the retained cache value');
    }
    $bound = 'original';
    $withReferences = ['left' => &$bound, 'right' => &$bound];
    $withReferences['self'] = &$withReferences;
    $cache->set('references', $withReferences);
    $cache->setMultiple(['bulk-references' => $withReferences]);
    $bound = 'changed outside';
    $copies = $cache->getMultiple(['references', 'bulk-references']);
    foreach ($copies as $cacheKey => $copy) {
        if ($copy['left'] !== 'original') {
            throw new RuntimeException('The cache value still shares a reference with its input');
        }
        $copy['right'] = 'local';
        if ($copy['left'] !== 'local' || $copy['self']['left'] !== 'local'
            || $cache->get($cacheKey)['left'] !== 'original' || $bound !== 'changed outside') {
            throw new RuntimeException('Cache read changed the stored value or reference aliases');
        }
    }

    var_dump($cache->setMultiple(new ArrayIterator([
        'iter-a' => 'A',
        'iter-b' => 'B',
    ])));
    $iterMany = $cache->getMultiple(defaultValue: 'na', keys: new ArrayIterator(['iter-a', 'iter-b', 'iter-c']));
    var_dump($iterMany['iter-a'], $iterMany['iter-b'], $iterMany['iter-c']);

    $numericValues = static function (): Generator {
        yield '42' => 'old';
        yield -17 => null;
        yield '42' => 'last';
        yield '042' => 'distinct';
        if (PHP_INT_SIZE === 8) {
            yield 4294967338 => 'wide key';
        }
    };
    $keyList = static function (): Generator {
        yield 9 => '42';
        yield 9 => '-17';
        yield -1 => '042';
        if (PHP_INT_SIZE === 8) {
            yield -1 => '4294967338';
        }
    };
    $expected = [42 => 'last', -17 => null, '042' => 'distinct'];
    if (PHP_INT_SIZE === 8) {
        $expected[4294967338] = 'wide key';
    }
    if (!$cache->setMultiple($numericValues())
        || $cache->getMultiple($keyList(), 'miss') !== $expected
        || !$cache->setMultiple([42 => true, -17 => true], 0)
        || $cache->has('42') || $cache->has('-17') || !$cache->has('042')) {
        throw new RuntimeException('Bulk cache operations changed numeric keys or lost a yielded value');
    }
    $iterationError = new DomainException('cache iterator failed');
    $broken = static function () use ($iterationError): Generator {
        yield 'partial' => true;
        throw $iterationError;
    };
    try {
        $cache->setMultiple($broken());
        throw new RuntimeException('A failing iterable was accepted');
    } catch (DomainException $error) {
        if ($error !== $iterationError || $cache->has('partial')) {
            throw new RuntimeException('Bulk cache writes changed the exception or wrote partial data', 0, $error);
        }
    }

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
