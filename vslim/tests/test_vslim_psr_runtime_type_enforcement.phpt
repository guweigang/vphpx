--TEST--
VSlim enforces PSR-facing runtime argument types on internal bridge methods
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
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

interface UploadedFileFactoryInterface
{
    public function createUploadedFile(StreamInterface $stream, ?int $size = null, int $error = \UPLOAD_ERR_OK, ?string $clientFilename = null, ?string $clientMediaType = null);
}
PHP);
}

if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
    eval(<<<'PHP'
namespace Psr\Http\Server;

interface RequestHandlerInterface
{
    public function handle(\Psr\Http\Message\ServerRequestInterface $request): \Psr\Http\Message\ResponseInterface;
}
PHP);
}

if (!interface_exists('Psr\\EventDispatcher\\ListenerProviderInterface')) {
    eval(<<<'PHP'
namespace Psr\EventDispatcher;

interface EventDispatcherInterface
{
    public function dispatch(object $event): object;
}

interface ListenerProviderInterface
{
    public function getListenersForEvent(object $event): iterable;
}

interface StoppableEventInterface
{
    public function isPropagationStopped(): bool;
}
PHP);
}

$stream = new VSlim\Psr7\Stream('demo');
$uri = new VSlim\Psr7\Uri('https://demo.local/items?trace=1');
$request = new VSlim\Psr7\Request();
$response = new VSlim\Psr7\Response();
$uploadedFileFactory = new VSlim\Psr17\UploadedFileFactory();
$serverRequest = (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('GET', '/');
$app = new VSlim\App();
$nextHandler = new VSlim\Psr15\NextHandler();
$continueHandler = new VSlim\Psr15\ContinueHandler();
$dispatcher = new VSlim\Psr14\EventDispatcher();
$provider = new VSlim\Psr14\ListenerProvider();

foreach ([
    [VSlim\Psr7\Request::class, 'withBody', 'body', Psr\Http\Message\StreamInterface::class],
    [VSlim\Psr7\ServerRequest::class, 'withBody', 'body', Psr\Http\Message\StreamInterface::class],
    [VSlim\Psr7\Response::class, 'withBody', 'body', Psr\Http\Message\StreamInterface::class],
    [VSlim\Psr17\UploadedFileFactory::class, 'createUploadedFile', 'stream', Psr\Http\Message\StreamInterface::class],
    [VSlim\Psr7Adapter::class, 'toVSlimResponse', 'response', Psr\Http\Message\ResponseInterface::class],
    [VSlim\Psr18\RequestException::class, 'attachRequest', 'request', Psr\Http\Message\RequestInterface::class],
    [VSlim\Psr18\NetworkException::class, 'attachRequest', 'request', Psr\Http\Message\RequestInterface::class],
    [VSlim\App::class, 'handle', 'request', Psr\Http\Message\ServerRequestInterface::class],
    [VSlim\Testing\Harness::class, 'handle', 'request', Psr\Http\Message\ServerRequestInterface::class],
    [VSlim\Psr15\NextHandler::class, 'handle', 'request', Psr\Http\Message\ServerRequestInterface::class],
    [VSlim\Psr15\ContinueHandler::class, 'handle', 'request', Psr\Http\Message\ServerRequestInterface::class],
] as [$class, $method, $name, $type]) {
    $parameter = (new ReflectionMethod($class, $method))->getParameters()[0];
    if ($parameter->getName() !== $name || (string) $parameter->getType() !== $type || $parameter->isOptional()) {
        throw new RuntimeException("Unexpected signature for $class::$method");
    }
}

foreach ([
    VSlim\Session\StartMiddleware::class,
    VSlim\Auth\RequireAuthMiddleware::class,
    VSlim\Auth\GuestMiddleware::class,
    VSlim\Auth\RequireAbilityMiddleware::class,
] as $class) {
    $method = new ReflectionMethod($class, 'process');
    [$requestParameter, $handlerParameter] = $method->getParameters();
    if ($method->getNumberOfRequiredParameters() !== 2
        || $requestParameter->getName() !== 'request'
        || (string) $requestParameter->getType() !== Psr\Http\Message\ServerRequestInterface::class
        || $handlerParameter->getName() !== 'handler'
        || (string) $handlerParameter->getType() !== Psr\Http\Server\RequestHandlerInterface::class) {
        throw new RuntimeException("Unexpected process signature for $class");
    }
    $middleware = new $class();
    foreach ([
        static fn () => $middleware->process(handler: $nextHandler, request: new stdClass()),
        static fn () => $middleware->process(handler: new stdClass(), request: $serverRequest),
    ] as $invoke) {
        try {
            $invoke();
            throw new RuntimeException("Invalid process parameter accepted by $class");
        } catch (TypeError) {
        }
    }
}

foreach ([$request, $serverRequest, $response] as $message) {
    if ((string) $message->withBody(body: $stream)->getBody() !== 'demo') {
        throw new RuntimeException('Named withBody lost the supplied stream');
    }
}

var_dump($response->withBody($stream) instanceof VSlim\Psr7\Response);
var_dump($request->withUri($uri) instanceof VSlim\Psr7\Request);
var_dump($uploadedFileFactory->createUploadedFile($stream) instanceof VSlim\Psr7\UploadedFile);
var_dump($app->handle($serverRequest) instanceof VSlim\Psr7\Response);
if (!$app->handle(request: $serverRequest) instanceof VSlim\Psr7\Response) {
    throw new RuntimeException('Named PSR-15 request did not produce a response');
}
var_dump($nextHandler->handle($serverRequest) instanceof VSlim\Psr7\Response);
var_dump($continueHandler->handle($serverRequest) instanceof VSlim\Psr7\Response);
var_dump($dispatcher->setProvider($provider) instanceof VSlim\Psr14\EventDispatcher);
$event = new stdClass();
var_dump($dispatcher->dispatch($event) === $event);

$cases = [
    'with-body' => static fn () => $response->withBody(new stdClass()),
    'with-uri' => static fn () => $request->withUri(new stdClass()),
    'uploaded-file' => static fn () => $uploadedFileFactory->createUploadedFile(new stdClass()),
    'response-adapter' => static fn () => VSlim\Psr7Adapter::toVSlimResponse(response: new stdClass()),
    'app-handle' => static fn () => $app->handle(new stdClass()),
    'next-handler-handle' => static fn () => $nextHandler->handle(new stdClass()),
    'continue-handler-handle' => static fn () => $continueHandler->handle(new stdClass()),
    'set-provider' => static fn () => $dispatcher->setProvider(new stdClass()),
    'dispatch' => static fn () => $dispatcher->dispatch('bad'),
];

foreach ($cases as $label => $call) {
    try {
        $call();
        echo $label, "-missed\n";
    } catch (TypeError $e) {
        echo $label, "-caught\n";
    }
}
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
with-body-caught
with-uri-caught
uploaded-file-caught
response-adapter-caught
app-handle-caught
next-handler-handle-caught
continue-handler-handle-caught
set-provider-caught
dispatch-caught
