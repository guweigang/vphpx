<?php
declare(strict_types=1);

namespace App\Http\Middleware {
    use Psr\Http\Server\RequestHandlerInterface;

    final class TraceMiddleware
    {
        public function process(
            mixed $request,
            RequestHandlerInterface $handler,
        ): mixed {
            $trace = trim((string) $request->getHeaderLine('x-trace-id'));
            if ($trace === '') {
                $trace = 'template-trace';
            }

            return $handler->handle(
                $request
                    ->withHeader('x-trace-id', $trace)
                    ->withAttribute('template_middleware', 'yes')
            )->withHeader('x-template-app', 'vslim-template');
        }
    }
}
