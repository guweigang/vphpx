--TEST--
VSlim Request setAttributes stringifies complex values for attributes facade
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
class AttrStringableProbe
{
    public function __toString(): string
    {
        return 'stringable-ok';
    }
}

class AttrJsonProbe
{
    public string $name = 'demo';
}

$request = new VSlim\VHttpd\Request('GET', '/', '');
$request->setAttributes([
    'plain' => 'x',
    'nested' => ['a' => 1],
    'stringable' => new AttrStringableProbe(),
    'json' => new AttrJsonProbe(),
    'nil' => null,
]);

var_export($request->attributes());
echo PHP_EOL;
?>
--EXPECT--
array (
  'plain' => 'x',
  'nested' => '{"a":1}',
  'stringable' => 'stringable-ok',
  'json' => '{"name":"demo"}',
  'nil' => '',
)
