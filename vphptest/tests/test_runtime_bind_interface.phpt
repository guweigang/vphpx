--TEST--
runtime interface binding remains idempotent when php_implements already auto-binds
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if ($class === 'RuntimeContracts\\Greeter') {
        eval(<<<'PHP'
namespace RuntimeContracts;

interface Greeter
{
    public function ping();
}
PHP);
    }
});

$iface = 'RuntimeContracts\\Greeter';

var_dump(interface_exists($iface, false));

$obj = new AliasWorker('edge', 'bridge');

var_dump(interface_exists($iface, false));
var_dump($obj instanceof $iface);
var_dump(v_bind_class_interface(AliasWorker::class, $iface));
var_dump((new AliasWorker('late', 'bind')) instanceof $iface);

$implements = class_implements(AliasWorker::class);
ksort($implements);
foreach ($implements as $name) {
    if (str_starts_with($name, 'RuntimeContracts\\')) {
        echo "implements={$name}" . PHP_EOL;
    }
}
?>
--EXPECT--
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
implements=RuntimeContracts\Greeter
