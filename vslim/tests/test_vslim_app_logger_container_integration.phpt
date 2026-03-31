--TEST--
VSlim App syncs native and PSR-3 logger services into the container with stable object identity
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
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

namespace {
    $app = new VSlim\App();
    $container = $app->container();

    $native = $container->get('logger');
    $psr = $container->get(Psr\Log\LoggerInterface::class);

    var_dump($native === $app->logger());
    var_dump($psr === $app->psrLogger());
    var_dump($psr->logger() === $native);

    $custom = (new VSlim\Log\Logger())->set_channel('custom-app');
    var_dump($app->set_logger($custom) === $app);
    var_dump($app->container()->get('logger') === $custom);

    $psrAgain = $app->container()->get(Psr\Log\LoggerInterface::class);
    var_dump($psrAgain === $psr);
    var_dump($psrAgain->logger() === $custom);

    $external = new VSlim\Container();
    $app->set_container($external);
    var_dump($external->get('logger') === $custom);
    var_dump($external->get(Psr\Log\LoggerInterface::class) === $psrAgain);
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
