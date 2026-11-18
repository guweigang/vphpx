--TEST--
VSlim keeps route precedence, method semantics and registration rollback with indexed matching
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->get('/probe/:id', static fn ($req) => 'dynamic:' . $req->getAttribute('id', '-'));
$app->get('/probe/fixed', static fn () => 'static');
$app->get('//root/static/', static fn () => 'root-static');
$app->get('/:scope/static', static fn ($req) => 'fallback:' . $req->getAttribute('scope'));
$app->post('/allow/:id', static fn () => 'post');
$app->get('/allow/item', static function ($req) {
    echo 'get:', $req->getMethod(), PHP_EOL;
    return 'get';
});
$app->head('/allow/item', static function () {
    echo "explicit head\n";
    return '';
});

foreach (['/probe/fixed', '/probe/:id', '/root/static', '/alternate/static'] as $path) {
    echo $app->dispatch('GET', $path)->body, PHP_EOL;
}
$head = $app->dispatch('HEAD', '/allow/item');
echo $head->status, '|', strlen($head->body), PHP_EOL;
foreach (['OPTIONS', 'PATCH'] as $method) {
    $reply = $app->dispatch($method, '/allow/item');
    echo $method, '|', $reply->status, '|', $reply->header('allow'), PHP_EOL;
}

$first = true;
$spec = ['routes' => static function (VSlim\App $app) use (&$first): void {
    $app->get('/rolled/back', static fn () => 'rebuilt');
    $app->get('/rolled/:id', static fn ($req) => $req->getAttribute('id'));
    if ($first) {
        $first = false;
        throw new LogicException('rollback');
    }
}];
try {
    $app->bootstrap($spec);
} catch (LogicException $error) {
    echo $error->getMessage(), '|', $app->dispatch('GET', '/rolled/back')->status, '|',
        $app->dispatch('GET', '/rolled/other')->status, PHP_EOL;
}
$app->bootstrap($spec);
echo $app->dispatch('GET', '/rolled/back')->body, '|', $app->dispatch('GET', '/rolled/other')->body, PHP_EOL;
?>
--EXPECT--
dynamic:fixed
dynamic:-
root-static
fallback:alternate
get:HEAD
200|0
OPTIONS|204|POST, GET, HEAD, OPTIONS
PATCH|405|POST, GET, HEAD
rollback|404|404
rebuilt|other
