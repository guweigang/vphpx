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
echo $text->stream_type . PHP_EOL;
echo $text->status . PHP_EOL;
echo $text->content_type . PHP_EOL;
echo ($text->has_header('content-type') ? 'has-ct' : 'no-ct') . PHP_EOL;
echo implode('', iterator_to_array($text->chunks(), false)) . PHP_EOL;

$text->set_header('x-demo', 'yes');
echo $text->header('x-demo') . PHP_EOL;

$sse = VSlim\Stream\Response::sse([
    ['event' => 'token', 'data' => 'hello'],
    ['event' => 'done', 'data' => 'done'],
]);
echo $sse->stream_type . PHP_EOL;
echo $sse->content_type . PHP_EOL;
$events = $sse->chunks();
echo $events[0]['event'] . '|' . $events[0]['data'] . PHP_EOL;
?>
--EXPECT--
text
200
text/plain; charset=utf-8
has-ct
ab
yes
sse
text/event-stream
token|hello
