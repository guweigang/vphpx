--TEST--
vphp compiler supports PHP 8.2 readonly classes
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$class = new ReflectionClass(VPHP\Compiler\ModuleProbeReadOnlyBox::class);
echo $class->isReadOnly() ? "class-readonly-ok\n" : "class-readonly-fail\n";

$prop = $class->getProperty('title');
echo $prop->isReadOnly() ? "prop-title-readonly-ok\n" : "prop-title-readonly-fail\n";

$box = new VPHP\Compiler\ModuleProbeReadOnlyBox();
echo $box->title, "\n";

try {
    $box->title = 'new-value';
} catch (Error $e) {
    echo "modify-error: " . $e->getMessage() . "\n";
}
?>
--EXPECT--
class-readonly-ok
prop-title-readonly-ok
readonly-box
modify-error: Cannot modify readonly property VPHP\Compiler\ModuleProbeReadOnlyBox::$title
