--TEST--
php_implements auto-registers runtime bindings for userland interfaces
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
$obj = new AliasWorker('edge', 'bridge');

var_dump(interface_exists($iface, false));
var_dump(interface_exists($iface));
var_dump($obj instanceof $iface);

$implements = class_implements($obj);
ksort($implements);
foreach ($implements as $name) {
    if (str_starts_with($name, 'RuntimeContracts\\')) {
        echo "implements={$name}" . PHP_EOL;
    }
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
implements=RuntimeContracts\Greeter
