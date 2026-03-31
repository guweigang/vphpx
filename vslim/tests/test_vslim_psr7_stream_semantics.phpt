--TEST--
VSlim PSR-7 stream implementation enforces detached and factory error semantics
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\Http\Message {
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
    if (!interface_exists(StreamFactoryInterface::class, false)) {
        interface StreamFactoryInterface {
            public function createStream(string $content = ''): StreamInterface;
            public function createStreamFromFile(string $filename, string $mode = 'r'): StreamInterface;
            public function createStreamFromResource($resource): StreamInterface;
        }
    }
}

namespace {
    $factory = new VSlim\Psr17\StreamFactory();
    $stream = $factory->createStream('hello');
    echo $stream->getSize() . '|' . ($stream->isReadable() ? 'r' : 'nr') . '|' . ($stream->isWritable() ? 'w' : 'nw') . '|' . ($stream->isSeekable() ? 's' : 'ns') . PHP_EOL;
    $stream->seek(2);
    $stream->rewind();
    echo $stream->tell() . PHP_EOL;

    $closed = $factory->createStream('bye');
    $closed->close();
    echo ($closed->getSize() === null ? 'close-size-null' : 'close-size-set') . PHP_EOL;

    try {
        $stream->read(-1);
        echo "read-neg-ok\n";
    } catch (\RuntimeException $e) {
        echo "read-neg-runtime\n";
    }

    $stream->detach();
    echo ((string) $stream === '' ? 'detached-empty' : 'detached-nonempty') . PHP_EOL;
    echo ($stream->getSize() === null ? 'size-null' : 'size-set') . PHP_EOL;
    echo ($stream->getMetadata() === [] ? 'meta-empty' : 'meta-set') . PHP_EOL;

    try {
        $stream->tell();
        echo "tell-ok\n";
    } catch (\RuntimeException $e) {
        echo "tell-runtime\n";
    }

    try {
        $stream->getContents();
        echo "contents-ok\n";
    } catch (\RuntimeException $e) {
        echo "contents-runtime\n";
    }

    try {
        $stream->write('x');
        echo "write-ok\n";
    } catch (\RuntimeException $e) {
        echo "write-runtime\n";
    }

    $tmp = sys_get_temp_dir() . '/vslim-psr7-stream-' . uniqid('', true) . '.txt';
    file_put_contents($tmp, 'file-body');
    $fileStream = $factory->createStreamFromFile($tmp, 'r');
    echo $fileStream->getMetadata('mode') . '|' . (str_starts_with(basename($fileStream->getMetadata('uri')), 'vslim-psr7-stream-') ? 'uri-prefix' : 'uri-miss') . PHP_EOL;

    try {
        $factory->createStreamFromFile($tmp . '.missing', 'r');
        echo "missing-ok\n";
    } catch (\RuntimeException $e) {
        echo "missing-runtime\n";
    }

    try {
        $factory->createStreamFromResource('not-a-resource');
        echo "resource-ok\n";
    } catch (\InvalidArgumentException $e) {
        echo "resource-invalid\n";
    }

    @unlink($tmp);
}
?>
--EXPECT--
5|r|w|s
0
close-size-null
read-neg-runtime
detached-empty
size-null
meta-empty
tell-runtime
contents-runtime
write-runtime
r|uri-prefix
missing-runtime
resource-invalid
