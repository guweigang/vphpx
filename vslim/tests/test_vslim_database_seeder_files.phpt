--TEST--
VSlim database migrator discovers and loads seeder files
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim_seeder_' . uniqid('', true);
$dir = $root . '/database/seeds';
mkdir($dir, 0777, true);

file_put_contents($dir . '/BaseSeeder.php', <<<'PHP'
<?php
return new class extends VSlim\Database\Seeder {
    public function run(): bool { return true; }
};
PHP);

file_put_contents($dir . '/DemoUsersSeeder.php', <<<'PHP'
<?php
return new class extends VSlim\Database\Seeder {
    public function run(): bool { return true; }
};
PHP);

$migrator = new VSlim\Database\Migrator();
$migrator->setSeedsPath($dir);

echo json_encode($migrator->seedFiles(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$seeder = $migrator->loadSeeder($dir . '/DemoUsersSeeder.php');
echo get_class($seeder) . PHP_EOL;
echo $seeder->name() . PHP_EOL;
echo ($seeder->db() instanceof VSlim\Database\Manager ? 'manager' : 'no-manager') . PHP_EOL;
?>
--EXPECTF--
["%s/BaseSeeder.php","%s/DemoUsersSeeder.php"]
VSlim\Database\Seeder@anonymous%c%s
DemoUsersSeeder
manager
