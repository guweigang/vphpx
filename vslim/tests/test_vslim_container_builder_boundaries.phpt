--TEST--
VSlim container keeps borrowed builder chains and stable resolved object entries
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
declare(strict_types=1);

$container = new VSlim\Container();
$service = new stdClass();
$service->name = 'direct';

$containerChain = $container
    ->set('direct', $service)
    ->factory('lazy', static function (): stdClass {
        $obj = new stdClass();
        $obj->name = 'lazy';
        return $obj;
    });

echo (spl_object_id($container) === spl_object_id($containerChain) ? "container-builder-borrowed\n" : "container-builder-fresh\n");

$direct1 = $container->get('direct');
$direct2 = $container->get('direct');
echo (spl_object_id($service) === spl_object_id($direct1) ? "direct-same\n" : "direct-diff\n");
echo (spl_object_id($direct1) === spl_object_id($direct2) ? "direct-stable\n" : "direct-unstable\n");
echo $direct2->name . "\n";

$lazy1 = $container->get('lazy');
$lazy2 = $container->get('lazy');
echo (spl_object_id($lazy1) === spl_object_id($lazy2) ? "lazy-stable\n" : "lazy-unstable\n");
echo $lazy2->name . "\n";

$original = (object) ['name' => 'referenced'];
$slot = $original;
$calls = 0;
$container->factory('reference', static function &() use (&$slot, &$calls): mixed {
    ++$calls;
    return $slot;
});
$resolved = $container->get('reference');
$slot = (object) ['name' => 'replacement'];
if ($resolved !== $original || $container->get('reference') !== $original || $calls !== 1) {
    throw new RuntimeException('A factory result must cache the original object independently of its reference slot');
}
$resolved->name = 'updated';
if ($container->get('reference')->name !== 'updated') {
    throw new RuntimeException('Reading a factory result by value must preserve object identity');
}

foreach (['standalone', 'web', 'cli'] as $kind) {
    foreach (['entry', 'factory', 'resolved'] as $case) {
        $refs = (static function () use ($kind, $case): array {
            $owner = match ($kind) {
                'standalone' => new VSlim\Container(),
                'web' => new VSlim\App(),
                'cli' => new VSlim\Cli\App(),
            };
            $core = $kind === 'cli' ? $owner->app() : $owner;
            $container = $kind === 'standalone' ? $owner : $core->container();
            $entry = (object) ['owner' => $owner, 'core' => $core];
            $values = [$owner, $core, $container, $entry];
            if ($case === 'entry') {
                $container->set('cycle', $entry);
            } else {
                $factory = static fn () => $entry;
                $container->factory('cycle', $factory);
                $values[] = $factory;
                if ($case === 'resolved'
                    && ($container->get('cycle') !== $entry || $container->get('cycle') !== $entry)) {
                    throw new RuntimeException('A resolved service changed identity');
                }
            }
            return array_map(WeakReference::create(...), $values);
        })();
        gc_collect_cycles();
        foreach ($refs as $ref) {
            if ($ref->get() !== null) {
                throw new RuntimeException("The $kind $case registration escaped cycle collection");
            }
        }
    }
}

$cli = new VSlim\Cli\App();
$core = $cli->app();
$container = $core->container();
$container->set('retained', 'ok');
if ($cli->app() !== $core || $core->container() !== $container) {
    throw new RuntimeException('Accessing the CLI core or container changed object identity');
}
$cliRef = WeakReference::create($cli);
unset($cli);
gc_collect_cycles();
if ($cliRef->get() !== null || $core->container() !== $container || $container->get('retained') !== 'ok') {
    throw new RuntimeException('A live core and container must remain usable after the CLI is released');
}
?>
--EXPECT--
container-builder-borrowed
direct-same
direct-stable
direct
lazy-stable
lazy
