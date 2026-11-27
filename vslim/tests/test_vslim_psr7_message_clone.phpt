--TEST--
VSlim PSR-7 messages support PHP clone with independent metadata and shared streams
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
use VSlim\Psr7\Request;
use VSlim\Psr7\Response;
use VSlim\Psr7\ServerRequest;
use VSlim\Psr7\Stream;

if (!interface_exists(Psr\Http\Message\StreamInterface::class)) {
    eval('namespace Psr\Http\Message; interface StreamInterface {}');
}

foreach ([new Request(), new Response(), new ServerRequest()] as $message) {
    $message = $message->withHeader('X-Copy', 'source')->withProtocolVersion('2.0');
    if (!(new ReflectionObject($message))->isCloneable()) {
        throw new RuntimeException('The PSR-7 message is not cloneable');
    }
    // Clone before either message has exposed its native body to PHP.
    $copy = clone $message;
    $body = $message->getBody();
    if ($copy === $message || $copy::class !== $message::class || $copy->getBody() !== $body
        || $copy->getHeaders() !== $message->getHeaders() || $copy->getProtocolVersion() !== '2.0') {
        throw new RuntimeException('A native clone lost metadata or created a separate body');
    }
    $body->write('shared');
    unset($message, $body);
    gc_collect_cycles();
    $copy->getBody()->rewind();
    if ($copy->getBody()->getContents() !== 'shared'
        || $copy->withHeader('X-Copy', 'changed')->getHeaderLine('X-Copy') !== 'changed'
        || $copy->getHeaderLine('X-Copy') !== 'source') {
        throw new RuntimeException('The clone lost its stream or shared mutable headers');
    }
    try {
        serialize($copy);
        throw new LogicException('Stream-backed messages became serializable');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Serialization of')) {
            throw $error;
        }
    }
}

$server = (new ServerRequest())->withMethod('POST')->withRequestTarget('/items')
    ->withCookieParams(['sid' => 'token'])->withQueryParams(['page' => 2])
    ->withParsedBody(['form' => 'data'])->withAttribute('principal', (object) ['id' => 1]);
$copy = clone $server;
$copy->method = 'PUT';
if ($server->getMethod() !== 'POST' || $copy->getMethod() !== 'PUT'
    || $copy->getRequestTarget() !== '/items'
    || $copy->getServerParams() !== $server->getServerParams()
    || $copy->getCookieParams() !== ['sid' => 'token']
    || $copy->getQueryParams() !== ['page' => 2]
    || $copy->getParsedBody() !== ['form' => 'data']
    || $copy->getAttribute('principal') !== $server->getAttribute('principal')
    || $copy->withoutAttribute('principal')->getAttribute('principal') !== null
    || $server->getAttribute('principal')->id !== 1) {
    throw new RuntimeException('The server request clone lost or shared its mutable metadata');
}

$request = new Request();
$method =& $request->method;
$method = 'PATCH';
$copy = clone $request;
if ($copy->getMethod() !== 'PATCH') {
    throw new RuntimeException('The clone missed the PHP reference value');
}
$copy->method = 'HEAD';
if ($method !== 'HEAD' || $request->getMethod() !== 'HEAD' || $copy->getMethod() !== 'HEAD') {
    throw new RuntimeException('The clone lost a PHP reference binding');
}
unset($method);

class HookedPsrResponse extends Response
{
    public ?object $bodyAtClone = null;

    public function __clone(): void
    {
        $this->bodyAtClone = $this->getBody();
    }
}
$response = new HookedPsrResponse(200);
$copy = clone $response;
$copy->status = 201;
if (!$copy instanceof HookedPsrResponse || $copy->bodyAtClone !== $response->getBody()
    || $response->getStatusCode() !== 200 || $copy->getStatusCode() !== 201) {
    throw new RuntimeException('The PHP clone hook ran before the V payload was initialized');
}
if (PHP_VERSION_ID >= 80500) {
    $cloneWith = 'clone';
    $updated = $cloneWith($response, ['status' => 202]);
    if ($updated->getStatusCode() !== 202 || $response->getStatusCode() !== 200
        || $updated->getBody() !== $response->getBody()) {
        throw new RuntimeException('Clone-with changed the original response or detached the shared stream');
    }
}

$probe = new VSlim\Dev\CloneResponseProbe();
$probe->status = 207;
$probe->label = 'source';
$probe->getBody()->write('subclass');
$copy = clone $probe;
$copy->status = 202;
$copy->label = 'clone';
if ($copy::class !== $probe::class
    || $probe->getStatusCode() !== 207 || $copy->getStatusCode() !== 202
    || $probe->label !== 'source' || $copy->label !== 'clone'
    || $copy->getBody() !== $probe->getBody()) {
    throw new RuntimeException('The generated descendant did not clone its V response and label separately');
}
if (PHP_VERSION_ID >= 80500) {
    $updated = $cloneWith($probe, ['status' => 208, 'label' => 'updated']);
    if ($updated->getStatusCode() !== 208 || $updated->label !== 'updated'
        || $probe->getStatusCode() !== 207 || $probe->label !== 'source'
        || $updated->getBody() !== $probe->getBody()) {
        throw new RuntimeException('Clone-with did not update both payload layers of a generated descendant');
    }
}

class CloneCycleStream extends Stream implements Psr\Http\Message\StreamInterface
{
    public ?object $message = null;
}
$stream = new CloneCycleStream('custom');
$original = (new Response())->withBody($stream);
$copy = clone $original;
if ($copy->getBody() !== $stream) {
    throw new RuntimeException('The native clone replaced an explicitly supplied stream');
}
$stream->message = $copy;
$refs = [WeakReference::create($stream), WeakReference::create($copy)];
unset($original, $copy, $stream);
gc_collect_cycles();
if ($refs[0]->get() !== null || $refs[1]->get() !== null) {
    throw new RuntimeException('The cloned body was not installed in Zend-owned state');
}

echo "message clone ok\n";
?>
--EXPECT--
message clone ok
