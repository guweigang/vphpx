--TEST--
VSlim native PSR-17 UploadedFileFactory builds PSR-7 UploadedFile objects
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
    if (!interface_exists(UploadedFileInterface::class, false)) {
        interface UploadedFileInterface {
            public function getStream(): StreamInterface;
            public function moveTo(string $targetPath): void;
            public function getSize(): ?int;
            public function getError(): int;
            public function getClientFilename(): ?string;
            public function getClientMediaType(): ?string;
        }
    }
    if (!interface_exists(StreamFactoryInterface::class, false)) {
        interface StreamFactoryInterface {
            public function createStream(string $content = ''): StreamInterface;
            public function createStreamFromFile(string $filename, string $mode = 'r'): StreamInterface;
            public function createStreamFromResource($resource): StreamInterface;
        }
    }
    if (!interface_exists(UploadedFileFactoryInterface::class, false)) {
        interface UploadedFileFactoryInterface {
            public function createUploadedFile(StreamInterface $stream, ?int $size = null, int $error = UPLOAD_ERR_OK, ?string $clientFilename = null, ?string $clientMediaType = null): UploadedFileInterface;
        }
    }
}

namespace {
    $factory = new VSlim\Psr17\UploadedFileFactory();
    $streamFactory = new VSlim\Psr17\StreamFactory();

    echo ($factory instanceof Psr\Http\Message\UploadedFileFactoryInterface ? 'uff-yes' : 'uff-no') . PHP_EOL;

    $upload = $factory->createUploadedFile(
        $streamFactory->createStream('alpha'),
        null,
        UPLOAD_ERR_OK,
        'alpha.txt',
        'text/plain'
    );

    echo get_class($upload) . PHP_EOL;
    echo ($upload instanceof Psr\Http\Message\UploadedFileInterface ? 'up-yes' : 'up-no') . PHP_EOL;
    echo get_class($upload->getStream()) . '|' . (string) $upload->getStream() . PHP_EOL;
    echo $upload->getSize() . '|' . $upload->getError() . '|' . $upload->getClientFilename() . '|' . $upload->getClientMediaType() . PHP_EOL;

    $target = sys_get_temp_dir() . '/vslim-uploaded-file-' . uniqid('', true) . '.txt';
    $upload->moveTo($target);
    echo filesize($target) . '|' . file_get_contents($target) . PHP_EOL;

    try {
        $upload->getStream();
        echo "stream-ok\n";
    } catch (\RuntimeException $e) {
        echo "stream-runtime\n";
    }

    try {
        $upload->moveTo($target . '.again');
        echo "move-ok\n";
    } catch (\RuntimeException $e) {
        echo "move-runtime\n";
    }

    $errored = $factory->createUploadedFile(
        $streamFactory->createStream('beta'),
        null,
        UPLOAD_ERR_CANT_WRITE,
        'beta.bin',
        null
    );
    echo $errored->getError() . '|' . ($errored->getClientMediaType() === null ? 'media-null' : 'media-set') . PHP_EOL;

    try {
        $errored->moveTo($target . '.err');
        echo "errored-move-ok\n";
    } catch (\RuntimeException $e) {
        echo "errored-move-runtime\n";
    }

    @unlink($target);
}
?>
--EXPECT--
uff-yes
VSlim\Psr7\UploadedFile
up-yes
VSlim\Psr7\Stream|alpha
5|0|alpha.txt|text/plain
5|alpha
stream-runtime
move-runtime
7|media-null
errored-move-runtime
