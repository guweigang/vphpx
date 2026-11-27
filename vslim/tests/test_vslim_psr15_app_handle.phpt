--TEST--
VSlim App handles PSR-15 requests natively
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace {
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
}

namespace {
    use Psr\Http\Message\ResponseInterface;
    use Psr\Http\Message\ServerRequestInterface;
    use Psr\Http\Server\MiddlewareInterface;
    use Psr\Http\Server\RequestHandlerInterface;

    $app = new VSlim\App();
    $api = $app->group('/api');

    $app->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle($request->withAttribute('mw', 'global'));
        }
    });

    $api->middleware(new class implements MiddlewareInterface {
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $current = (string) $request->getAttribute('mw', '');
            return $handler->handle($request->withAttribute('mw', $current . '-group'));
        }
    });

    $app->get('/api/hello/:name', new class implements RequestHandlerInterface {
        public function handle(ServerRequestInterface $request): ResponseInterface
        {
            $response = new VSlim\Psr7\Response(207, '');
            $response = $response->withHeader('X-MW', (string) $request->getAttribute('mw', ''));
            $body = $response->getBody();
            $body->write(sprintf(
                'hello|%s|%s|%s',
                (string) $request->getAttribute('name', ''),
                (string) $request->getAttribute('mw', ''),
                (string) $request->getAttribute('trace_id', '')
            ));
            return $response->withBody($body);
        }
    });

    $request = (new VSlim\Psr7\ServerRequest())
        ->withMethod('GET')
        ->withUri(new VSlim\Psr7\Uri('https://example.com/api/hello/world?trace_id=query-trace'))
        ->withAttribute('trace_id', 'attr-trace');

    $response = $app->handle(request: $request);

    echo ($app instanceof RequestHandlerInterface ? 'handler' : 'no'), PHP_EOL;
    echo get_class($response), PHP_EOL;
    echo $response->getStatusCode(), PHP_EOL;
    echo $response->getHeaderLine('x-mw'), PHP_EOL;
    echo (string) $response->getBody(), PHP_EOL;

    function testPipe(string $contents): array
    {
        $php = 'echo ' . var_export($contents, true) . ';';
        $process = proc_open([PHP_BINARY, '-n', '-r', $php], [1 => ['pipe', 'w']], $pipes);
        return [$process, (new VSlim\Psr17\StreamFactory())->createStreamFromResource($pipes[1])];
    }

    [$inputProcess, $input] = testPipe('request body');
    [$outputProcess, $output] = testPipe('response body');
    $streamApp = new VSlim\App();
    $before = new class($input) implements MiddlewareInterface {
        public function __construct(private object $body) {}
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            if ($request->getBody() !== $this->body || $request->getAttribute('name') !== 'world') {
                throw new RuntimeException('Before middleware lost the body or route parameters');
            }
            return $handler->handle($request->withAttribute('phase', 'before'));
        }
    };
    $middle = new class($input, $output) implements MiddlewareInterface {
        public function __construct(private object $input, private object $output) {}
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            if ($request->getBody() !== $this->input || $request->getAttribute('phase') !== 'before') {
                throw new RuntimeException('Standard middleware lost the forwarded request');
            }
            $response = $handler->handle($request->withAttribute('phase', 'middle'));
            if ($response->getBody() !== $this->output) {
                throw new RuntimeException('Next handler replaced the response stream');
            }
            return $response->withHeader('X-Middle', 'yes');
        }
    };
    $after = new class($input, $output) implements MiddlewareInterface {
        public function __construct(private object $input, private object $output) {}
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            $response = $handler->handle($request);
            if ($request->getBody() !== $this->input || $request->getAttribute('phase') !== 'middle'
                || $response->getBody() !== $this->output) {
                throw new RuntimeException('After middleware lost the forwarded streams or attributes');
            }
            return $response->withHeader('X-After', 'yes');
        }
    };
    $streamApp->middleware(handler: $before, phase: VSlim\MiddlewarePhase::before);
    $streamApp->middleware($middle);
    $streamApp->middleware(handler: $after, phase: VSlim\MiddlewarePhase::after);
    $streamApp->post('/stream/:name', static function (ServerRequestInterface $request) use ($input, $output): ResponseInterface {
        $body = $request->getBody();
        if ($body !== $input || $body->read(1) . $body->getContents() !== 'request body') {
            throw new RuntimeException('PSR-15 dispatch consumed the input before the handler');
        }
        return (new VSlim\Psr7\Response(202))->withBody($output);
    });
    $incoming = (new VSlim\Psr7\ServerRequest())
        ->withMethod('POST')->withUri(new VSlim\Psr7\Uri('/stream/world'))
        ->withHeader('Content-Type', 'application/octet-stream')->withBody($input);
    $final = $streamApp->handle($incoming);
    if ($final->getBody() !== $output) {
        throw new RuntimeException('Application replaced the final response stream');
    }
    echo implode('|', [$final->getStatusCode(), $final->getHeaderLine('X-Middle'),
        $final->getHeaderLine('X-After'), $final->getBody()->getContents()]), PHP_EOL;
    $input->close();
    $output->close();
    proc_close($inputProcess);
    proc_close($outputProcess);

    $validationApp = new VSlim\App();
    $validationApp->delete('/validated', static function (ServerRequestInterface $request): ResponseInterface {
        return (new VSlim\Psr7\Response())->withHeader('X-Replay', $request->getBody()->getContents());
    });
    [$formProcess, $form] = testPipe('_method=DELETE&answer=42');
    $formRequest = (new VSlim\Psr7\ServerRequest())
        ->withMethod('POST')->withUri(new VSlim\Psr7\Uri('/validated'))
        ->withHeader('Content-Type', 'application/x-www-form-urlencoded')->withBody($form);
    $validated = $validationApp->handle($formRequest);
    echo $validated->getStatusCode() . '|' . $validated->getHeaderLine('X-Replay'), PHP_EOL;
    $form->close();
    proc_close($formProcess);

    [$jsonProcess, $json] = testPipe('{unclosed');
    $invalid = $formRequest->withMethod('DELETE')->withHeader('Content-Type', 'application/json')->withBody($json);
    echo $validationApp->handle($invalid)->getStatusCode(), PHP_EOL;
    $json->close();
    proc_close($jsonProcess);

    $seekable = (new VSlim\Psr17\StreamFactory())->createStream('{"key":"value"}');
    $seekable->seek(4);
    $validationApp->post('/cursor', static function (ServerRequestInterface $request) use ($seekable): ResponseInterface {
        if ($request->getBody() !== $seekable || $seekable->tell() !== 4) {
            throw new RuntimeException('Validation moved or replaced the seekable input stream');
        }
        return new VSlim\Psr7\Response(201);
    });
    $cursorRequest = $invalid->withMethod('POST')->withUri(new VSlim\Psr7\Uri('/cursor'))->withBody($seekable);
    echo $validationApp->handle($cursorRequest)->getStatusCode(), PHP_EOL;

    $previousLimit = getenv('VSLIM_MAX_BODY_BYTES');
    putenv('VSLIM_MAX_BODY_BYTES=4');
    [$limitProcess, $large] = testPipe('12345');
    $limited = $formRequest->withMethod('DELETE')
        ->withHeader('Content-Type', 'application/octet-stream')->withBody($large);
    echo $validationApp->handle($limited)->getStatusCode(), PHP_EOL;
    $large->close();
    proc_close($limitProcess);
    putenv($previousLimit === false ? 'VSLIM_MAX_BODY_BYTES' : 'VSLIM_MAX_BODY_BYTES=' . $previousLimit);

    [$echoProcess, $echoBody] = testPipe('forwarded bytes');
    $echoApp = new VSlim\App();
    $echoApp->middleware(new class($echoBody) implements MiddlewareInterface {
        public function __construct(private object $body) {}
        public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
        {
            return $handler->handle($request->withBody($this->body));
        }
    });
    $echoApp->post('/echo', static fn (ServerRequestInterface $request): ResponseInterface =>
        (new VSlim\Psr7\Response())->withBody($request->getBody()));
    $echo = $echoApp->dispatchEnvelopeWorker([
        'method' => 'POST', 'path' => '/echo', 'headers' => ['x-request-id' => 'echo-rid'],
    ]);
    if (!$echo instanceof VSlim\Stream\Response || $echo->header('x-request-id') !== 'echo-rid') {
        throw new RuntimeException('The worker lost the echoed stream or request metadata');
    }
    echo implode('', iterator_to_array($echo->chunks(), false)), PHP_EOL;
    $echoBody->close();
    proc_close($echoProcess);
}
?>
--EXPECT--
handler
VSlim\Psr7\Response
207
global-group
hello|world|global-group|attr-trace
202|yes|yes|response body
200|_method=DELETE&answer=42
400
201
413
forwarded bytes
