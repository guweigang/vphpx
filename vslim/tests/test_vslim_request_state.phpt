--TEST--
VSlim request metadata uses PHP WeakMap identity and lifetime
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
$app = new VSlim\App();
$state = $app->requestState();
$signature = new ReflectionMethod($app, 'requestState');
if (!$state instanceof WeakMap || (string) $signature->getReturnType() !== 'WeakMap'
    || $app->requestState() !== $state || (new VSlim\App())->requestState() === $state) {
    throw new RuntimeException('Expected one native WeakMap per app');
}

$factory = new VSlim\Psr17\ServerRequestFactory();
$request = $factory->createServerRequest('GET', '/');
$other = $factory->createServerRequest('GET', '/');
$data = new stdClass();
$weakData = WeakReference::create($data);
$state[$request] = $data;
$state[$other] = null;
unset($data);
if ($app->requestState()[$request] !== $weakData->get()
    || $request->getAttributes() !== [] || count($state) !== 2) {
    throw new RuntimeException('Expected distinct metadata for equivalent request objects');
}
unset($request);
gc_collect_cycles();
if (count($state) !== 1 || $state[$other] !== null || $weakData->get() !== null) {
    throw new RuntimeException('Expected metadata to be released when the request goes away');
}

$stateRef = WeakReference::create($state);
unset($state, $app);
gc_collect_cycles();
if ($stateRef->get() !== null) {
    throw new RuntimeException('The request state outlived its app');
}

$app = new VSlim\App();
$app->requestState()[$other] = $app;
$weakApp = WeakReference::create($app);
unset($app);
gc_collect_cycles();
if ($weakApp->get() !== null) {
    throw new RuntimeException('PHP could not collect a cycle through the app request state');
}

$app = new VSlim\App();
if (method_exists($app, 'bindRequestState') !== (PHP_VERSION_ID >= 80600)) {
    throw new RuntimeException('Unexpected PHP version for request-state binding');
}
if (PHP_VERSION_ID >= 80600) {
    $method = new ReflectionMethod($app, 'bindRequestState');
    [$requestParam, $stateParam] = $method->getParameters();
    if ($requestParam->getName() !== 'request' || (string) $requestParam->getType() !== 'object'
        || $stateParam->getName() !== 'state' || (string) $stateParam->getType() !== 'mixed'
        || !$stateParam->isPassedByReference() || (string) $method->getReturnType() !== 'void') {
        throw new RuntimeException('Unexpected request-state binding signature');
    }
    $request = $factory->createServerRequest('GET', '/');
    $metadata = null;
    $app->bindRequestState(state: $metadata, request: $request);
    $state = $app->requestState();
    $metadata = ['status' => 'started'];
    $alias =& $state[$request];
    $alias['status'] = 'done';
    if ($metadata !== ['status' => 'done'] || $state[$request] !== $metadata) {
        throw new RuntimeException('Request metadata did not share the caller reference');
    }
    unset($request);
    if (count($state) !== 0 || $alias !== $metadata) {
        throw new RuntimeException('Request binding prevented cleanup of its weak key');
    }
}
echo "ok\n";
?>
--EXPECT--
ok
