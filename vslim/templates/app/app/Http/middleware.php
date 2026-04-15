<?php
declare(strict_types=1);

use Psr\Http\Server\MiddlewareInterface;

if (!interface_exists(MiddlewareInterface::class)) {
    return static function (VSlim\App $app): void {};
}

return function (VSlim\App $app): void {
    $app->middleware($app->startSessionMiddleware());
    $app->middleware(\App\Http\Middleware\TraceMiddleware::class);
};
