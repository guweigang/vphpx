--TEST--
VSlim App bootstrapDir assembles an app from convention files when bootstrap app file is absent
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = __DIR__ . '/fixtures/vslim_bootstrap_conventions';

$app = new VSlim\App();
$app->bootstrapDir($root);

echo $app->dispatch('GET', '/hello')->body . PHP_EOL;
echo $app->dispatch('GET', '/module')->body . PHP_EOL;
echo $app->dispatch('GET', '/ping')->body . PHP_EOL;
echo $app->url_for('convention.ping', []) . PHP_EOL;
echo $app->view_base_path() . PHP_EOL;
echo $app->assets_prefix() . '|' . ($app->view_cache_enabled() ? 'yes' : 'no') . '|' . ($app->error_response_json_enabled() ? 'yes' : 'no') . PHP_EOL;
echo $app->logger()->channel() . '|' . ($app->container()->get('logger') === $app->logger() ? 'logger-same' : 'logger-diff') . PHP_EOL;
echo $app->clock()->now()->format(DATE_ATOM) . '|' . ($app->cache()->clock() === $app->clock() ? 'clock-same' : 'clock-diff') . PHP_EOL;
echo $app->dispatch('GET', '/missing')->body . PHP_EOL;
echo $app->dispatch('GET', '/broken')->body . PHP_EOL;
echo $app->providerCount() . '|' . $app->moduleCount() . '|' . ($app->booted() ? 'yes' : 'no') . PHP_EOL;
?>
--EXPECTF--
hello|convention-app|provider-from-convention|yes|yes
module|yes
pong
/svc/ping
%s/tests/fixtures/vslim_bootstrap_conventions/views
/conv-assets|yes|yes
convention.app|logger-same
2024-01-01T00:00:00+00:00|clock-same
{"ok":false,"error":"missing-from-errors","path":"\/missing"}
{"ok":false,"error":"runtime-from-errors","status":500,"message":"container service not found","path":"\/broken"}
1|1|yes
