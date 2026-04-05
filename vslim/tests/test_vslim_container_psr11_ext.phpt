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

function vslim_test_factory_string(): string
{
    return 'string-codex';
}

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
$c->factory('hello.str', 'vslim_test_factory_string');
$c->factory('hello.static', [new class {
    public static function makeStatic(): string
    {
        return 'static-codex';
    }
}::class, 'makeStatic']);
$c->factory('hello', fn () => 'hi-' . $c->get('name'));
 $factoryObj = new class($c) {
    public function __construct(private VSlim\Container $container) {}

    public function makeHi(): string
    {
        return 'obj-' . $this->container->get('name');
    }
};
 $c->factory('hello.obj', [$factoryObj, 'makeHi']);
echo $c->get('name') . PHP_EOL;
echo $c->get('hello.str') . PHP_EOL;
echo $c->get('hello.static') . PHP_EOL;
echo $c->get('hello') . PHP_EOL;
echo $c->get('hello.obj') . PHP_EOL;
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
string-codex
static-codex
hi-codex
obj-codex
bool(true)
bool(false)
not_found_class
bool(true)
bool(true)
