<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use App\Support\DemoCatalog;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class WorkspaceContextMiddleware implements MiddlewareInterface
{
    public function __construct(
        private \VSlim\App $app,
        private DemoCatalog $catalog,
    ) {
    }

    private function debug(string $message): void
    {
        if (getenv('KS_DEBUG') === false || getenv('KS_DEBUG') === '') {
            return;
        }
        file_put_contents('php://stderr', "[ks-debug] workspace {$message}\n");
    }

    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler,
    ): ResponseInterface {
        $this->debug('enter');
        $workspace = null;
        $tenant = trim((string) $request->getAttribute('tenant', ''));
        if ($tenant === '') {
            $tenant = $this->tenantFromPath($request->getUri()->getPath());
        }
        if ($tenant !== '') {
            $workspace = $this->catalog->findWorkspaceBySlug($tenant);
        }

        if ($workspace === null && $this->app->authCheck($request)) {
            $workspace = $this->catalog->defaultWorkspaceForUser(
                $this->app->authId($request),
            );
        }

        $user = $this->app->authCheck($request)
            ? $this->app->authUser($request)
            : null;

        $request = $request
            ->withAttribute('studio.workspace', $workspace)
            ->withAttribute('studio.viewer', $user);

        $response = $handler->handle($request);
        if (getenv('KS_DEBUG') !== false && getenv('KS_DEBUG') !== '') {
            $this->debug('response-status=' . (string) $response->getStatusCode());
        }
        $this->debug('return');
        return $response;
    }

    private function tenantFromPath(string $path): string
    {
        $trimmed = trim($path, '/');
        if ($trimmed === '') {
            return '';
        }

        $parts = explode('/', $trimmed);
        if (($parts[0] ?? '') !== 'brand') {
            return '';
        }

        return trim((string) ($parts[1] ?? ''));
    }
}
