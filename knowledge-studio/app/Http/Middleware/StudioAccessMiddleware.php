<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class StudioAccessMiddleware implements MiddlewareInterface
{
    public function __construct(private \VSlim\App $app)
    {
    }

    private function debug(string $message): void
    {
        if (getenv('KS_DEBUG') === false || getenv('KS_DEBUG') === '') {
            return;
        }
        file_put_contents('php://stderr', "[ks-debug] access {$message}\n");
    }

    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler,
    ): ResponseInterface {
        $this->debug('enter');
        $path = $request->getUri()->getPath();
        $isAuthed = $this->app->authCheck($request);

        if ($path === '/login' && $isAuthed) {
            return (new \VSlim\Psr7\Response(302, ''))
                ->withHeader('location', '/console');
        }

        if (str_starts_with($path, '/console') && !$isAuthed) {
            $this->debug('redirect-login');
            return (new \VSlim\Psr7\Response(302, ''))
                ->withHeader('location', '/login');
        }

        $response = $handler->handle($request);
        if (getenv('KS_DEBUG') !== false && getenv('KS_DEBUG') !== '') {
            $this->debug('response-status=' . (string) $response->getStatusCode());
        }
        $this->debug('return');
        return $response;
    }
}
