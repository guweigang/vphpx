--TEST--
VSlim app logger uses config defaults
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$cfg = <<<'TOML'
[logging]
channel = 'cfg-app'
level = 'debug'
target = 'stdout'
TOML;

$app = new VSlim\App();
$app->loadConfigText($cfg);

$logger = $app->logger();
echo $logger->channel(), "\n";
echo $logger->level(), "\n";
echo $logger->outputTarget(), "\n";
echo ($app->psrLogger()->logger() === $logger ? 'same' : 'diff'), "\n";
?>
--EXPECT--
cfg-app
debug
stdout
same
