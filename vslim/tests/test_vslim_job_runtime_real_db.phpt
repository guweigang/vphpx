--TEST--
VSlim job dispatcher and worker run a PHP userland job against a real MySQL queue
--SKIPIF--
<?php
if (!extension_loaded('vslim')) print 'skip';
if (!is_file('/Users/guweigang/Source/vphpx/knowledge-studio/.env')) print 'skip';
VSlim\EnvLoader::bootstrap('/Users/guweigang/Source/vphpx/knowledge-studio');
if ((getenv('VSLIM_DB_TRANSPORT') ?: 'direct') !== 'direct') {
    print 'skip';
    return;
}
foreach (['VSLIM_DB_HOST', 'VSLIM_DB_PORT', 'VSLIM_DB_USER', 'VSLIM_DB_NAME'] as $key) {
    $value = getenv($key);
    if ($value === false || $value === '') {
        print 'skip';
        return;
    }
}
$cfg = (new VSlim\Database\Config())
    ->set_driver('mysql')
    ->setHost((string) getenv('VSLIM_DB_HOST'))
    ->setPort((int) getenv('VSLIM_DB_PORT'))
    ->set_username((string) getenv('VSLIM_DB_USER'))
    ->set_password((string) (getenv('VSLIM_DB_PASSWORD') ?: ''))
    ->setDatabase((string) getenv('VSLIM_DB_NAME'));
$db = (new VSlim\Database\Manager())->setConfig($cfg);
try {
    if (!$db->ping()) {
        print 'skip';
        return;
    }
    $db->query('SELECT 1 FROM vslim_jobs LIMIT 1');
    $db->query('SELECT 1 FROM vslim_failed_jobs LIMIT 1');
} catch (Throwable $e) {
    print 'skip';
    return;
}
?>
--FILE--
<?php
VSlim\EnvLoader::bootstrap('/Users/guweigang/Source/vphpx/knowledge-studio');

final class VSlimJobRuntimePhptJob
{
    public function handle(array $payload): void
    {
        file_put_contents($payload['path'], $payload['message'] . PHP_EOL, FILE_APPEND);
    }
}

final class VSlimJobRuntimePhptFailingJob
{
    public function handle(array $payload): void
    {
        throw new RuntimeException($payload['message']);
    }
}

$cfg = (new VSlim\Database\Config())
    ->set_driver('mysql')
    ->setHost((string) getenv('VSLIM_DB_HOST'))
    ->setPort((int) getenv('VSLIM_DB_PORT'))
    ->set_username((string) getenv('VSLIM_DB_USER'))
    ->set_password((string) (getenv('VSLIM_DB_PASSWORD') ?: ''))
    ->setDatabase((string) getenv('VSLIM_DB_NAME'));

$db = (new VSlim\Database\Manager())->setConfig($cfg);
$queue = 'vslim_phpt_' . getmypid();
$path = sys_get_temp_dir() . '/vslim_job_runtime_' . getmypid() . '.out';
@unlink($path);

$db->executeParams('DELETE FROM vslim_failed_jobs WHERE queue = ?', [$queue]);
$db->executeParams('DELETE FROM vslim_jobs WHERE queue = ?', [$queue]);

$dispatcher = (new VSlim\Job\Dispatcher())->setManager($db);
$jobId = $dispatcher->dispatch(VSlimJobRuntimePhptJob::class, [
    'message' => 'queued-ok',
    'path' => $path,
], $queue, 0, 2);

$worker = (new VSlim\Job\Worker())
    ->setManager($db)
    ->setWorkerId('phpt-worker')
    ->setRetryDelaySeconds(0);

$ran = $worker->runOnce($queue);
$rows = $db->queryParams('SELECT status, attempts, reserved_by IS NULL AS reserved_is_null, last_error IS NULL AS error_is_null FROM vslim_jobs WHERE id = ?', [(string) $jobId]);
$row = $rows[0] ?? [];

echo ($jobId > 0 ? "dispatch-ok\n" : "dispatch-bad\n");
echo "ran={$ran}\n";
echo file_exists($path) ? trim((string) file_get_contents($path)) . PHP_EOL : "missing-output\n";
echo "status=" . ($row['status'] ?? '') . PHP_EOL;
echo "attempts=" . ($row['attempts'] ?? '') . PHP_EOL;
echo "reserved=" . (($row['reserved_is_null'] ?? '') === '1' ? 'null' : 'not-null') . PHP_EOL;
echo "error=" . (($row['error_is_null'] ?? '') === '1' ? 'null' : 'not-null') . PHP_EOL;

