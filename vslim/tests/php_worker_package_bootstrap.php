<?php

declare(strict_types=1);

$vhttpdPackageSrc = (getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd') . '/php/package/src';

$requireClass = static function (string $class, string $relativePath) use ($vhttpdPackageSrc): void {
    if (class_exists($class, false)) {
        return;
    }
    require_once $vhttpdPackageSrc . '/' . $relativePath;
};

$requireClass('VHttpd\\Attribute\\Dispatchable', 'VHttpd/Attribute/Dispatchable.php');
$requireClass('VHttpd\\JsonShape', 'VHttpd/JsonShape.php');
$requireClass('VHttpd\\Psr7Adapter', 'VHttpd/Psr7Adapter.php');
$requireClass('VHttpd\\Upstream\\Plan', 'VHttpd/Upstream/Plan.php');
$requireClass('VHttpd\\PhpWorker\\Client', 'VHttpd/PhpWorker/Client.php');
$requireClass('VHttpd\\PhpWorker\\StreamResponse', 'VHttpd/PhpWorker/StreamResponse.php');
$requireClass('VHttpd\\PhpWorker\\StreamApp', 'VHttpd/PhpWorker/StreamApp.php');
$requireClass('VHttpd\\PhpWorker\\WebSocket\\CommandSink', 'VHttpd/PhpWorker/WebSocket/CommandSink.php');
$requireClass('VHttpd\\PhpWorker\\WebSocket\\CommandBuffer', 'VHttpd/PhpWorker/WebSocket/CommandBuffer.php');
$requireClass('VHttpd\\PhpWorker\\WebSocket\\Connection', 'VHttpd/PhpWorker/WebSocket/Connection.php');
$requireClass('VSlim\\WebSocket\\App', 'VSlim/WebSocket/App.php');
$requireClass('VHttpd\\PhpWorker\\Server', 'VHttpd/PhpWorker/Server.php');
