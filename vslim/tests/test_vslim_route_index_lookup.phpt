--TEST--
VSlim indexed route names, reverse URLs and allowed methods preserve registration order and rollback
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setBasePath(basePath: '/api');
$handler = static fn (): string => 'ok';
$app->get('/unnamed', $handler);
$app->postNamed('item', '/shared/:id', $handler);
$app->getNamed('item', '/shared/fixed', $handler);
$app->deleteNamed('fallback', '/:group/fixed', $handler);
$parameter = (new ReflectionMethod($app, 'setBasePath'))->getParameters()[0];
$doctor = $app->doctor();
if ($parameter->getName() !== 'basePath' || (string) $parameter->getType() !== 'string'
    || $doctor['route_count'] !== '4' || $doctor['provider_count'] !== '0' || $doctor['module_count'] !== '0') {
    throw new RuntimeException('Unexpected base path signature or application diagnostics');
}

echo 'names|', implode(',', $app->routeNames()), PHP_EOL;
echo 'urls|', $app->urlFor('item', ['id' => '8']), '|', $app->urlFor('item', []), '|',
    $app->urlForQueryAbs('item', ['id' => '8'], ['z' => '2', 'a' => '1'], 'https', 'example.test'), '|',
    $app->urlFor('', []), PHP_EOL;
if ($app->urlForAbs('missing', [], 'https', 'example.test') !== ''
    || $app->urlForAbs('item', [], 'https', 'example.test') !== ''
    || $app->urlForAbs('item', ['id' => '8'], '', ' example.test ') !== 'http://example.test/api/shared/8'
    || $app->urlForAbs('item', ['id' => '8'], 'https', '') !== '/api/shared/8') {
    throw new RuntimeException('Unexpected absolute route URL');
}
echo 'lookup|', (int) $app->hasRouteName(''), '|', (int) $app->hasRouteName('missing'), '|',
    implode(',', $app->allowedMethodsFor('/shared/fixed')), '|',
    implode(',', $app->allowedMethodsFor('/missing/other/extra')), PHP_EOL;

$first = true;
$spec = ['routes' => static function (VSlim\App $app) use ($handler, &$first): void {
    $app->putNamed('item', '/shared/fixed', $handler);
    $app->patchNamed('temporary', '/shared/fixed', $handler);
    $app->optionsNamed('temporary', '/shared/fixed', $handler);
    if ($first) {
        $first = false;
        throw new LogicException('rollback');
    }
}];
try {
    $app->bootstrap($spec);
} catch (LogicException $error) {
    echo $error->getMessage(), '|', (int) $app->hasRouteName('temporary'), '|',
        $app->urlFor('item', ['id' => '9']), '|', implode(',', $app->routeNames()), '|',
        implode(',', $app->allowedMethodsFor('/shared/fixed')), PHP_EOL;
}
$app->bootstrap($spec);
echo 'retry|', $app->urlFor('temporary', []), '|', $app->urlFor('item', ['id' => '9']), '|',
    implode(',', $app->routeNames()), '|', implode(',', $app->allowedMethodsFor('/shared/fixed')), PHP_EOL;
?>
--EXPECT--
names|item,fallback
urls|/api/shared/8||https://example.test/api/shared/8?a=1&z=2|/api/unnamed
lookup|1|0|POST,GET,HEAD,DELETE,OPTIONS|
rollback|0|/api/shared/9|item,fallback|POST,GET,HEAD,DELETE,OPTIONS
retry|/api/shared/fixed|/api/shared/9|item,fallback,temporary|POST,GET,HEAD,DELETE,PUT,PATCH,OPTIONS
