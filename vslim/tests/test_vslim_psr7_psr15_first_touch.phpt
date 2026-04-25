--TEST--
VSlim PSR-7 PSR-15 and PSR-17 bindings support first-touch metadata queries
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
if (extension_loaded('psr')) {
    echo "skip psr extension already loaded; runtime autoload binding needs a clean environment";
    return;
}
?>
--FILE--
<?php
spl_autoload_register(function (string $class): void {
    if (str_starts_with($class, 'Psr\\Http\\Message\\')) {
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

interface RequestInterface extends MessageInterface
{
    public function getRequestTarget();
    public function withRequestTarget($requestTarget);
    public function getMethod();
    public function withMethod($method);
    public function getUri();
    public function withUri(UriInterface $uri, bool $preserveHost = false);
}

interface ServerRequestInterface extends RequestInterface
{
    public function getServerParams();
    public function getCookieParams();
    public function withCookieParams(array $cookies);
    public function getQueryParams();
    public function withQueryParams(array $query);
    public function getUploadedFiles();
    public function withUploadedFiles(array $uploadedFiles);
    public function getParsedBody();
    public function withParsedBody($data);
    public function getAttributes();
    public function getAttribute($name, $default = null);
    public function withAttribute($name, $value);
    public function withoutAttribute($name);
}

interface ResponseInterface extends MessageInterface
{
    public function getStatusCode();
    public function withStatus($code, $reasonPhrase = '');
    public function getReasonPhrase();
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

interface UploadedFileInterface
{
    public function getStream();
    public function moveTo($targetPath);
    public function getSize();
    public function getError();
    public function getClientFilename();
    public function getClientMediaType();
}

interface ResponseFactoryInterface { public function createResponse($code = 200, $reasonPhrase = ''); }
interface RequestFactoryInterface { public function createRequest($method, $uri); }
interface ServerRequestFactoryInterface { public function createServerRequest($method, $uri, array $serverParams = []); }
interface StreamFactoryInterface { public function createStream($content = ''); public function createStreamFromFile($filename, $mode = 'r'); public function createStreamFromResource($resource); }
interface UploadedFileFactoryInterface { public function createUploadedFile(StreamInterface $stream, $size = null, $error = \UPLOAD_ERR_OK, $clientFilename = null, $clientMediaType = null); }
interface UriFactoryInterface { public function createUri($uri = ''); }
PHP);
    }

    if (str_starts_with($class, 'Psr\\Http\\Server\\')) {
        eval(<<<'PHP'
namespace Psr\Http\Server;

interface RequestHandlerInterface
{
    public function handle(\Psr\Http\Message\ServerRequestInterface $request): \Psr\Http\Message\ResponseInterface;
}

interface MiddlewareInterface
{
    public function process(\Psr\Http\Message\ServerRequestInterface $request, RequestHandlerInterface $handler): \Psr\Http\Message\ResponseInterface;
}
PHP);
    }
});

$serverRequestIface = 'Psr\\Http\\Message\\ServerRequestInterface';
$messageIface = 'Psr\\Http\\Message\\MessageInterface';
$responseFactoryIface = 'Psr\\Http\\Message\\ResponseFactoryInterface';
$streamFactoryIface = 'Psr\\Http\\Message\\StreamFactoryInterface';
$requestHandlerIface = 'Psr\\Http\\Server\\RequestHandlerInterface';
$responseIface = 'Psr\\Http\\Message\\ResponseInterface';
$streamIface = 'Psr\\Http\\Message\\StreamInterface';
$uriIface = 'Psr\\Http\\Message\\UriInterface';
$requestIface = 'Psr\\Http\\Message\\RequestInterface';

$typeName = static function (?ReflectionType $type): ?string {
    if ($type === null) {
        return null;
    }
    if ($type instanceof ReflectionNamedType) {
        return $type->getName();
    }
    return get_class($type);
};

var_dump(interface_exists($serverRequestIface, false));
var_dump(interface_exists($requestHandlerIface, false));

$implements = class_implements(VSlim\Psr7\ServerRequest::class);
var_dump(isset($implements[$serverRequestIface]));
var_dump(isset($implements[$messageIface]));
var_dump(is_a(VSlim\Psr17\ResponseFactory::class, $responseFactoryIface, true));
var_dump(is_a(VSlim\Psr17\StreamFactory::class, $streamFactoryIface, true));
var_dump(is_a(VSlim\App::class, $requestHandlerIface, true));
var_dump(is_a(VSlim\Psr15\NextHandler::class, $requestHandlerIface, true));
var_dump(is_a(VSlim\Psr15\ContinueHandler::class, $requestHandlerIface, true));
var_dump((new VSlim\App()) instanceof Psr\Http\Server\RequestHandlerInterface);
var_dump((new VSlim\Psr15\NextHandler()) instanceof Psr\Http\Server\RequestHandlerInterface);
var_dump((new VSlim\Psr15\ContinueHandler()) instanceof Psr\Http\Server\RequestHandlerInterface);
var_dump((new VSlim\Psr7\ServerRequest()) instanceof Psr\Http\Message\ServerRequestInterface);
var_dump($typeName((new ReflectionMethod(VSlim\App::class, 'handle'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr15\NextHandler::class, 'handle'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr15\NextHandler::class, 'handle'))->getParameters()[0]->getType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr15\ContinueHandler::class, 'handle'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\Response::class, 'getBody'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\Response::class, 'withStatus'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\Request::class, 'getUri'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\Request::class, 'withUri'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\ServerRequest::class, 'withAttribute'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr7\Uri::class, 'withPath'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr17\RequestFactory::class, 'createRequest'))->getReturnType()));
var_dump($typeName((new ReflectionMethod(VSlim\Psr17\ResponseFactory::class, 'createResponse'))->getReturnType()));
?>
--EXPECT--
bool(false)
bool(false)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
string(34) "Psr\Http\Message\ResponseInterface"
string(34) "Psr\Http\Message\ResponseInterface"
string(39) "Psr\Http\Message\ServerRequestInterface"
string(34) "Psr\Http\Message\ResponseInterface"
string(32) "Psr\Http\Message\StreamInterface"
string(34) "Psr\Http\Message\ResponseInterface"
string(29) "Psr\Http\Message\UriInterface"
string(33) "Psr\Http\Message\RequestInterface"
string(39) "Psr\Http\Message\ServerRequestInterface"
string(29) "Psr\Http\Message\UriInterface"
string(33) "Psr\Http\Message\RequestInterface"
string(34) "Psr\Http\Message\ResponseInterface"
