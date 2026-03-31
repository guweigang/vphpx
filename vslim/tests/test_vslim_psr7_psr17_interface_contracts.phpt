--TEST--
VSlim PSR-7 and PSR-17 classes satisfy fuller PSR interface contracts
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Http\\Message\\ServerRequestInterface')) {
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
    public function withUri(UriInterface $uri, $preserveHost = false);
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

interface ResponseFactoryInterface
{
    public function createResponse($code = 200, $reasonPhrase = '');
}

interface RequestFactoryInterface
{
    public function createRequest($method, $uri);
}

interface ServerRequestFactoryInterface
{
    public function createServerRequest($method, $uri, array $serverParams = []);
}

interface StreamFactoryInterface
{
    public function createStream($content = '');
    public function createStreamFromFile($filename, $mode = 'r');
    public function createStreamFromResource($resource);
}

interface UploadedFileFactoryInterface
{
    public function createUploadedFile(StreamInterface $stream, $size = null, $error = \UPLOAD_ERR_OK, $clientFilename = null, $clientMediaType = null);
}

interface UriFactoryInterface
{
    public function createUri($uri = '');
}
PHP);
}

$stream = new VSlim\Psr7\Stream('hello');
$uri = new VSlim\Psr7\Uri('https://demo.local/path?x=1');
$request = new VSlim\Psr7\Request();
$serverRequest = (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('GET', '/');
$response = new VSlim\Psr7\Response();
$uploadedFile = new VSlim\Psr7\UploadedFile($stream, 5, UPLOAD_ERR_OK, 'demo.txt', 'text/plain');
$responseFactory = new VSlim\Psr17\ResponseFactory();
$requestFactory = new VSlim\Psr17\RequestFactory();
$serverRequestFactory = new VSlim\Psr17\ServerRequestFactory();
$streamFactory = new VSlim\Psr17\StreamFactory();
$uploadedFileFactory = new VSlim\Psr17\UploadedFileFactory();
$uriFactory = new VSlim\Psr17\UriFactory();

var_dump($stream instanceof Psr\Http\Message\StreamInterface);
var_dump($uri instanceof Psr\Http\Message\UriInterface);
var_dump($request instanceof Psr\Http\Message\RequestInterface);
var_dump($request instanceof Psr\Http\Message\MessageInterface);
var_dump($serverRequest instanceof Psr\Http\Message\ServerRequestInterface);
var_dump($serverRequest instanceof Psr\Http\Message\RequestInterface);
var_dump($serverRequest instanceof Psr\Http\Message\MessageInterface);
var_dump($response instanceof Psr\Http\Message\ResponseInterface);
var_dump($response instanceof Psr\Http\Message\MessageInterface);
var_dump($uploadedFile instanceof Psr\Http\Message\UploadedFileInterface);
var_dump($responseFactory instanceof Psr\Http\Message\ResponseFactoryInterface);
var_dump($requestFactory instanceof Psr\Http\Message\RequestFactoryInterface);
var_dump($serverRequestFactory instanceof Psr\Http\Message\ServerRequestFactoryInterface);
var_dump($streamFactory instanceof Psr\Http\Message\StreamFactoryInterface);
var_dump($uploadedFileFactory instanceof Psr\Http\Message\UploadedFileFactoryInterface);
var_dump($uriFactory instanceof Psr\Http\Message\UriFactoryInterface);

$implements = class_implements(VSlim\Psr7\ServerRequest::class);
var_dump(isset($implements['Psr\\Http\\Message\\ServerRequestInterface']));
var_dump(isset($implements['Psr\\Http\\Message\\RequestInterface']));
var_dump(isset($implements['Psr\\Http\\Message\\MessageInterface']));
?>
--EXPECT--
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
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
