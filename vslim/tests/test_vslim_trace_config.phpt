--TEST--
VSlim app trace memory settings can be driven by config
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
namespace Psr\Clock {
    if (!interface_exists(ClockInterface::class, false)) {
        interface ClockInterface {
            public function now(): \DateTimeImmutable;
        }
    }
}

namespace {
    final class FixedClock implements Psr\Clock\ClockInterface
    {
        public function __construct(private DateTimeImmutable $now) {}
        public function now(): DateTimeImmutable { return $this->now; }
    }

    putenv('VSLIM_TRACE_MEM=');
    putenv('VSLIM_TRACE_MEM_EVERY=');

    $logFile = sys_get_temp_dir() . '/vslim_trace_config_' . getmypid() . '.log';
    @unlink($logFile);

    $clock = new FixedClock(new DateTimeImmutable('2024-01-01T00:00:00.123+00:00'));
    $logger = (new VSlim\Log\Logger())
        ->set_level(VSlim\Log\Level::DEBUG)
        ->set_output_file($logFile);

    $app = new VSlim\App();
    $app->load_config_text(<<<'TOML'
[app.trace]
memory = true
memory_every = 1
TOML);
    $app->setClock($clock);
    $app->set_logger($logger);
    $app->get('/ping', fn () => 'pong');
    $res = $app->dispatch('GET', '/ping');

    echo $res->status . PHP_EOL;
    clearstatcache();
    $body = file_exists($logFile) ? file_get_contents($logFile) : '';
    echo str_contains($body, 'memory trace') ? "trace-on\n" : "trace-off\n";
    echo str_contains($body, 'ts=1704067200123') ? "ts-ok\n" : "ts-miss\n";

    @unlink($logFile);
}
?>
--EXPECTF--
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
200
trace-on
ts-ok
