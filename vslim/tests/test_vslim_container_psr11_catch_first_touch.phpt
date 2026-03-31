--TEST--
VSlim container supports first-touch catch against Composer-loaded PSR-11 interfaces
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
    spl_autoload_register(function (string $class): void {
        if (str_starts_with($class, 'Psr\\Container\\')) {
            eval(<<<'PHP'
namespace Psr\Container;

interface ContainerExceptionInterface extends \Throwable {}
interface NotFoundExceptionInterface extends ContainerExceptionInterface {}
interface ContainerInterface
{
    public function get(string $id);
    public function has(string $id): bool;
}
PHP);
        }
    });
} else {
    require_once $autoload;
}

$container = new VSlim\Container();

try {
    $container->get('missing');
    echo "missing_not_thrown\n";
} catch (Psr\Container\NotFoundExceptionInterface $e) {
    echo "caught_not_found\n";
} catch (Psr\Container\ContainerExceptionInterface $e) {
    echo "caught_container\n";
} catch (Throwable $e) {
    echo get_class($e), "\n";
}
?>
--EXPECT--
caught_not_found
