<?php
declare(strict_types=1);

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

return function (VSlim\App $app): void {
    $app->middleware(\App\Http\Middleware\TraceMiddleware::class);
    $app->after(new class implements MiddlewareInterface {
        public function process(
            ServerRequestInterface $request,
            RequestHandlerInterface $handler,
        ): ResponseInterface {
            return $handler
                ->handle($request)
                ->withHeader(
                    "x-app-http-middleware",
                    (string) $request->getAttribute("http_class_mw", "")
                );
        }
    });
};
