--TEST--
VSlim framework getters reuse host-owned objects across repeated access
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();

$container1 = $app->container();
$container2 = $app->container();
$clock1 = $app->clock();
$clock2 = $app->clock();
$config1 = $app->config();
$config2 = $app->config();
$logger1 = $app->logger();
$logger2 = $app->logger();
$mcp1 = $app->mcp();
$mcp2 = $app->mcp();

echo (spl_object_id($container1) === spl_object_id($container2) ? 'container-stable' : 'container-unstable') . PHP_EOL;
echo (spl_object_id($clock1) === spl_object_id($clock2) ? 'clock-stable' : 'clock-unstable') . PHP_EOL;
echo (spl_object_id($config1) === spl_object_id($config2) ? 'config-stable' : 'config-unstable') . PHP_EOL;
echo (spl_object_id($logger1) === spl_object_id($logger2) ? 'logger-stable' : 'logger-unstable') . PHP_EOL;
echo (spl_object_id($mcp1) === spl_object_id($mcp2) ? 'mcp-stable' : 'mcp-unstable') . PHP_EOL;

$app2 = new VSlim\App();
$userContainer = new VSlim\Container();
$userClock = new VSlim\Psr20\Clock();
$userConfig = new VSlim\Config();
$userLogger = new VSlim\Log\Logger();
$userMcp = new VSlim\Mcp\App();

$app2->set_container($userContainer);
$app2->setClock($userClock);
$app2->set_config($userConfig);
$app2->set_logger($userLogger);
$app2->set_mcp($userMcp);

echo (spl_object_id($userContainer) === spl_object_id($app2->container()) ? 'container-same' : 'container-diff') . PHP_EOL;
echo (spl_object_id($userClock) === spl_object_id($app2->clock()) ? 'clock-same' : 'clock-diff') . PHP_EOL;
echo (spl_object_id($userConfig) === spl_object_id($app2->config()) ? 'config-same' : 'config-diff') . PHP_EOL;
echo (spl_object_id($userLogger) === spl_object_id($app2->logger()) ? 'logger-same' : 'logger-diff') . PHP_EOL;
echo (spl_object_id($userMcp) === spl_object_id($app2->mcp()) ? 'mcp-same' : 'mcp-diff') . PHP_EOL;

$provider = new VSlim\Psr14\ListenerProvider();
$dispatcher = (new VSlim\Psr14\EventDispatcher())->setProvider($provider);
$provider1 = $dispatcher->provider();
$provider2 = $dispatcher->provider();

echo (spl_object_id($provider) === spl_object_id($provider1) ? 'provider-same' : 'provider-diff') . PHP_EOL;
echo (spl_object_id($provider1) === spl_object_id($provider2) ? 'provider-stable' : 'provider-unstable') . PHP_EOL;
?>
--EXPECT--
container-stable
clock-stable
config-stable
logger-stable
mcp-stable
container-same
clock-same
config-same
logger-same
mcp-same
provider-same
provider-stable
