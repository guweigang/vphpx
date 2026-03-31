--TEST--
VSlim PSR-3 logger supports first-touch metadata queries and runtime binding
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
spl_autoload_register(function (string $class): void {
    if ($class === 'Psr\\Log\\LoggerInterface') {
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
});

$iface = 'Psr\\Log\\LoggerInterface';

var_dump(interface_exists($iface, false));

$implements = class_implements(VSlim\Log\PsrLogger::class);
var_dump(isset($implements[$iface]));
var_dump(is_a(VSlim\Log\PsrLogger::class, $iface, true));

$logger = new VSlim\Log\PsrLogger();
var_dump($logger instanceof Psr\Log\LoggerInterface);

try {
    $logger->log('bad-level', 'demo');
    echo "invalid-level-missed\n";
} catch (InvalidArgumentException $e) {
    echo "invalid-level-caught\n";
}
?>
--EXPECT--
bool(false)
bool(true)
bool(true)
bool(true)
invalid-level-caught
