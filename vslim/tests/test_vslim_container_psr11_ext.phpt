--TEST--
VSlim container can bind to autoloaded PSR-11 interfaces at runtime
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
// Prefer the real Composer PSR package when available.
$autoload = dirname(__DIR__) . '/examples/vendor/autoload.php';
if (is_file($autoload)) {
    require_once $autoload;
} else {
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
}

$containerIface = 'Psr\\Container\\ContainerInterface';
$containerExceptionIface = 'Psr\\Container\\ContainerExceptionInterface';
$notFoundExceptionIface = 'Psr\\Container\\NotFoundExceptionInterface';

var_dump(interface_exists($containerIface, false));
var_dump(interface_exists($containerIface));
$implementsBefore = class_implements(VSlim\Container::class);
var_dump(isset($implementsBefore[$containerIface]));
var_dump(interface_exists($containerExceptionIface));
var_dump(interface_exists($notFoundExceptionIface));
$notFoundImplements = class_implements(VSlim\Container\NotFoundException::class);
var_dump(isset($notFoundImplements[$containerExceptionIface]));
var_dump(isset($notFoundImplements[$notFoundExceptionIface]));
var_dump((new ReflectionClass(VSlim\Container\NotFoundException::class))->implementsInterface($notFoundExceptionIface));
$c = new VSlim\Container();
var_dump(interface_exists($containerIface, false));
var_dump($c instanceof $containerIface);

$c->set('name', 'codex');
$c->factory('hello', fn () => 'hi-' . $c->get('name'));
echo $c->get('name') . PHP_EOL;
echo $c->get('hello') . PHP_EOL;
var_dump($c->has('name'));
var_dump($c->has('missing'));

try {
    $c->get('missing');
    echo "missing_not_thrown\n";
} catch (VSlim\Container\NotFoundException $e) {
    echo "not_found_class\n";
    var_dump($e instanceof $containerExceptionIface);
    var_dump($e instanceof $notFoundExceptionIface);
}
?>
--EXPECT--
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
codex
hi-codex
bool(true)
bool(false)
not_found_class
bool(true)
bool(true)
