--TEST--
VSlim testing harness manages session cookies and auth helpers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();

$app->get('/session', function (VSlim\Psr7\ServerRequest $request) use ($app): string {
    return $app->session($request)->get('name', 'guest');
});

$app->post('/session', function (VSlim\Psr7\ServerRequest $request) use ($app): VSlim\VHttpd\Response {
    $session = $app->session($request);
    $session->set('name', 'codex');
    $response = new VSlim\VHttpd\Response(200, 'saved', 'text/plain; charset=utf-8');
    $session->commit($response);
    return $response;
});

$app->get('/me', function (VSlim\Psr7\ServerRequest $request) use ($app): string {
    return $app->authId($request);
});

$test = $app->testing();

echo $test->responseBody($test->get('/session')) . PHP_EOL;

$test->withSession(['name' => 'alice']);
echo $test->responseBody($test->get('/session')) . PHP_EOL;

$test->clearCookies();
$test->post('/session');
echo $test->responseBody($test->get('/session')) . PHP_EOL;

$test->clearCookies()->actingAs('42');
echo $test->responseBody($test->get('/me')) . PHP_EOL;
echo array_key_exists('vslim_session', $test->cookies()) ? 'cookie' : 'missing', PHP_EOL;
?>
--EXPECT--
guest
alice
codex
42
cookie
