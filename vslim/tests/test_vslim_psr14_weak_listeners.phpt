--TEST--
VSlim PSR-14 weak listeners preserve order and skip expired callable objects
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo 'skip vslim extension missing';
}
?>
--FILE--
<?php
namespace Psr\EventDispatcher {
    interface EventDispatcherInterface
    {
        public function dispatch(object $event): object;
    }

    interface ListenerProviderInterface
    {
        public function getListenersForEvent(object $event): iterable;
    }
}

namespace {
    final class WeakListenerEvent
    {
        public array $trace = [];
    }

    final class WeakListenerProbe
    {
        public ?self $cycle = null;

        public function __construct(private string $name) {}

        public function __invoke(WeakListenerEvent $event): void
        {
            $event->trace[] = $this->name;
        }
    }

    $provider = new VSlim\Psr14\ListenerProvider();
    $countMethod = new ReflectionMethod($provider, 'count');
    if (!$provider instanceof Countable || !$provider instanceof Psr\EventDispatcher\ListenerProviderInterface
        || (string) $countMethod->getReturnType() !== 'int' || count($provider) !== 0) {
        throw new RuntimeException('The listener provider did not expose the two native contracts');
    }
    $dispatcher = (new VSlim\Psr14\EventDispatcher())->setProvider($provider);
    $provider->listen(WeakListenerEvent::class, static function (WeakListenerEvent $event): void {
        $event->trace[] = 'first';
    });
    $weak = new WeakListenerProbe('weak');
    $handle = WeakReference::create($weak);
    $expired = new WeakListenerProbe('expired');
    $expired->cycle = $expired;
    $expiredHandle = WeakReference::create($expired);
    if ($provider->listenWeak(eventClass: WeakListenerEvent::class, listener: $weak) !== $provider
        || $dispatcher->listenWeak(eventClass: '*', listener: $expired) !== $dispatcher) {
        throw new RuntimeException('Weak registration lost the fluent receiver');
    }
    $provider->listen(WeakListenerEvent::class, new WeakListenerProbe('last'));
    unset($expired);
    gc_collect_cycles();
    if ($expiredHandle->get() !== null || $provider->listenerCount() !== 3 || count($provider) !== 3) {
        throw new RuntimeException('The registration retained a cyclic weak listener');
    }
    $event = new WeakListenerEvent();
    if ($dispatcher->dispatch($event) !== $event || $event->trace !== ['first', 'weak', 'last']) {
        throw new RuntimeException('Live weak listeners changed dispatch order');
    }

    $iterable = $provider->getListenersForEvent($event);
    unset($weak);
    if ($handle->get() !== null || $provider->listenerCount() !== 2 || count($provider) !== 2) {
        throw new RuntimeException('An unstarted listener generator pinned a weak target');
    }
    $event->trace = [];
    foreach ($iterable as $listener) {
        $listener($event);
    }
    unset($listener);
    if ($event->trace !== ['first', 'last']) {
        throw new RuntimeException('The generator yielded an expired listener or changed order');
    }

    $dropping = new VSlim\Psr14\EventDispatcher();
    $target = static function (WeakListenerEvent $event): void { $event->trace[] = 'too late'; };
    $targetHandle = WeakReference::create($target);
    $dropping->listen(WeakListenerEvent::class, static function (WeakListenerEvent $event) use (&$target): void {
        $event->trace[] = 'drop';
        $target = null;
    });
    $dropping->listenWeak(WeakListenerEvent::class, $target);
    $event->trace = [];
    $dropping->dispatch($event);
    if ($event->trace !== ['drop'] || $targetHandle->get() !== null || $dropping->provider()->listenerCount() !== 1) {
        throw new RuntimeException('Dispatch pinned a weak target before reaching it');
    }

    $next = new WeakListenerProbe('new');
    $dropping->listenWeak(WeakListenerEvent::class, $next);
    $event->trace = [];
    $dropping->dispatch($event);
    if ($event->trace !== ['drop', 'new'] || $dropping->provider()->listenerCount() !== 2) {
        throw new RuntimeException('Pruning expired listeners changed the remaining registrations');
    }
    try {
        $provider->listenWeak('*', new stdClass());
        throw new RuntimeException('A non-callable object was registered');
    } catch (TypeError) {
    }
    $parameter = (new ReflectionMethod($provider, 'listenWeak'))->getParameters()[1];
    if ($parameter->getName() !== 'listener' || (string) $parameter->getType() !== 'object') {
        throw new RuntimeException('The weak listener signature lost the object parameter');
    }
    echo "ok\n";
}
?>
--EXPECT--
ok
