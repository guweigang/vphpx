--TEST--
VSlim builder exports PHP-only special signature types for reflection metadata
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if (!str_starts_with($class, 'Psr\\Http\\Message\\')) {
        return;
    }

    eval(<<<'PHP'
namespace Psr\Http\Message;

interface MessageInterface
{
    public function getProtocolVersion();
    public function withProtocolVersion($version);
    public function getHeaders();
    public function hasHeader($name);
    public function getHeader($name);
    public function getHeaderLine($name);
    public function withHeader($name, $value);
    public function withAddedHeader($name, $value);
    public function withoutHeader($name);
    public function getBody();
    public function withBody(StreamInterface $body);
}

interface StreamInterface
{
    public function __toString();
    public function close();
    public function detach();
    public function getSize();
    public function tell();
    public function eof();
    public function isSeekable();
    public function seek($offset, $whence = SEEK_SET);
    public function rewind();
    public function isWritable();
    public function write($string);
    public function isReadable();
    public function read($length);
    public function getContents();
    public function getMetadata($key = null);
}

interface UriInterface
{
    public function getScheme();
    public function getAuthority();
    public function getUserInfo();
    public function getHost();
    public function getPort();
    public function getPath();
    public function getQuery();
    public function getFragment();
    public function withScheme($scheme);
    public function withUserInfo($user, $password = null);
    public function withHost($host);
    public function withPort($port);
    public function withPath($path);
    public function withQuery($query);
    public function withFragment($fragment);
    public function __toString();
}

interface RequestInterface extends MessageInterface
{
    public function getRequestTarget();
    public function withRequestTarget($requestTarget);
    public function getMethod();
    public function withMethod($method);
    public function getUri();
    public function withUri(UriInterface $uri, bool $preserveHost = false);
}

interface ResponseInterface extends MessageInterface
{
    public function getStatusCode();
    public function withStatus($code, $reasonPhrase = '');
    public function getReasonPhrase();
}
PHP);
});

$probe = new VSlim\Dev\PhpSignatureProbe();

$describeType = static function (?ReflectionType $type): ?string {
    if ($type === null) {
        return null;
    }
    if ($type instanceof ReflectionNamedType) {
        return $type->getName();
    }
    if ($type instanceof ReflectionUnionType) {
        $names = array_map(
            static fn (ReflectionNamedType $named): string => $named->getName(),
            $type->getTypes(),
        );
        sort($names, SORT_STRING);
        return implode('|', $names);
    }
    return get_class($type);
};

$alwaysTrue = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'alwaysTrue');
$alwaysFalse = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'alwaysFalse');
$alwaysNull = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'alwaysNull');
$alwaysThrow = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'alwaysThrow');
$acceptTrue = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptTrue');
$acceptFalse = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptFalse');
$acceptNull = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptNull');
$acceptCallable = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptCallable');
$makePsrResponse = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'makePsrResponse');
$makeStaticPsrResponse = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'makeStaticPsrResponse');
$acceptPsrRequest = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptPsrRequest');
$acceptDateTimeInterface = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'acceptDateTimeInterface');
$optionalTail = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'optionalTail');
$responseCtor = new ReflectionMethod(VSlim\Psr7\Response::class, '__construct');
$createResponse = new ReflectionMethod(VSlim\Psr17\ResponseFactory::class, 'createResponse');
$requestWithUri = new ReflectionMethod(VSlim\Psr7\Request::class, 'withUri');
$serverRequestWithUri = new ReflectionMethod(VSlim\Psr7\ServerRequest::class, 'withUri');

