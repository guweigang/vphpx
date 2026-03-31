<?php
declare(strict_types=1);

namespace Psr\Http\Message {
    if (!interface_exists(RequestInterface::class, false)) {
        interface RequestInterface {}
    }

    if (!interface_exists(ServerRequestInterface::class, false)) {
        interface ServerRequestInterface extends RequestInterface
        {
            public function getAttribute(string $name, $default = null);
            public function withAttribute(string $name, $value);
        }
    }

    if (!interface_exists(ResponseInterface::class, false)) {
        interface ResponseInterface {}
    }
}

namespace Psr\Http\Server {
    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;

    if (!interface_exists(RequestHandlerInterface::class, false)) {
        interface RequestHandlerInterface
        {
            public function handle(ServerRequestInterface $request): ResponseInterface;
        }
    }

    if (!interface_exists(MiddlewareInterface::class, false)) {
        interface MiddlewareInterface
        {
            public function process(
                ServerRequestInterface $request,
                RequestHandlerInterface $handler,
            ): ResponseInterface;
        }
    }
}

namespace {
    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    if (!class_exists("AppDirTraceMiddleware", false)) {
        final class AppDirTraceMiddleware implements MiddlewareInterface
        {
            public function process(
                ServerRequestInterface $request,
                RequestHandlerInterface $handler,
            ): ResponseInterface {
                return $handler->handle($request->withAttribute("dir_mw", "yes"));
            }
        }
    }
}
