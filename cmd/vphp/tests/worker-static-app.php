<?php
declare(strict_types=1);

use VHttpd\PhpWorker\StreamResponse;
use VPHP\Smoke\IntegerCounter;
use VPHP\Smoke\LegacyIntegerCounter;
use VPHP\Smoke\ZendStaticCounter;
use VPHP\Smoke\ZendStaticTrait;

class WorkerGenericCounter extends IntegerCounter
{
    public static int $count = 100;
}

class WorkerLegacyCounter extends LegacyIntegerCounter
{
    public static int $count = 200;
}

class WorkerZendCounter extends ZendStaticCounter
{
    public static int $count = 21;
}

class WorkerZendTraitCounter
{
    use ZendStaticTrait;
}

class WorkerStaticProbeFailure extends RuntimeException {}
class WorkerStaticProbeOuterFailure extends RuntimeException {}

function loadWorkerLateZendCounter(): void
{
    class WorkerLateZendCounter extends ZendStaticCounter
    {
        private const INITIAL = 61;
        public static int $count = self::INITIAL;
    }
}

$tables = [
    'generic' => [IntegerCounter::class, WorkerGenericCounter::class, [5, 100, 'default']],
    'legacy' => [LegacyIntegerCounter::class, WorkerLegacyCounter::class, [0, 200, '']],
];

$rootLabels = ['generic' => 'root generic', 'legacy' => 'root legacy'];
foreach ($tables as $kind => [$base]) {
    $base::$label =& $rootLabels[$kind];
}
$outsideZendCount =& ZendStaticCounter::counterReference();
$outsideZendCount = 37;
WorkerZendCounter::$count =& $outsideZendCount;
$outsideTraitCount =& WorkerZendTraitCounter::traitCountReference();
$outsideTraitCount = 79;

$runNested = static function (
    array $table,
    callable $afterWrites,
    ?callable $beforeWrites = null,
    WorkerStaticProbeFailure|WorkerStaticProbeOuterFailure|null $expectedFailure = null,
    bool $rethrowFromMiddle = false,
    bool $rethrowFromOuter = false,
): void {
    [$base, $child, $defaults] = $table;
    $count = 700;
    $label = 'outer';
    $base::$label =& $label;
    $child::$count =& $count;
    $catchInMiddle = $expectedFailure instanceof WorkerStaticProbeFailure;
    $catchOutside = $rethrowFromMiddle || $expectedFailure instanceof WorkerStaticProbeOuterFailure;

    $resumeOuter = static function () use ($base, $child, $defaults, $afterWrites, $beforeWrites, $expectedFailure, $catchInMiddle, $catchOutside, $rethrowFromMiddle, $rethrowFromOuter, &$count, &$label): void {
        $caughtOutside = false;
        try {
            vphp_standalone_probe_with_static_request(static function () use ($base, $child, $defaults, $afterWrites, $beforeWrites, $expectedFailure, $catchInMiddle, $rethrowFromMiddle, &$count, &$label): void {
                $middleLabel = 'middle';
                $child::$label =& $middleLabel;
                $resumeMiddle = static function () use ($base, $child, $defaults, $afterWrites, $beforeWrites, $expectedFailure, $catchInMiddle, $rethrowFromMiddle, &$middleLabel, &$count, &$label): void {
                    $caught = false;
                    try {
                        vphp_standalone_probe_with_static_request(static function () use ($base, $child, $defaults, $afterWrites, $beforeWrites, &$middleLabel, &$count, &$label): void {
                            if ($beforeWrites !== null) {
                                $beforeWrites();
                            }
                            [$count, $label, $middleLabel] = [900, 'changed outer', 'changed middle'];
                            if ($base::touchWorkerStatics() !== $defaults[0] . ':' . $defaults[2]
                                || $child::touchWorkerStatics() !== $defaults[1] . ':' . $defaults[2] . ':V'
                                || [$base::$count, $child::$count, $base::$label, $child::$label]
                                    !== [$defaults[0] + 1, $defaults[1] + 1, $defaults[2] . ':V:V', $defaults[2] . ':V:V']) {
                                throw new LogicException('Deepest worker did not synchronize V writes from its defaults');
                            }
                            $afterWrites();
                        });
                    } catch (WorkerStaticProbeFailure $error) {
                        if ($error !== $expectedFailure) {
                            throw $error;
                        }
                        $caught = true;
                    } finally {
                        if ($middleLabel !== 'middle:outer' || $child::$label !== $middleLabel
                            || $base::$count !== $defaults[0] + 10 || $child::$count !== $defaults[1]) {
                            throw new LogicException('Deepest worker did not restore the middle state');
                        }
                    }
                    if ($catchInMiddle) {
                        if (!$caught) {
                            throw new LogicException('Middle worker did not catch the original deepest exception');
                        }
                        $child::$count += 2;
                        $middleLabel .= ':PHP';
                        if ($rethrowFromMiddle) {
                            throw $error;
                        }
                    }
                };
                $middleSuffix = $catchInMiddle ? ':PHP' : '';
                $expectedMiddleCount = $defaults[1] + ($catchInMiddle ? 2 : 0);
                try {
                    $middleResult = $base::reenterWorkerStatics($resumeMiddle);
                } finally {
                    if ($base::$count !== $defaults[0] + 11 || $child::$count !== $expectedMiddleCount
                        || $middleLabel !== "middle:outer$middleSuffix:resumed" || $child::$label !== $middleLabel) {
                        throw new LogicException('Middle V method did not restore its state on exit');
                    }
                }
                if ($middleResult !== ($defaults[0] + 10) . ":middle:outer$middleSuffix") {
                    throw new LogicException('Middle V method did not observe the restored state');
                }
            });
        } catch (WorkerStaticProbeFailure|WorkerStaticProbeOuterFailure $error) {
            if (!$catchOutside || $error !== $expectedFailure) {
                throw $error;
            }
            $caughtOutside = true;
        } finally {
            if ([$count, $child::$count, $label, $base::$label, $child::$label]
                !== [710, 710, 'outer:outer', 'outer:outer', 'outer:outer']) {
                throw new LogicException('Middle worker did not restore the outer state');
            }
        }
        if ($catchOutside && !$caughtOutside) {
            throw new LogicException('Outer worker did not catch the original deepest exception');
        }
        if ($expectedFailure !== null) {
            $base::$count += 3;
            $child::$label .= ':PHP';
        }
        if ($rethrowFromOuter) {
            throw $error;
        }
    };
    $outerSuffix = $expectedFailure === null ? '' : ':PHP';
    $expectedOuterCount = $defaults[0] + ($expectedFailure === null ? 0 : 3);
    $expectedLabel = "outer:outer$outerSuffix:resumed";
    try {
        $outerResult = $child::reenterWorkerStatics($resumeOuter);
    } finally {
        if ([$base::$count, $count, $child::$count, $label, $base::$label, $child::$label]
            !== [$expectedOuterCount, 711, 711, $expectedLabel, $expectedLabel, $expectedLabel]) {
            throw new LogicException('Outer V method could not write after the middle worker exited');
        }
    }
    if ($outerResult !== "710:outer:outer$outerSuffix") {
        throw new LogicException('Outer V method did not observe the restored state');
    }
};

