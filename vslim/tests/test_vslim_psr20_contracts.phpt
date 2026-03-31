--TEST--
VSlim PSR-20 clock returns DateTimeImmutable objects with stable interface metadata
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
namespace Psr\Clock {
    if (!interface_exists(ClockInterface::class, false)) {
        interface ClockInterface {
            public function now(): \DateTimeImmutable;
        }
    }
}

namespace {
    $clock = new VSlim\Psr20\Clock();
    $first = $clock->now();
    $second = $clock->now();

    var_dump($clock instanceof Psr\Clock\ClockInterface);
    var_dump($first instanceof DateTimeImmutable);
    var_dump($second instanceof DateTimeImmutable);
    var_dump($first !== $second);
    var_dump(abs($first->getTimestamp() - time()) <= 5);

    $nowMethod = new ReflectionMethod(VSlim\Psr20\Clock::class, 'now');
    $returnType = $nowMethod->getReturnType();
    var_dump($returnType instanceof ReflectionNamedType ? $returnType->getName() : null);
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
string(17) "DateTimeImmutable"
