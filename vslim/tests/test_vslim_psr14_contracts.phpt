--TEST--
VSlim PSR-14 dispatcher resolves listeners and honors stoppable events
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
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

    interface StoppableEventInterface
    {
        public function isPropagationStopped(): bool;
    }
}

namespace {
    interface TaggedEvent {}

    class BaseEvent
    {
        public array $trace = [];
    }

    class ChildEvent extends BaseEvent implements TaggedEvent {}

    class StopEvent implements \Psr\EventDispatcher\StoppableEventInterface
    {
        public array $trace = [];
        public bool $stopped = false;

        public function isPropagationStopped(): bool
        {
            return $this->stopped;
        }
    }

    $provider = new \VSlim\Psr14\ListenerProvider();
    $dispatcher = new \VSlim\Psr14\EventDispatcher();
    $dispatcher->setProvider($provider);

    $provider
        ->listen(ChildEvent::class, function (ChildEvent $event): void {
            $event->trace[] = 'exact';
        })
        ->listen(BaseEvent::class, function (BaseEvent $event): void {
            $event->trace[] = 'parent';
        })
        ->listen(TaggedEvent::class, function (TaggedEvent $event): void {
            $event->trace[] = 'iface';
        })
        ->listenAny(function (object $event): void {
            $event->trace[] = 'any';
        });

    $event = new ChildEvent();
    $listenerGenerator = $provider->getListenersForEvent($event);
    if (!$listenerGenerator instanceof \Generator || $event->trace !== []) {
        throw new \RuntimeException('The native listener provider did not return a lazy PHP Generator');
    }
    if ((new \ReflectionGenerator($listenerGenerator))->getFunction()->returnsReference()) {
        throw new \RuntimeException('The PSR-14 listener snapshot must yield values');
    }
    $listeners = iterator_to_array($listenerGenerator, false);
    var_dump(count($listeners));
    $snapshotProvider = new \VSlim\Psr14\ListenerProvider();
    $snapshotProvider->listenAny(static function (): void {});
    $snapshot = $snapshotProvider->getListenersForEvent($event);
    $snapshotProvider->listenAny(static function (): void {});
    if (count(iterator_to_array($snapshot, false)) !== 1) {
        throw new \RuntimeException('The generator lost the listener snapshot');
    }

    $snapshotProvider = new \VSlim\Psr14\ListenerProvider();
    $firstListener = static function (object $event): void {};
    $secondListener = static function (object $event): void {};
    $snapshotProvider->listenAny($firstListener)->listenAny($secondListener);
    $firstSnapshot = $snapshotProvider->getListenersForEvent($event);
    $secondSnapshot = $snapshotProvider->getListenersForEvent($event);
    unset($snapshotProvider);
    if ($firstSnapshot->key() !== 0 || $firstSnapshot->current() !== $firstListener) {
        throw new \RuntimeException('The first generator did not yield the original listener');
    }
    $unused = new \stdClass();
    $weakInput = \WeakReference::create($unused);
    $firstSnapshot->send($unused);
    unset($unused);
    if ($weakInput->get() !== null) {
        throw new \RuntimeException('The suspended listener provider retained an unused send value');
    }
    if ($firstSnapshot->key() !== 1 || $firstSnapshot->current() !== $secondListener
        || $secondSnapshot->key() !== 0 || $secondSnapshot->current() !== $firstListener) {
        throw new \RuntimeException('The generator snapshots must have independent cursors');
    }
    $firstSnapshot->next();
    if ($firstSnapshot->valid() || $firstSnapshot->getReturn() !== null
        || iterator_to_array($secondSnapshot) !== [$firstListener, $secondListener]) {
        throw new \RuntimeException('Listener snapshots must survive the provider and finish normally');
    }
    $exceptionSnapshot = $provider->getListenersForEvent($event);
    $exceptionSnapshot->rewind();
    $injected = new \LogicException('injected into the listener generator');
    try {
        $exceptionSnapshot->throw($injected);
        throw new \RuntimeException('The listener generator swallowed an exception');
    } catch (\LogicException $caught) {
        if ($caught !== $injected || $exceptionSnapshot->valid()) {
            throw new \RuntimeException('The listener generator replaced the injected exception or stayed open');
        }
    }

