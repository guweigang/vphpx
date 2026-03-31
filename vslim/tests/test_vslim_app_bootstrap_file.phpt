--TEST--
VSlim App bootstrapFile loads bootstrap PHP files that return specs or closures
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$specPath = __DIR__ . '/fixtures/vslim_bootstrap_spec_fixture.php';
$callablePath = __DIR__ . '/fixtures/vslim_bootstrap_callable_fixture.php';

$app1 = new VSlim\App();
$app1->bootstrapFile($specPath);
echo $app1->dispatch('GET', '/spec')->body . PHP_EOL;
echo $app1->dispatch('GET', '/missing')->body . PHP_EOL;
echo $app1->url_for('fixture.spec', []) . PHP_EOL;

$app2 = new VSlim\App();
$app2->bootstrapFile($specPath);
echo $app2->dispatch('GET', '/spec')->body . PHP_EOL;

$app3 = new VSlim\App();
$app3->bootstrapFile($callablePath);
echo $app3->dispatch('GET', '/callable')->body . PHP_EOL;
?>
--EXPECT--
spec-fixture
spec-missing
/fixture/spec
spec-fixture
callable-fixture
