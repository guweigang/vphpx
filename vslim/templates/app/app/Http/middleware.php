<?php
declare(strict_types=1);

use Psr\Http\Server\MiddlewareInterface;

if (!interface_exists(MiddlewareInterface::class)) {
    return static function (VSlim\App $app): void {};
}

require_once __DIR__ . '/Middleware/TraceMiddleware.php';

return function (VSlim\App $app): void {
    $app->middleware(\App\Http\Middleware\TraceMiddleware::class);
};
