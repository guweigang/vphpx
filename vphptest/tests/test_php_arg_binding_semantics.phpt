--TEST--
Compiler argument binding semantics matrix
--FILE--
<?php
$obj = new class {
    public string $name = 'codex';
};

echo v_php_arg_binding_optional_scalar_api() . PHP_EOL;
echo v_php_arg_binding_optional_scalar_api(11) . PHP_EOL;
echo v_php_arg_binding_optional_scalar_api(label: 'named') . PHP_EOL;

echo v_php_optional_value_api() . PHP_EOL;
echo v_php_optional_value_api(null) . PHP_EOL;
echo v_php_optional_value_api('text') . PHP_EOL;

echo v_php_optional_object_api() . PHP_EOL;
echo v_php_optional_object_api(null) . PHP_EOL;
echo v_php_optional_object_api($obj) . PHP_EOL;

echo v_php_params_struct_api() . PHP_EOL;
echo v_php_params_struct_api(reasonPhrase: 'Partial') . PHP_EOL;
echo v_php_params_struct_api(201, 'Created', true, 2.5) . PHP_EOL;

echo v_php_semantic_params_struct_api() . PHP_EOL;
echo v_php_semantic_params_struct_api(label: 'Named', items: ['a', 'b']) . PHP_EOL;
try {
    v_php_semantic_params_struct_api(items: 'not-array');
} catch (Throwable $e) {
    echo 'caught=' . $e->getMessage() . PHP_EOL;
}
?>
--EXPECTF--
optional_scalar=7:fallback
optional_scalar=11:fallback
optional_scalar=7:named
optional_value=none
optional_value=some:null:true
optional_value=some:string:false
optional_object=none
optional_object=none
optional_object=some:borrowed:codex
params=200::false:1.5
params=200:Partial:false:1.5
params=201:Created:true:2.5
semantic_params=:false:0
semantic_params=Named:false:2
caught=v_php_semantic_params_struct_api(): Argument #3 ($items) must be of type array, string given, called in %s on line %d
