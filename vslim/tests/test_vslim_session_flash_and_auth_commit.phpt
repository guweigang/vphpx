--TEST--
VSlim session flash helpers and app login/logout helpers support common redirect flows
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->load_config_text(<<<'TOML'
[app]
key = "auth-secret"

[session]
cookie = "sid"
TOML);

$requestFactory = new VSlim\Psr17\ServerRequestFactory();
$request = $requestFactory->createServerRequest('GET', 'https://example.com/');

$session = $app->session($request);
$session->flash('notice', 'saved');
echo ($session->hasFlash('notice') ? 'flash_yes' : 'flash_no') . PHP_EOL;
echo $session->getFlash('notice') . PHP_EOL;
echo $session->pullFlash('notice') . PHP_EOL;
echo ($session->hasFlash('notice') ? 'flash_yes' : 'flash_no') . PHP_EOL;

$loginResponse = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
echo ($app->login($request, $loginResponse, '501') ? 'login_ok' : 'login_fail') . PHP_EOL;
$cookieValue = explode(';', $loginResponse->cookieHeader(), 2)[0];
$cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

$authedRequest = $requestFactory
    ->createServerRequest('GET', 'https://example.com/')
    ->withCookieParams(['sid' => $cookieValue]);
echo ($app->authCheck($authedRequest) ? 'auth_yes' : 'auth_no') . PHP_EOL;
echo $app->authId($authedRequest) . PHP_EOL;

$logoutResponse = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
echo ($app->logout($authedRequest, $logoutResponse) ? 'logout_ok' : 'logout_fail') . PHP_EOL;
$clearedCookie = $logoutResponse->cookieHeader();
echo (str_contains($clearedCookie, 'Max-Age=0') ? 'cleared_yes' : 'cleared_no') . PHP_EOL;
?>
--EXPECT--
flash_yes
saved
saved
flash_no
login_ok
auth_yes
501
logout_ok
cleared_yes
