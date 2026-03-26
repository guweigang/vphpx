--TEST--
runtime interface binding still enforces method signature compatibility
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if ($class === 'RuntimeContracts\\BadGreeter') {
        eval(<<<'PHP'
namespace RuntimeContracts;

interface BadGreeter
{
    public function ping(int $code): string;
}
PHP);
    }
});

v_bind_class_interface(AliasWorker::class, 'RuntimeContracts\\BadGreeter');
echo "should_not_reach\n";
?>
--EXPECTF--
Fatal error: Declaration of AliasWorker::ping(): string must be compatible with RuntimeContracts\BadGreeter::ping(int $code): string in %s on line %d
