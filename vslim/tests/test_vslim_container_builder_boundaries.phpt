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
?>
--EXPECT--
container-builder-borrowed
direct-same
direct-stable
direct
lazy-stable
lazy
