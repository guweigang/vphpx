<?php
declare(strict_types=1);

use Psr\Http\Server\MiddlewareInterface;

if (!interface_exists(MiddlewareInterface::class)) {
    return static function (VSlim\App $app): void {};
}

return function (VSlim\App $app): void {
    if (getenv('KS_DISABLE_MIDDLEWARE') !== false && getenv('KS_DISABLE_MIDDLEWARE') !== '') {
        return;
    }
    if (getenv('KS_DISABLE_SESSION_MIDDLEWARE') === false || getenv('KS_DISABLE_SESSION_MIDDLEWARE') === '') {
        $app->middleware($app->startSessionMiddleware());
    }
    if (getenv('KS_DISABLE_TRACE_MIDDLEWARE') === false || getenv('KS_DISABLE_TRACE_MIDDLEWARE') === '') {
        if (getenv('KS_TRACE_AS_OBJECT') !== false && getenv('KS_TRACE_AS_OBJECT') !== '') {
            $app->middleware(new \App\Http\Middleware\TraceMiddleware());
        } else {
            $app->middleware(\App\Http\Middleware\TraceMiddleware::class);
        }
    }
    $app->middleware(new \App\Http\Middleware\LocaleMiddleware(
        $app->container()->get(\App\Support\LocaleCatalog::class),
        $app->container()->get(\App\Support\LocalePreferenceResolver::class),
    ));
    if (getenv('KS_DISABLE_ACCESS_MIDDLEWARE') === false || getenv('KS_DISABLE_ACCESS_MIDDLEWARE') === '') {
        $app->middleware(new \App\Http\Middleware\StudioAccessMiddleware($app));
    }
    if (getenv('KS_DISABLE_WORKSPACE_MIDDLEWARE') === false || getenv('KS_DISABLE_WORKSPACE_MIDDLEWARE') === '') {
        $app->middleware(
            new \App\Http\Middleware\WorkspaceContextMiddleware(
                $app,
                $app->container()->get('studio.catalog'),
                $app->container()->get(\App\Repositories\WorkspaceRepository::class),
            )
        );
    }
};
