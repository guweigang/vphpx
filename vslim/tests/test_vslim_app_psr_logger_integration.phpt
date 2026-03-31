--TEST--
VSlim App exposes a stable PSR-3 logger wrapper bound to the current native logger
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

    $psr1 = $app->psrLogger();
    $psr2 = $app->psrLogger();

    var_dump($psr1 === $psr2);
    var_dump($psr1 instanceof Psr\Log\LoggerInterface);
    var_dump($psr1->logger() === $app->logger());

    $custom = (new VSlim\Log\Logger())->set_channel('custom-app');
    var_dump($app->set_logger($custom) === $app);
    var_dump($app->psrLogger() === $psr1);
    var_dump($app->psrLogger()->logger() === $custom);
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
