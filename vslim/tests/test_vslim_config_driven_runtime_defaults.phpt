--TEST--
VSlim app reads view cache and request limits from config
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->load_config_text(<<<'TOML'
[view]
cache = true

[http]
max_body_bytes = 4
TOML);

echo ($app->view_cache_enabled() ? 'cache-on' : 'cache-off') . PHP_EOL;

$app->post('/x', fn ($req) => 'ok');
$oversized = new VSlim\Vhttpd\Request('POST', '/x', '12345');
$oversized->set_headers(['content-type' => 'application/x-www-form-urlencoded']);
$res = $app->dispatch_request($oversized);
echo $res->status . PHP_EOL;
echo $res->body . PHP_EOL;
?>
--EXPECT--
cache-on
413
Payload Too Large