var_dump($describeType($alwaysTrue->getReturnType()));
var_dump($describeType($alwaysFalse->getReturnType()));
var_dump($describeType($alwaysNull->getReturnType()));
var_dump($describeType($alwaysThrow->getReturnType()));
var_dump($describeType($acceptTrue->getParameters()[0]->getType()));
var_dump($describeType($acceptFalse->getParameters()[0]->getType()));
var_dump($describeType($acceptNull->getParameters()[0]->getType()));
var_dump($describeType($acceptCallable->getParameters()[0]->getType()));
var_dump($describeType($makePsrResponse->getReturnType()));
var_dump($describeType($makeStaticPsrResponse->getReturnType()));
var_dump($describeType($acceptPsrRequest->getParameters()[0]->getType()));
var_dump($describeType($acceptDateTimeInterface->getParameters()[0]->getType()));
var_dump($describeType($requestWithUri->getParameters()[1]->getType()));
var_dump($requestWithUri->getParameters()[1]->getName());
var_dump($requestWithUri->getParameters()[1]->getDefaultValue());
var_dump($describeType($serverRequestWithUri->getParameters()[1]->getType()));
var_dump($serverRequestWithUri->getParameters()[1]->getName());
var_dump($serverRequestWithUri->getParameters()[1]->getDefaultValue());
var_dump($optionalTail->getNumberOfRequiredParameters());
var_dump($responseCtor->getNumberOfRequiredParameters());
var_dump($createResponse->getNumberOfRequiredParameters());

var_dump($probe->alwaysTrue());
var_dump($probe->alwaysFalse());
var_dump($probe->alwaysNull());
var_dump($probe->acceptTrue(true));
var_dump($probe->acceptFalse(false));
var_dump($probe->acceptNull(null));
var_dump($probe->acceptCallable(static fn (): string => 'ok'));
var_dump($probe->makePsrResponse() instanceof VSlim\Psr7\Response);
var_dump(VSlim\Dev\PhpSignatureProbe::makeStaticPsrResponse() instanceof VSlim\Psr7\Response);
var_dump($probe->acceptPsrRequest(new VSlim\Psr7\Request()));
var_dump($probe->acceptDateTimeInterface(new DateTimeImmutable('2024-01-01T00:00:00+00:00')));
var_dump($probe->acceptDateTimeInterface(null));
var_dump($probe->optionalTail('head'));
var_dump($probe->optionalTail('head', 'tail'));
try {
    $probe->acceptTrue(false);
    echo "accept-true-missed\n";
} catch (TypeError $e) {
    echo "accept-true-caught\n";
}

try {
    $probe->acceptFalse(true);
    echo "accept-false-missed\n";
} catch (TypeError $e) {
    echo "accept-false-caught\n";
}

try {
    $probe->acceptNull('x');
    echo "accept-null-missed\n";
} catch (TypeError $e) {
    echo "accept-null-caught\n";
}

try {
    $probe->acceptCallable(new stdClass());
    echo "accept-callable-missed\n";
} catch (TypeError $e) {
    echo "accept-callable-caught\n";
}

try {
    $probe->acceptPsrRequest(new stdClass());
    echo "accept-psr-request-missed\n";
} catch (TypeError $e) {
    echo "accept-psr-request-caught\n";
}

try {
    $probe->acceptDateTimeInterface('x');
    echo "accept-datetime-missed\n";
} catch (TypeError $e) {
    echo "accept-datetime-caught\n";
}

try {
    $probe->alwaysThrow();
    echo "always-throw-missed\n";
} catch (RuntimeException $e) {
    echo "always-throw-caught\n";
}
?>
--EXPECT--
string(4) "true"
string(5) "false"
string(4) "null"
string(5) "never"
string(4) "true"
string(5) "false"
string(4) "null"
string(8) "callable"
string(34) "Psr\Http\Message\ResponseInterface"
string(34) "Psr\Http\Message\ResponseInterface"
string(33) "Psr\Http\Message\RequestInterface"
string(17) "DateTimeInterface"
string(4) "bool"
string(12) "preserveHost"
bool(false)
string(4) "bool"
string(12) "preserveHost"
bool(false)
int(1)
int(0)
int(0)
bool(true)
bool(false)
NULL
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
string(4) "head"
string(9) "head:tail"
accept-true-caught
accept-false-caught
accept-null-caught
accept-callable-caught
accept-psr-request-caught
accept-datetime-caught
always-throw-caught
