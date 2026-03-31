<?php
declare(strict_types=1);

namespace Psr\Clock {
    if (!interface_exists(ClockInterface::class, false)) {
        interface ClockInterface
        {
            public function now(): \DateTimeImmutable;
        }
    }
}

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
    use Psr\Clock\ClockInterface;
    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    if (!class_exists("ConventionClock", false)) {
        final class ConventionClock implements ClockInterface
        {
            public function __construct(private \DateTimeImmutable $now) {}

            public function now(): \DateTimeImmutable
            {
                return $this->now;
            }
        }
    }

    if (!class_exists("ConventionProvider", false)) {
        final class ConventionProvider extends VSlim\Support\ServiceProvider
        {
            public function register(): void
            {
                $this->app()->container()->set("provider.message", "provider-from-convention");
            }

            public function boot(): void
            {
                $this->app()->container()->set("provider.booted", "yes");
            }
        }
    }

    if (!class_exists("ConventionModule", false)) {
        final class ConventionModule extends VSlim\Support\Module
        {
            public function register(): void
            {
                $this->app()->container()->set("module.registered", "yes");
            }

            public function routes(): void
            {
                $this->app()->get("/module", fn () => "module|" . $this->app()->container()->get("module.booted"));
            }

            public function boot(): void
            {
                $this->app()->container()->set("module.booted", "yes");
            }
        }
    }

    if (!class_exists("ConventionTraceMiddleware", false)) {
        final class ConventionTraceMiddleware implements MiddlewareInterface
        {
            public function process(
                ServerRequestInterface $request,
                RequestHandlerInterface $handler,
            ): ResponseInterface {
                return $handler->handle($request->withAttribute("mw", "yes"));
            }
        }
    }
}
