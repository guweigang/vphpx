--TEST--
php-worker accepts a custom object method exposed as an HTTP callable
--FILE--
<?php
declare(strict_types=1);

require_once __DIR__ . '/worker_wire_fixture.php';

$fixture = tempnam(sys_get_temp_dir(), 'vslim-http-');
file_put_contents($fixture, <<<'PHP'
<?php
declare(strict_types=1);

final class DispatchableHttpFixture
{
    public function dispatchEnvelopeWorker(array $envelope): array
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

return (new DispatchableHttpFixture())->dispatchEnvelopeWorker(...);
PHP);

$server = new WorkerWireFixture($fixture);
$res = $server->request([
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
