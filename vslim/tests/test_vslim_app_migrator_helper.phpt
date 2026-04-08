--TEST--
VSlim app migrator helper binds database manager and project paths
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim_app_migrator_' . uniqid('', true);
$configDir = $root . '/config';
mkdir($configDir, 0777, true);
mkdir($root . '/database/migrations', 0777, true);
mkdir($root . '/database/seeds', 0777, true);
file_put_contents($configDir . '/app.toml', "[app]\nname = 'MigratorApp'\n");

$app = VSlim\App::demo();
$app->load_config($configDir);
$migrator = $app->migrator();

echo ($migrator->manager() instanceof VSlim\Database\Manager ? 'manager' : 'no-manager') . PHP_EOL;
echo $migrator->migrationsPath() . PHP_EOL;
echo $migrator->seedsPath() . PHP_EOL;
echo ($app->migrator() === $migrator ? 'cached' : 'new') . PHP_EOL;
?>
--EXPECTF--
manager
%s/database/migrations
%s/database/seeds
cached
