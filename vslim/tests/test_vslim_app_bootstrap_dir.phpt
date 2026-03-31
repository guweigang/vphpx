--TEST--
VSlim App bootstrapDir loads project-root and bootstrap-directory conventions
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = __DIR__ . '/fixtures/vslim_bootstrap_project';
$bootstrap = $root . '/bootstrap';
$file = $bootstrap . '/app.php';

$app1 = new VSlim\App();
$app1->bootstrapDir($root);
echo $app1->dispatch('GET', '/project')->body . PHP_EOL;
echo $app1->url_for('fixture.project', []) . PHP_EOL;

$app2 = new VSlim\App();
$app2->bootstrapDir($bootstrap);
echo $app2->dispatch('GET', '/project')->body . PHP_EOL;

$app3 = new VSlim\App();
$app3->bootstrapDir($file);
echo $app3->dispatch('GET', '/project')->body . PHP_EOL;
?>
--EXPECT--
project-fixture
/project/project
project-fixture
project-fixture
