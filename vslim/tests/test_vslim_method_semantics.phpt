--TEST--
VSlim method semantics: HEAD fallback, OPTIONS allow, and method override
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->get('/hello', function ($req) {
    return 'hello-body';
});
$app->delete('/items/:id', function ($req) {
    return 'deleted:' . $req->getAttribute('id') . ':' . $req->getMethod();
});
$app->head('/explicit-head', function ($req) {
    return 'explicit-head-body';
});

$head = new VSlim\Vhttpd\Request('HEAD', '/hello', '');
$headRes = $app->dispatch_request($head);
echo $headRes->status . '|' . strlen($headRes->body) . PHP_EOL;

$explicitHead = new VSlim\Vhttpd\Request('HEAD', '/explicit-head', '');
$explicitHeadRes = $app->dispatch_request($explicitHead);
echo $explicitHeadRes->status . '|' . strlen($explicitHeadRes->body) . PHP_EOL;

$opt = new VSlim\Vhttpd\Request('OPTIONS', '/items/9', '');
$optRes = $app->dispatch_request($opt);
echo $optRes->status . '|' . $optRes->header('allow') . PHP_EOL;

$overrideHeader = new VSlim\Vhttpd\Request('POST', '/items/7', '');
$overrideHeader->set_headers(['x-http-method-override' => 'DELETE']);
$overrideHeaderRes = $app->dispatch_request($overrideHeader);
echo $overrideHeaderRes->status . '|' . $overrideHeaderRes->body . PHP_EOL;

$overrideQueryRes = $app->dispatch('POST', '/items/8?_method=DELETE');
echo $overrideQueryRes->status . '|' . $overrideQueryRes->body . PHP_EOL;

$overrideBody = new VSlim\Vhttpd\Request('POST', '/items/10', '_method=DELETE');
$overrideBodyRes = $app->dispatch_request($overrideBody);
echo $overrideBodyRes->status . '|' . $overrideBodyRes->body . PHP_EOL;
?>
--EXPECT--
200|0
200|0
204|DELETE, OPTIONS
200|deleted:7:DELETE
200|deleted:8:DELETE
200|deleted:10:DELETE
