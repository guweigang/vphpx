--TEST--
VSlim container supports class-string first-touch PSR-11 metadata queries
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (extension_loaded('psr')) {
    echo "skip psr extension already loaded; runtime autoload binding needs a clean environment";
    return;
}
?>
--FILE--
<?php
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (!is_file($autoload)) {
    echo "skip missing Composer autoload\n";
    return;
}
require_once $autoload;

$iface = 'Psr\\Container\\ContainerInterface';

$implements = class_implements(VSlim\Container::class);
var_dump(isset($implements[$iface]));
var_dump(is_a(VSlim\Container::class, $iface, true));
var_dump(is_subclass_of(VSlim\Container::class, $iface, true));
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
