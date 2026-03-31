--TEST--
VSlim live wrappers distinguish fresh facades from borrowed host-owned views
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$socket = new VSlim\Live\Socket();
$form1 = $socket->form('profile');
$form2 = $socket->form('profile');

echo ($form1->available() ? 'form1-available' : 'form1-missing') . PHP_EOL;
echo ($form2->available() ? 'form2-available' : 'form2-missing') . PHP_EOL;
echo (spl_object_id($form1) === spl_object_id($form2) ? 'form-stable' : 'form-distinct') . PHP_EOL;

$form1->fill(['email' => 'a@example.com']);
echo $form2->input('email') . PHP_EOL;

$form2->errors(['email' => 'bad']);
echo ($form1->has_error('email') ? 'form-error-visible' : 'form-error-missing') . PHP_EOL;

$form1->clear_error('email');
echo ($form2->has_error('email') ? 'form-error-still-there' : 'form-error-cleared') . PHP_EOL;

$view = new VSlim\View('/tmp/live', '/assets');
$live = (new VSlim\Live\View())->set_view($view);
$component = (new VSlim\Live\Component())->set_view($view);

$liveView1 = $live->view();
$liveView2 = $live->view();
$componentView1 = $component->view();
$componentView2 = $component->view();

echo (spl_object_id($view) === spl_object_id($liveView1) ? 'live-view-same' : 'live-view-diff') . PHP_EOL;
echo (spl_object_id($liveView1) === spl_object_id($liveView2) ? 'live-view-stable' : 'live-view-unstable') . PHP_EOL;
echo (spl_object_id($view) === spl_object_id($componentView1) ? 'component-view-same' : 'component-view-diff') . PHP_EOL;
echo (spl_object_id($componentView1) === spl_object_id($componentView2) ? 'component-view-stable' : 'component-view-unstable') . PHP_EOL;
?>
--EXPECT--
form1-available
form2-available
form-distinct
a@example.com
form-error-visible
form-error-cleared
live-view-same
live-view-stable
component-view-same
component-view-stable