$fail = static function (string $kind, array $table) use ($runNested): never {
    $runNested($table, static function () use ($kind): never {
        file_put_contents(__DIR__ . '/failure.pid', (string) getmypid());
        throw new WorkerStaticProbeFailure($kind);
    });
    throw new LogicException('Deepest exception did not reach vhttpd');
};

return static function (array $request) use ($tables, $fail, $runNested, &$rootLabels, &$outsideZendCount, &$outsideTraitCount): array|StreamResponse {
    $path = parse_url($request['path'], PHP_URL_PATH);
    if ($path === '/fiber-static') {
        require_once __DIR__ . '/worker-static-fibers.php';
        verifyWorkerStaticFibers();
        return [
            'status' => 200,
            'content_type' => 'application/json',
            'body' => json_encode(['pid' => getmypid()], JSON_THROW_ON_ERROR),
        ];
    }
    if ($rootLabels !== ['generic' => 'root generic', 'legacy' => 'root legacy']) {
        throw new LogicException('Previous worker scope did not restore its outer PHP references');
    }
    foreach ($tables as [$base, $child, $defaults]) {
        if ([$base::$count, $child::$count, $base::$label, $child::$label] !== [...$defaults, $defaults[2]]) {
            throw new LogicException('Worker leaked static values across requests');
        }
    }

    if ($path === '/zend-static-fail' || $path === '/zend-static-recover') {
        if (ZendStaticCounter::$count !== 0 || WorkerZendCounter::$count !== 21 || $outsideZendCount !== 37) {
            throw new LogicException('Ordinary static request did not start fresh or restore the worker alias');
        }
        if (WorkerZendTraitCounter::$count !== 73 || $outsideTraitCount !== 79) {
            throw new LogicException('Native trait static storage did not reset on the worker');
        }
        $traitCount =& WorkerZendTraitCounter::traitCountReference();
        $traitCount = 83;
        $outsideTraitCount = 89;
        $base =& ZendStaticCounter::counterReference();
        $child =& WorkerZendCounter::counterReference();
        [$base, $child, $outsideZendCount] = [41, 43, 47];
        if ($path === '/zend-static-fail') {
            ZendStaticCounter::$count =& $outsideZendCount;
            WorkerZendCounter::$count =& $outsideZendCount;
            $outsideZendCount = 53;
            ZendStaticCounter::$payload = new class {
                public function __destruct()
                {
                    $failure = new WorkerStaticProbeFailure('destructor reentry');
                    try {
                        vphp_standalone_probe_with_static_request(static function () use ($failure): never {
                            if ([ZendStaticCounter::$count, WorkerZendCounter::$count] !== [0, 21]) {
                                throw new LogicException('Destructor reentry inherited static values from the failing request');
                            }
                            loadWorkerLateZendCounter();
                            $late =& WorkerLateZendCounter::counterReference();
                            if ($late !== 61) {
                                throw new LogicException('The late class did not start at its declared default');
                            }
                            $late = 67;
                            ZendStaticCounter::$count = 59;
                            throw $failure;
                        });
                    } catch (WorkerStaticProbeFailure $error) {
                        if ($error !== $failure || $error->getPrevious() !== null) {
                            throw new LogicException('Destructor reentry changed the exception chain', previous: $error);
                        }
                        if (WorkerLateZendCounter::$count !== 61) {
                            throw new LogicException('Destructor reentry leaked the first value of a late class');
                        }
                        file_put_contents(__DIR__ . '/zend-static-destructor.pid', (string) getmypid());
                    }
                }
            };
            file_put_contents(__DIR__ . '/zend-static-failure.pid', (string) getmypid());
            throw new WorkerStaticProbeFailure('zend-static');
        }
        $late =& WorkerLateZendCounter::counterReference();
        if ($late !== 61) {
            throw new LogicException('A late class retained its static value from a previous request');
        }
        $late = 71;
        return [
            'status' => 200,
            'content_type' => 'application/json',
            'body' => json_encode([getmypid(), ZendStaticCounter::$count, WorkerZendCounter::$count, WorkerLateZendCounter::$count, WorkerZendTraitCounter::$count], JSON_THROW_ON_ERROR),
        ];
    }

    if (str_starts_with($path, '/fail/')) {
        $kind = substr($path, strlen('/fail/'));
        $fail($kind, $tables[$kind]);
    }

    if (preg_match('~^/(stream-fail|sse-fail|sse-disconnect(?:-fail|-catch|-catch-outer|-rethrow|-rethrow-both)?)/(generic|legacy)$~', $path, $route)) {
        [, $mode, $kind] = $route;
        $chunks = (static function () use ($fail, $runNested, $mode, $kind, $tables, &$rootLabels): iterable {
            yield $mode !== 'stream-fail'
                ? ['id' => $kind, 'event' => 'ready', 'data' => "first-$kind"]
                : "first-$kind\n";

            $waitForClient = static function () use ($mode, $kind): void {
                $release = __DIR__ . "/release-$mode-$kind";
                $deadline = microtime(true) + 5;
                do {
                    clearstatcache(true, $release);
                    if (is_file($release)) {
                        return;
                    }
                    usleep(10_000);
                } while (microtime(true) < $deadline);
                throw new LogicException('Client did not acknowledge the first stream message');
            };
            if (str_starts_with($mode, 'sse-disconnect')) {
                $caughtFailure = match ($mode) {
                    'sse-disconnect-catch', 'sse-disconnect-rethrow', 'sse-disconnect-rethrow-both' => new WorkerStaticProbeFailure($kind),
                    'sse-disconnect-catch-outer' => new WorkerStaticProbeOuterFailure($kind),
                    default => null,
                };
                $runNested(
                    $tables[$kind],
                    static function () use ($kind, $mode, $caughtFailure, &$rootLabels): void {
                        $rootLabels[$kind] = 'changed after disconnect';
                        if (in_array($mode, ['sse-disconnect-fail', 'sse-disconnect-rethrow-both'], true)) {
                            file_put_contents(__DIR__ . '/failure.pid', (string) getmypid());
                        }
                        if ($caughtFailure !== null) {
                            throw $caughtFailure;
                        }
                        if ($mode === 'sse-disconnect-fail') {
                            throw new WorkerStaticProbeFailure($kind);
                        }
                    },
                    static function () use ($kind, $mode, $waitForClient): void {
                        touch(__DIR__ . "/deepest-ready-$mode-$kind");
                        $waitForClient();
                    },
                    $caughtFailure,
                    rethrowFromMiddle: in_array($mode, ['sse-disconnect-rethrow', 'sse-disconnect-rethrow-both'], true),
                    rethrowFromOuter: $mode === 'sse-disconnect-rethrow-both',
                );
                file_put_contents(__DIR__ . '/disconnect.pid', (string) getmypid());
                yield ['id' => $kind, 'event' => 'late', 'data' => "after-$kind"];
                return;
            }
            $waitForClient();
            $fail($kind, $tables[$kind]);
        })();
        return $mode === 'stream-fail' ? StreamResponse::text($chunks) : StreamResponse::sse($chunks);
    }

    $states = [];
    foreach ($tables as $kind => [$base, $child, $defaults]) {
        $reference = ['count' => $defaults[1] + 10, 'label' => 'php'];
        $child::$count =& $reference['count'];
        $base::$label =& $reference['label'];
        if ($child::touchWorkerStatics() !== ($defaults[1] + 10) . ':php'
            || $base::touchWorkerStatics() !== $defaults[0] . ':php:V') {
            throw new LogicException('PHP writes were not visible to the V static tables');
        }
        $reference['count']++;
        $child::$label .= ':child';
        $states[$kind] = [$base::$count, $child::$count, $base::$label, $child::$label, $reference];
    }

    return [
        'status' => 200,
        'content_type' => 'application/json',
        'body' => json_encode(['pid' => getmypid(), 'states' => $states], JSON_THROW_ON_ERROR),
    ];
};
