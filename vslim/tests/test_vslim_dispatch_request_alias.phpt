--TEST--
VSlim App exposes camelCase vhttpd facade dispatch aliases
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$req = new VSlim\VHttpd\Request('GET', '/users/42?trace_id=alias', '');

foreach ([
    'dispatch' => ['VSlim\VHttpd\Response', ['method' => 'string', 'rawPath' => 'string']],
    'dispatchBody' => ['VSlim\VHttpd\Response', ['method' => 'string', 'rawPath' => 'string', 'body' => 'string']],
    'dispatchRequest' => ['VSlim\VHttpd\Response', ['req' => 'VSlim\VHttpd\Request']],
    'dispatchEnvelope' => ['VSlim\VHttpd\Response', ['envelope' => 'mixed']],
    'dispatchEnvelopeWorker' => ['mixed', ['envelope' => 'mixed']],
    'dispatchEnvelopeMap' => ['array', ['envelope' => 'mixed']],
    'handle' => ['Psr\Http\Message\ResponseInterface', ['request' => 'Psr\Http\Message\ServerRequestInterface']],
] as $method => [$returnType, $parameters]) {
    $signature = new ReflectionMethod(VSlim\App::class, $method);
    $actual = [];
    foreach ($signature->getParameters() as $parameter) {
        $actual[$parameter->getName()] = (string) $parameter->getType();
    }
    if ($actual !== $parameters || (string) $signature->getReturnType() !== $returnType
        || $signature->getNumberOfRequiredParameters() !== count($parameters)) {
        throw new RuntimeException("Unexpected signature for VSlim\\App::$method");
    }
}

$requestRes = $app->dispatchRequest(req: $req);
echo $requestRes->status . '|' . $requestRes->body . PHP_EOL;

$dispatchRes = $app->dispatch(rawPath: '/users/43?trace_id=named', method: 'GET');
echo $dispatchRes->status . '|' . $dispatchRes->body . PHP_EOL;

$bodyRes = $app->dispatchBody(body: '', rawPath: '/health', method: 'POST');
echo $bodyRes->status . '|' . $bodyRes->body . PHP_EOL;

$envelope = [
    'method' => 'GET',
    'path' => '/meta',
    'body' => '',
    'headers' => ['x-trace-id' => 'alias'],
    'query' => [],
    'cookies' => [],
    'attributes' => [],
    'server' => [],
    'uploaded_files' => [],
];
$envelopeRes = $app->dispatchEnvelope(envelope: $envelope);
echo $envelopeRes->status . '|' . $envelopeRes->body . PHP_EOL;
$workerResponse = $app->dispatchEnvelopeWorker(envelope: $envelope);
$mapResponse = $app->dispatchEnvelopeMap(envelope: $envelope);
echo $workerResponse->status, '|', $mapResponse['status'], '|',
    $workerResponse->body === $mapResponse['body'] ? 'same body' : 'different body', PHP_EOL;
?>
--EXPECT--
200|{"user":"42","trace":"alias"}
200|{"user":"43","trace":"named"}
405|Method Not Allowed
200|{"runtime":"vslim","bridge":"vphp","server":"vhttpd","trace":"trace-local-mvp"}
200|200|same body
