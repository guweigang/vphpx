--TEST--
VSlim route metadata helpers expose route names and allowed methods
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->get('/health', function ($req) { return 'ok'; });
$app->post('/users', function ($req) { return 'create'; });
$app->putNamed('users.update', '/users/:id', function ($req) { return 'u'; });
$app->deleteNamed('users.delete', '/users/:id', function ($req) { return 'd'; });
$app->anyNamed('echo.any', '/echo/:id', function ($req) { return 'e'; });
$app->getNamed('health.dup', '/health', function ($req) { return 'dup'; });

echo $app->routeCount() . PHP_EOL;
echo implode(',', $app->routeNames()) . PHP_EOL;
var_dump($app->hasRouteName('users.update'));
var_dump($app->hasRouteName('missing'));
echo implode(',', $app->allowedMethodsFor('/users/7')) . PHP_EOL;
echo implode(',', $app->allowedMethodsFor('/echo/9')) . PHP_EOL;
echo implode(',', $app->allowedMethodsFor('/none')) . PHP_EOL;
echo $app->routeManifestLines()[0] . PHP_EOL;
echo $app->routeConflictKeys()[0] . PHP_EOL;
$manifest = $app->routeManifest();
echo $manifest[0]['method'] . ' ' . $manifest[0]['pattern'] . PHP_EOL;
$conflicts = $app->routeConflicts();
echo count($conflicts) . '|' . $conflicts[0]['method'] . '|' . $conflicts[0]['pattern'] . '|' . $conflicts[0]['count'] . PHP_EOL;
?>
--EXPECT--
6
users.update,users.delete,echo.any,health.dup
bool(true)
bool(false)
PUT,DELETE,OPTIONS
GET,HEAD,POST,PUT,PATCH,DELETE,OPTIONS

GET /health
GET /health x2
GET /health
1|GET|/health|2
