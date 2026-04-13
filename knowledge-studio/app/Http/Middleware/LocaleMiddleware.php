<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use App\Support\LocaleCatalog;
use App\Support\LocalePreferenceResolver;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class LocaleMiddleware implements MiddlewareInterface
{
    public function __construct(
        private LocaleCatalog $locales,
        private LocalePreferenceResolver $resolver,
    )
    {
    }

    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler,
    ): ResponseInterface {
        $params = $request->getQueryParams();
        $locale = $this->resolver->resolve(
            is_array($params) ? $params : [],
            (string) $request->getUri()->getQuery(),
            (string) $request->getHeaderLine('accept-language'),
        );
        $response = $handler->handle($request->withAttribute('studio.locale', $locale));

        return $response->withHeader('content-language', $locale);
    }
}
