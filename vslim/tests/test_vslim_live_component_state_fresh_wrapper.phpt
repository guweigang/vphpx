--TEST--
VSlim live component state returns a fresh wrapper while sharing socket-backed state
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$socket = (new VSlim\Live\Socket())->set_id('sock-1');
$component = (new VSlim\Live\Component())
    ->set_id('counter')
    ->bind_socket($socket);

$state1 = $component->state();
$state2 = $component->state();

echo ($state1->available() ? 'state1-available' : 'state1-missing') . PHP_EOL;
echo ($state2->available() ? 'state2-available' : 'state2-missing') . PHP_EOL;
echo (spl_object_id($state1) === spl_object_id($state2) ? 'state-stable' : 'state-distinct') . PHP_EOL;

$state1->set('count', '41');
echo $state2->get('count') . PHP_EOL;

$state2->set('count', '42');
echo $state1->get_or('count', 'missing') . PHP_EOL;

$state1->clear('count');
echo ($state2->get('count') === '' ? 'state-cleared' : 'state-not-cleared') . PHP_EOL;
?>
--EXPECT--
state1-available
state2-available
state-distinct
41
42
state-cleared
