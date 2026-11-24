<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\inspectPhpStream;
use function VPHP\ReferenceProbe\newPhpStreamContext;
use function VPHP\ReferenceProbe\openPhpStream;
use function VPHP\ReferenceProbe\phpStreamWrapperData;
use function VPHP\ReferenceProbe\readPhpStream;
use function VPHP\ReferenceProbe\readPhpStreamToEnd;
use function VPHP\ReferenceProbe\readPhpStreamExactly;
use function VPHP\ReferenceProbe\readCompletePhpStreamLine;
use function VPHP\ReferenceProbe\writePhpStream;

if (!extension_loaded('reference_property_contracts')) {
    return;
}

final class VphpIncompleteStreamProbe
{
    public $context;
    private bool $started = false;
    private string $mode;
    public static ?RuntimeException $failure = null;

    public function stream_open($path, $mode, $options, &$openedPath): bool
    {
        $this->mode = parse_url($path, PHP_URL_HOST);
        return true;
    }

    public function stream_read(int $count): string|false
    {
        if (!$this->started) {
            $this->started = true;
            return 'abc';
        }
        if ($this->mode === 'throw') {
            throw self::$failure;
        }
        return $this->mode === 'fail' ? false : '';
    }

    public function stream_eof(): bool
    {
        return false;
    }
}

final class VphpStreamOpenProbe
{
    public $context;
    public string $path;

    public function stream_open($path, $mode, $options, &$openedPath): bool
    {
        $this->path = $path;
        return true;
    }
}

