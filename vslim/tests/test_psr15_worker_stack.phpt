--TEST--
VHTTPD worker dispatches PSR-15 middleware stack bootstrap
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace {
    if (!interface_exists('Psr\\Http\\Message\\ServerRequestInterface')) {
        eval('namespace Psr\\Http\\Message { interface ServerRequestInterface {} interface ResponseInterface {} }');
    }
    if (!interface_exists('Psr\\Http\\Server\\RequestHandlerInterface')) {
        eval('namespace Psr\\Http\\Server { interface RequestHandlerInterface { public function handle(\\Psr\\Http\\Message\\ServerRequestInterface $request): \\Psr\\Http\\Message\\ResponseInterface; } }');
    }
    if (!interface_exists('Psr\\Http\\Server\\MiddlewareInterface')) {
        eval('namespace Psr\\Http\\Server { interface MiddlewareInterface { public function process(\\Psr\\Http\\Message\\ServerRequestInterface $request, RequestHandlerInterface $handler): \\Psr\\Http\\Message\\ResponseInterface; } }');
    }
}

namespace Nyholm\Psr7\Factory {
    final class Psr17Factory {
        public function createServerRequest(string $method, string $uri, array $server = []): \TestPsr7Request {
            return new \TestPsr7Request($method, $uri, $server);
        }
        public function createStream(string $content): \TestPsr7Stream {
            return new \TestPsr7Stream($content);
        }
    }
}

namespace {
    final class TestPsr7Stream implements \Psr\Http\Message\StreamInterface {
        public function __construct(public string $content) {}
        public function __toString(): string { return $this->content; }
        public function close() {}
        public function detach() { return null; }
        public function getSize() { return strlen($this->content); }
        public function tell() { return 0; }
        public function eof() { return true; }
        public function isSeekable() { return false; }
        public function seek($offset, $whence = SEEK_SET) {}
        public function rewind() {}
        public function isWritable() { return false; }
        public function write($string) { return 0; }
        public function isReadable() { return true; }
        public function read($length) { return substr($this->content, 0, (int) $length); }
        public function getContents() { return $this->content; }
        public function getMetadata($key = null) { return $key === null ? [] : null; }
    }

    final class TestPsr7Uri implements \Psr\Http\Message\UriInterface {
        public function __construct(
            public string $scheme,
            public string $host,
            public ?int $port,
            public string $path,
            public string $query,
        ) {}
        public function getScheme() { return $this->scheme; }
        public function getAuthority() { return $this->host . ($this->port !== null ? ':' . $this->port : ''); }
        public function getUserInfo() { return ''; }
        public function getHost() { return $this->host; }
        public function getPort() { return $this->port; }
        public function getPath() { return $this->path; }
        public function getQuery() { return $this->query; }
        public function getFragment() { return ''; }
        public function withScheme($scheme) { $clone = clone $this; $clone->scheme = (string) $scheme; return $clone; }
        public function withUserInfo($user, $password = null) { return clone $this; }
        public function withHost($host) { $clone = clone $this; $clone->host = (string) $host; return $clone; }
        public function withPort($port) { $clone = clone $this; $clone->port = $port === null ? null : (int) $port; return $clone; }
        public function withPath($path) { $clone = clone $this; $clone->path = (string) $path; return $clone; }
        public function withQuery($query) { $clone = clone $this; $clone->query = (string) $query; return $clone; }
        public function withFragment($fragment) { return clone $this; }
        public function __toString(): string {
            $uri = $this->scheme . '://' . $this->host;
            if ($this->port !== null) {
                $uri .= ':' . $this->port;
            }
            $uri .= $this->path;
            if ($this->query !== '') {
                $uri .= '?' . $this->query;
            }
            return $uri;
        }
    }

    final class TestPsr7Request implements \Psr\Http\Message\ServerRequestInterface {
        public string $protocolVersion = '1.1';
        public array $headers = [];
        public array $cookies = [];
        public array $query = [];
        public array $attributes = [];
        public array $uploadedFiles = [];
        public ?TestPsr7Stream $body = null;

        public function __construct(
            public string $method,
            public string $uri,
            public array $server
        ) {
            $this->body = new TestPsr7Stream('');
        }

