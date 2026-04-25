--TEST--
VSlim auth session guard can login logout and persist through session cookie
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->loadConfigText(<<<'TOML'
[app]
key = "auth-secret"

[session]
cookie = "auth_sid"

[auth]
session_key = "auth.uid"
TOML);

$request = new VSlim\VHttpd\Request('GET', '/', '');
$guard = $app->auth($request);
echo ($guard->guest() ? 'guest_yes' : 'guest_no') . PHP_EOL;
$guard->login('42');

$response = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
$guard->store()->commit($response);
$cookieValue = explode(';', $response->cookieHeader(), 2)[0];
$cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

$request2 = new VSlim\VHttpd\Request('GET', '/', '');
$request2->setCookies(['auth_sid' => $cookieValue]);
$guard2 = $app->auth($request2);
echo ($guard2->check() ? 'auth_yes' : 'auth_no') . PHP_EOL;
echo $guard2->id() . PHP_EOL;

$guard2->logout();
$response2 = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
$guard2->store()->commit($response2);
$cookieValue2 = explode(';', $response2->cookieHeader(), 2)[0];
$cookieValue2 = explode('=', $cookieValue2, 2)[1] ?? '';

$request3 = new VSlim\VHttpd\Request('GET', '/', '');
$request3->setCookies(['auth_sid' => $cookieValue2]);
$guard3 = $app->auth($request3);
echo ($guard3->guest() ? 'guest_yes' : 'guest_no') . PHP_EOL;
?>
--EXPECT--
guest_yes
auth_yes
42
guest_yes
