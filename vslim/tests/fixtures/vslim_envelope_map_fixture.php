<?php

declare(strict_types=1);

if (!interface_exists('Psr\\Http\\Message\\MessageInterface')) {
    eval('namespace Psr\\Http\\Message {
        interface MessageInterface {
            public function getProtocolVersion(): string;
            public function withProtocolVersion(string $version);
            public function getHeaders(): array;
            public function hasHeader(string $name): bool;
            public function getHeader($name): array;
            public function getHeaderLine($name): string;
            public function withHeader($name, $value);
            public function withAddedHeader($name, $value);
            public function withoutHeader($name);
            public function getBody(): StreamInterface;
            public function withBody(StreamInterface $body);
        }
        interface StreamInterface {
            public function __toString(): string;
            public function close(): void;
            public function detach();
            public function getSize(): ?int;
            public function tell(): int;
            public function eof(): bool;
            public function isSeekable(): bool;
            public function seek(int $offset, int $whence = SEEK_SET): void;
            public function rewind(): void;
            public function isWritable(): bool;
            public function write(string $string): int;
            public function isReadable(): bool;
            public function read(int $length): string;
            public function getContents(): string;
            public function getMetadata($key = null);
        }
        interface UriInterface {
            public function getScheme(): string;
            public function getAuthority(): string;
            public function getUserInfo(): string;
            public function getHost(): string;
            public function getPort(): ?int;
            public function getPath(): string;
            public function getQuery(): string;
            public function getFragment(): string;
            public function withScheme(string $scheme);
            public function withUserInfo(string $user, ?string $password = null);
            public function withHost(string $host);
            public function withPort(?int $port);
            public function withPath(string $path);
            public function withQuery(string $query);
            public function withFragment(string $fragment);
            public function __toString(): string;
        }
        interface RequestInterface extends MessageInterface {
            public function getRequestTarget(): string;
            public function withRequestTarget(string $requestTarget);
            public function getMethod(): string;
            public function withMethod(string $method);
            public function getUri(): UriInterface;
            public function withUri(UriInterface $uri, bool $preserveHost = false);
        }
        interface ServerRequestInterface extends RequestInterface {
            public function getServerParams(): array;
            public function getCookieParams(): array;
            public function withCookieParams(array $cookies);
            public function getQueryParams(): array;
            public function withQueryParams(array $query);
            public function getUploadedFiles(): array;
            public function withUploadedFiles(array $uploadedFiles);
            public function getParsedBody();
            public function withParsedBody($data);
            public function getAttributes(): array;
            public function getAttribute(string $name, $default = null);
            public function withAttribute(string $name, $value);
            public function withoutAttribute(string $name);
        }
        interface ResponseInterface extends MessageInterface {
            public function getStatusCode(): int;
            public function withStatus(int $code, string $reasonPhrase = "");
            public function getReasonPhrase(): string;
        }
    }');
}
if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
    eval('namespace Psr\\Http\\Server {
        interface RequestHandlerInterface { public function handle(\\Psr\\Http\\Message\\ServerRequestInterface $request): \\Psr\\Http\\Message\\ResponseInterface; }
        interface MiddlewareInterface { public function process(\\Psr\\Http\\Message\\ServerRequestInterface $request, RequestHandlerInterface $handler): \\Psr\\Http\\Message\\ResponseInterface; }
    }');
}

return static function (mixed $request, array $envelope = []): array {
    static $app = null;
    if (!$app instanceof VSlim\App) {
        $app = new VSlim\App();
        $app->before(new class implements \Psr\Http\Server\MiddlewareInterface {
            public function process(\Psr\Http\Message\ServerRequestInterface $request, \Psr\Http\Server\RequestHandlerInterface $handler): \Psr\Http\Message\ResponseInterface
            {
                $uri = new VSlim\Psr7\Uri('https://phase.map.local/hello/codex?trace_id=phase-map');
                return $handler->handle(
                    $request
                        ->withUri($uri)
                        ->withHeader('x-trace-id', 'phase-map')
                );
            }
        });
        $app->get('/hello/:name', new class implements \Psr\Http\Server\RequestHandlerInterface {
            public function handle(\Psr\Http\Message\ServerRequestInterface $request): \Psr\Http\Message\ResponseInterface
            {
                return (new VSlim\Psr7\Response(200, ''))
                    ->withBody(new VSlim\Psr7\Stream(
                        'Hello, ' . $request->getAttribute('name') . '|' . $request->getHeaderLine('x-trace-id') . '|' . $request->getUri()->getQuery()
                    ))
                    ->withHeader('content-type', 'text/plain; charset=utf-8')
                    ->withHeader('x-app', 'map-fixture')
                    ->withHeader('x-route-trace', $request->getHeaderLine('x-trace-id'));
            }
        });
    }

    $payload = is_array($request) ? $request : $envelope;
    if (!is_array($payload)) {
        return [
            'status' => 500,
            'content_type' => 'text/plain; charset=utf-8',
            'headers' => ['content-type' => 'text/plain; charset=utf-8'],
            'body' => 'invalid payload',
        ];
    }

    $map = $app->dispatch_envelope_map($payload);
    $headers = [];
    foreach ($map as $k => $v) {
        if (is_string($k) && str_starts_with($k, 'headers_')) {
            $name = substr($k, 8);
            if ($name !== '') {
                $headers[$name] = (string) $v;
            }
        }
    }
    if (!isset($headers['content-type'])) {
        $headers['content-type'] = (string) ($map['content_type'] ?? 'text/plain; charset=utf-8');
    }

    return [
        'status' => (int) ($map['status'] ?? '500'),
        'content_type' => (string) ($map['content_type'] ?? 'text/plain; charset=utf-8'),
        'headers' => $headers,
        'body' => (string) ($map['body'] ?? ''),
    ];
};
