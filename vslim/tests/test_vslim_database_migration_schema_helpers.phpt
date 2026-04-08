--TEST--
VSlim database migration schema helpers generate common SQL snippets
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$migration = new class extends VSlim\Database\Migration {};

echo $migration->createTableSql('users', [
    '`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT',
    '`name` VARCHAR(255) NOT NULL',
    'PRIMARY KEY (`id`)',
]) . PHP_EOL;

echo $migration->dropTableSql('users') . PHP_EOL;
echo $migration->addColumnSql('users', '`email` VARCHAR(255) NOT NULL') . PHP_EOL;
echo $migration->dropColumnSql('users', 'email') . PHP_EOL;
?>
--EXPECT--
CREATE TABLE IF NOT EXISTS `users` (`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`id`))
DROP TABLE IF EXISTS `users`
ALTER TABLE `users` ADD COLUMN `email` VARCHAR(255) NOT NULL
ALTER TABLE `users` DROP COLUMN `email`
