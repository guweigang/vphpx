--TEST--
VSlim PSR-6 cache item and pool support first-touch metadata queries and runtime binding
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (extension_loaded('psr')) {
    echo "skip psr extension already loaded; runtime autoload binding needs a clean environment";
    return;
}
?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if (!str_starts_with($class, 'Psr\\Cache\\')) {
        return;
    }

    eval(<<<'PHP'
namespace Psr\Cache;

interface CacheException extends \Throwable {}

interface InvalidArgumentException extends CacheException {}

interface CacheItemInterface
{
    public function getKey(): string;
    public function get(): mixed;
    public function isHit(): bool;
    public function set(mixed $value): static;
    public function expiresAt(?\DateTimeInterface $expiration): static;
    public function expiresAfter(int|\DateInterval|null $time): static;
}

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
PHP);
});

$describeType = static function (?ReflectionType $type): ?string {
    if ($type === null) {
        return null;
    }
    if ($type instanceof ReflectionNamedType) {
        return $type->getName();
    }
    if ($type instanceof ReflectionUnionType) {
        $names = array_map(
            static fn (ReflectionNamedType $named): string => $named->getName(),
            $type->getTypes(),
        );
        sort($names, SORT_STRING);
        return implode('|', $names);
    }
    return get_class($type);
};

$itemIface = 'Psr\\Cache\\CacheItemInterface';
$poolIface = 'Psr\\Cache\\CacheItemPoolInterface';
$cacheExIface = 'Psr\\Cache\\CacheException';
$invalidArgIface = 'Psr\\Cache\\InvalidArgumentException';

var_dump(interface_exists($itemIface, false));
var_dump(interface_exists($poolIface, false));
var_dump(interface_exists($cacheExIface, false));
var_dump(interface_exists($invalidArgIface, false));
var_dump(is_a(VSlim\Psr6\CacheItem::class, $itemIface, true));
var_dump(is_a(VSlim\Psr6\CacheItemPool::class, $poolIface, true));
var_dump(is_a(VSlim\Psr6\CacheException::class, $cacheExIface, true));
var_dump(is_a(VSlim\Psr6\InvalidArgumentException::class, $invalidArgIface, true));
var_dump((new VSlim\Psr6\CacheItemPool()) instanceof Psr\Cache\CacheItemPoolInterface);
var_dump((new VSlim\Psr6\CacheItemPool())->getItem('alpha') instanceof Psr\Cache\CacheItemInterface);

$getItem = new ReflectionMethod(VSlim\Psr6\CacheItemPool::class, 'getItem');
$getItems = new ReflectionMethod(VSlim\Psr6\CacheItemPool::class, 'getItems');
$save = new ReflectionMethod(VSlim\Psr6\CacheItemPool::class, 'save');
$set = new ReflectionMethod(VSlim\Psr6\CacheItem::class, 'set');
$expiresAt = new ReflectionMethod(VSlim\Psr6\CacheItem::class, 'expiresAt');
$expiresAfter = new ReflectionMethod(VSlim\Psr6\CacheItem::class, 'expiresAfter');

var_dump($describeType($getItem->getReturnType()));
var_dump($describeType($getItems->getParameters()[0]->getType()));
$getItemsReturn = $getItems->getReturnType();
if ($getItemsReturn === null && method_exists($getItems, 'getTentativeReturnType')) {
    $getItemsReturn = $getItems->getTentativeReturnType();
}
var_dump($describeType($getItemsReturn));
var_dump($describeType($save->getParameters()[0]->getType()));
var_dump($describeType($set->getReturnType()));
var_dump($describeType($expiresAt->getParameters()[0]->getType()));
var_dump($describeType($expiresAt->getReturnType()));
var_dump($describeType($expiresAfter->getReturnType()));
?>
--EXPECT--
bool(false)
bool(false)
bool(false)
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
string(28) "Psr\Cache\CacheItemInterface"
string(5) "array"
string(17) "Traversable|array"
string(28) "Psr\Cache\CacheItemInterface"
string(6) "static"
string(17) "DateTimeInterface"
string(6) "static"
string(6) "static"
