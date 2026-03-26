--TEST--
VSlim container supports first-touch instanceof against Composer-loaded PSR-11 interfaces
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

$container = new VSlim\Container();
var_dump($container instanceof Psr\Container\ContainerInterface);

try {
    $container->get('missing');
    echo "missing_not_thrown\n";
} catch (VSlim\Container\NotFoundException $e) {
    var_dump($e instanceof Psr\Container\ContainerExceptionInterface);
    var_dump($e instanceof Psr\Container\NotFoundExceptionInterface);
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
