--TEST--
VSlim StreamResponse supports text and sse factories
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
declare(strict_types=1);

$text = VSlim\Stream\Response::text((function (): iterable {
    yield "a";
    yield "b";
})());
echo $text->streamType . PHP_EOL;
echo $text->status . PHP_EOL;
try {
    $text->status = new stdClass();
    echo "invalid status accepted\n";
} catch (TypeError) {
    echo "rejected status leaves " . $text->status . PHP_EOL;
}
unset($text->status);
echo isset($text->status) || array_key_exists('status', get_object_vars($text)) ? "status still set\n" : "status unset\n";
try {
    $text->status;
    echo "unset status read succeeded\n";
} catch (Error $error) {
    echo str_contains($error->getMessage(), 'must not be accessed before initialization') ? "status uninitialized\n" : $error->getMessage() . PHP_EOL;
}
$text->status ??= 200;
echo "status restored " . $text->status . PHP_EOL;
echo "status incremented " . (++$text->status) . " then " . ($text->status += 2) . PHP_EOL;
echo "current status " . $text->status . PHP_EOL;
$statusAlias =& $text->status;
$statusAlias = 204;
echo "status through alias " . $text->status . PHP_EOL;
$text->setStatus(205);
echo "status after V setter " . $statusAlias . PHP_EOL;
unset($statusAlias);
$text->status = 200;
echo $text->contentType . PHP_EOL;
echo ($text->hasHeader('content-type') ? 'has-ct' : 'no-ct') . PHP_EOL;
echo implode('', iterator_to_array($text->chunks(), false)) . PHP_EOL;

$text->setHeader('x-demo', 'yes');
echo $text->header('x-demo') . PHP_EOL;

$sse = VSlim\Stream\Response::sse([
    ['event' => 'token', 'data' => 'hello'],
    ['event' => 'done', 'data' => 'done'],
]);
echo $sse->streamType . PHP_EOL;
echo $sse->contentType . PHP_EOL;
$events = $sse->chunks();
echo $events[0]['event'] . '|' . $events[0]['data'] . PHP_EOL;

$closed = 0;
$generator = (static function () use (&$closed): Generator {
    try {
        yield 'first';
    } finally {
        ++$closed;
    }
})();
$weak = WeakReference::create($generator);
$first = VSlim\Stream\Response::text($generator);
$second = VSlim\Stream\Response::text($generator);
$generator->rewind();
unset($generator, $first);
if ($closed !== 0 || $weak->get() === null) {
    throw new RuntimeException('Dropping one stream response closed a shared generator');
}
$chunks = $second->chunks();
if ($chunks !== $weak->get() || $chunks->current() !== 'first') {
    throw new RuntimeException('The remaining response lost its original generator');
}
$second->setChunks($chunks);
unset($second);
if ($chunks->current() !== 'first') {
    throw new RuntimeException('Dropping a response closed the generator returned by its getter');
}
unset($chunks);
if ($closed !== 1 || $weak->get() !== null) {
    throw new RuntimeException('The generator survived the last response or was closed twice');
}

$generator = (static function (): Generator { yield 'discarded'; })();
$weak = WeakReference::create($generator);
$response = VSlim\Stream\Response::text($generator);
unset($generator);
$response->setChunks(null);
if ($response->chunks() !== null || $weak->get() !== null) {
    throw new RuntimeException('Clearing the chunks left the original generator attached');
}

$slot = ['event' => 'change', 'data' => 'before'];
$generator = (static function &() use (&$slot): Generator {
    yield 'event' => $slot;
})();
$response = VSlim\Stream\Response::sse($generator);
foreach ($response->chunks() as $key => &$chunk) {
    $chunk['data'] = 'after';
    if ($key !== 'event') {
        throw new RuntimeException('The response lost the original generator key');
    }
}
unset($chunk, $response, $generator);
if ($slot['data'] !== 'after') {
    throw new RuntimeException('The response detached the generator reference');
}

foreach ([
    'constructor' => static fn ($source) => new VSlim\Stream\Response('sse', $source, 200, 'text/event-stream', []),
    'text' => VSlim\Stream\Response::text(...),
    'textWith' => static fn ($source) => VSlim\Stream\Response::textWith($source, 200, 'text/plain', []),
    'sse' => VSlim\Stream\Response::sse(...),
    'sseWith' => static fn ($source) => VSlim\Stream\Response::sseWith($source, 200, []),
    'factoryText' => VSlim\Stream\Factory::text(...),
    'factoryTextWith' => static fn ($source) => VSlim\Stream\Factory::textWith($source, 200, 'text/plain', []),
    'factorySse' => VSlim\Stream\Factory::sse(...),
    'factorySseWith' => static fn ($source) => VSlim\Stream\Factory::sseWith($source, 200, []),
] as $name => $create) {
    foreach ([false, true] as $start) {
        $node = new stdClass();
        $generator = (static function &() use (&$node): Generator { yield $node; })();
        $response = $create($generator);
        $node->response = $response;
        if ($start && $response->chunks()->current() !== $node) {
            throw new RuntimeException("The stream lost its captured object in $name");
        }
        $weakResponse = WeakReference::create($response);
        $weakGenerator = WeakReference::create($generator);
        unset($node, $response, $generator);
        gc_collect_cycles();
        if ($weakResponse->get() !== null || $weakGenerator->get() !== null) {
            throw new RuntimeException("An abandoned generator and response kept each other alive in $name");
        }
    }
}

foreach ([false, true] as $start) {
    $owner = new stdClass();
    $listener = static fn () => $owner;
    $provider = new VSlim\Psr14\ListenerProvider();
    $provider->listenAny($listener);
    $generator = $provider->getListenersForEvent($owner);
    $response = VSlim\Stream\Response::sse($generator);
    $owner->response = $response;
    if ($start && $response->chunks()->current() !== $listener) {
        throw new RuntimeException('The stream lost its native producer capture');
    }
    $weakResponse = WeakReference::create($response);
    $weakGenerator = WeakReference::create($generator);
    $weakListener = WeakReference::create($listener);
    unset($owner, $listener, $provider, $generator, $response);
    gc_collect_cycles();
    gc_collect_cycles();
    if ($weakResponse->get() !== null || $weakGenerator->get() !== null || $weakListener->get() !== null) {
        throw new RuntimeException('The stream kept the abandoned native producer capture alive');
    }
}
?>
--EXPECT--
text
200
rejected status leaves 200
status unset
status uninitialized
status restored 200
status incremented 201 then 203
current status 203
status through alias 204
status after V setter 205
text/plain; charset=utf-8
has-ct
ab
yes
sse
text/event-stream
token|hello
