--TEST--
VSlim database model builds queries and tracks record state
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$db = (new VSlim\Database\Manager())->setConfig(
    (new VSlim\Database\Config())->set_driver('mysql')
);

$model = (new VSlim\Database\Model())
    ->setManager($db)
    ->setTable('users')
    ->setPrimaryKey('id')
    ->fill([
        'name' => 'alice',
        'email' => 'alice@example.com',
    ]);

echo json_encode($model->attributes(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
echo ($model->exists() ? 'exists' : 'new') . PHP_EOL;
echo $model->newQuery()->toSql() . PHP_EOL;
echo $model->findQuery(7)->toSql() . PHP_EOL;
echo json_encode($model->findQuery(7)->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
echo $model->saveQuery()->toSql() . PHP_EOL;
echo json_encode($model->saveQuery()->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$model->set('id', 7);
echo json_encode($model->attributes(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
echo $model->saveQuery()->toSql() . PHP_EOL;
echo json_encode($model->saveQuery()->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
echo $model->deleteQuery()->toSql() . PHP_EOL;
echo json_encode($model->deleteQuery()->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$bad = (new VSlim\Database\Model())->setManager(
    (new VSlim\Database\Manager())->setConfig((new VSlim\Database\Config())->set_driver('sqlite'))
)->setTable('users');
try {
    $bad->find(1);
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'not supported yet') ? "unsupported\n" : "wrong-error\n";
}
try {
    $bad->fill(['name' => 'bob'])->save();
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'not supported yet') ? "unsupported-save\n" : "wrong-error\n";
}
?>
--EXPECT--
{"name":"alice","email":"alice@example.com"}
new
SELECT * FROM `users`
SELECT * FROM `users` WHERE `id` = ?
["7"]
INSERT INTO `users` (`email`, `name`) VALUES (?, ?)
["alice@example.com","alice"]
{"name":"alice","email":"alice@example.com","id":"7"}
INSERT INTO `users` (`email`, `id`, `name`) VALUES (?, ?, ?)
["alice@example.com","7","alice"]
DELETE FROM `users` WHERE `id` = ? LIMIT 1
["7"]
unsupported
unsupported-save
