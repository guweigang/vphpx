--TEST--
VSlim App bootstrapDir can assemble provider module route and view conventions from app directories
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = __DIR__ . '/fixtures/vslim_bootstrap_app_dirs';

$app = new VSlim\App();
$app->bootstrapDir($root);

echo $app->dispatch('GET', '/home')->body . PHP_EOL;
$module = $app->dispatch('GET', '/module/ping');
echo $module->body . '|' . $module->header('x-app-http-middleware') . PHP_EOL;
echo $app->dispatch('GET', '/controller/home')->body . PHP_EOL;
echo $app->dispatch('GET', '/controller/bound')->body . PHP_EOL;
echo $app->urlFor('appdir.home', []) . PHP_EOL;
echo $app->viewBasePath() . PHP_EOL;
echo $app->providerCount() . '|' . $app->moduleCount() . '|' . ($app->booted() ? 'yes' : 'no') . PHP_EOL;
?>
--EXPECTF--
home|app-dir-demo|provider-loaded|yes
module|module-registered|loaded
controller|yes|/app-dir/home
bound-controller|bound-service|yes
/app-dir/home
%s/tests/fixtures/vslim_bootstrap_app_dirs/resources/views
1|1|yes
