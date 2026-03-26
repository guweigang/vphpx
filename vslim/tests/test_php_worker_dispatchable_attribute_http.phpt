--TEST--
php-worker accepts custom HTTP dispatchables marked with VHttpd Dispatchable
--FILE--
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 3) . '/vhttpd/php/package/src/legacy_aliases.php';

$fixture = sys_get_temp_dir() . '/vhttpd_dispatchable_http_fixture.php';
file_put_contents($fixture, <<<'PHP'
<?php
declare(strict_types=1);

use VPhp\VHttpd\Attribute\Dispatchable;

#[Dispatchable('http')]
final class DispatchableHttpFixture
{
    public function dispatch_envelope_worker(array $envelope): array
    {
        return [
            'status' => 200,
            'headers' => [
                'content-type' => 'text/plain; charset=utf-8',
                'x-dispatchable-kind' => 'http',
            ],
            'body' => 'hello:' . ($envelope['path'] ?? '/'),
        ];
    }
}

return new DispatchableHttpFixture();
PHP);

$server = new VPhp\VHttpd\PhpWorker\Server('/tmp/vhttpd_dispatchable_http.sock', $fixture);
$res = $server->dispatchRequest([
    'id' => 'req-http-dispatchable',
    'method' => 'GET',
    'path' => '/attr-http',
    'query' => [],
    'headers' => [],
    'cookies' => [],
    'attributes' => [],
    'body' => '',
    'scheme' => 'http',
    'host' => 'demo.local',
    'port' => '80',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'server' => [],
    'uploaded_files' => [],
]);

echo $res['status'], PHP_EOL;
echo $res['headers']['x-dispatchable-kind'] ?? '', PHP_EOL;
echo $res['body'] ?? '', PHP_EOL;

@unlink($fixture);
?>
--EXPECT--
200
http
hello:/attr-http
