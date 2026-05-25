--TEST--
VSlim compiler supports PHP 8.0+ typed properties
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
// ModuleProbeReadOnlyBox 有 title(string) 和 value(int) 两个 pub 属性
$class = new ReflectionClass(VSlim\Compiler\ModuleProbeReadOnlyBox::class);

$props = [
    'title' => 'string',
    'value' => 'int',
];

foreach ($props as $name => $expectedType) {
    $prop = $class->getProperty($name);

    $hasType = $prop->hasType();
    echo "prop-{$name}-hasType: " . ($hasType ? 'yes' : 'no') . "\n";

    if ($hasType) {
        $type = $prop->getType();
        echo "prop-{$name}-type: " . $type->getName() . "\n";
    }

    echo "prop-{$name}-readonly: " . ($prop->isReadOnly() ? 'yes' : 'no') . "\n";
}

// ModuleProbeBox 有 name(string) 和 count(int) 两个 pub mut 属性
$class2 = new ReflectionClass(VSlim\Compiler\ModuleProbeBox::class);

$props2 = [
    'name'  => 'string',
    'count' => 'int',
];

foreach ($props2 as $name => $expectedType) {
    $prop = $class2->getProperty($name);

    $hasType = $prop->hasType();
    echo "prop-{$name}-hasType: " . ($hasType ? 'yes' : 'no') . "\n";

    if ($hasType) {
        $type = $prop->getType();
        echo "prop-{$name}-type: " . $type->getName() . "\n";
    }

    echo "prop-{$name}-readonly: " . ($prop->isReadOnly() ? 'yes' : 'no') . "\n";
}
?>
--EXPECT--
prop-title-hasType: yes
prop-title-type: string
prop-title-readonly: yes
prop-value-hasType: yes
prop-value-type: int
prop-value-readonly: yes
prop-name-hasType: yes
prop-name-type: string
prop-name-readonly: no
prop-count-hasType: yes
prop-count-type: int
prop-count-readonly: no
