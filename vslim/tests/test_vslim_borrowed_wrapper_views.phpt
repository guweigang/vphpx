--TEST--
VSlim borrowed wrapper view access reuses host-owned view objects
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setViewBasePath(__DIR__ . '/fixtures');
$app->setAssetsPrefix('/assets');

$controller = new class($app) extends VSlim\Controller {};
$controllerView1 = $controller->view();
$controllerView2 = $controller->view();
echo (spl_object_id($controllerView1) === spl_object_id($controllerView2) ? 'controller-same' : 'controller-diff') . PHP_EOL;
echo $controllerView2->asset('app.js') . PHP_EOL;

$live = (new VSlim\Live\View())->set_app($app);
$liveView1 = $live->view();
$liveView2 = $live->view();
echo (spl_object_id($liveView1) === spl_object_id($liveView2) ? 'live-same' : 'live-diff') . PHP_EOL;
echo $liveView2->asset('app.js') . PHP_EOL;

$component = (new VSlim\Live\Component())->set_app($app);
$componentView1 = $component->view();
$componentView2 = $component->view();
echo (spl_object_id($componentView1) === spl_object_id($componentView2) ? 'component-same' : 'component-diff') . PHP_EOL;
echo $componentView2->asset('app.js') . PHP_EOL;

$socket = new VSlim\Live\Socket();
$socketPatch = $live->patch($socket, 'root');
echo (spl_object_id($socket) === spl_object_id($socketPatch) ? 'live-patch-same' : 'live-patch-diff') . PHP_EOL;

$boundSocket = new VSlim\Live\Socket();
$component->set_id('counter-root')->bind_socket($boundSocket);
$componentPatch = $component->patch($boundSocket);
$componentBoundPatch = $component->patch_bound();
$componentAppend = $component->append_to($boundSocket, 'items');
$componentAppendBound = $component->append_to_bound('items');
$componentRemove = $component->remove($boundSocket);
$componentRemoveBound = $component->remove_bound();
echo (spl_object_id($boundSocket) === spl_object_id($componentPatch) ? 'component-patch-same' : 'component-patch-diff') . PHP_EOL;
echo (spl_object_id($boundSocket) === spl_object_id($componentBoundPatch) ? 'component-patch-bound-same' : 'component-patch-bound-diff') . PHP_EOL;
echo (spl_object_id($boundSocket) === spl_object_id($componentAppend) ? 'component-append-same' : 'component-append-diff') . PHP_EOL;
echo (spl_object_id($boundSocket) === spl_object_id($componentAppendBound) ? 'component-append-bound-same' : 'component-append-bound-diff') . PHP_EOL;
echo (spl_object_id($boundSocket) === spl_object_id($componentRemove) ? 'component-remove-same' : 'component-remove-diff') . PHP_EOL;
echo (spl_object_id($boundSocket) === spl_object_id($componentRemoveBound) ? 'component-remove-bound-same' : 'component-remove-bound-diff') . PHP_EOL;
?>
--EXPECT--
controller-same
/assets/app.js
live-same
/assets/app.js
component-same
/assets/app.js
live-patch-same
component-patch-same
component-patch-bound-same
component-append-same
component-append-bound-same
component-remove-same
component-remove-bound-same
