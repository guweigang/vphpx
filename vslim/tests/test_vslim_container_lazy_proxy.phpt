--TEST--
VSlim retains a native lazy service proxy and invokes its initializer on demand
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
$container = new VSlim\Container();
if (method_exists($container, 'lazyProxy') !== (PHP_VERSION_ID >= 80400)) {
    throw new RuntimeException('Unexpected visibility of lazyProxy');
}
if (PHP_VERSION_ID < 80400) {
    echo "ok\n";
    return;
}

final class NativeLazyService {
    public function __construct(public string $name) {}
}

$reflection = new ReflectionClass(NativeLazyService::class);
$previous = new NativeLazyService('previous');
$container->set('service', $previous);
try {
    $container->lazyProxy('service', ArrayObject::class, static fn () => new ArrayObject());
    throw new RuntimeException('Expected an unsupported-class error');
} catch (Error $error) {
    if ($container->get('service') !== $previous) {
        throw new RuntimeException('Failed proxy creation replaced an existing entry');
    }
}

$attempts = 0;
$failure = new RuntimeException('initialization failed');
$result = $container->lazyProxy(id: 'service', className: NativeLazyService::class, initializer:
    static function (NativeLazyService $proxy) use (&$attempts, $failure): NativeLazyService {
        if (++$attempts === 1) {
            throw $failure;
        }
        return new NativeLazyService('ready');
    }
);
$proxy = $container->get('service');
if ($result !== $container || !$proxy instanceof NativeLazyService || $proxy === $previous
    || $container->get('service') !== $proxy || !$reflection->isUninitializedLazyObject($proxy)
    || $attempts !== 0) {
    throw new RuntimeException('Creating or resolving the entry initialized or replaced the proxy');
}
try {
    $proxy->name;
    throw new RuntimeException('Expected the initializer exception');
} catch (RuntimeException $error) {
    if ($error !== $failure || !$reflection->isUninitializedLazyObject($proxy)) {
        throw $error;
    }
}
if ($proxy->name !== 'ready' || $attempts !== 2 || $reflection->isUninitializedLazyObject($proxy)
    || $container->get('service') !== $proxy || $container->get('service')->name !== 'ready'
    || $attempts !== 2) {
    throw new RuntimeException('The proxy did not retry or remain the registered service');
}
echo "ok\n";
?>
--EXPECT--
ok
