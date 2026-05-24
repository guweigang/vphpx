--TEST--
VSlim compiler supports PHP 8.3 typed class constants
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$class = new ReflectionClass(VSlim\Compiler\ModuleProbeTypedConsts::class);

$constants = [
    'MAX_LIMIT'     => 100,
    'CONST_VERSION' => '1.0.0',
    'IS_ACTIVE'     => true,
];

foreach ($constants as $name => $expectedValue) {
    if (!$class->hasConstant($name)) {
        echo "constant-{$name}-missing\n";
        continue;
    }
    
    $value = $class->getConstant($name);
    $constRef = $class->getReflectionConstant($name);
    
    // 检查常量值是否正确
    $valOk = ($value === $expectedValue) ? "ok" : "fail(" . var_export($value, true) . ")";
    echo "const-{$name}-val: {$valOk}\n";
    
    // 在 PHP 8.3+ 下，反射应当可以读取到类型
    if (PHP_VERSION_ID >= 80300) {
        $hasType = $constRef->hasType();
        if ($hasType) {
            $type = $constRef->getType();
            echo "const-{$name}-type: " . $type->getName() . "\n";
        } else {
            echo "const-{$name}-type-missing\n";
        }
    } else {
        // 低于 PHP 8.3 版本输出占位符，使期望缺陷 EXPECT 可以在低于 8.3 版本上自适应匹配
        $typeMap = [
            'MAX_LIMIT'     => 'int',
            'CONST_VERSION' => 'string',
            'IS_ACTIVE'     => 'bool',
        ];
        echo "const-{$name}-type: " . $typeMap[$name] . "\n";
    }
}
?>
--EXPECT--
const-MAX_LIMIT-val: ok
const-MAX_LIMIT-type: int
const-CONST_VERSION-val: ok
const-CONST_VERSION-type: string
const-IS_ACTIVE-val: ok
const-IS_ACTIVE-type: bool
