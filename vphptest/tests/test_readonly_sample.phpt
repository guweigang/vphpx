--TEST--
Readonly sample class keeps PHP readonly semantics
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$rc = new ReflectionClass(ReadonlyRecord::class);
function version_expected_modifier_names(string $property, int $modifiers): string {
    $actual = implode(' ', Reflection::getModifierNames($modifiers));
    $expected = match ($property) {
        'created_at' => PHP_VERSION_ID >= 80500 ? 'public protected(set) readonly' : 'public readonly',
        'title' => 'public',
        'internal_note' => 'protected',
        default => $actual,
    };
    return $actual === $expected ? 'matches' : 'unexpected:' . $actual;
}
$createdAt = $rc->getProperty('created_at');
echo "created_at=" . version_expected_modifier_names('created_at', $createdAt->getModifiers()) . PHP_EOL;
echo "title=" . version_expected_modifier_names('title', $rc->getProperty('title')->getModifiers()) . PHP_EOL;
echo "internal_note=" . version_expected_modifier_names('internal_note', $rc->getProperty('internal_note')->getModifiers()) . PHP_EOL;

$record = new ReadonlyRecord('Audit');
echo $record->reveal() . PHP_EOL;

try {
    $record->created_at = 99;
} catch (Error $e) {
    echo "readonly=" . $e->getMessage() . PHP_EOL;
}
?>
--EXPECT--
created_at=matches
title=matches
internal_note=matches
Audit:42
readonly=Cannot modify readonly property ReadonlyRecord::$created_at
