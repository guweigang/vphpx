--TEST--
VSlim compiler supports PHP wrappers property binding, getter, setter and sync
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$class = new ReflectionClass(VSlim\Compiler\ModuleProbeWrapperBox::class);

$expectedTypes = [
    'val' => null, // mixed / no type
    'obj' => 'object',
    'str' => 'string',
    'num' => 'int',
    'b'   => 'bool',
    'arr' => 'array',
];

echo "=== Reflection Types ===\n";
foreach ($expectedTypes as $name => $expectedType) {
    $prop = $class->getProperty($name);
    $hasType = $prop->hasType();
    if ($expectedType === null) {
        echo "prop-{$name}-type: " . ($hasType ? $prop->getType()->getName() : 'none') . "\n";
    } else {
        echo "prop-{$name}-type: " . ($hasType ? $prop->getType()->getName() : 'none') . "\n";
    }
}

echo "=== Default Values ===\n";
$box = new VSlim\Compiler\ModuleProbeWrapperBox();
var_dump($box->val);
var_dump($box->obj);
var_dump($box->str);
var_dump($box->num);
var_dump($box->b);
var_dump($box->arr);

echo "=== Setter and Getter ===\n";
$box->val = "hello val";
$box->obj = (object)["foo" => "bar"];
$box->str = "hello str";
$box->num = 123;
$box->b = true;
$box->arr = ["x", "y"];

var_dump($box->val);
var_dump($box->obj);
var_dump($box->str);
var_dump($box->num);
var_dump($box->b);
var_dump($box->arr);

echo "=== Sync Props via Method ===\n";
$box->change_props("changed val", (object)["key" => "val"], "changed str", 456, false, ["a", "b"]);

var_dump($box->val);
var_dump($box->obj);
var_dump($box->str);
var_dump($box->num);
var_dump($box->b);
var_dump($box->arr);

?>
--EXPECTF--
=== Reflection Types ===
prop-val-type: none
prop-obj-type: object
prop-str-type: string
prop-num-type: int
prop-b-type: bool
prop-arr-type: array
=== Default Values ===
NULL
NULL
NULL
NULL
NULL
NULL
=== Setter and Getter ===
string(9) "hello val"
object(stdClass)#%d (1) {
  ["foo"]=>
  string(3) "bar"
}
string(9) "hello str"
int(123)
bool(true)
array(2) {
  [0]=>
  string(1) "x"
  [1]=>
  string(1) "y"
}
=== Sync Props via Method ===
string(11) "changed val"
object(stdClass)#%d (1) {
  ["key"]=>
  string(3) "val"
}
string(11) "changed str"
int(456)
bool(false)
array(2) {
  [0]=>
  string(1) "a"
  [1]=>
  string(1) "b"
}
