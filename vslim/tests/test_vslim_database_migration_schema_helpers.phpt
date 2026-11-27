--TEST--
VSlim database migration schema helpers generate common SQL snippets
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$migration = new class extends VSlim\Database\Migration {};

$signature = new ReflectionMethod($migration, 'addColumnSql');
[$table, $column] = $signature->getParameters();
if ($signature->getNumberOfRequiredParameters() !== 2 || $table->getName() !== 'tableName'
    || $column->getName() !== 'columnDef' || (string) $table->getType() !== 'string'
    || (string) $column->getType() !== 'string' || (string) $signature->getReturnType() !== 'string') {
    throw new RuntimeException('Unexpected addColumnSql signature');
}

echo $migration->createTableSql(columns: [
    '`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT',
    '`name` VARCHAR(255) NOT NULL',
    'PRIMARY KEY (`id`)',
], tableName: 'users') . PHP_EOL;

echo $migration->dropTableSql('users') . PHP_EOL;
echo $migration->addColumnSql(columnDef: '`email` VARCHAR(255) NOT NULL', tableName: 'users') . PHP_EOL;
echo $migration->dropColumnSql(columnName: 'email', tableName: 'users') . PHP_EOL;
?>
--EXPECT--
CREATE TABLE IF NOT EXISTS `users` (`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`id`))
DROP TABLE IF EXISTS `users`
ALTER TABLE `users` ADD COLUMN `email` VARCHAR(255) NOT NULL
ALTER TABLE `users` DROP COLUMN `email`
