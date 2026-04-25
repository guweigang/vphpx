--TEST--
VSlim app view and route group factories return fresh wrappers while sharing configured runtime
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setViewBasePath('/tmp/vslim-factory');
$app->setAssetsPrefix('/static');
$app->set_view_cache(true);

$view1 = $app->make_view();
$view2 = $app->make_view();

echo (spl_object_id($view1) === spl_object_id($view2) ? 'view-stable' : 'view-distinct') . PHP_EOL;
echo ($view1->base_path() === $view2->base_path() ? 'view-base-same' : 'view-base-diff') . PHP_EOL;
echo ($view1->assets_prefix() === $view2->assets_prefix() ? 'view-assets-same' : 'view-assets-diff') . PHP_EOL;
echo ($view1->cache_enabled() && $view2->cache_enabled() ? 'view-cache-same' : 'view-cache-diff') . PHP_EOL;

$group1 = $app->group('/api');
$group2 = $app->group('/api');
$nested1 = $group1->group('/v1');
$nested2 = $group1->group('/v1');

echo (spl_object_id($group1) === spl_object_id($group2) ? 'group-stable' : 'group-distinct') . PHP_EOL;
echo (spl_object_id($nested1) === spl_object_id($nested2) ? 'nested-stable' : 'nested-distinct') . PHP_EOL;

$group1->get('/users', fn ($req) => 'g1');
$group2->get('/teams', fn ($req) => 'g2');
$nested1->get('/ping', fn ($req) => 'v1');
$nested2->get('/pong', fn ($req) => 'v2');

echo $app->dispatch('GET', '/api/users')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/teams')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/v1/ping')->body . PHP_EOL;
echo $app->dispatch('GET', '/api/v1/pong')->body . PHP_EOL;
?>
--EXPECT--
view-distinct
view-base-same
view-assets-same
view-cache-same
group-distinct
nested-distinct
g1
g2
v1
v2
