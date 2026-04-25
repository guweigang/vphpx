--TEST--
VSlim App can use an injected PSR-20 clock for runtime trace timestamps
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

        public function now(): DateTimeImmutable
        {
            return $this->now;
        }
    }

    putenv('VSLIM_TRACE_MEM=1');
    putenv('VSLIM_TRACE_MEM_EVERY=1');

    $logFile = sys_get_temp_dir() . '/vslim_app_clock_' . getmypid() . '.log';
    @unlink($logFile);

    $clock = new FixedClock(new DateTimeImmutable('2024-01-01T00:00:00.123+00:00'));
    $logger = (new VSlim\Log\Logger())
        ->setLevel(VSlim\Log\Level::DEBUG)
        ->setOutputFile($logFile);

    $app = new VSlim\App();
    var_dump($app->setClock($clock) === $app);
    var_dump($app->clock() === $clock);

    $app->setLogger($logger);
    $app->get('/ping', fn () => 'pong');
    $res = $app->dispatch('GET', '/ping');

    var_dump($res->status);

    clearstatcache();
    $body = file_exists($logFile) ? file_get_contents($logFile) : '';
    echo str_contains($body, 'ts=1704067200123') ? "ts-ok\n" : "ts-miss\n";

    @unlink($logFile);
}
?>
--EXPECTF--
bool(true)
bool(true)
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
%smemory trace%s ts=1704067200123
int(200)
ts-ok
