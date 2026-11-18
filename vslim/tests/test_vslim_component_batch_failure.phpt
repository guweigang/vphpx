--TEST--
VSlim preserves successful provider and module registrations when a lifecycle callback throws
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
class PrefixComponent
{
    public function register(VSlim\App $app): void { $app->container()->set('prefix', 'ready'); }
    public function boot(): void { echo "prefix boot\n"; }
}

class FailingComponent
{
    public function __construct(private bool $fails = true) {}
    public function setApp(VSlim\App $app): void
    {
        if ($this->fails) {
            throw new LogicException('setApp failed');
        }
    }
    public function register(): void { echo "retry registered\n"; }
}

class SuffixComponent
{
    public function register(): void { echo "unexpected suffix registration\n"; }
}

class FailingModule
{
    public function providers(): iterable
    {
        return [PrefixComponent::class, FailingComponent::class, SuffixComponent::class];
    }
}

class FailingBootComponent
{
    public function boot(): void { throw new LogicException('boot failed'); }
}

class RetryProvidersModule
{
    private bool $first = true;

    public function providers(VSlim\App $app): iterable
    {
        if ($this->first) {
            $this->first = false;
            $app->container()->set('providers.marker', 'failed');
            throw new LogicException('providers callback failed');
        }

        $app->container()->set('providers.marker', 'ready');
        return new ArrayIterator([new class {
            public function register(VSlim\App $app): void
            {
                $app->container()->set('returned.provider', 'registered');
            }
        }]);
    }
}

function attempt(callable $run): void
{
    try {
        $run();
        echo "unexpected success\n";
    } catch (LogicException $error) {
        echo $error->getMessage(), PHP_EOL;
    }
}

foreach (['registerMany' => 'Provider', 'moduleMany' => 'Module'] as $entry => $kind) {
    $app = new VSlim\App();
    attempt(static fn () => $app->$entry([PrefixComponent::class, FailingComponent::class, SuffixComponent::class]));
    $count = lcfirst($kind) . 'Count';
    $has = 'has' . $kind;
    echo $entry, '|', $app->$count(), '|', $app->container()->get('prefix'), '|',
        (int) $app->$has(FailingComponent::class), (int) $app->$has(SuffixComponent::class), '|',
        (int) $app->booted(), PHP_EOL;
    $app->$entry([new FailingComponent(false)]);
    echo 'retry|', $app->$count(), '|', (int) $app->$has(FailingComponent::class), PHP_EOL;
}

$app = new VSlim\App();
attempt(static fn () => $app->moduleMany([FailingModule::class, SuffixComponent::class]));
echo 'nested|', $app->providerCount(), '|', $app->moduleCount(), '|', $app->container()->get('prefix'), '|',
    (int) $app->hasProvider(FailingComponent::class), (int) $app->hasModule(FailingModule::class), PHP_EOL;

$app = new VSlim\App();
$app->register(PrefixComponent::class);
$retry = new RetryProvidersModule();
attempt(static fn () => $app->module($retry));
echo 'providers-failed|', $app->providerCount(), '|', $app->moduleCount(), '|',
    (int) $app->container()->has('providers.marker'), '|', $app->container()->get('prefix'), PHP_EOL;
$app->module($retry);
echo 'providers-retried|', $app->providerCount(), '|', $app->moduleCount(), '|',
    $app->container()->get('providers.marker'), '|', $app->container()->get('returned.provider'), PHP_EOL;

$app = new VSlim\App();
attempt(static fn () => $app->bootstrap(spec: [
    'providers' => [PrefixComponent::class, FailingBootComponent::class],
    'modules' => [PrefixComponent::class],
    'boot' => true,
]));
echo 'auto-boot|', $app->providerCount(), '|', $app->moduleCount(), '|', (int) $app->booted(), PHP_EOL;

$app = new VSlim\App();
$app->register(FailingBootComponent::class);
$app->get('/', static function (): string {
    echo "unexpected route dispatch\n";
    return 'unreachable';
});
attempt(static fn () => $app->dispatch('GET', '/'));
echo 'dispatch|', (int) $app->booted(), PHP_EOL;

foreach (['registerMany' => 'Provider', 'moduleMany' => 'Module'] as $entry => $kind) {
    $app = new VSlim\App();
    $app->boot();
    attempt(static fn () => $app->$entry([PrefixComponent::class, FailingBootComponent::class, SuffixComponent::class]));
    $count = lcfirst($kind) . 'Count';
    $has = 'has' . $kind;
    echo 'late-', $kind, '|', $app->$count(), '|', (int) $app->$has(FailingBootComponent::class),
        (int) $app->$has(SuffixComponent::class), '|', (int) $app->booted(), PHP_EOL;
}
?>
--EXPECT--
setApp failed
registerMany|1|ready|00|0
retry registered
retry|2|1
setApp failed
moduleMany|1|ready|00|0
retry registered
retry|2|1
setApp failed
nested|1|0|ready|00
providers callback failed
providers-failed|1|0|0|ready
providers-retried|2|1|ready|registered
prefix boot
boot failed
auto-boot|2|1|0
boot failed
dispatch|0
prefix boot
boot failed
late-Provider|1|00|1
prefix boot
boot failed
late-Module|1|00|1
