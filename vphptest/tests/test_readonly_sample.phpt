--TEST--
Readonly sample class keeps PHP readonly semantics
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$rc = new ReflectionClass(ReadonlyRecord::class);
function normalized_modifier_names(int $modifiers): string {
    $names = Reflection::getModifierNames($modifiers);
    $names = array_values(array_filter($names, static fn ($name) => $name !== 'protected(set)'));
    return implode(' ', $names);
}
echo "created_at=" . normalized_modifier_names($rc->getProperty('created_at')->getModifiers()) . PHP_EOL;
echo "title=" . normalized_modifier_names($rc->getProperty('title')->getModifiers()) . PHP_EOL;
echo "internal_note=" . normalized_modifier_names($rc->getProperty('internal_note')->getModifiers()) . PHP_EOL;

$record = new ReadonlyRecord('Audit');
echo $record->reveal() . PHP_EOL;

try {
    $record->created_at = 99;
} catch (Error $e) {
    echo "readonly=" . $e->getMessage() . PHP_EOL;
}
?>
--EXPECT--
created_at=public readonly
title=public
internal_note=protected
Audit:42
readonly=Cannot modify readonly property ReadonlyRecord::$created_at