(static function (): void {
    $stream = openPhpStream(path: 'php://temp', mode: 'w+', context: null, reportErrors: true);
    if (!is_resource($stream) || phpStreamWrapperData($stream) !== null) {
        throw new RuntimeException('A plain PHP stream lost its resource type');
    }
    fwrite($stream, 'stream payload');
    rewind($stream);
    if (stream_get_contents($stream) !== 'stream payload') {
        throw new RuntimeException('The VPHP stream could not be read and written from PHP');
    }
    if (writePhpStream($stream, "a\0b") !== 3 || !inspectPhpStream($stream, -2)
        || readPhpStream($stream, 0) !== '' || readPhpStream($stream, -1) !== null
        || readPhpStream($stream, 2) !== "\0b" || readPhpStream($stream, 1) !== '') {
        throw new RuntimeException('Native stream operations lost binary contents, position or EOF');
    }
    $context = stream_context_create();
    if (inspectPhpStream($context, 0) || readPhpStream($context, 1) !== null
        || writePhpStream($context, 'x') !== null) {
        throw new RuntimeException('Stream operations accepted a non-stream resource');
    }
    try {
        openPhpStream('php://temp', 'r', $stream, false);
        throw new LogicException('The bridge accepted a stream as its context');
    } catch (TypeError) {
    }
    $payload = str_repeat("a\0b", 4000);
    ftruncate($stream, 0);
    rewind($stream);
    fwrite($stream, $payload);
    rewind($stream);
    if (readPhpStreamExactly($stream, 0) !== '' || readPhpStreamExactly($stream, 2) !== "a\0"
        || readPhpStreamToEnd($stream) !== substr($payload, 2) || readPhpStreamToEnd($stream) !== '') {
        throw new RuntimeException('The checked stream reader lost binary content or EOF');
    }
    rewind($stream);
    try {
        readPhpStreamExactly($stream, strlen($payload) + 1);
        throw new LogicException('A short exact read returned success');
    } catch (Exception $e) {
        if ($e->getMessage() !== 'failed to read the requested number of PHP stream bytes') {
            throw $e;
        }
    }
    fclose($stream);

    $lines = fopen('php://temp', 'w+');
    fwrite($lines, "a\0b\r\nlong line\ntruncated");
    rewind($lines);
    if (readCompletePhpStreamLine($lines, 5) !== "a\0b\r\n") {
        throw new RuntimeException('The complete line reader lost binary data or the line terminator');
    }
    foreach ([5 => 4, 15 => 64] as $offset => $limit) {
        fseek($lines, $offset);
        try {
            readCompletePhpStreamLine($lines, $limit);
            throw new LogicException('A partial or overlong line returned success');
        } catch (Exception $e) {
            if ($e->getMessage() !== 'failed to read a complete PHP stream line') {
                throw $e;
            }
        }
    }
    fclose($lines);

    stream_wrapper_register('vphpincomplete', VphpIncompleteStreamProbe::class);
    try {
        VphpIncompleteStreamProbe::$failure = new RuntimeException('stream callback failed');
        foreach (['fail', 'stall', 'throw'] as $mode) {
            $incomplete = fopen('vphpincomplete://' . $mode, 'r');
            try {
                readPhpStreamToEnd($incomplete);
                throw new LogicException('An incomplete stream returned success');
            } catch (Exception $e) {
                if ($mode === 'throw'
                    ? $e !== VphpIncompleteStreamProbe::$failure
                    : $e->getMessage() !== 'failed to read PHP stream to EOF') {
                    throw $e;
                }
            } finally {
                fclose($incomplete);
            }
        }
    } finally {
        VphpIncompleteStreamProbe::$failure = null;
        stream_wrapper_unregister('vphpincomplete');
    }

    stream_wrapper_register('vphpstreamprobe', VphpStreamOpenProbe::class);
    try {
        $context = stream_context_create(['vphpstreamprobe' => ['marker' => 'test']]);
        $options = ['marker' => 'native', 'number' => 2, 'nested' => ['binary' => "a\0b"]];
        $native = newPhpStreamContext(options: ['vphpstreamprobe' => &$options]);
        $other = newPhpStreamContext([]);
        $options['marker'] = 'changed';
        if (get_resource_type($native) !== 'stream-context' || $native === stream_context_get_default()
            || stream_context_get_options($other) !== [] || $native === $other
            || stream_context_get_options($native) !== ['vphpstreamprobe' => [
                'marker' => 'native', 'number' => 2, 'nested' => ['binary' => "a\0b"],
            ]]) {
            throw new RuntimeException('The VPHP context did not preserve independent native options');
        }
        $nativeStream = openPhpStream('vphpstreamprobe://native', 'r', $native, false);
        $nativeData = phpStreamWrapperData($nativeStream);
        fclose($nativeStream);
        if (!$nativeData instanceof VphpStreamOpenProbe || $nativeData->context !== $native) {
            throw new RuntimeException('The stream did not retain the original VPHP context');
        }
        $contextCount = count(get_resources('stream-context'));
        foreach ([[0 => []], ['http' => false], ['http' => [1 => true]],
            ["http\0other" => []], ['http' => ["timeout\0other" => 1]]] as $invalid) {
            try {
                newPhpStreamContext(['valid' => ['marker' => true]] + $invalid);
                throw new LogicException('Invalid stream context options were accepted');
            } catch (ValueError) {
            }
        }
        if (count(get_resources('stream-context')) !== $contextCount) {
            throw new RuntimeException('A rejected VPHP context leaked its resource');
        }
        $first = openPhpStream('vphpstreamprobe://first', 'r', $context, false);
        $second = openPhpStream('vphpstreamprobe://second', 'r', $context, false);
        $firstData = phpStreamWrapperData($first);
        $secondData = phpStreamWrapperData($second);
        fclose($first);
        fclose($second);
        if (!$firstData instanceof VphpStreamOpenProbe || !$secondData instanceof VphpStreamOpenProbe
            || $firstData->path !== 'vphpstreamprobe://first' || $secondData->path !== 'vphpstreamprobe://second'
            || $firstData->context !== $context || $secondData->context !== $context) {
            throw new RuntimeException('Stream wrapper data lost its stream or context');
        }
        $default = stream_context_get_default();
        $stream = openPhpStream('vphpstreamprobe://default', 'r', null, false);
        $data = phpStreamWrapperData($stream);
        fclose($stream);
        if (!$data instanceof VphpStreamOpenProbe || $data->context !== $default) {
            throw new RuntimeException('Opening without an explicit context lost the PHP default context');
        }
    } finally {
        stream_wrapper_unregister('vphpstreamprobe');
    }

    $path = tempnam(sys_get_temp_dir(), 'vphp-missing-stream-');
    if ($path === false) {
        throw new RuntimeException('Unable to allocate a fixture path');
    }
    unlink($path);
    $warnings = 0;
    set_error_handler(static function () use (&$warnings): bool {
        ++$warnings;
        return true;
    });
    try {
        foreach ([false, true] as $reportErrors) {
            try {
                openPhpStream($path, 'r', null, $reportErrors);
                throw new LogicException('A nonexistent file was opened');
            } catch (Exception $error) {
                if ($error->getMessage() !== 'failed to open PHP stream') {
                    throw $error;
                }
            }
            if ($warnings !== (int) $reportErrors) {
                throw new RuntimeException('The stream warning option did not control PHP warning reporting');
            }
        }
        try {
            openPhpStream("php://temp\0/other", 'r', null, false);
            throw new LogicException('The bridge accepted an embedded null byte in the path');
        } catch (ValueError) {
        }
    } finally {
        restore_error_handler();
    }
})();
