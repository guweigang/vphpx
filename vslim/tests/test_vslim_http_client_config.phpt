--TEST--
VSlim app http client uses config defaults
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$cfg = <<<'TOML'
[http.client]
timeout_seconds = 12
TOML;

$app = new VSlim\App();
$app->load_config_text($cfg);

$client = $app->httpClient();
echo $client->timeout_seconds_value(), "\n";
echo ($app->container()->get('http_client') === $client ? 'same' : 'diff'), "\n";
?>
--EXPECT--
12
same
