--TEST--
VSlim testing harness provides container overrides and quick dispatch helpers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->get('/hello', function () use ($app): string {
    return (string) $app->config()->get_string('testing.message', (string) $app->container()->get('message'));
});
$app->post('/echo', function (VSlim\Psr7\ServerRequest $request): string {
    return $request->getBody()->getContents();
});
$app->post('/json', function (VSlim\Psr7\ServerRequest $request): string {
    return $request->getBody()->getContents();
});

$test = $app->testing();
$test->withService('message', 'from-test');
$test->withConfigText("[testing]\nmessage = 'from-config'\n");

$hello = $test->get('/hello');
$echo = $test->post('/echo', 'payload');
$json = $test->postJson('/json', ['name' => 'codex']);

$test->assertStatus($hello, 200);
$test->assertBodyContains($hello, 'from-config');

echo $test->responseBody($hello) . PHP_EOL;
echo $test->responseBody($echo) . PHP_EOL;
echo $test->responseBody($json) . PHP_EOL;
echo $test->responseJson($json)['name'] . PHP_EOL;

$psr = $test->handleRequest('GET', 'https://example.com/hello');
$test->assertStatus($psr, 200);
echo $psr->getStatusCode() . PHP_EOL;
echo $psr->getBody()->getContents() . PHP_EOL;
?>
--EXPECT--
from-config
payload
{"name":"codex"}
codex
200
from-config
