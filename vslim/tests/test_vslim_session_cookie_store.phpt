--TEST--
VSlim session store can round-trip through request cookies and response headers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->loadConfigText(<<<'TOML'
[app]
key = "session-secret"

[session]
cookie = "sid"
ttl_seconds = 3600
same_site = "strict"
http_only = true
TOML);

$request = new VSlim\VHttpd\Request('GET', '/', '');
$session = $app->session(request: $request);
foreach (['get', 'pull', 'getFlash', 'pullFlash'] as $method) {
    $signature = new ReflectionMethod($session, $method);
    $parameters = $signature->getParameters();
    if ($signature->getNumberOfRequiredParameters() !== 1 || $parameters[0]->getName() !== 'key'
        || $parameters[1]->getName() !== 'defaultValue' || (string) $parameters[1]->getType() !== 'string'
        || $parameters[1]->getDefaultValue() !== '' || (string) $signature->getReturnType() !== 'string'
        || $session->$method(key: 'missing') !== ''
        || $session->$method(defaultValue: 'fallback', key: 'missing') !== 'fallback') {
        throw new RuntimeException("Unexpected signature or fallback for $method");
    }
}
$session->setHttpOnly(httpOnly: true)->setSameSite(sameSite: 'strict')->setTtlSeconds(ttlSeconds: 3600);
$session->set(value: 'neo', key: 'user');
$session->set('scope', 'matrix');
$session->set("scope\0nested", "left\0雪");

$response = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
$session->commit(response: $response);
$header = $response->cookieHeader();
echo (str_starts_with($header, 'sid=') ? 'cookie_yes' : 'cookie_no') . PHP_EOL;
echo (str_contains($header, 'HttpOnly') ? 'http_only_yes' : 'http_only_no') . PHP_EOL;
echo (str_contains($header, 'SameSite=Strict') ? 'same_site_yes' : 'same_site_no') . PHP_EOL;

$cookieValue = explode(';', $header, 2)[0];
$cookieValue = explode('=', $cookieValue, 2)[1] ?? '';

$request2 = new VSlim\VHttpd\Request('GET', '/', '');
$request2->setCookies(['sid' => $cookieValue]);
$session2 = $app->session($request2);
echo $session2->get('user') . PHP_EOL;
echo $session2->get('scope') . PHP_EOL;
echo ($session2->has('user') ? 'user_yes' : 'user_no') . PHP_EOL;
if (!$session2->has("scope\0nested") || $session2->get("scope\0nested") !== "left\0雪") {
    throw new RuntimeException('Session cookie round-trip truncated a string key or value');
}
?>
--EXPECT--
cookie_yes
http_only_yes
same_site_yes
neo
matrix
user_yes
