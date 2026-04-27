--TEST--
PHP params struct and semantic empty helpers
--FILE--
<?php
echo v_php_semantic_empty_api() . PHP_EOL;
echo v_php_params_struct_api() . PHP_EOL;
echo v_php_params_struct_api(201) . PHP_EOL;
echo v_php_params_struct_api(202, 'Accepted', true, 2.5) . PHP_EOL;
echo v_php_params_struct_api(ratio: 3.5, reasonPhrase: 'Named') . PHP_EOL;
echo v_php_semantic_params_struct_api() . PHP_EOL;
echo v_php_semantic_params_struct_api(label: 'Named', items: ['a', 'b']) . PHP_EOL;
echo v_php_args_api('hello', 42) . PHP_EOL;
$rf = new ReflectionFunction('v_php_params_struct_api');
foreach ($rf->getParameters() as $p) {
    echo $p->getName() . ':' . ($p->isOptional() ? 'optional' : 'required') . ':';
    echo $p->isDefaultValueAvailable() ? var_export($p->getDefaultValue(), true) : 'none';
    echo PHP_EOL;
}
?>
--EXPECT--
empty=:0:0.0:false:true:0:0
params=200::false:1.5
params=201::false:1.5
params=202:Accepted:true:2.5
params=200:Named:false:3.5
semantic_params=:false:0
semantic_params=Named:false:2
args=2:0:first:hello|1:second:42|missing=false:true
status:optional:200
reasonPhrase:optional:''
secure:optional:false
ratio:optional:1.5