    $cycleProvider = new \VSlim\Psr14\ListenerProvider();
    $listener = static fn () => $cycleProvider;
    $cycleProvider->listenAny($listener);
    $weakProvider = \WeakReference::create($cycleProvider);
    $weakListener = \WeakReference::create($listener);
    $cycle = $cycleProvider->getListenersForEvent($event);
    unset($cycleProvider, $listener);
    gc_collect_cycles();
    if ($weakProvider->get() === null || $cycle->current() !== $weakListener->get()) {
        throw new \RuntimeException('A live generator lost the listener or its provider');
    }
    unset($cycle);
    gc_collect_cycles();
    if ($weakProvider->get() !== null || $weakListener->get() !== null) {
        throw new \RuntimeException('The listener and its provider kept each other alive');
    }

    foreach ([false, true] as $start) {
        $node = new \stdClass();
        $listener = static function () use ($node): object { return $node; };
        $cycleProvider = new \VSlim\Psr14\ListenerProvider();
        $cycleProvider->listenAny($listener);
        $cycle = $cycleProvider->getListenersForEvent($event);
        $node->generator = $cycle;
        if ($start && $cycle->current() !== $listener) {
            throw new \RuntimeException('The generator lost the captured listener');
        }
        $weakNode = \WeakReference::create($node);
        $weakGenerator = \WeakReference::create($cycle);
        unset($cycleProvider, $listener, $node, $cycle);
        gc_collect_cycles();
        if ($weakNode->get() !== null || $weakGenerator->get() !== null) {
            throw new \RuntimeException('The listener snapshot kept a reference cycle alive');
        }
    }

    foreach (['dispatcher', 'explicit', 'app', 'container'] as $mode) {
        $isApp = $mode === 'app' || $mode === 'container';
        $root = $isApp ? new \VSlim\App() : new \VSlim\Psr14\EventDispatcher();
        $events = $isApp ? $root->dispatcher() : $root;
        if ($mode === 'explicit') {
            $events->setProvider(new \VSlim\Psr14\ListenerProvider());
        }
        if ($mode === 'container') {
            $services = $root->container();
            $services->factory('app.cycle', static fn () => $root);
            if ($services->get('app.cycle') !== $root
                || $services->get(\Psr\EventDispatcher\EventDispatcherInterface::class) !== $events
                || $services->get(\Psr\EventDispatcher\ListenerProviderInterface::class) !== $events->provider()) {
                throw new \RuntimeException('The container lost a cached service or PSR-14 alias');
            }
        }
        $listener = static fn () => $root;
        $events->listenAny($listener);
        $listenerProvider = $events->provider();
        $cycle = $listenerProvider->getListenersForEvent($event);
        $weak = array_map(\WeakReference::create(...), [$root, $events, $listenerProvider, $listener]);
        if (isset($services)) {
            $weak[] = \WeakReference::create($services);
        }
        unset($root, $events, $listenerProvider, $listener, $services);
        gc_collect_cycles();
        if ($cycle->current() !== $weak[3]->get() || $weak[0]->get() === null) {
            throw new \RuntimeException("A live generator lost its event services in $mode");
        }
        unset($cycle);
        gc_collect_cycles();
        foreach ($weak as $reference) {
            if ($reference->get() !== null) {
                throw new \RuntimeException("An event service cycle survived in $mode: " . $reference->get()::class);
            }
        }
    }

    $returned = $dispatcher->dispatch($event);
    var_dump($returned === $event);
    var_dump($event->trace);
    var_dump($provider->listenerCount());
    var_dump($dispatcher->provider() === $provider);

    $stoppable = new StopEvent();
    $dispatcher->listen(StopEvent::class, function (StopEvent $event): void {
        $event->trace[] = 'stop-first';
        $event->stopped = true;
    });
    $dispatcher->listen(StopEvent::class, function (StopEvent $event): void {
        $event->trace[] = 'stop-second';
    });
    $dispatcher->listenAny(function (object $event): void {
        $event->trace[] = 'stop-any';
    });

    $dispatcher->dispatch($stoppable);
    var_dump($stoppable->trace);

