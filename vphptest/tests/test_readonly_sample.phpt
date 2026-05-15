--TEST--
Readonly sample class keeps PHP readonly semantics
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$rc = new ReflectionClass(ReadonlyRecord::class);
$vphpSupportsProtectedSet = false;
function stable_modifier_names(int $modifiers): string {
    $names = Reflection::getModifierNames($modifiers);
    $names = array_values(array_filter($names, static fn ($name) => $name !== 'protected(set)'));
    return implode(' ', $names);
}
$createdAt = $rc->getProperty('created_at');
echo "created_at=" . stable_modifier_names($createdAt->getModifiers()) . PHP_EOL;
$createdAtModifiers = Reflection::getModifierNames($createdAt->getModifiers());
$createdAtHasProtectedSet = in_array('protected(set)', $createdAtModifiers, true);
echo "created_at_protected_set=" .
    ($vphpSupportsProtectedSet && PHP_VERSION_ID >= 80500 && $createdAtHasProtectedSet ? 'supported' : 'not-supported') .
    PHP_EOL;
echo "title=" . stable_modifier_names($rc->getProperty('title')->getModifiers()) . PHP_EOL;
echo "internal_note=" . stable_modifier_names($rc->getProperty('internal_note')->getModifiers()) . PHP_EOL;

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
created_at_protected_set=not-supported
title=public
internal_note=protected
Audit:42
readonly=Cannot modify readonly property ReadonlyRecord::$created_at
