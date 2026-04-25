--TEST--
VSlim app reads view cache and request limits from config
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->loadConfigText(<<<'TOML'
[view]
cache = true

[http]
max_body_bytes = 4
TOML);

echo ($app->viewCacheEnabled() ? 'cache-on' : 'cache-off') . PHP_EOL;

$app->post('/x', fn ($req) => 'ok');
$oversized = new VSlim\Vhttpd\Request('POST', '/x', '12345');
$oversized->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
$res = $app->dispatchRequest($oversized);
echo $res->status . PHP_EOL;
echo $res->body . PHP_EOL;
?>
--EXPECT--
cache-on
413
Payload Too Large
