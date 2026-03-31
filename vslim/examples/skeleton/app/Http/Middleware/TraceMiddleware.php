<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class TraceMiddleware implements MiddlewareInterface
{
    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler,
    ): ResponseInterface {
        $trace = trim((string) $request->getHeaderLine("x-trace-id"));
        if ($trace === "") {
            $query = $request->getQueryParams();
            $candidate = $query["trace_id"] ?? "";
            $trace = is_string($candidate) && $candidate !== ""
                ? $candidate
                : "skeleton-trace";
        }

        return $handler->handle(
            $request
                ->withHeader("x-trace-id", $trace)
                ->withAttribute("skeleton_layer", "http-middleware")
        );
    }
}
