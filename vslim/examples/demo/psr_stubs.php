<?php
declare(strict_types=1);

namespace Psr\Http\Message {
    if (!interface_exists(RequestInterface::class, false)) {
        interface RequestInterface {}
    }

    if (!interface_exists(ServerRequestInterface::class, false)) {
        interface ServerRequestInterface extends RequestInterface {}
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
