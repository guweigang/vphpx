--TEST--
VSlim compiler binds PHP declarations from submodules
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
echo vslim_module_probe(), "\n";
echo vslim_module_probe_options('custom', 9), "\n";
echo MODULE_PROBE_CONSTANT, "\n";
$box = new VSlim\Compiler\ModuleProbeBox();
$box->name = 'changed';
$box->count = 42;
echo $box->label(), "\n";
echo VSlim\Compiler\ModuleProbeBox::staticLabel(), "\n";
echo $box instanceof VSlim\Compiler\ModuleProbeContract ? "implements-ok\n" : "implements-missing\n";
echo interface_exists(VSlim\Compiler\ModuleProbeContract::class) ? "interface-ok\n" : "interface-missing\n";
echo enum_exists(VSlim\Compiler\ModuleProbeKind::class) ? "enum-ok\n" : "enum-missing\n";
echo VSlim\Compiler\ModuleProbeKind::alpha->value, "\n";
echo $box->test_sumtype(10), "\n";
echo $box->test_sumtype('world'), "\n";
$ref = new ReflectionMethod($box, 'test_sumtype');
$params = $ref->getParameters();
echo $params[0]->getType() ? $params[0]->getType()->__toString() : 'no-type', "\n";
?>
--EXPECT--
module-probe-ok
custom:9
module-constant-ok
changed:42
box-static-label
implements-ok
interface-ok
enum-ok
7
110
hello:world
string|int
