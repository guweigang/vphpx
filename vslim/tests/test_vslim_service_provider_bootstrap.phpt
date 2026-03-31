--TEST--
VSlim App supports service-provider register boot and auto-boot lifecycle
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
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

namespace {
    final class DemoEvent
    {
        public array $messages = [];
    }

    final class DemoProvider extends VSlim\Support\ServiceProvider
    {
        public array $events = [];

        public function register(): void
        {
            $this->events[] = 'register';
            $this->app()->container()->set('demo.message', 'hello-provider');
        }

        public function boot(): void
        {
            $this->events[] = 'boot';
            $this->app()->events()->listenAny(function (object $event): void {
                if ($event instanceof DemoEvent) {
                    $event->messages[] = (string) $this->app()->container()->get('demo.message');
                }
            });
        }
    }

    final class LateProvider extends VSlim\Support\ServiceProvider
    {
        public array $events = [];

        public function register(VSlim\App $app): void
        {
            $this->events[] = 'register';
            $app->container()->set('late.message', 'late-provider');
        }

        public function boot(VSlim\App $app): void
        {
            $this->events[] = 'boot';
            $app->container()->set('late.booted', 'yes');
        }
    }

    final class AutoBootProvider extends VSlim\Support\ServiceProvider
    {
        public array $events = [];

        public function register(): void
        {
            $this->events[] = 'register';
        }

        public function boot(): void
        {
            $this->events[] = 'boot';
            $this->app()->container()->set('auto.booted', 'yes');
        }
    }

    final class BatchProvider extends VSlim\Support\ServiceProvider
    {
        public function register(): void
        {
            $this->app()->container()->set('batch.message', 'batch-provider');
        }
    }

    $app = new VSlim\App();
    $provider = new DemoProvider();

    var_dump($app->booted());
    var_dump($app->register($provider) === $app);
    echo implode(',', $provider->events) . PHP_EOL;
    var_dump($app->providerCount());
    var_dump($app->hasProvider(DemoProvider::class));
    var_dump($app->register(DemoProvider::class) === $app);
    var_dump($app->providerCount());

    $app->boot();
    echo implode(',', $provider->events) . PHP_EOL;

    $event = new DemoEvent();
    $app->events()->dispatch($event);
    echo implode(',', $event->messages) . PHP_EOL;

    $app->boot();
    echo implode(',', $provider->events) . PHP_EOL;

    $late = new LateProvider();
    $app->register($late);
    echo implode(',', $late->events) . PHP_EOL;
    echo $app->container()->get('late.message') . '|' . $app->container()->get('late.booted') . PHP_EOL;
    var_dump($app->providerCount());

    $app2 = new VSlim\App();
    $auto = new AutoBootProvider();
    $app2->register($auto);
    var_dump($app2->booted());
    $app2->get('/boot', fn () => (string) $app2->container()->get('auto.booted'));
    $res = $app2->dispatch('GET', '/boot');
    echo $res->body . PHP_EOL;
    echo implode(',', $auto->events) . PHP_EOL;
    var_dump($app2->booted());

    $app3 = new VSlim\App();
    $app3->registerMany([BatchProvider::class, new AutoBootProvider()]);
    var_dump($app3->providerCount());
    $app3->boot();
    echo $app3->container()->get('batch.message') . '|' . $app3->container()->get('auto.booted') . PHP_EOL;
}
?>
--EXPECT--
bool(false)
bool(true)
register
int(1)
bool(true)
bool(true)
int(1)
register,boot
hello-provider
register,boot
register,boot
late-provider|yes
int(2)
bool(false)
yes
register,boot
bool(true)
int(2)
batch-provider|yes
