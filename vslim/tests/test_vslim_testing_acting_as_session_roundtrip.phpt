--TEST--
VSlim testing actingAs cookie round-trips through app session loader
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->loadConfigText(<<<'TOML'
[session]
cookie_name = "ks_session"
secret = "demo-secret"
TOML);

$test = $app->testing()->clearCookies()->actingAs('u-1');
$request = $test->request('GET', '/console');
$session = $app->session($request);

echo $session->get('auth.user_id', 'missing') . PHP_EOL;
?>
--EXPECT--
u-1