        public function getRequestTarget() { return $this->uri; }
        public function withRequestTarget($requestTarget) { $clone = clone $this; $clone->uri = (string) $requestTarget; return $clone; }
        public function getMethod() { return $this->method; }
        public function withMethod($method) { $clone = clone $this; $clone->method = (string) $method; return $clone; }
        public function getUri() {
            $parts = parse_url($this->uri);
            return new TestPsr7Uri(
                (string) ($parts['scheme'] ?? 'http'),
                (string) ($parts['host'] ?? ''),
                isset($parts['port']) ? (int) $parts['port'] : null,
                (string) ($parts['path'] ?? '/'),
                (string) ($parts['query'] ?? ''),
            );
        }
        public function withUri(\Psr\Http\Message\UriInterface $uri, $preserveHost = false) { $clone = clone $this; $clone->uri = (string) $uri; return $clone; }
        public function getProtocolVersion() { return $this->protocolVersion; }
        public function withProtocolVersion($version): self {
            $clone = clone $this;
            $clone->protocolVersion = (string) $version;
            return $clone;
        }
        public function getHeaders() { return $this->headers; }
        public function hasHeader($name) { return array_key_exists($name, $this->headers); }
        public function getHeader($name) { return isset($this->headers[$name]) ? (array) $this->headers[$name] : []; }
        public function getHeaderLine($name) { return implode(', ', $this->getHeader($name)); }
        public function withBody(\Psr\Http\Message\StreamInterface $body): self {
            $clone = clone $this;
            $clone->body = $body;
            return $clone;
        }
        public function getBody() { return $this->body; }
        public function withCookieParams(array $cookies): self {
            $clone = clone $this;
            $clone->cookies = $cookies;
            return $clone;
        }
        public function getCookieParams() { return $this->cookies; }
        public function withQueryParams(array $query): self {
            $clone = clone $this;
            $clone->query = $query;
            return $clone;
        }
        public function getQueryParams() { return $this->query; }
        public function withUploadedFiles(array $uploadedFiles): self {
            $clone = clone $this;
            $clone->uploadedFiles = $uploadedFiles;
            return $clone;
        }
        public function getUploadedFiles() { return $this->uploadedFiles; }
        public function withHeader($name, $value): self {
            $clone = clone $this;
            $clone->headers[(string) $name] = (array) $value;
            return $clone;
        }
        public function withAddedHeader($name, $value): self {
            $clone = clone $this;
            $existing = isset($clone->headers[$name]) ? (array) $clone->headers[$name] : [];
            $clone->headers[$name] = array_merge($existing, (array) $value);
            return $clone;
        }
        public function withoutHeader($name): self {
            $clone = clone $this;
            unset($clone->headers[$name]);
            return $clone;
        }
        public function getServerParams() { return $this->server; }
        public function getParsedBody() { return null; }
        public function withParsedBody($parsedBody): self { return clone $this; }
        public function getAttributes() { return $this->attributes; }
        public function getAttribute($name, $default = null) { return $this->attributes[$name] ?? $default; }
        public function withAttribute($name, $value): self {
            $clone = clone $this;
            $clone->attributes[(string) $name] = $value;
            return $clone;
        }
        public function withoutAttribute($name): self {
            $clone = clone $this;
            unset($clone->attributes[(string) $name]);
            return $clone;
        }
    }

    final class TestPsr7Response implements \Psr\Http\Message\ResponseInterface {
        public function __construct(
            private int $status,
            private array $headers,
            private \Psr\Http\Message\StreamInterface $body,
        ) {}
        public function getStatusCode() { return $this->status; }
        public function withStatus($code, $reasonPhrase = '') { $clone = clone $this; $clone->status = (int) $code; return $clone; }
        public function getReasonPhrase() { return ''; }
        public function getProtocolVersion() { return '1.1'; }
        public function withProtocolVersion($version) { return clone $this; }
        public function getHeaders() { return $this->headers; }
        public function hasHeader($name) { return array_key_exists($name, $this->headers); }
        public function getHeader($name) { return isset($this->headers[$name]) ? (array) $this->headers[$name] : []; }
        public function getHeaderLine($name) { return implode(', ', $this->getHeader($name)); }
        public function withHeader($name, $value) { $clone = clone $this; $clone->headers[$name] = (array) $value; return $clone; }
        public function withAddedHeader($name, $value) { $clone = clone $this; $clone->headers[$name] = array_merge($clone->getHeader($name), (array) $value); return $clone; }
        public function withoutHeader($name) { $clone = clone $this; unset($clone->headers[$name]); return $clone; }
        public function getBody() { return $this->body; }
        public function withBody(\Psr\Http\Message\StreamInterface $body) { $clone = clone $this; $clone->body = $body; return $clone; }
    }

    putenv('VHTTPD_APP=' . __DIR__ . '/fixtures/psr15_stack_app_fixture.php');
    define('VSLIM_HTTPD_WORKER_NOAUTO', true);
    $autoload = dirname(__DIR__, 3) . '/vhttpd/php/package/vendor/autoload.php';
    if (!is_file($autoload)) {
        $autoload = dirname(__DIR__) . '/vendor/autoload.php';
    }
    if (!is_file($autoload)) { echo "autoload_missing\n"; exit; }
    require_once $autoload;

    $worker = new \VPhp\VHttpd\PhpWorker\Server('/tmp/vslim_worker_test.sock');
    $res = $worker->dispatchRequest([
        'id' => 'req-psr15-stack',
        'method' => 'GET',
        'path' => '/stack/run?trace_id=worker-stack',
        'query' => ['trace_id' => 'worker-stack'],
        'headers' => ['content-type' => 'application/json'],
        'cookies' => ['sid' => 'cookie-stack'],
        'attributes' => ['source' => 'psr15-stack'],
        'body' => '',
        'scheme' => 'https',
        'host' => 'demo.local',
        'port' => '443',
        'protocol_version' => '2',
        'remote_addr' => '127.0.0.1',
        'server' => ['REQUEST_TIME_FLOAT' => '1.23'],
        'uploaded_files' => [],
    ]);

    echo $res['id'] . PHP_EOL;
    echo $res['status'] . '|' . $res['content_type'] . '|' . $res['headers']['x-app'] . PHP_EOL;
    echo $res['body'] . PHP_EOL;
}
?>
--EXPECT--
req-psr15-stack
209|text/plain; charset=utf-8|psr15, stack
stack|GET|https://demo.local:443/stack/run?trace_id=worker-stack|worker-stack|mw1-mw2
