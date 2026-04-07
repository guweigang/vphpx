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

echo $test->get('/hello')->body . PHP_EOL;
echo $test->post('/echo', 'payload')->body . PHP_EOL;
echo $test->postJson('/json', ['name' => 'codex'])->body . PHP_EOL;

$psr = $test->handleRequest('GET', 'https://example.com/hello');
echo $psr->getStatusCode() . PHP_EOL;
echo $psr->getBody()->getContents() . PHP_EOL;
?>
--EXPECT--
from-config
payload
{"name":"codex"}
200
from-config
