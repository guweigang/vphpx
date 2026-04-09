<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class TraceMiddleware implements MiddlewareInterface
{
    private function debug(string $message): void
    {
        if (getenv('KS_DEBUG') === false || getenv('KS_DEBUG') === '') {
            return;
        }
        file_put_contents('php://stderr', "[ks-debug] trace {$message}\n");
    }

    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler,
    ): ResponseInterface {
        $this->debug('enter');
        $trace = trim((string) $request->getHeaderLine('x-trace-id'));
        if ($trace === '') {
            $trace = 'knowledge-studio-trace';
        }

        $nextRequest = $request;
        if (getenv('KS_TRACE_SKIP_REQUEST_HEADER') === false || getenv('KS_TRACE_SKIP_REQUEST_HEADER') === '') {
            $nextRequest = $request->withHeader('x-trace-id', $trace);
        }

        $response = $handler->handle($nextRequest);
        $this->debug('after-handle');
        if (getenv('KS_TRACE_SKIP_RESPONSE_HEADER') === false || getenv('KS_TRACE_SKIP_RESPONSE_HEADER') === '') {
            $response = $response->withHeader('x-knowledge-studio', 'foundation');
        }
        $this->debug('return');
        return $response;
    }
}
