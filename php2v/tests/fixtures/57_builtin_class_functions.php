<?php
interface TestInterface {}
class ParentClass implements TestInterface {
    public $parent_prop = 1;
    public function parent_method() {}
}
class ChildClass extends ParentClass {
    public $child_prop = 2;
    public function child_method() {}
}

$obj = new ChildClass();

// 1. get_class
echo get_class($obj) . "\n";

// 2. get_parent_class
echo get_parent_class($obj) . "\n";
echo (get_parent_class('ParentClass') ?: 'none') . "\n";

// 3. is_a & is_subclass_of
echo (is_a($obj, 'ChildClass') ? 'yes' : 'no') . "\n";
echo (is_a($obj, 'ParentClass') ? 'yes' : 'no') . "\n";
echo (is_a($obj, 'TestInterface') ? 'yes' : 'no') . "\n";
echo (is_subclass_of($obj, 'ParentClass') ? 'yes' : 'no') . "\n";
echo (is_subclass_of($obj, 'TestInterface') ? 'yes' : 'no') . "\n";

// 4. method_exists
echo (method_exists($obj, 'child_method') ? 'yes' : 'no') . "\n";
echo (method_exists($obj, 'parent_method') ? 'yes' : 'no') . "\n";
echo (method_exists('ChildClass', 'parent_method') ? 'yes' : 'no') . "\n";
echo (method_exists($obj, 'non_existent') ? 'yes' : 'no') . "\n";

// 5. property_exists
echo (property_exists($obj, 'child_prop') ? 'yes' : 'no') . "\n";
echo (property_exists($obj, 'parent_prop') ? 'yes' : 'no') . "\n";
echo (property_exists('ChildClass', 'child_prop') ? 'yes' : 'no') . "\n";

// 6. spl_object_hash
$hash1 = spl_object_hash($obj);
$hash2 = spl_object_hash($obj);
echo ($hash1 === $hash2 ? 'hash_stable' : 'hash_unstable') . "\n";
echo (strlen($hash1) > 0 ? 'hash_non_empty' : 'hash_empty') . "\n";
