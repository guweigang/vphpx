--TEST--
VSlim PSR-7 internal object getters borrow host-owned refs without breaking later access
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Http\\Message\\MessageInterface')) {
    eval(<<<'PHP'
namespace Psr\Http\Message;
interface StreamInterface { public function __toString(); }
interface UriInterface { public function __toString(); }
interface MessageInterface { public function getBody(); }
interface RequestInterface extends MessageInterface { public function getUri(); }
interface ServerRequestInterface extends RequestInterface {}
interface ResponseInterface extends MessageInterface {}
interface UploadedFileInterface { public function getStream(); }
PHP);
}

$response = new VSlim\Psr7\Response();
$response->getBody()->write('hello');
$body = $response->getBody();
unset($body);
gc_collect_cycles();
echo (string) $response->getBody() . PHP_EOL;

$request = (new VSlim\Psr17\RequestFactory())->createRequest('GET', 'https://demo.local/hello?q=1');
$uri = $request->getUri();
unset($uri);
gc_collect_cycles();
echo (string) $request->getUri() . PHP_EOL;

$serverRequest = (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('POST', '/submit');
$serverRequest->getBody()->write('payload');
$stream = $serverRequest->getBody();
unset($stream);
gc_collect_cycles();
echo (string) $serverRequest->getBody() . PHP_EOL;

$upload = new VSlim\Psr7\UploadedFile(new VSlim\Psr7\Stream('upload'), 6, UPLOAD_ERR_OK, 'demo.txt', 'text/plain');
$uploadStream = $upload->getStream();
unset($uploadStream);
gc_collect_cycles();
echo (string) $upload->getStream() . PHP_EOL;
?>
--EXPECT--
hello
https://demo.local/hello?q=1
payload
upload
