--TEST--
vphp compiler supports PHP 8.1+ Enum interoperability with V
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
if (!enum_exists(VPHP\Compiler\ModuleProbeKind::class)) { echo "Enum not found\n"; exit; }

$ref = new ReflectionEnum(VPHP\Compiler\ModuleProbeKind::class);
echo $ref->isBacked() ? "enum-backed-ok\n" : "enum-backed-fail\n";

echo VPHP\Compiler\ModuleProbeKind::alpha->value . "\n";
echo VPHP\Compiler\ModuleProbeKind::beta->value . "\n";

$cases = VPHP\Compiler\ModuleProbeKind::cases();
echo count($cases) === 2 ? "case-count-ok\n" : "invalid-case-count\n";
?>
--EXPECT--
enum-backed-ok
7
11
case-count-ok