    $custom = new class implements \Psr\EventDispatcher\ListenerProviderInterface {
        public int $advanced = 0;

        public function getListenersForEvent(object $event): iterable {
            yield static function (StopEvent $event): void {
                $event->trace[] = 'custom';
                $event->stopped = true;
            };
            ++$this->advanced;
            yield static function (): void {
                throw new \LogicException('Dispatcher advanced a stopped generator');
            };
        }
    };
    $app = new \VSlim\App();
    $container = $app->container();
    foreach ([[$app, 'setListenerProvider'], [$dispatcher, 'setProvider']] as [$owner, $method]) {
        $parameter = (new \ReflectionMethod($owner, $method))->getParameters()[0];
        if ($parameter->getName() !== 'provider'
            || (string) $parameter->getType() !== \Psr\EventDispatcher\ListenerProviderInterface::class) {
            throw new \RuntimeException("Unexpected listener provider parameter on $method");
        }
    }
    if ($app->setListenerProvider(provider: $custom) !== $app
        || $app->listenerProvider() !== $custom || $app->dispatcher()->provider() !== $custom
        || $container->get(\Psr\EventDispatcher\ListenerProviderInterface::class) !== $custom) {
        throw new \RuntimeException('The PSR-14 service lost the userland provider');
    }
    $event = new StopEvent();
    if ($app->events()->dispatch($event) !== $event || $event->trace !== ['custom'] || $custom->advanced !== 0) {
        throw new \RuntimeException('Dispatch did not stop before advancing the generator');
    }

    $native = new \VSlim\Psr14\ListenerProvider();
    $native->listenAny(static function (StopEvent $event): void {
        $event->trace[] = 'delegated';
        $event->stopped = true;
    })->listenAny(static function (): void {
        throw new \LogicException('Dispatcher advanced a stopped delegated snapshot');
    });
    $delegating = new class($native) implements \Psr\EventDispatcher\ListenerProviderInterface {
        public array $delegates = [];
        public int $closed = 0;

        public function __construct(private \VSlim\Psr14\ListenerProvider $native) {}

        public function getListenersForEvent(object $event): iterable {
            $middle = $this->delegateSnapshot($event);
            $this->delegates = [\WeakReference::create($middle)];
            yield from $middle;
            throw new \LogicException('Dispatcher advanced the stopped outer generator');
        }

        private function delegateSnapshot(object $event): \Generator {
            $snapshot = $this->native->getListenersForEvent($event);
            $this->delegates[] = \WeakReference::create($snapshot);
            try {
                yield from $snapshot;
            } finally {
                ++$this->closed;
            }
        }
    };
    $app->setListenerProvider($delegating);
    for ($request = 1; $request <= 2; ++$request) {
        $event = new StopEvent();
        if ($app->events()->dispatch($event) !== $event || $event->trace !== ['delegated'] || $delegating->closed !== $request
            || array_map(static fn (\WeakReference $ref) => $ref->get(), $delegating->delegates) !== [null, null]) {
            throw new \RuntimeException('Stopping delegated dispatch did not close and release its snapshots');
        }
    }

    $fiberProvider = new class implements \Psr\EventDispatcher\ListenerProviderInterface {
        public array $trace = [];
        public \WeakReference $listener;
        public \WeakReference $generator;

        public function getListenersForEvent(object $event): iterable {
            $generator = (function (): \Generator {
                $listener = function (): void {
                    \Fiber::suspend('listening');
                    $this->trace[] = 'resumed';
                };
                $this->listener = \WeakReference::create($listener);
                try {
                    yield $listener;
                    $this->trace[] = 'advanced';
                } finally {
                    $this->trace[] = 'closed';
                }
            })();
            $this->generator = \WeakReference::create($generator);
            return $generator;
        }
    };
    $app->setListenerProvider($fiberProvider);
    $fiber = new \Fiber(static fn () => $app->events()->dispatch(new ChildEvent()));
    if ($fiber->start() !== 'listening' || $fiberProvider->listener->get() === null
        || $fiberProvider->generator->get() === null) {
        throw new \RuntimeException('The suspended PSR-14 dispatch lost its listener or generator');
    }
    $abandonedListener = $fiberProvider->listener;
    $abandonedGenerator = $fiberProvider->generator;
    $survivingEvent = new ChildEvent();
    $survivingFiber = new \Fiber(static fn () => $app->events()->dispatch($survivingEvent));
    if ($survivingFiber->start() !== 'listening') {
        throw new \RuntimeException('The second PSR-14 dispatch did not reach its listener');
    }
    unset($fiber);
    gc_collect_cycles();
    if ($fiberProvider->trace !== ['closed'] || $abandonedListener->get() !== null
        || $abandonedGenerator->get() !== null || $fiberProvider->listener->get() === null
        || $fiberProvider->generator->get() === null) {
        throw new \RuntimeException('Cancelling one dispatch changed the lifetime of either listener generator');
    }
    $survivingFiber->resume();
    if ($survivingFiber->getReturn() !== $survivingEvent
        || $fiberProvider->trace !== ['closed', 'resumed', 'advanced', 'closed']
        || $fiberProvider->listener->get() !== null || $fiberProvider->generator->get() !== null) {
        throw new \RuntimeException('The surviving dispatch did not complete and release its listener generator');
    }

