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
    $listeners = iterator_to_array($provider->getListenersForEvent($event), false);
    var_dump(count($listeners));

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
