--TEST--
VSlim PSR-20 binding supports first-touch metadata queries
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if ($class === 'Psr\\Clock\\ClockInterface') {
        eval(<<<'PHP'
namespace Psr\Clock;

interface ClockInterface
{
    public function now(): \DateTimeImmutable;
}
PHP);
    }
});

$iface = 'Psr\\Clock\\ClockInterface';

var_dump(interface_exists($iface, false));
var_dump(is_a(VSlim\Psr20\Clock::class, $iface, true));
var_dump((new VSlim\Psr20\Clock()) instanceof Psr\Clock\ClockInterface);

$nowMethod = new ReflectionMethod(VSlim\Psr20\Clock::class, 'now');
$returnType = $nowMethod->getReturnType();

var_dump($returnType instanceof ReflectionNamedType ? $returnType->getName() : null);

$implements = class_implements(VSlim\Psr20\Clock::class);
var_dump(isset($implements['Psr\\Clock\\ClockInterface']));
?>
--EXPECT--
bool(false)
bool(true)
bool(true)
string(17) "DateTimeImmutable"
bool(true)
