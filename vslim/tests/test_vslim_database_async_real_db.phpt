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
$pending = $db->queryAsync('SELECT 1 AS ok');
$rows = $pending->wait();

echo ($pending instanceof VSlim\Database\PendingResult ? "pending-ok\n" : "pending-bad\n");
echo ($pending->resolved() ? "resolved\n" : "pending\n");
echo $pending->affectedRows() . PHP_EOL;
echo $pending->lastInsertId() . PHP_EOL;
echo $pending->lastError() === '' ? "no-error\n" : "has-error\n";
echo $rows[0]['ok'] . PHP_EOL;

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
