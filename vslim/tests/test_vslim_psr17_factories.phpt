--TEST--
VSlim native PSR-17 factories build PSR-7 style stream and response objects
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\Http\Message {
    if (!interface_exists(MessageInterface::class, false)) {
        interface MessageInterface {
            public function getProtocolVersion(): string;
            public function withProtocolVersion(string $version);
            public function getHeaders(): array;
            public function hasHeader(string $name): bool;
            public function getHeader($name): array;
            public function getHeaderLine($name): string;
            public function withHeader($name, $value);
            public function withAddedHeader($name, $value);
            public function withoutHeader($name);
            public function getBody(): StreamInterface;
            public function withBody(StreamInterface $body);
        }
    }
    if (!interface_exists(StreamInterface::class, false)) {
        interface StreamInterface {
            public function __toString(): string;
            public function close(): void;
            public function detach();
            public function getSize(): ?int;
            public function tell(): int;
            public function eof(): bool;
            public function isSeekable(): bool;
            public function seek(int $offset, int $whence = SEEK_SET): void;
            public function rewind(): void;
            public function isWritable(): bool;
            public function write(string $string): int;
            public function isReadable(): bool;
            public function read(int $length): string;
            public function getContents(): string;
            public function getMetadata($key = null);
        }
    }
    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface extends MessageInterface {
            public function getStatusCode(): int;
            public function withStatus(int $code, string $reasonPhrase = '');
            public function getReasonPhrase(): string;
        }
    }
    if (!interface_exists(ResponseFactoryInterface::class, false)) {
        interface ResponseFactoryInterface {
            public function createResponse(int $code = 200, string $reasonPhrase = ''): ResponseInterface;
        }
    }
    if (!interface_exists(StreamFactoryInterface::class, false)) {
        interface StreamFactoryInterface {
            public function createStream(string $content = ''): StreamInterface;
            public function createStreamFromFile(string $filename, string $mode = 'r'): StreamInterface;
            public function createStreamFromResource($resource): StreamInterface;
        }
    }
}

namespace {
    $responseFactory = new VSlim\Psr17\ResponseFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();

    echo ($responseFactory instanceof Psr\Http\Message\ResponseFactoryInterface ? 'rf-yes' : 'rf-no') . PHP_EOL;
    echo ($streamFactory instanceof Psr\Http\Message\StreamFactoryInterface ? 'sf-yes' : 'sf-no') . PHP_EOL;

    $stream = $streamFactory->createStream('hello');
    echo get_class($stream) . PHP_EOL;
    echo ($stream instanceof Psr\Http\Message\StreamInterface ? 'stream-yes' : 'stream-no') . PHP_EOL;
    echo (string) $stream . '|' . $stream->getSize() . PHP_EOL;
    $stream->seek($stream->getSize());
    $stream->write(' world');
    $stream->rewind();
    echo $stream->getContents() . PHP_EOL;

    $response = $responseFactory->createResponse();
    echo get_class($response) . PHP_EOL;
    echo ($response instanceof Psr\Http\Message\ResponseInterface ? 'resp-yes' : 'resp-no') . PHP_EOL;
    echo $response->getStatusCode() . '|' . $response->getReasonPhrase() . '|' . $response->getProtocolVersion() . PHP_EOL;

    $response2 = $response
        ->withHeader('X-Test', ['a', 'b'])
        ->withBody($stream)
        ->withStatus(201, 'Made');
    echo $response->hasHeader('x-test') ? "orig-has\n" : "orig-miss\n";
    echo $response2->getHeaderLine('x-test') . PHP_EOL;
    echo (string) $response2->getBody() . PHP_EOL;
    echo $response2->getStatusCode() . '|' . $response2->getReasonPhrase() . PHP_EOL;

    $tmp = sys_get_temp_dir() . '/vslim_psr17_' . getmypid() . '.txt';
    file_put_contents($tmp, 'file-body');
    $fileStream = $streamFactory->createStreamFromFile($tmp);
    echo $fileStream->getContents() . PHP_EOL;
    var_dump($fileStream->isReadable(), $fileStream->isWritable(), $fileStream->isSeekable());
    $fileStream->close();

    $append = $streamFactory->createStreamFromFile(mode: 'ab', filename: $tmp);
    var_dump($append->isReadable(), $append->isWritable(), $append->write('|append'));
    $append->close();
    echo file_get_contents($tmp) . PHP_EOL;

    $writable = $streamFactory->createStreamFromFile($tmp, 'w+b');
    var_dump($writable->getSize(), $writable->write("a\x00b"), $writable->getSize());
    $writable->seek(defaultWhence: SEEK_END, offset: -2);
    echo $writable->tell() . '|' . bin2hex($writable->getContents()) . PHP_EOL;
    $writable->close();

    $resource = fopen('php://temp', 'r+');
    fwrite($resource, 'resource-body');
    rewind($resource);
    $resourceStream = $streamFactory->createStreamFromResource($resource);
    echo $resourceStream->getContents() . PHP_EOL;
    fclose($resource);
    var_dump($resourceStream->getSize(), $resourceStream->getMetadata(), $resourceStream->detach());
    $resourceStream->close();

