--TEST--
Article OOP Modifiers Test
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php

echo "1. Reflection checks:\n";

$rc = new ReflectionClass(Article::class);

function version_expected_modifier_names(string $property, int $modifiers): string {
    $actual = implode(' ', Reflection::getModifierNames($modifiers));
    $expected = match ($property) {
        'post_id', 'author', 'id', 'title', 'is_top' => 'public',
        'created_at' => PHP_VERSION_ID >= 80500 ? 'public protected(set) readonly' : 'public readonly',
        'content' => 'protected',
        'total_count' => 'public static',
        default => $actual,
    };
    return $actual === $expected ? 'matches' : 'unexpected:' . $actual;
}

$props = $rc->getProperties();
foreach ($props as $p) {
    $modifiers = version_expected_modifier_names($p->getName(), $p->getModifiers());
    echo "Property: " . $p->getName() . " - " . $modifiers . "\n";
}

$methods = $rc->getMethods();
foreach ($methods as $m) {
    // Only check methods we defined, ignore standard ones if any
    $modifiers = implode(' ', Reflection::getModifierNames($m->getModifiers()));
    echo "Method: " . $m->getName() . " - " . $modifiers . "\n";
}


echo "\n2. Runtime behavior:\n";

$article = new Article("Hello V!", 1);
echo "Title: " . $article->title . "\n";

echo "Formatted: " . $article->get_formatted_title() . "\n";

try {
    echo $article->content;
} catch (Error $e) {
    echo "Caught protected property access: " . $e->getMessage() . "\n";
}

try {
    $article->created_at = 99;
} catch (Error $e) {
    echo "Caught readonly property write: " . $e->getMessage() . "\n";
}

try {
    $article->internal_format();
} catch (Error $e) {
    echo "Caught protected method call: " . $e->getMessage() . "\n";
}

?>
--EXPECT--
1. Reflection checks:
Property: post_id - matches
Property: author - matches
Property: created_at - matches
Property: id - matches
Property: title - matches
Property: is_top - matches
Property: content - matches
Property: total_count - matches
Method: __construct - public
Method: internal_format - protected
Method: create - public static
Method: get_formatted_title - public
Method: save - public
Method: dump_properties - public
Method: process_with_callback - public
Method: restore_author - public static
Method: set_author - public
Method: get_author - public

2. Runtime behavior:
Title: Hello V!
Formatted: [Protected] Hello V!
Caught protected property access: Cannot access protected property Article::$content
Caught readonly property write: Cannot modify readonly property Article::$created_at
Caught protected method call: Call to protected method Article::internal_format() from global scope
