--TEST--
vphp compiler binds PHP declarations from submodules
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
echo v_compiler_probe(), "\n";
echo v_compiler_probe_options('custom', 9), "\n";
echo COMPILER_PROBE_CONSTANT, "\n";
$box = new VPHP\Compiler\ModuleProbeBox();
$box->name = 'changed';
$box->count = 42;
echo $box->label(), "\n";
echo VPHP\Compiler\ModuleProbeBox::staticLabel(), "\n";
echo $box instanceof VPHP\Compiler\ModuleProbeContract ? "implements-ok\n" : "implements-missing\n";
echo interface_exists(VPHP\Compiler\ModuleProbeContract::class) ? "interface-ok\n" : "interface-missing\n";
echo enum_exists(VPHP\Compiler\ModuleProbeKind::class) ? "enum-ok\n" : "enum-missing\n";
echo VPHP\Compiler\ModuleProbeKind::alpha->value, "\n";
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
