--TEST--
VSlim PSR-7 Request and ServerRequest withUri expose their boolean option and honor named calls and defaults
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$uri = new VSlim\Psr7\Uri('https://new.example/path');
foreach ([VSlim\Psr7\Request::class, VSlim\Psr7\ServerRequest::class] as $requestClass) {
    echo $requestClass, "\n";
    $method = new ReflectionMethod($requestClass, 'withUri');
    [$uriParam, $preserveHost] = $method->getParameters();
    echo $method->getReturnType(), "\n";
    var_dump($method->getNumberOfRequiredParameters());
    var_dump($uriParam->getName(), (string) $uriParam->getType());
    var_dump($preserveHost->getName(), (string) $preserveHost->getType());
    var_dump($preserveHost->isOptional(), $preserveHost->getDefaultValue());

    $request = (new $requestClass())->withHeader('Host', 'original.example');
    $named = $request->withUri(preserveHost: true, uri: $uri);
    $omitted = $request->withUri($uri);
    $currentBody = $request->getBody();
    $currentUri = $omitted->getUri();
    var_dump($currentBody === $request->getBody(), $currentUri === $omitted->getUri(), $omitted === $request);
    echo $named->getHeaderLine('Host'), ' ', $named->getUri(), "\n";
    echo $omitted->getHeaderLine('Host'), ' ', $omitted->getUri(), "\n";
}
?>
--EXPECT--
VSlim\Psr7\Request
Psr\Http\Message\RequestInterface
int(1)
string(3) "uri"
string(29) "Psr\Http\Message\UriInterface"
string(12) "preserveHost"
string(4) "bool"
bool(true)
bool(false)
bool(true)
bool(true)
bool(false)
original.example https://new.example/path
new.example https://new.example/path
VSlim\Psr7\ServerRequest
Psr\Http\Message\ServerRequestInterface
int(1)
string(3) "uri"
string(29) "Psr\Http\Message\UriInterface"
string(12) "preserveHost"
string(4) "bool"
bool(true)
bool(false)
bool(true)
bool(true)
bool(false)
original.example https://new.example/path
new.example https://new.example/path
