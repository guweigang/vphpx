<?php

if (isset($argv[1]) && !str_starts_with($argv[1], '--')) {
    require $argv[1];
}
$mode = $argv[2] ?? $argv[1] ?? '';
if ($mode === '--override-get') {
    eval('class PhpOverrideFinalGet extends BackedGetterChild { public int $score { get => 8; } }');
    exit;
}
if ($mode === '--override-set') {
    eval('class PhpOverrideFinalSet extends VGetterChild { public int $score { set {} } }');
    exit;
}

if (PHP_VERSION_ID < 80400) {
    foreach ([LockedGetter::class, LockedSetter::class, VSetterChild::class, VGetterChild::class] as $class) {
        if (property_exists($class, 'score')) {
            throw new RuntimeException("A hooked property appeared before PHP 8.4 on $class");
        }
    }
    if ((new BackedGetterChild())->score !== 4) {
        throw new RuntimeException('The ordinary property was affected');
    }
    exit;
}

eval('class PhpSetterChild extends LockedGetter {
    public int $score { set { parent::$score::set($value + 20); } }
}');
eval('class PhpGetterChild extends LockedSetter {
    public int $score { get => parent::$score::get() + 2; }
}');

foreach ([
    [LockedGetter::class, LockedGetter::class, LockedGetter::class, 'get'],
    [LockedSetter::class, LockedSetter::class, LockedSetter::class, 'set'],
    [VSetterChild::class, LockedGetter::class, VSetterChild::class, 'get'],
    [VGetterChild::class, VGetterChild::class, LockedSetter::class, 'set'],
    [PhpSetterChild::class, LockedGetter::class, PhpSetterChild::class, 'get'],
    [PhpGetterChild::class, PhpGetterChild::class, LockedSetter::class, 'set'],
    [BackedGetterChild::class, LockedGetter::class, LockedGetter::class, 'get'],
] as [$class, $getterOwner, $setterOwner, $locked]) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if ($property->isFinal() || $property->isVirtual() !== ($class !== BackedGetterChild::class)
        || array_keys($hooks) !== ['get', 'set']
        || $hooks['get']->getDeclaringClass()->getName() !== $getterOwner
        || $hooks['set']->getDeclaringClass()->getName() !== $setterOwner
        || $hooks['get']->isFinal() !== ($locked === 'get')
        || $hooks['set']->isFinal() !== ($locked === 'set')
        || (string) $hooks['get']->getReturnType() !== 'int'
        || (string) $hooks['set']->getParameters()[0]->getType() !== 'int') {
        throw new RuntimeException("Unexpected final hook Reflection for $class");
    }
}

if (extension_loaded('final_property_hooks')) {
    foreach ([VSetterChild::class => 17, VGetterChild::class => 15,
        PhpSetterChild::class => 27, PhpGetterChild::class => 16, BackedGetterChild::class => 7] as $class => $expected) {
        $value = new $class();
        $value->score = 7;
        if ($value->score !== $expected) {
            throw new RuntimeException("Unexpected inherited hook behavior for $class");
        }
    }
}
