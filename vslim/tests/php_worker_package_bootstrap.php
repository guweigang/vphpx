<?php

declare(strict_types=1);

$vhttpdRoot = getenv('VHTTPD_ROOT') ?: dirname(__DIR__, 3) . '/vhttpd';
$vhttpdAutoload = $vhttpdRoot . '/php/package/vendor/autoload.php';

if (file_exists($vhttpdAutoload)) {
    require_once $vhttpdAutoload;
}

$vhttpdPackageSrc = $vhttpdRoot . '/php/package/src';

$requireClass = static function (string $class, string $relativePath) use ($vhttpdPackageSrc): void {
    if (class_exists($class, false) || interface_exists($class, false)) {
        return;
    }
    $fullPath = $vhttpdPackageSrc . '/' . $relativePath;
    if (file_exists($fullPath)) {
        require_once $fullPath;
    }
};

$requireClass('VSlim\\Psr7Adapter', 'VSlim/Psr7Adapter.php');
$requireClass('VHttpd\\PhpWorker\\Client', 'VHttpd/PhpWorker/Client.php');
$requireClass('VHttpd\\PhpWorker\\StreamResponse', 'VHttpd/PhpWorker/StreamResponse.php');
$requireClass('VHttpd\\PhpWorker\\StreamApp', 'VHttpd/PhpWorker/StreamApp.php');
$requireClass('VSlim\\WebSocket\\App', 'VSlim/WebSocket/App.php');
$requireClass('VHttpd\\PhpWorker\\Server', 'VHttpd/PhpWorker/Server.php');
