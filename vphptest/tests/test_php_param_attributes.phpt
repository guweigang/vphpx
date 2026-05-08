--TEST--
vphp exports PHP attributes for function and method parameters
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
#[Attribute(Attribute::TARGET_PARAMETER)]
class FromQuery
{
    public function __construct(public string $name) {}
}

#[Attribute(Attribute::TARGET_PARAMETER)]
class MustBeString {}

#[Attribute(Attribute::TARGET_PARAMETER)]
class MustBeInt {}

echo v_php_param_attr_api(query: 'term', page: 2) . PHP_EOL;

$rf = new ReflectionFunction('v_php_param_attr_api');
foreach ($rf->getParameters() as $p) {
    echo 'function:' . $p->getName() . '=';
    echo implode(',', array_map(fn($a) => $a->getName(), $p->getAttributes())) . PHP_EOL;
}
$queryAttrs = $rf->getParameters()[0]->getAttributes();
echo 'query_source=' . $queryAttrs[0]->newInstance()->name . PHP_EOL;

$sample = new DispatchableSample('box');
echo $sample->tagged('needle') . PHP_EOL;

$rm = new ReflectionMethod(DispatchableSample::class, 'tagged');
$param = $rm->getParameters()[0];
echo 'method:' . $param->getName() . '=';
echo implode(',', array_map(fn($a) => $a->getName(), $param->getAttributes())) . PHP_EOL;
echo 'method_source=' . $param->getAttributes()[0]->newInstance()->name . PHP_EOL;

echo v_php_arg_attr_runtime_api('term', 2) . PHP_EOL;
?>
--EXPECT--
param_attr=term:2
function:query=FromQuery,MustBeString
function:page=FromQuery,MustBeInt
query_source=q
box:needle
method:name=FromQuery,MustBeString
method_source=name
runtime=query:true:q:page:2:100
