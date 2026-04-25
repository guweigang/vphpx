--TEST--
VSlim PSR-3 logger wrapper reuses its inner native logger across repeated access
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

$psr = new VSlim\Log\PsrLogger();
$inner1 = $psr->logger();
$inner2 = $psr->logger();

echo (spl_object_id($inner1) === spl_object_id($inner2) ? 'inner-stable' : 'inner-unstable') . PHP_EOL;

$external = (new VSlim\Log\Logger())
    ->setChannel('external')
    ->setLevel('debug');

$psr->setLogger($external);
$inner3 = $psr->logger();
$inner4 = $psr->logger();

echo (spl_object_id($external) === spl_object_id($inner3) ? 'external-same' : 'external-diff') . PHP_EOL;
echo (spl_object_id($inner3) === spl_object_id($inner4) ? 'external-stable' : 'external-unstable') . PHP_EOL;
echo $inner4->channel() . PHP_EOL;
echo $inner4->level() . PHP_EOL;
?>
--EXPECT--
inner-stable
external-same
external-stable
external
debug
