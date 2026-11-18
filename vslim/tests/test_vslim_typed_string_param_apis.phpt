--TEST--
VSlim typed string attributes preserve public API defaults, parameter names and omission
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
foreach ([
    [VSlim\App::class, 'errorResponse', 2, 'errorCode'],
    [VSlim\App::class, 'unauthorized', 0, 'message'],
    [VSlim\Psr7\Uri::class, '__construct', 0, 'defaultUri'],
    [VSlim\Psr7\Stream::class, '__construct', 0, 'defaultContent'],
    [VSlim\Psr7\Response::class, '__construct', 1, 'defaultReasonPhrase'],
    [VSlim\VHttpd\Request::class, 'inputOr', 1, 'defaultValue'],
    [VSlim\Session\Store::class, 'pullFlash', 1, 'defaultValue'],
    [VSlim\Testing\Harness::class, 'handleRequest', 2, 'body'],
    [VSlim\Database\Migrator::class, 'seed', 0, 'name'],
    [VSlim\Dev\PhpSignatureProbe::class, 'optionalTail', 1, 'suffix'],
] as [$class, $name, $position, $expectedName]) {
    $method = new ReflectionMethod($class, $name);
    $param = $method->getParameters()[$position];
    echo $name, '|', (int) ($param->getName() === $expectedName), '|', $param->getType(),
        '|', $param->getDefaultValue(), '|', $method->getNumberOfRequiredParameters(), PHP_EOL;
}

$response = new VSlim\Psr7\Response(defaultReasonPhrase: 'Custom');
echo 'response|', $response->getStatusCode(), '|', $response->getReasonPhrase(), '|',
    $response->withStatus(defaultReasonPhrase: null, code: 203)->getStatusCode(), PHP_EOL;
$uri = new VSlim\Psr7\Uri(defaultUri: 'https://example.test/path');
echo 'uri|', (string) new VSlim\Psr7\Uri(), '|', $uri->getPath(), '|',
    $uri->withUserInfo(defaultPassword: null, user: 'guest')->getUserInfo(), PHP_EOL;
echo 'stream|', (string) new VSlim\Psr7\Stream(), '|',
    (string) new VSlim\Psr7\Stream(defaultContent: 'contents'), PHP_EOL;

$request = new VSlim\VHttpd\Request('GET', '/', '');
echo 'input|', $request->inputOr(key: 'missing'), '|',
    $request->inputOr(defaultValue: 'fallback', key: 'missing'), PHP_EOL;
$session = new VSlim\Session\Store();
echo 'session|', $session->getFlash(key: 'missing'), '|',
    $session->pullFlash(defaultValue: 'fallback', key: 'missing'), PHP_EOL;
$app = new VSlim\App();
echo 'error|', $app->unauthorized()->getStatusCode(), '|',
    $app->unauthorized(message: 'Custom')->getStatusCode(), PHP_EOL;
?>
--EXPECT--
errorResponse|1|string||2
unauthorized|1|string|Unauthorized|0
__construct|1|string||0
__construct|1|string||0
__construct|1|string||0
inputOr|1|string||1
pullFlash|1|string||1
handleRequest|1|string||2
seed|1|string||0
optionalTail|1|string||1
response|200|Custom|203
uri||/path|guest
stream||contents
input||fallback
session||fallback
error|401|401
