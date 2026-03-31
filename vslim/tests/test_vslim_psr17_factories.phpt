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

    $resource = fopen('php://temp', 'r+');
    fwrite($resource, 'resource-body');
    rewind($resource);
    $resourceStream = $streamFactory->createStreamFromResource($resource);
    echo $resourceStream->getContents() . PHP_EOL;
    fclose($resource);
    unlink($tmp);
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
resource-body
