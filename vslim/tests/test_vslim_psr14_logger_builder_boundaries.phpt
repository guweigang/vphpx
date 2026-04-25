--TEST--
VSlim PSR-14 and logger wrappers keep borrowed builder and stable getter boundaries
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
declare(strict_types=1);

namespace Psr\EventDispatcher {
    if (!interface_exists(EventDispatcherInterface::class, false)) {
        interface EventDispatcherInterface
        {
            public function dispatch(object $event): object;
        }
    }

    if (!interface_exists(ListenerProviderInterface::class, false)) {
        interface ListenerProviderInterface
        {
            public function getListenersForEvent(object $event): iterable;
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

namespace {
    final class DemoEvent
    {
        public array $trace = [];
    }

    $provider = new VSlim\Psr14\ListenerProvider();
    $providerChain = $provider
        ->listen(DemoEvent::class, static function (DemoEvent $event): void {
            $event->trace[] = 'exact';
        })
        ->listenAny(static function (object $event): void {
            $event->trace[] = 'any';
        });
    echo (spl_object_id($provider) === spl_object_id($providerChain) ? "provider-builder-borrowed\n" : "provider-builder-fresh\n");

    $dispatcher = new VSlim\Psr14\EventDispatcher();
    $dispatcherChain = $dispatcher
        ->setProvider($provider)
        ->listen(DemoEvent::class, static function (DemoEvent $event): void {
            $event->trace[] = 'dispatcher';
        });
    echo (spl_object_id($dispatcher) === spl_object_id($dispatcherChain) ? "dispatcher-builder-borrowed\n" : "dispatcher-builder-fresh\n");

    $provider1 = $dispatcher->provider();
    $provider2 = $dispatcher->provider();
    echo (spl_object_id($provider) === spl_object_id($provider1) ? "dispatcher-provider-same\n" : "dispatcher-provider-diff\n");
    echo (spl_object_id($provider1) === spl_object_id($provider2) ? "dispatcher-provider-stable\n" : "dispatcher-provider-unstable\n");

    $event = new DemoEvent();
    $dispatcher->dispatch($event);
    echo implode(',', $event->trace) . "\n";

    $native = new VSlim\Log\Logger();
    $nativeChain = $native
        ->setChannel('native')
        ->setLevel('debug')
        ->withContext('trace_id', 't-1');
    echo (spl_object_id($native) === spl_object_id($nativeChain) ? "native-logger-borrowed\n" : "native-logger-fresh\n");

    $psr = new VSlim\Log\PsrLogger();
    $psrChain = $psr
        ->setLogger($native)
        ->setChannel('psr')
        ->setLevel('info');
    echo (spl_object_id($psr) === spl_object_id($psrChain) ? "psr-logger-borrowed\n" : "psr-logger-fresh\n");

    $inner1 = $psr->logger();
    $inner2 = $psr->logger();
    echo (spl_object_id($inner1) === spl_object_id($inner2) ? "psr-inner-stable\n" : "psr-inner-unstable\n");
    echo $inner2->channel() . '|' . $inner2->level() . "\n";
}
?>
--EXPECT--
provider-builder-borrowed
dispatcher-builder-borrowed
dispatcher-provider-same
dispatcher-provider-stable
exact,dispatcher,any
native-logger-borrowed
psr-logger-borrowed
psr-inner-stable
psr|info
