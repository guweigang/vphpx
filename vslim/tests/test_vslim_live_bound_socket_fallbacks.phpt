--TEST--
VSlim live bound socket helpers reuse bound sockets but allocate fresh fallback sockets
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$socket = (new VSlim\Live\Socket())
    ->setId('sock-1')
    ->setTarget('/live');

$bound = (new VSlim\Live\Component())
    ->setId('counter')
    ->bindSocket($socket)
    ->assign('count', '7');

$boundPatch = $bound->patchBound();
$boundAppend = $bound->appendToBound('list');
$boundPrepend = $bound->prependToBound('list');
$boundRemove = $bound->removeBound();

echo (spl_object_id($socket) === spl_object_id($boundPatch) ? 'patch-same' : 'patch-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundAppend) ? 'append-same' : 'append-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundPrepend) ? 'prepend-same' : 'prepend-diff') . PHP_EOL;
echo (spl_object_id($socket) === spl_object_id($boundRemove) ? 'remove-same' : 'remove-diff') . PHP_EOL;
echo count($socket->patches()) . PHP_EOL;

$unbound = (new VSlim\Live\Component())
    ->setId('counter')
    ->assign('count', '7');

$fallbackPatch1 = $unbound->patchBound();
$fallbackPatch2 = $unbound->patchBound();
$fallbackRemove = $unbound->removeBound();

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
