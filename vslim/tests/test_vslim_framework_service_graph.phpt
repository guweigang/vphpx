--TEST--
VSlim App exposes a framework-style default service graph through the container
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

namespace Psr\Log {
    if (!interface_exists(LoggerInterface::class, false)) {
        interface LoggerInterface
        {
            public function emergency($message, array $context = []): void;
            public function alert($message, array $context = []): void;
            public function critical($message, array $context = []): void;
            public function error($message, array $context = []): void;
            public function warning($message, array $context = []): void;
            public function notice($message, array $context = []): void;
            public function info($message, array $context = []): void;
            public function debug($message, array $context = []): void;
            public function log($level, $message, array $context = []): void;
        }
    }
}

namespace Psr\EventDispatcher {
    if (!interface_exists(ListenerProviderInterface::class, false)) {
        interface ListenerProviderInterface
        {
            public function getListenersForEvent(object $event): iterable;
        }
    }
    if (!interface_exists(EventDispatcherInterface::class, false)) {
        interface EventDispatcherInterface
        {
            public function dispatch(object $event): object;
        }
    }
}

namespace Psr\SimpleCache {
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

namespace Psr\Cache {
    if (!interface_exists(CacheItemInterface::class, false)) {
        interface CacheItemInterface
        {
            public function getKey(): string;
            public function get(): mixed;
            public function isHit(): bool;
            public function set(mixed $value): static;
            public function expiresAt(?\DateTimeInterface $expiration): static;
            public function expiresAfter(\DateInterval|int|null $time): static;
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

namespace Psr\Http\Message {
    if (!interface_exists(RequestInterface::class, false)) {
        interface RequestInterface {}
    }
    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface {}
    }
}

namespace Psr\Http\Client {
    if (!interface_exists(ClientInterface::class, false)) {
        interface ClientInterface
        {
            public function sendRequest(\Psr\Http\Message\RequestInterface $request): \Psr\Http\Message\ResponseInterface;
        }
    }
}

namespace {
    final class FixedClock implements Psr\Clock\ClockInterface
    {
        public function __construct(private DateTimeImmutable $now) {}

        public function now(): DateTimeImmutable
        {
            return $this->now;
        }
    }

    $app = new VSlim\App();
    $container = $app->container();
    $dispatcher = $app->dispatcher();
    $provider = $app->listenerProvider();
    $cache = $app->cache();
    $pool = $app->cachePool();
    $client = $app->httpClient();

    var_dump($app->events() === $dispatcher);
    var_dump($dispatcher->provider() === $provider);
    var_dump($container->get('events') === $dispatcher);
    var_dump($container->get('events.provider') === $provider);
    var_dump($container->get('cache') === $cache);
    var_dump($container->get('cache.pool') === $pool);
    var_dump($container->get('http_client') === $client);
    var_dump($container->get(Psr\EventDispatcher\EventDispatcherInterface::class) === $dispatcher);
    var_dump($container->get(Psr\SimpleCache\CacheInterface::class) === $cache);
    var_dump($container->get(Psr\Cache\CacheItemPoolInterface::class) === $pool);
    var_dump($container->get(Psr\Http\Client\ClientInterface::class) === $client);

    $clock = new FixedClock(new DateTimeImmutable('2024-01-01T00:00:00+00:00'));
    $app->setClock($clock);
    var_dump($app->cache()->clock() === $clock);
    var_dump($app->cachePool()->clock() === $clock);

    $external = new VSlim\Container();
    $app->setContainer($external);
    var_dump($external->get('events') === $dispatcher);
    var_dump($external->get('cache') === $cache);
    var_dump($external->get('cache.pool') === $pool);
    var_dump($external->get('http_client') === $client);
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