    $resource = fopen('php://temp', 'w+');
    fwrite($resource, 'abcdef');
    fseek($resource, 2);
    $stream = $streamFactory->createStreamFromResource(resource: $resource);
    echo $stream->tell() . '|' . ftell($resource) . PHP_EOL;
    echo $stream->read(1) . '|' . ftell($resource) . PHP_EOL;
    fwrite($resource, 'Z');
    echo (string) $stream . '|' . $stream->tell() . PHP_EOL;
    echo (string) $response->withBody($stream)->getBody() . '|' . ftell($resource) . PHP_EOL;
    var_dump($stream->getMetadata('seekable'), $stream->getMetadata('missing'), $stream->detach() === $resource);
    echo stream_get_contents($resource) . PHP_EOL;
    var_dump($stream->detach(), $stream->eof());
    fclose($resource);

    $resource = fopen('php://temp', 'r+');
    $stream = $streamFactory->createStreamFromResource($resource);
    $stream->close();
    var_dump(is_resource($resource), $stream->isReadable());

    try {
        $streamFactory->createStreamFromResource(stream_context_create());
    } catch (InvalidArgumentException $error) {
        echo "non-stream-resource\n";
    }

    $process = proc_open([PHP_BINARY, '-n', '-r', 'echo "pipe-data";'], [1 => ['pipe', 'w']], $pipes);
    $pipe = $streamFactory->createStreamFromResource($pipes[1]);
    var_dump($pipe->isSeekable(), $pipe->read(0));
    $messages = [new VSlim\Psr7\Request(), new VSlim\Psr7\ServerRequest(), $response];
    foreach ($messages as $message) {
        $original = $message->getBody();
        $withBody = $message->withBody(body: $pipe);
        $withHeader = $withBody->withHeader('X-Flow', 'yes')->withProtocolVersion('2');
        if ($withHeader->getBody() !== $pipe || $message->getBody() !== $original
            || $message->hasHeader('X-Flow') || $withHeader->getHeaderLine('X-Flow') !== 'yes') {
            throw new RuntimeException('Message mutations lost the body or changed the original message');
        }
    }
    echo $withHeader->getBody()->read(5) . '|' . $pipe->getContents() . PHP_EOL;
    var_dump($pipe->eof(), $pipe->detach() === $pipes[1]);
    fclose($pipes[1]);
    proc_close($process);
    unlink($tmp);

    foreach ($messages as $message) {
        $body = $streamFactory->createStream('x');
        $weak = WeakReference::create($body);
        $first = $message->withBody($body);
        $second = $first->withAddedHeader('X-Next', '1')->withoutHeader('X-Next');
        unset($first, $body);
        $second->getBody()->seek(1);
        $second->getBody()->write('y');
        if ($weak->get() !== $second->getBody() || (string) $weak->get() !== 'xy') {
            throw new RuntimeException('The resulting message did not keep the original stream alive');
        }
        unset($second);
        if ($weak->get() !== null) {
            throw new RuntimeException('The body outlived its message');
        }
    }

    $foreign = new class implements Psr\Http\Message\StreamInterface {
        public $owner;
        private bool $read = false;
        public function __toString(): string { throw new RuntimeException('Unexpected eager read'); }
        public function close(): void {}
        public function detach() { return null; }
        public function getSize(): ?int { return null; }
        public function tell(): int { return 0; }
        public function eof(): bool { return $this->read; }
        public function isSeekable(): bool { return false; }
        public function seek(int $offset, int $whence = SEEK_SET): void {}
        public function rewind(): void {}
        public function isWritable(): bool { return false; }
        public function write(string $string): int { throw new RuntimeException('Not writable'); }
        public function isReadable(): bool { return true; }
        public function read(int $length): string {
            if ($this->read) {
                return '';
            }
            $this->read = true;
            return "userland\0";
        }
        public function getContents(): string { return ''; }
        public function getMetadata($key = null) { return $key === null ? [] : null; }
    };

    $workerBody = clone $foreign;
    $app = new VSlim\App();
    $app->get('/userland-stream', static fn () => $response->withBody($workerBody));
    $workerResponse = $app->dispatchEnvelopeWorker(['method' => 'GET', 'path' => '/userland-stream']);
    if (!$workerResponse instanceof VSlim\Stream\Response || $workerBody->eof()
        || iterator_to_array($workerResponse->chunks(), false) !== ["userland\0"]) {
        throw new RuntimeException('Worker did not iterate the PHP userland stream lazily');
    }
    $foreign->owner = $response->withBody($foreign)->withStatus(202);
    if ($foreign->owner->getBody() !== $foreign) {
        throw new RuntimeException('The message replaced a PHP userland stream');
    }
    $weakStream = WeakReference::create($foreign);
    $weakMessage = WeakReference::create($foreign->owner);
    unset($foreign);
    gc_collect_cycles();
    if ($weakStream->get() !== null || $weakMessage->get() !== null) {
        throw new RuntimeException('Zend could not collect a stream and its message');
    }
    echo "shared bodies and collection verified\n";
}
?>
--EXPECT--
rf-yes
sf-yes
VSlim\Psr7\Stream
stream-yes
hello|5
hello world
VSlim\Psr7\Response
resp-yes
200|OK|1.1
orig-miss
a, b
hello world
201|Made
file-body
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
int(7)
file-body|append
int(0)
int(3)
int(3)
1|0062
resource-body
NULL
array(0) {
}
NULL
2|2
c|3
abcZef|4
abcZef|4
bool(true)
NULL
bool(true)
ef
NULL
bool(true)
bool(false)
bool(false)
non-stream-resource
bool(false)
string(0) ""
pipe-|data
bool(true)
bool(true)
shared bodies and collection verified
