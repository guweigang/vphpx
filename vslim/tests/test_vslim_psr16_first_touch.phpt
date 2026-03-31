--TEST--
VSlim PSR-16 cache supports first-touch metadata queries and runtime binding
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
    if (str_starts_with($class, 'Psr\\SimpleCache\\')) {
        eval(<<<'PHP'
namespace Psr\SimpleCache;

interface CacheException extends \Throwable {}

interface InvalidArgumentException extends CacheException {}

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
PHP);
    }
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

$cacheIface = 'Psr\\SimpleCache\\CacheInterface';
$cacheExIface = 'Psr\\SimpleCache\\CacheException';
$invalidArgIface = 'Psr\\SimpleCache\\InvalidArgumentException';

var_dump(interface_exists($cacheIface, false));
var_dump(interface_exists($cacheExIface, false));
var_dump(interface_exists($invalidArgIface, false));
var_dump(is_a(VSlim\Psr16\Cache::class, $cacheIface, true));
var_dump(is_a(VSlim\Psr16\CacheException::class, $cacheExIface, true));
var_dump(is_a(VSlim\Psr16\InvalidArgumentException::class, $invalidArgIface, true));
var_dump((new VSlim\Psr16\Cache()) instanceof Psr\SimpleCache\CacheInterface);
var_dump((new VSlim\Psr16\InvalidArgumentException('bad', 0)) instanceof Psr\SimpleCache\InvalidArgumentException);

$getMultiple = new ReflectionMethod(VSlim\Psr16\Cache::class, 'getMultiple');
$setMultiple = new ReflectionMethod(VSlim\Psr16\Cache::class, 'setMultiple');
$has = new ReflectionMethod(VSlim\Psr16\Cache::class, 'has');
$clear = new ReflectionMethod(VSlim\Psr16\Cache::class, 'clear');

$getMultipleReturn = $getMultiple->getReturnType();
if ($getMultipleReturn === null && method_exists($getMultiple, 'getTentativeReturnType')) {
    $getMultipleReturn = $getMultiple->getTentativeReturnType();
}
$getMultipleParam = $getMultiple->getParameters()[0]->getType();
$setMultipleParam = $setMultiple->getParameters()[0]->getType();

var_dump($describeType($getMultipleReturn));
var_dump($describeType($getMultipleParam));
var_dump($describeType($setMultipleParam));
var_dump($describeType($has->getParameters()[0]->getType()));
var_dump($describeType($has->getReturnType()));
var_dump($describeType($clear->getReturnType()));
?>
--EXPECT--
bool(false)
bool(false)
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
string(17) "Traversable|array"
string(17) "Traversable|array"
string(17) "Traversable|array"
string(6) "string"
string(4) "bool"
string(4) "bool"
