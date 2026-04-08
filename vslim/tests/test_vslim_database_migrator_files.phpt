--TEST--
VSlim database migrator discovers and loads migration files
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim_migrator_' . uniqid('', true);
$dir = $root . '/database/migrations';
mkdir($dir, 0777, true);

file_put_contents($dir . '/20260407_120000_create_users.php', <<<'PHP'
<?php
return new class extends VSlim\Database\Migration {
    public function up(): bool { return true; }
    public function down(): bool { return true; }
};
PHP);

file_put_contents($dir . '/20260407_130000_create_posts.php', <<<'PHP'
<?php
return new class extends VSlim\Database\Migration {
    public function up(): bool { return true; }
    public function down(): bool { return true; }
};
PHP);

$migrator = new VSlim\Database\Migrator();
$migrator->setMigrationsPath($dir);

echo json_encode($migrator->migrationFiles(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$migration = $migrator->loadMigration($dir . '/20260407_120000_create_users.php');
echo get_class($migration) . PHP_EOL;
echo $migration->name() . PHP_EOL;
echo ($migration->db() instanceof VSlim\Database\Manager ? 'manager' : 'no-manager') . PHP_EOL;
?>
--EXPECTF--
["%s/20260407_120000_create_users.php","%s/20260407_130000_create_posts.php"]
VSlim\Database\Migration@anonymous%c%s
20260407_120000_create_users
manager
