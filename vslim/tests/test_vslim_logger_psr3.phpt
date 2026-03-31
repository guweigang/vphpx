--TEST--
VSlim PSR-3 logger wrapper binds to LoggerInterface and reuses the native logger
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Log\\LoggerInterface')) {
    eval(<<<'PHP'
namespace Psr\Log;

interface LoggerInterface
{
    public function emergency($message, array $context = []): void;
    public function alert($message, array $context = []): void;
    public function critical($message, array $context = []): void;
    public function error($message, array $context = []): void;
    public function warning($message, array $context = []): void;
    public function notice($message, array $context = []): void;
    public function info($message, array $context = []): void;
    public function debug($message, array $context = []): void;
    public function log($level, $message, array $context = []): void;
}
PHP);
}

$logger = new VSlim\Log\PsrLogger();
$logger->set_channel('psr3-test');
$inner = $logger->logger();

echo ($logger instanceof Psr\Log\LoggerInterface ? 'yes' : 'no') . PHP_EOL;
$interfaces = class_implements($logger);
sort($interfaces);
echo in_array('Psr\\Log\\LoggerInterface', $interfaces, true) ? "has_interface\n" : "missing_interface\n";
echo get_class($inner) . PHP_EOL;
echo $inner->channel() . PHP_EOL;

$logger->info('hello', ['trace_id' => 'abc']);
$logger->warning('warn', ['count' => '2']);
$logger->log('notice', 'custom', ['mode' => 'psr3']);

$logger->info(new class {
    public function __toString(): string { return 'stringable-message'; }
}, [
    'n' => 7,
    'obj' => new class {
        public function __toString(): string { return 'ctx-object'; }
    },
    'arr' => ['x' => 1],
]);

try {
    $logger->log('nope', 'bad-level', []);
    echo "invalid-level-missed\n";
} catch (\InvalidArgumentException $e) {
    echo "invalid-level-caught\n";
}

echo "called\n";
?>
--EXPECTF--
yes
has_interface
VSlim\Log\Logger
psr3-test
%A
invalid-level-caught
called
