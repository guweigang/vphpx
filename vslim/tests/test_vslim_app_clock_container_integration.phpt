--TEST--
VSlim App syncs clock service into the container with stable object identity
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
    $defaultClock = $container->get('clock');
    var_dump($defaultClock === $app->clock());
    var_dump($container->get(Psr\Clock\ClockInterface::class) === $defaultClock);

    $customClock = new FixedClock(new DateTimeImmutable('2024-01-01T00:00:00+00:00'));
    var_dump($app->setClock($customClock) === $app);
    var_dump($app->container()->get('clock') === $customClock);
    var_dump($app->container()->get(Psr\Clock\ClockInterface::class) === $customClock);

    $external = new VSlim\Container();
    $app->set_container($external);
    var_dump($external->get('clock') === $customClock);
    var_dump($external->get(Psr\Clock\ClockInterface::class) === $customClock);
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
