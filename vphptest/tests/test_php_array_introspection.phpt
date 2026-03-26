--TEST--
ZVal array introspection preserves raw key types and detects PHP lists
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$cases = [
    'list' => ['a', 'b'],
    'assoc' => [
        'name' => 'codex',
        'tags' => ['a', 'b'],
    ],
    'mixed' => [
        0 => 'zero',
        'name' => 'codex',
        2 => 'two',
    ],
];

foreach ($cases as $label => $value) {
    $meta = v_php_array_introspection($value);
    ksort($meta);
    foreach ($meta as $k => $v) {
        echo $label . '.' . $k . '=' . $v . PHP_EOL;
    }
}
?>
--EXPECT--
list.assoc_keys=
list.first=a
list.is_list=true
list.key_strings=0,1
list.keys=integer:0,integer:1
list.name=
assoc.assoc_keys=name,tags
assoc.first=
assoc.is_list=false
assoc.key_strings=name,tags
assoc.keys=string:name,string:tags
assoc.name=codex
mixed.assoc_keys=name
mixed.first=zero
mixed.is_list=false
mixed.key_strings=0,name,2
mixed.keys=integer:0,string:name,integer:2
mixed.name=codex
