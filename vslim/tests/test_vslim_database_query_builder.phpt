--TEST--
VSlim database query builder generates SQL and params
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$db = (new VSlim\Database\Manager())->setConfig(
    (new VSlim\Database\Config())->set_driver('mysql')
);

$select = $db->table('users')
    ->select(['id', 'name'])
    ->where('status', 'active')
    ->whereOp('age', '>=', 18)
    ->orderBy('id', 'desc')
    ->limit(10)
    ->offset(20);

echo $select->toSql() . PHP_EOL;
echo json_encode($select->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$insert = $db->table('users')->insert([
    'name' => 'alice',
    'active' => true,
]);
echo $insert->toSql() . PHP_EOL;
echo json_encode($insert->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$update = $db->table('users')
    ->update(['name' => 'bob'])
    ->where('id', 7);
echo $update->toSql() . PHP_EOL;
echo json_encode($update->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$delete = $db->table('users')->delete()->where('id', 9)->limit(1);
echo $delete->toSql() . PHP_EOL;
echo json_encode($delete->params(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$bad = (new VSlim\Database\Manager())
    ->setConfig((new VSlim\Database\Config())->set_driver('sqlite'));
try {
    $bad->table('users')->where('id', 1)->first();
    echo "no-exception\n";
} catch (RuntimeException $e) {
    echo str_contains($e->getMessage(), 'not supported yet') ? "unsupported\n" : "wrong-error\n";
}

try {
    $db->table('users')->where('id', 1)->insertGetId();
    echo "no-exception\n";
} catch (InvalidArgumentException $e) {
    echo "invalid\n";
}
?>
--EXPECT--
SELECT `id`, `name` FROM `users` WHERE `status` = ? AND `age` >= ? ORDER BY `id` DESC LIMIT 10 OFFSET 20
["active","18"]
INSERT INTO `users` (`active`, `name`) VALUES (?, ?)
["1","alice"]
UPDATE `users` SET `name` = ? WHERE `id` = ?
["bob","7"]
DELETE FROM `users` WHERE `id` = ? LIMIT 1
["9"]
unsupported
invalid
