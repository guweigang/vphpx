--TEST--
VSlim database async query succeeds against a real MySQL server
--SKIPIF--
<?php
if (!extension_loaded("vslim")) print "skip";
$knowledgeStudioRoot = dirname(__DIR__, 2) . '/knowledge-studio';
if (!is_file($knowledgeStudioRoot . '/.env')) print "skip";
VSlim\EnvLoader::bootstrap($knowledgeStudioRoot);
if ((getenv('VSLIM_DB_TRANSPORT') ?: 'direct') !== 'direct') {
    print "skip";
    return;
}
foreach (['VSLIM_DB_HOST', 'VSLIM_DB_PORT', 'VSLIM_DB_USER', 'VSLIM_DB_NAME'] as $key) {
    $value = getenv($key);
    if ($value === false || $value === '') {
        print "skip";
        return;
    }
}
$cfg = (new VSlim\Database\Config())
    ->setDriver('mysql')
    ->setHost((string) getenv('VSLIM_DB_HOST'))
    ->setPort((int) getenv('VSLIM_DB_PORT'))
    ->setUsername((string) getenv('VSLIM_DB_USER'))
    ->setPassword((string) (getenv('VSLIM_DB_PASSWORD') ?: ''))
    ->setDatabase((string) getenv('VSLIM_DB_NAME'));
$db = (new VSlim\Database\Manager())->setConfig($cfg);
try {
    if (!$db->ping()) {
        print "skip";
        return;
    }
} catch (Throwable $e) {
    print "skip";
    return;
}
?>
--FILE--
<?php
$knowledgeStudioRoot = dirname(__DIR__, 2) . '/knowledge-studio';
VSlim\EnvLoader::bootstrap($knowledgeStudioRoot);

$cfg = (new VSlim\Database\Config())
    ->setDriver('mysql')
    ->setHost((string) getenv('VSLIM_DB_HOST'))
    ->setPort((int) getenv('VSLIM_DB_PORT'))
    ->setUsername((string) getenv('VSLIM_DB_USER'))
    ->setPassword((string) (getenv('VSLIM_DB_PASSWORD') ?: ''))
    ->setDatabase((string) getenv('VSLIM_DB_NAME'));

$db = (new VSlim\Database\Manager())->setConfig($cfg);
$pending = $db->queryAsync(query: 'SELECT 1 AS ok');
$rows = $pending->wait();

echo ($pending instanceof VSlim\Database\PendingResult ? "pending-ok\n" : "pending-bad\n");
echo ($pending->resolved() ? "resolved\n" : "pending\n");
echo $pending->affectedRows() . PHP_EOL;
echo $pending->lastInsertId() . PHP_EOL;
echo $pending->lastError() === '' ? "no-error\n" : "has-error\n";
echo $rows[0]['ok'] . PHP_EOL;

$holder = (new VSlim\Database\Manager())->setConfig($cfg);
$lock = 'vslim-async-' . bin2hex(random_bytes(8));
$abandonedLock = $lock . '-abandoned';
if (!$holder->beginTransaction()) {
    throw new RuntimeException('Could not reserve the lock holder connection');
}
try {
    if ((string) $holder->query("SELECT GET_LOCK('$lock', 0) AS acquired")[0]['acquired'] !== '1') {
        throw new RuntimeException('Could not take the test lock');
    }
    $waitingQuery = $db->queryAsync("SELECT GET_LOCK('$lock', 4) AS acquired");
    $first = VSlim\Task::spawn(static fn () => $waitingQuery->wait(), []);
    $second = VSlim\Task::spawn(static fn () => $waitingQuery->wait(), []);
    $third = VSlim\Task::spawn(static fn () => $waitingQuery->wait(), []);
    $reason = new DomainException('Stop waiting for the database');
    $release = VSlim\Task::spawn(static function () use ($first, $reason, $holder, $lock): void {
        VSlim\Task::sleep(0);
        if (!$first->cancel($reason)
            || (string) $holder->query("SELECT RELEASE_LOCK('$lock') AS released")[0]['released'] !== '1') {
            throw new RuntimeException('Could not cancel the waiter or release the test lock');
        }
    }, []);
    try {
        VSlim\Task::waitAll([$first, $second, $third, $release]);
        throw new LogicException('The cancelled database waiter returned normally');
    } catch (DomainException $error) {
        if ($error !== $reason) {
            throw $error;
        }
    }
    $result = $second->wait();
    if ((string) $result[0]['acquired'] !== '1' || $third->wait() !== $result
        || $waitingQuery->wait() !== $result || !$waitingQuery->resolved()) {
        throw new RuntimeException('The database wait blocked its lock releaser or lost a shared result');
    }

    if ((string) $holder->query("SELECT GET_LOCK('$abandonedLock', 0) AS acquired")[0]['acquired'] !== '1') {
        throw new RuntimeException('Could not take the lock for the abandoned query');
    }
    $abandoned = $db->queryAsync("SELECT GET_LOCK('$abandonedLock', 4) AS acquired");
    $started = hrtime(true);
    unset($abandoned);
    if (hrtime(true) - $started >= 3_000_000_000) {
        throw new RuntimeException('Dropping a pending query blocked the request thread');
    }
} finally {
    $holder->query("SELECT RELEASE_LOCK('$abandonedLock')");
    $holder->query("SELECT RELEASE_LOCK('$lock')");
    $holder->rollBack();
}

try {
    $db->query('SELECT definitely_invalid FROM');
    echo "syntax-query-missed\n";
} catch (RuntimeException $e) {
    echo "syntax-query-error\n";
}

$afterError = $db->query('SELECT 2 AS ok');
echo $afterError[0]['ok'] . PHP_EOL;
?>
--EXPECT--
pending-ok
resolved
1
0
no-error
1
syntax-query-error
2
