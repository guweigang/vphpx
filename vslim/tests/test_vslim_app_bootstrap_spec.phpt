--TEST--
VSlim App bootstrap spec assembles a framework-style app skeleton in one pass
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

    final class BootstrapProvider extends VSlim\Support\ServiceProvider
    {
        public array $events = [];

        public function register(): void
        {
            $this->events[] = 'register';
            $this->app()->container()->set('provider.message', 'hello-provider');
        }

        public function boot(): void
        {
            $this->events[] = 'boot';
            $this->app()->container()->set('provider.booted', 'yes');
        }
    }

    final class BlogModule extends VSlim\Support\Module
    {
        public array $events = [];

        public function register(): void
        {
            $this->events[] = 'register';
            $this->app()->container()->set('module.registered', 'yes');
        }

        public function routes(): void
        {
            $this->events[] = 'routes';
            $this->app()->get('/ping', fn () => 'pong|' . $this->app()->container()->get('provider.message') . '|' . $this->app()->container()->get('module.registered'));
        }

        public function boot(): void
        {
            $this->events[] = 'boot';
        }
    }

    $provider = new BootstrapProvider();
    $module = new BlogModule();
    $container = new VSlim\Container();
    $clock = new FixedClock(new DateTimeImmutable('2024-01-01T00:00:00+00:00'));
    $assembled = [];

    $app = new VSlim\App();
    var_dump($app->bootstrap([
        'container' => $container,
        'config_text' => "[app]\nname = 'demo-app'\n",
        'base_path' => '/api',
        'view_base_path' => __DIR__ . '/fixtures/views',
        'assets_prefix' => '/static',
        'view_cache' => true,
        'error_response_json' => true,
        'clock' => $clock,
        'providers' => [$provider],
        'modules' => [$module],
        'not_found' => fn () => new VSlim\VHttpd\Response(404, 'missing-bootstrap', 'text/plain; charset=utf-8'),
        'routes' => [
            function (VSlim\App $app) use (&$assembled): void {
                $assembled[] = 'routes-a';
                $app->get_named('health.show', '/health', fn () => 'health|' . $app->config()->get_string('app.name', '') . '|' . $app->container()->get('provider.booted'));
            },
            function (VSlim\App $app) use (&$assembled): void {
                $assembled[] = 'routes-b';
                $app->get('/ready', fn () => 'ready');
            },
        ],
        'boot' => true,
    ]) === $app);

    echo implode(',', $provider->events) . PHP_EOL;
    echo implode(',', $module->events) . PHP_EOL;
    echo implode(',', $assembled) . PHP_EOL;
    var_dump($app->booted());
    var_dump($app->providerCount());
    var_dump($app->moduleCount());
    echo $app->dispatch('GET', '/health')->body . PHP_EOL;
    echo $app->dispatch('GET', '/ping')->body . PHP_EOL;
    echo $app->dispatch('GET', '/ready')->body . PHP_EOL;
    echo $app->dispatch('GET', '/missing')->body . PHP_EOL;
    echo $app->url_for('health.show', []) . PHP_EOL;
    echo $app->view_base_path() . '|' . $app->assets_prefix() . '|' . ($app->view_cache_enabled() ? 'yes' : 'no') . '|' . ($app->error_response_json_enabled() ? 'yes' : 'no') . PHP_EOL;
    echo $container->get('provider.message') . '|' . $container->get('module.registered') . PHP_EOL;
    var_dump($app->cache()->clock() === $clock);
}
?>
--EXPECTF--
bool(true)
register,boot
register,routes,boot
routes-a,routes-b
bool(true)
int(1)
int(1)
health|demo-app|yes
pong|hello-provider|yes
ready
missing-bootstrap
/api/health
%s/tests/fixtures/views|/static|yes|yes
hello-provider|yes
bool(true)
