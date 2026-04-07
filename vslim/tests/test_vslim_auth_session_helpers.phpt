--TEST--
VSlim app auth helpers and session pull reduce common auth and session boilerplate
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
echo ($app->authGuest($request) ? 'guest_yes' : 'guest_no') . PHP_EOL;
echo ($app->authCheck($request) ? 'check_yes' : 'check_no') . PHP_EOL;
echo ($app->authId($request) === '' ? 'id_empty' : 'id_set') . PHP_EOL;

$session = $app->session($request);
$session->set('notice', 'saved');
echo $session->pull('notice') . PHP_EOL;
echo ($session->has('notice') ? 'notice_yes' : 'notice_no') . PHP_EOL;

$guard = $app->auth($request);
$guard->login('99');
$response = new VSlim\Vhttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
$guard->store()->commit($response);
$cookieValue = explode(';', $response->cookie_header(), 2)[0];
$cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

$next = $requestFactory
    ->createServerRequest('GET', 'https://example.com/')
    ->withCookieParams(['sid' => $cookieValue]);
echo ($app->authCheck($next) ? 'check_yes' : 'check_no') . PHP_EOL;
echo $app->authId($next) . PHP_EOL;
?>
--EXPECT--
guest_yes
check_no
id_empty
saved
notice_no
check_yes
99
