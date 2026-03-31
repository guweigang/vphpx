--TEST--
VSlim live bound socket helpers reuse bound sockets but allocate fresh fallback sockets
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$socket = (new VSlim\Live\Socket())
    ->set_id('sock-1')
    ->set_target('/live');

$bound = (new VSlim\Live\Component())
    ->set_id('counter')
    ->bind_socket($socket)
    ->assign('count', '7');

$boundPatch = $bound->patch_bound();
$boundAppend = $bound->append_to_bound('list');
$boundPrepend = $bound->prepend_to_bound('list');
$boundRemove = $bound->remove_bound();

echo (spl_object_id($socket) === spl_object_id($boundPatch) ? 'patch-same' : 'patch-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundAppend) ? 'append-same' : 'append-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundPrepend) ? 'prepend-same' : 'prepend-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundRemove) ? 'remove-same' : 'remove-diff') . PHP_EOL;
echo count($socket->patches()) . PHP_EOL;

$unbound = (new VSlim\Live\Component())
    ->set_id('counter')
    ->assign('count', '7');

$fallbackPatch1 = $unbound->patch_bound();
$fallbackPatch2 = $unbound->patch_bound();
$fallbackRemove = $unbound->remove_bound();

echo (spl_object_id($fallbackPatch1) === spl_object_id($fallbackPatch2) ? 'fallback-patch-stable' : 'fallback-patch-distinct') . PHP_EOL;
echo (spl_object_id($fallbackPatch1) === spl_object_id($fallbackRemove) ? 'fallback-shared' : 'fallback-fresh') . PHP_EOL;
echo count($fallbackPatch1->patches()) . PHP_EOL;
echo count($fallbackRemove->patches()) . PHP_EOL;
?>
--EXPECT--
patch-same
append-same
prepend-same
remove-same
4
fallback-patch-distinct
fallback-fresh
0
0
