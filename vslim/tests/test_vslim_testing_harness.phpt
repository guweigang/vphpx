--TEST--
VSlim testing harness provides container overrides and quick dispatch helpers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->get('/hello', function () use ($app): string {
    return (string) $app->config()->getString('testing.message', (string) $app->container()->get('message'));
});
$app->post('/echo', function (VSlim\Psr7\ServerRequest $request): string {
    return $request->getBody()->getContents();
});
$app->post('/json', function (VSlim\Psr7\ServerRequest $request): string {
    return $request->getBody()->getContents();
});

$test = $app->testing();
$handle = new ReflectionMethod($test, 'handle');
$request = $handle->getParameters()[0];
$handleRequest = new ReflectionMethod($test, 'handleRequest');
$body = $handleRequest->getParameters()[2];
if ($request->getName() !== 'request' || (string) $request->getType() !== 'Psr\Http\Message\ServerRequestInterface'
    || (string) $handle->getReturnType() !== 'Psr\Http\Message\ResponseInterface'
    || $handleRequest->getNumberOfRequiredParameters() !== 2 || $body->getName() !== 'body'
    || (string) $body->getType() !== 'string' || $body->getDefaultValue() !== '') {
    throw new RuntimeException('Unexpected testing harness signature');
}
$test->withService(value: 'from-test', id: 'message');
$test->withConfigText(text: "[testing]\nmessage = 'from-config'\n");

$hello = $test->get('/hello');
$echo = $test->post(body: 'payload', uri: '/echo');
$json = $test->postJson(payload: ['name' => 'codex'], uri: '/json');

$test->assertStatus($hello, 200);
$test->assertBodyContains($hello, 'from-config');

echo $test->responseBody($hello) . PHP_EOL;
echo $test->responseBody($echo) . PHP_EOL;
echo $test->responseBody($json) . PHP_EOL;
echo $test->responseJson($json)['name'] . PHP_EOL;

$psr = $test->handleRequest(uri: 'https://example.com/hello', method: 'GET');
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