$db->executeParams('DELETE FROM vslim_jobs WHERE queue = ?', [$queue]);
@unlink($path);

$firstId = $dispatcher->dispatch(VSlimJobRuntimePhptJob::class, [
    'message' => 'loop-a',
    'path' => $path,
], $queue, 0, 2);
$secondId = $dispatcher->dispatch(VSlimJobRuntimePhptJob::class, [
    'message' => 'loop-b',
    'path' => $path,
], $queue, 0, 2);
$loopRan = $worker->run($queue, 10, 0, true);
$loopRows = $db->queryParams('SELECT status FROM vslim_jobs WHERE id IN (?, ?) ORDER BY id ASC', [(string) $firstId, (string) $secondId]);

echo "loop-ran={$loopRan}\n";
echo "loop-output=" . trim((string) file_get_contents($path)) . PHP_EOL;
echo "loop-statuses=" . implode(',', array_column($loopRows, 'status')) . PHP_EOL;

$db->executeParams('DELETE FROM vslim_jobs WHERE queue = ?', [$queue]);
@unlink($path);

$stalePayload = json_encode([
    'message' => 'stale-recovered',
    'path' => $path,
], JSON_THROW_ON_ERROR);
$db->executeParams(
    "INSERT INTO vslim_jobs (queue, job_class, payload_json, status, attempts, max_attempts, available_at, reserved_at, reserved_by, created_at, updated_at)
     VALUES (?, ?, ?, 'reserved', 1, 3, NOW(), DATE_SUB(NOW(), INTERVAL 120 SECOND), 'dead-worker', NOW(), NOW())",
    [$queue, VSlimJobRuntimePhptJob::class, $stalePayload]
);
$staleId = $db->lastInsertId();
$staleRan = $worker->setReserveTimeoutSeconds(1)->runOnce($queue);
$staleRows = $db->queryParams('SELECT status, attempts, reserved_by IS NULL AS reserved_is_null FROM vslim_jobs WHERE id = ?', [(string) $staleId]);
$staleRow = $staleRows[0] ?? [];

echo "stale-ran={$staleRan}\n";
echo "stale-output=" . trim((string) file_get_contents($path)) . PHP_EOL;
echo "stale-status=" . ($staleRow['status'] ?? '') . PHP_EOL;
echo "stale-attempts=" . ($staleRow['attempts'] ?? '') . PHP_EOL;
echo "stale-reserved=" . (($staleRow['reserved_is_null'] ?? '') === '1' ? 'null' : 'not-null') . PHP_EOL;

$db->executeParams('DELETE FROM vslim_failed_jobs WHERE queue = ?', [$queue]);
$db->executeParams('DELETE FROM vslim_jobs WHERE queue = ?', [$queue]);

$failedId = $dispatcher->dispatch(VSlimJobRuntimePhptFailingJob::class, [
    'message' => 'planned job failure',
], $queue, 0, 1);
$failedRan = $worker->runOnce($queue);
$failedRows = $db->queryParams('SELECT status, attempts, last_error FROM vslim_jobs WHERE id = ?', [(string) $failedId]);
$failedRow = $failedRows[0] ?? [];
$deadRows = $db->queryParams('SELECT error_message FROM vslim_failed_jobs WHERE job_id = ?', [(string) $failedId]);
$deadRow = $deadRows[0] ?? [];

echo "failed-ran={$failedRan}\n";
echo "failed-status=" . ($failedRow['status'] ?? '') . PHP_EOL;
echo "failed-attempts=" . ($failedRow['attempts'] ?? '') . PHP_EOL;
echo "failed-error=" . ($failedRow['last_error'] ?? '') . PHP_EOL;
echo "dead-error=" . ($deadRow['error_message'] ?? '') . PHP_EOL;

$db->executeParams('DELETE FROM vslim_failed_jobs WHERE queue = ?', [$queue]);
$db->executeParams('DELETE FROM vslim_jobs WHERE queue = ?', [$queue]);
@unlink($path);
?>
--EXPECT--
dispatch-ok
ran=1
queued-ok
status=completed
attempts=1
reserved=null
error=null
loop-ran=2
loop-output=loop-a
loop-b
loop-statuses=completed,completed
stale-ran=1
stale-output=stale-recovered
stale-status=completed
stale-attempts=2
stale-reserved=null
failed-ran=1
failed-status=failed
failed-attempts=1
failed-error=planned job failure
dead-error=planned job failure
