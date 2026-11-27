--TEST--
VSlim stream response factories satisfy the native static PHP contract
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
use VSlim\Stream\Factory;
use VSlim\Stream\Response;
use VSlim\Stream\ResponseFactory;

interface UserStreamResponseFactory extends ResponseFactory {}
class UserStreamFactory extends Factory implements UserStreamResponseFactory {}

foreach ([ResponseFactory::class, Response::class, Factory::class] as $factory) {
    foreach (['text' => 'chunks', 'sse' => 'events'] as $name => $argName) {
        $method = new ReflectionMethod($factory, $name);
        if (!$method->isStatic() || $method->isAbstract() !== ($factory === ResponseFactory::class)
            || (string) $method->getReturnType() !== Response::class
            || $method->getParameters()[0]->getName() !== $argName
            || (string) $method->getParameters()[0]->getType() !== 'mixed') {
            throw new RuntimeException("Unexpected static factory signature for $factory::$name");
        }
        $discard = $method->getAttributes('NoDiscard');
        $expected = PHP_VERSION_ID >= 80500 && $factory === ResponseFactory::class && $name === 'text';
        if (count($discard) !== (int) $expected
            || ($expected && $discard[0]->newInstance()->message !== 'Use the stream response')) {
            throw new RuntimeException("Unexpected NoDiscard metadata for $factory::$name");
        }
    }
}

$inherited = new ReflectionMethod(UserStreamResponseFactory::class, 'text');
if ($inherited->getDeclaringClass()->getName() !== ResponseFactory::class
    || $inherited->getParameters()[0]->getName() !== 'chunks'
    || !is_subclass_of(UserStreamFactory::class, ResponseFactory::class)
    || UserStreamFactory::text(chunks: ['inherited'])->chunks() !== ['inherited']) {
    throw new RuntimeException('Userland interface inheritance changed the stream factory contract');
}

foreach ([Response::class, Factory::class] as $factory) {
    if (!is_subclass_of($factory, ResponseFactory::class)) {
        throw new RuntimeException("$factory did not implement ResponseFactory");
    }
    $text = $factory::text(chunks: ['hello']);
    $sse = $factory::sse(events: [['event' => 'message', 'data' => 'hello']]);
    echo $text->status, '|', $text->streamType, '|', $text->contentType, PHP_EOL;
    echo $sse->status, '|', $sse->streamType, '|', $sse->contentType, PHP_EOL;
}
$native = fopen('php://memory', 'w+b');
fwrite($native, "prea\0\xff");
fseek($native, 3);
$rawText = Response::text($native);
if (ftell($native) !== 3 || !$rawText->chunks() instanceof Generator
    || iterator_to_array($rawText->chunks(), false) !== ["a\0\xff"] || !is_resource($native)) {
    throw new RuntimeException('Text response did not lazily stream a PHP resource from its current position');
}
rewind($native);
$rawText->setChunks($native);
$previous = $rawText->chunks();
try {
    $rawText->setChunks(stream_context_create());
    throw new LogicException('Text response accepted a resource that is not a stream');
} catch (InvalidArgumentException $error) {
    if ($rawText->chunks() !== $previous) {
        throw new RuntimeException('A failed resource replacement changed the response body', 0, $error);
    }
}
unset($native);
if (iterator_to_array($previous, false) !== ["prea\0\xff"]) {
    throw new RuntimeException('Text response lost the replacement stream');
}
$custom = Factory::textWith(headers: ['X-Test' => 'custom'], contentType: 'text/custom', status: 207, chunks: ['body']);
if ($custom->status !== 207 || $custom->contentType !== 'text/custom' || $custom->chunks() !== ['body']
    || $custom->header('X-Test') !== 'custom') {
    throw new RuntimeException('The stream factory lost explicitly named arguments');
}
foreach (['textFrom' => 'text', 'sseFrom' => 'sse'] as $name => $type) {
    $calls = 0;
    $factory = static function () use (&$calls): array {
        ++$calls;
        return ['first' => 'body'];
    };
    $method = new ReflectionMethod(Response::class, $name);
    [$parameter, $arguments] = $method->getParameters();
    if ($name === 'textFrom') {
        $timeout = $method->getParameters()[2];
        if ($timeout->getName() !== 'waitTimeoutMs' || (string) $timeout->getType() !== 'int'
            || $timeout->getDefaultValue() !== -1) {
            throw new RuntimeException('textFrom lost its optional stream wait timeout');
        }
    }
    $response = Response::$name(factory: $factory);
    $chunks = $response->chunks();
    if (!$method->isStatic() || (string) $method->getReturnType() !== Response::class
        || $parameter->getName() !== 'factory' || (string) $parameter->getType() !== 'callable'
        || $arguments->getName() !== 'args' || (string) $arguments->getType() !== 'array'
        || $arguments->getDefaultValue() !== [] || $method->getNumberOfRequiredParameters() !== 1
        || $response->streamType !== $type || !$chunks instanceof Generator || $calls !== 0
        || iterator_to_array($chunks) !== ['first' => 'body'] || $calls !== 1) {
        throw new RuntimeException("Unexpected deferred stream behavior for $name");
    }
    $named = Response::$name(
        args: ['last' => null, 'first' => 'body'],
        factory: static fn ($first, $middle = 'default', $last = 'last') => ['first' => [$first, $middle, $last]],
    );
    if ($named->streamType !== $type || iterator_to_array($named->chunks()) !== ['first' => ['body', 'default', null]]) {
        throw new RuntimeException("$name lost the deferred factory arguments");
    }
}
$events = [['event' => 'ready', 'data' => 'first']];
$byReference = static function &() use (&$events): array { return $events; };
$deferred = Response::sseFrom(factory: $byReference)->chunks();
$events[] = ['event' => 'done', 'data' => 'last'];
if (iterator_to_array($deferred) !== $events) {
    throw new RuntimeException('The SSE factory read the reference before iteration or lost its events');
}
$opens = 0;
$openStream = static function (string $contents) use (&$opens) {
    ++$opens;
    $resource = fopen('php://memory', 'w+b');
    fwrite($resource, 'x' . $contents);
    fseek($resource, 1);
    return $resource;
};
$textStream = Response::textFrom(args: ['contents' => "worker\0"], factory: $openStream);
if ($opens !== 0 || iterator_to_array($textStream->chunks(), false) !== ["worker\0"] || $opens !== 1) {
    throw new RuntimeException('textFrom did not lazily open and stream its PHP resource');
}

$domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
foreach ([
    Response::textStream(stream: $reader, waitTimeoutMs: 0),
    Response::textFrom(factory: static fn () => $reader, waitTimeoutMs: 0),
] as $response) {
    try {
        $response->chunks()->current();
        throw new LogicException('The text response ignored its stream wait timeout');
    } catch (Exception $error) {
        if (!str_contains($error->getMessage(), 'Timed out waiting for PHP stream data') || !is_resource($reader)) {
            throw $error;
        }
    }
}
fclose($reader);
fclose($writer);

foreach ([false, true] as $deferredResource) {
    [$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    stream_set_blocking($reader, false);
    $response = $deferredResource
        ? Response::textFrom(static fn () => $reader)
        : Response::text($reader);
    $consumer = VSlim\Task::spawn(
        static fn () => implode(iterator_to_array($response->chunks(), false)),
        [],
    );
    $producer = VSlim\Task::spawn(static function () use ($writer): void {
        VSlim\Task::sleep(0);
        fwrite($writer, "chunk\0\xff");
        fclose($writer);
    }, []);
    if (VSlim\Task::waitAll([$consumer, $producer]) !== ["chunk\0\xff", null]) {
        throw new RuntimeException('A text stream task failed to wait for its producer');
    }
    fclose($reader);
}

[$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
stream_set_blocking($reader, false);
$body = Response::text($reader)->chunks();
$consumer = VSlim\Task::spawn(static fn () => $body->current(), []);
$cancelled = new DomainException('cancel stream consumer');
$cancel = VSlim\Task::spawn(static function () use ($consumer, $cancelled): void {
    VSlim\Task::sleep(0);
    $consumer->cancel($cancelled);
}, []);
try {
    VSlim\Task::waitAll([$consumer, $cancel]);
    throw new LogicException('Cancellation did not interrupt the stream generator');
} catch (DomainException $error) {
    if ($error !== $cancelled || $body->valid() || !is_resource($reader)) {
        throw new RuntimeException('Stream cancellation changed the exception or the resource lifetime', 0, $error);
    }
}
fclose($reader);
fclose($writer);

$invalidEvents = Response::sseFrom(factory: $openStream, args: ['contents' => 'raw']);
try {
    $invalidEvents->chunks()->current();
    throw new LogicException('sseFrom accepted an unframed resource');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'only with arrays and Traversables')) {
        throw $error;
    }
}
?>
--EXPECT--
200|text|text/plain; charset=utf-8
200|sse|text/event-stream
200|text|text/plain; charset=utf-8
200|sse|text/event-stream
