--TEST--
VSlim PSR-6 cache pool returns fresh item wrappers over shared cache entry state
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

    $item1 = $pool->getItem('alpha');
    $item2 = $pool->getItem('alpha');

    echo (spl_object_id($item1) === spl_object_id($item2) ? 'item-stable' : 'item-distinct') . PHP_EOL;
    echo ($item1->getKey() === $item2->getKey() ? 'item-key-same' : 'item-key-diff') . PHP_EOL;
    echo ($item1->isHit() ? 'item-hit' : 'item-miss') . PHP_EOL;

    $item1->set('A');
    $pool->save($item1);

    echo ($item2->isHit() ? 'item2-hit' : 'item2-miss') . PHP_EOL;
    echo $item2->get() . PHP_EOL;

    $item3 = $pool->getItem('alpha');
    echo (spl_object_id($item2) === spl_object_id($item3) ? 'item23-stable' : 'item23-distinct') . PHP_EOL;
    echo $item3->get() . PHP_EOL;

    $item3->set('B');
    $pool->saveDeferred($item3);
    echo ($pool->getItem('alpha')->get() === 'B' ? 'deferred-visible' : 'deferred-hidden') . PHP_EOL;
    $pool->commit();
    echo ($pool->getItem('alpha')->get() === 'B' ? 'commit-visible' : 'commit-hidden') . PHP_EOL;

    $pool->setNamespace('isolated');
    $bound = 'staged';
    $object = new stdClass();
    $input = ['left' => &$bound, 'right' => &$bound, 'object' => $object];
    $input['loop'] = &$input;
    $staged = $pool->getItem('references')->set($input);
    $bound = 'outside';
    $itemRead = $staged->get();
    $itemRead['left'] = 'item-copy';
    if ($itemRead['right'] !== 'item-copy' || $itemRead['loop']['left'] !== 'item-copy'
        || $itemRead['object'] !== $object || $staged->get()['left'] !== 'staged'
        || $bound !== 'outside') {
        throw new RuntimeException('Cache item failed to isolate array references');
    }
    if (!$pool->saveDeferred($staged)) {
        throw new RuntimeException('Could not stage a reference graph');
    }
    $staged->set(['left' => 'replacement']);
    $pending = $pool->getItems(['references'])['references']->get();
    $pending['right'] = 'pending-copy';
    if ($pending['left'] !== 'pending-copy' || $pool->getItem('references')->get()['left'] !== 'staged'
        || !$pool->commit() || $pool->getItem('references')->get()['left'] !== 'staged') {
        throw new RuntimeException('Deferred commit lost isolation or the staged value');
    }
    if (!$pool->saveDeferred($pool->getItem('references')->set('superseded'))
        || !$pool->save($staged) || $pool->getItem('references')->get() !== ['left' => 'replacement']
        || !$pool->commit() || $pool->getItem('references')->get() !== ['left' => 'replacement']) {
        throw new RuntimeException('A deferred namespaced value overwrote a later direct save');
    }
}
?>
--EXPECT--
item-distinct
item-key-same
item-miss
item2-miss

item23-distinct
A
deferred-visible
commit-visible
