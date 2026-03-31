--TEST--
VSlim PSR-14 bindings support first-touch metadata queries
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
    if (str_starts_with($class, 'Psr\\EventDispatcher\\')) {
        eval(<<<'PHP'
namespace Psr\EventDispatcher;

interface EventDispatcherInterface
{
    public function dispatch(object $event): object;
}

interface ListenerProviderInterface
{
    public function getListenersForEvent(object $event): iterable;
}

interface StoppableEventInterface
{
    public function isPropagationStopped(): bool;
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

$dispatcherIface = 'Psr\\EventDispatcher\\EventDispatcherInterface';
$providerIface = 'Psr\\EventDispatcher\\ListenerProviderInterface';

var_dump(interface_exists($dispatcherIface, false));
var_dump(interface_exists($providerIface, false));
var_dump(is_a(VSlim\Psr14\EventDispatcher::class, $dispatcherIface, true));
var_dump(is_a(VSlim\Psr14\ListenerProvider::class, $providerIface, true));
var_dump((new VSlim\Psr14\EventDispatcher()) instanceof Psr\EventDispatcher\EventDispatcherInterface);
var_dump((new VSlim\Psr14\ListenerProvider()) instanceof Psr\EventDispatcher\ListenerProviderInterface);

$dispatchMethod = new ReflectionMethod(VSlim\Psr14\EventDispatcher::class, 'dispatch');
$dispatchReturn = $dispatchMethod->getReturnType();
$dispatchParam = $dispatchMethod->getParameters()[0]->getType();
$providerMethod = new ReflectionMethod(VSlim\Psr14\EventDispatcher::class, 'provider');
$providerReturn = $providerMethod->getReturnType();

$listenersMethod = new ReflectionMethod(VSlim\Psr14\ListenerProvider::class, 'getListenersForEvent');
$listenersReturn = $listenersMethod->getReturnType();
if ($listenersReturn === null && method_exists($listenersMethod, 'getTentativeReturnType')) {
    $listenersReturn = $listenersMethod->getTentativeReturnType();
}
$listenersParam = $listenersMethod->getParameters()[0]->getType();

var_dump($describeType($dispatchReturn));
var_dump($describeType($dispatchParam));
var_dump($describeType($providerReturn));
var_dump($describeType($listenersReturn));
var_dump($describeType($listenersParam));
?>
--EXPECT--
bool(false)
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
string(6) "object"
string(6) "object"
string(45) "Psr\EventDispatcher\ListenerProviderInterface"
string(17) "Traversable|array"
string(6) "object"
