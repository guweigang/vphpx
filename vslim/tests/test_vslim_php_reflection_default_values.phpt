--TEST--
VSlim exports PHP reflection default values for optional internal parameters
--SKIPIF--
<?php
if (!extension_loaded('vslim')) {
    echo "skip vslim extension missing";
    return;
}
?>
--FILE--
<?php
$responseCtor = new ReflectionMethod(VSlim\Psr7\Response::class, '__construct');
$createResponse = new ReflectionMethod(VSlim\Psr17\ResponseFactory::class, 'createResponse');
$appBadRequest = new ReflectionMethod(VSlim\App::class, 'badRequest');
$requestInputOr = new ReflectionMethod(VSlim\Vhttpd\Request::class, 'input_or');
$configGetMap = new ReflectionMethod(VSlim\Config::class, 'get_map');
$seek = new ReflectionMethod(VSlim\Psr7\Stream::class, 'seek');

var_dump($responseCtor->getParameters()[0]->isDefaultValueAvailable());
var_dump($responseCtor->getParameters()[0]->getDefaultValue());
var_dump($responseCtor->getParameters()[1]->getDefaultValue());

var_dump($createResponse->getParameters()[0]->isDefaultValueAvailable());
var_dump($createResponse->getParameters()[0]->getDefaultValue());
var_dump($createResponse->getParameters()[1]->getDefaultValue());

var_dump($appBadRequest->getParameters()[0]->getDefaultValue());
var_dump($requestInputOr->getParameters()[1]->getDefaultValue());
var_dump($configGetMap->getParameters()[1]->getDefaultValue());

var_dump($seek->getParameters()[1]->isDefaultValueConstant());
var_dump($seek->getParameters()[1]->getDefaultValueConstantName());
var_dump($seek->getParameters()[1]->getDefaultValue());
?>
--EXPECT--
bool(true)
int(200)
string(0) ""
bool(true)
int(200)
string(0) ""
string(11) "Bad Request"
string(0) ""
array(0) {
}
bool(true)
string(8) "SEEK_SET"
int(0)