    $error = new \RuntimeException('listener failed');
    $throwing = new class($error) implements \Psr\EventDispatcher\ListenerProviderInterface {
        public int $advanced = 0;

        public function __construct(private \RuntimeException $error) {}

        public function getListenersForEvent(object $event): iterable {
            yield fn () => throw $this->error;
            ++$this->advanced;
        }
    };
    $dispatcher->setProvider(provider: $throwing);
    $app->setDispatcher($dispatcher);
    if ($app->listenerProvider() !== $throwing
        || $container->get(\Psr\EventDispatcher\ListenerProviderInterface::class) !== $throwing) {
        throw new \RuntimeException('Installing a configured dispatcher lost its provider');
    }
    try {
        $dispatcher->dispatch(new ChildEvent());
        throw new \LogicException('Expected the listener exception');
    } catch (\RuntimeException $caught) {
        if ($caught !== $error || $throwing->advanced !== 0) {
            throw new \RuntimeException('Dispatch lost the listener exception or advanced the generator');
        }
    }
    $arrayProvider = new class implements \Psr\EventDispatcher\ListenerProviderInterface {
        public function getListenersForEvent(object $event): iterable {
            return [
                static function (ChildEvent $event): void { $event->trace[] = 'array-first'; },
                static function (ChildEvent $event): void { $event->trace[] = 'array-second'; },
            ];
        }
    };
    $dispatcher->setProvider($arrayProvider)->listenAny(static function (ChildEvent $event): void {
        $event->trace[] = 'dispatcher';
    });
    $event = new ChildEvent();
    if ($dispatcher->dispatch($event) !== $event || $event->trace !== ['array-first', 'array-second', 'dispatcher']) {
        throw new \RuntimeException('Dispatch lost the array iteration or local listener order');
    }

    foreach ([false, true] as $useGenerator) {
        $referenceProvider = new class($useGenerator) implements \Psr\EventDispatcher\ListenerProviderInterface {
            public mixed $slot;
            public int $advanced = 0;
            private iterable $listeners;

            public function __construct(bool $useGenerator)
            {
                $this->slot = function (StopEvent $event): void {
                    $this->slot = null;
                    $this->listeners = [];
                    $event->trace[] = 'reference';
                    $event->stopped = true;
                };
                $this->listeners = $useGenerator ? $this->generate() : [
                    &$this->slot,
                    static fn () => throw new \LogicException('Dispatcher ran a listener after propagation stopped'),
                ];
            }

            public function &getListenersForEvent(object $event): iterable { return $this->listeners; }

            private function &generate(): Generator
            {
                yield $this->slot;
                ++$this->advanced;
            }
        };
        $dispatcher->setProvider($referenceProvider);
        $event = new StopEvent();
        if ($dispatcher->dispatch($event) !== $event || $event->trace !== ['reference']
            || $referenceProvider->slot !== null || $referenceProvider->advanced !== 0) {
            throw new \RuntimeException('Dispatch lost a referenced listener or advanced it after propagation stopped');
        }
    }
    $dispatcher->setProvider($provider);
    if ($dispatcher->provider() !== $provider) {
        throw new \RuntimeException('Replacing an external provider did not restore the native provider');
    }
}
?>
--EXPECT--
int(4)
bool(true)
array(4) {
  [0]=>
  string(5) "exact"
  [1]=>
  string(6) "parent"
  [2]=>
  string(5) "iface"
  [3]=>
  string(3) "any"
}
int(4)
bool(true)
array(1) {
  [0]=>
  string(10) "stop-first"
}
