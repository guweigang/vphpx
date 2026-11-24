--TEST--
VSlim infers PHP class parameters from V classes in other modules
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
foreach ([
    [VSlim\Controller::class, 'setView', '?' . VSlim\View::class],
    [VSlim\App::class, 'setMcp', VSlim\Mcp\App::class],
    [VSlim\App::class, 'setLogger', VSlim\Log\Logger::class],
    [VSlim\Stream\OllamaClient::class, 'fromConfig', VSlim\Config::class],
] as [$owner, $name, $type]) {
    $arg = (new ReflectionMethod($owner, $name))->getParameters()[0];
    if ((string) $arg->getType() !== $type || $arg->allowsNull() !== str_starts_with($type, '?')) {
        throw new RuntimeException("Unexpected parameter type for $owner::$name");
    }
}

$controller = new VSlim\Controller(new VSlim\App());
$view = new class('', '/assets') extends VSlim\View {};
var_dump($controller->setView(view: $view) === $controller);
$unbound = (new ReflectionClass(VSlim\View::class))->newInstanceWithoutConstructor();
try {
    $controller->setView(view: $unbound);
    throw new RuntimeException('setView accepted an unbound view');
} catch (TypeError $error) {
    var_dump(str_contains($error->getMessage(), 'object not bound to V pointer') && $controller->view() === $view);
}
var_dump($controller->setView(view: null) === $controller && $controller->view() !== $view);
$controller->setView($view);
var_dump($controller->setView() === $controller && $controller->view() !== $view);
var_dump(VSlim\Stream\OllamaClient::fromConfig(config: new VSlim\Config()) instanceof VSlim\Stream\OllamaClient);
try {
    $controller->setView(view: new stdClass());
    throw new RuntimeException('setView accepted an unrelated object');
} catch (TypeError $error) {
    var_dump(str_contains($error->getMessage(), 'VSlim\View'));
}
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
bool(true)
