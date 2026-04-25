--TEST--
VSlim logger supports PHP-side local diagnostics and app binding
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$logFile = sys_get_temp_dir() . '/vslim_logger_' . getmypid() . '.log';
@unlink($logFile);

$logger = new VSlim\Log\Logger();
echo get_class($logger) . PHP_EOL;
echo $logger->level() . PHP_EOL;
echo VSlim\Log\Logger::debugLevel() . PHP_EOL;
echo VSlim\Log\Level::DEBUG . PHP_EOL;
echo VSlim\Log\Level::debug() . PHP_EOL;
echo $logger->outputTarget() . PHP_EOL;

$logger
    ->setLevel(VSlim\Log\Level::DEBUG)
    ->setChannel('diag')
    ->withContext('worker', 'php')
    ->setOutputFile($logFile);

echo $logger->level() . '|' . $logger->channel() . PHP_EOL;
echo $logger->outputTarget() . PHP_EOL;

$logger->debugContext('hello log', [
    'trace' => 't-1',
    'path' => '/ping',
]);

$stdoutLogger = (new VSlim\Log\Logger())
    ->useStdout()
    ->setOutputFile($logFile);
echo $stdoutLogger->outputTarget() . PHP_EOL;

$app = new VSlim\App();
echo ($app->hasLogger() ? 'has' : 'no') . PHP_EOL;
$app->setLogger($logger);
echo ($app->hasLogger() ? 'has' : 'no') . PHP_EOL;
echo $app->logger()->channel() . PHP_EOL;

clearstatcache();
$body = file_get_contents($logFile);
echo (str_contains($body, '[DEBUG]') ? 'debug-tag' : 'debug-miss') . PHP_EOL;
echo (str_contains($body, '[diag] hello log') ? 'message-ok' : 'message-miss') . PHP_EOL;
echo (str_contains($body, 'path=/ping') ? 'path-ok' : 'path-miss') . PHP_EOL;
echo (str_contains($body, 'trace=t-1') ? 'trace-ok' : 'trace-miss') . PHP_EOL;
echo (str_contains($body, 'worker=php') ? 'worker-ok' : 'worker-miss') . PHP_EOL;

@unlink($logFile);
?>
--EXPECTF--
VSlim\Log\Logger
info
debug
debug
debug
stderr
debug|diag
stderr+file
%s[diag] hello log path=/ping trace=t-1 worker=php
stdout+file
no
has
diag
debug-tag
message-ok
path-ok
trace-ok
worker-ok
