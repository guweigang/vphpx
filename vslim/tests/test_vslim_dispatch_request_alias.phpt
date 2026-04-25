--TEST--
VSlim App exposes camelCase vhttpd facade dispatch aliases
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$req = new VSlim\VHttpd\Request('GET', '/users/42?trace_id=alias', '');

$requestRes = $app->dispatchRequest($req);
echo $requestRes->status . '|' . $requestRes->body . PHP_EOL;

$bodyRes = $app->dispatchBody('POST', '/health', '');
echo $bodyRes->status . '|' . $bodyRes->body . PHP_EOL;

$envelopeRes = $app->dispatchEnvelope([
    'method' => 'GET',
    'path' => '/meta',
    'body' => '',
    'headers' => ['x-trace-id' => 'alias'],
    'query' => [],
    'cookies' => [],
    'attributes' => [],
    'server' => [],
    'uploaded_files' => [],
]);
echo $envelopeRes->status . '|' . $envelopeRes->body . PHP_EOL;
?>
--EXPECT--
200|{"user":"42","trace":"trace-local-mvp"}
405|Method Not Allowed
200|{"runtime":"vslim","bridge":"vphp","server":"vhttpd","trace":"trace-local-mvp"}
