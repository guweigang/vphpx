<?php
declare(strict_types=1);

namespace VSlim\Worker;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\RequestHandlerInterface;
use VHttpd\PhpWorker\StreamResponse;
use VSlim\App;
use VSlim\Stream\Response as SlimStreamResponse;
use VSlim\VHttpd\Response as SlimResponse;

final class Adapter
{
    public static function http(callable $handler): callable
    {
        return static function (array $request, array $envelope = []) use ($handler): array|StreamResponse {
            try {
                $response = $handler($request, $envelope);
                if (is_array($response) || $response instanceof StreamResponse) {
                    return $response;
                }
                return self::response($response);
            } catch (\Throwable $error) {
                $headers = [
                    'x-worker-error-class' => $error instanceof \TypeError ? 'app_contract_error' : 'worker_runtime_error',
                    'x-worker-exception' => $error::class,
                ];
                return ['status' => 500, 'headers' => $headers, 'body' => 'Internal Server Error'];
            }
        };
    }

    public static function app(App $app): callable
    {
        return self::http(static fn (array $envelope) => self::dispatch($app, $envelope));
    }

    public static function psr(callable|RequestHandlerInterface $handler, object $requests, object $streams): callable
    {
        $handle = $handler instanceof RequestHandlerInterface ? $handler->handle(...) : $handler;
        return self::http(static fn (array $envelope): array => self::psrResponse(
            $handle(self::request($envelope, $requests, $streams), $envelope),
        ));
    }

    public static function middleware(RequestHandlerInterface $handler, array $middlewares): RequestHandlerInterface
    {
        foreach (array_reverse($middlewares) as $middleware) {
            $handler = new class($middleware, $handler) implements RequestHandlerInterface {
                public function __construct(private object $middleware, private RequestHandlerInterface $next) {}

                public function handle(ServerRequestInterface $request): ResponseInterface
                {
                    return $this->middleware->process($request, $this->next);
                }
            };
        }
        return $handler;
    }

    public static function request(array $envelope, object $requests, object $streams): object
    {
        $path = (string) ($envelope['path'] ?? '/');
        $host = (string) ($envelope['host'] ?? '');
        $port = (string) ($envelope['port'] ?? '');
        $scheme = (string) ($envelope['scheme'] ?? 'http');
        $version = (string) ($envelope['protocol_version'] ?? '1.1');
        $uri = $host !== '' && str_starts_with($path, '/')
            ? $scheme . '://' . $host . ($port === '' ? '' : ':' . $port) . $path
            : $path;
        $server = ($envelope['server'] ?? []) + [
            'HTTP_HOST' => $host,
            'REMOTE_ADDR' => (string) ($envelope['remote_addr'] ?? ''),
            'SERVER_PROTOCOL' => 'HTTP/' . $version,
        ];
        $request = $requests->createServerRequest((string) ($envelope['method'] ?? 'GET'), $uri, $server)
            ->withProtocolVersion($version)
            ->withBody($streams->createStream((string) ($envelope['body'] ?? '')))
            ->withCookieParams($envelope['cookies'] ?? [])
            ->withQueryParams($envelope['query'] ?? [])
            ->withUploadedFiles($envelope['uploaded_files'] ?? []);
        foreach ($envelope['headers'] ?? [] as $name => $value) {
            $request = $request->withHeader($name, is_array($value) ? implode(', ', $value) : (string) $value);
        }
        foreach ($envelope['attributes'] ?? [] as $name => $value) {
            $request = $request->withAttribute($name, $value);
        }
        return $request;
    }

    public static function dispatch(App $app, array $envelope): array|StreamResponse
    {
        return self::response($app->dispatchEnvelopeWorker($envelope));
    }

    public static function response(SlimResponse|SlimStreamResponse|ResponseInterface $response): array|StreamResponse
    {
        if ($response instanceof SlimStreamResponse) {
            return new StreamResponse(
                $response->chunks(),
                $response->status,
                $response->headers(),
                $response->streamType,
                $response->contentType,
            );
        }
        if ($response instanceof SlimResponse) {
            return [
                'status' => $response->status,
                'content_type' => $response->contentType,
                'headers' => $response->headers(),
                'body' => $response->body,
            ];
        }
        return self::psrResponse($response);
    }

    private static function psrResponse(object $response): array
    {
        $stream = $response->getBody();
        if ($stream instanceof \Stringable) {
            $body = (string) $stream;
        } else {
            $stream->rewind();
            $body = $stream->getContents();
        }
        $headers = array_change_key_case(array_map(
            static fn (array $values): string => implode(', ', $values),
            $response->getHeaders(),
        ));
        $headers['content-length'] ??= (string) strlen($body);
        return [
            'status' => $response->getStatusCode(),
            'headers' => $headers,
            'body' => $body,
        ];
    }
}
