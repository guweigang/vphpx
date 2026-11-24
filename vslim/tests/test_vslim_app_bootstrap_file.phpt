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
echo $app1->urlFor('fixture.spec', []) . PHP_EOL;

$app2 = new VSlim\App();
$app2->bootstrapFile($specPath);
echo $app2->dispatch('GET', '/spec')->body . PHP_EOL;

$app3 = new VSlim\App();
$app3->bootstrapFile($callablePath);
echo $app3->dispatch('GET', '/callable')->body . PHP_EOL;

$referencePath = tempnam(sys_get_temp_dir(), 'vslim-bootstrap-ref-');
try {
    file_put_contents($referencePath, <<<'PHP'
<?php
return static function &($receiver): mixed {
    ++$GLOBALS['bootstrapReferenceCalls'];
    return $GLOBALS['bootstrapReferenceSpec'];
};
PHP);
    foreach ([false, true] as $traversable) {
        foreach ([new VSlim\App(), new VSlim\Cli\App()] as $receiver) {
            $GLOBALS['bootstrapReferenceCalls'] = 0;
            $spec = $receiver instanceof VSlim\Cli\App
                ? ['commands' => ['ref:command' => static fn () => 0], 'boot' => false]
                : ['routes' => static function (VSlim\App $app): void {
                    $app->get('/ref-spec', static fn () => 'reference spec');
                }, 'boot' => false];
            $GLOBALS['bootstrapReferenceSpec'] = $traversable ? new ArrayObject($spec) : $spec;
            $receiver->bootstrapFile($referencePath);
            $loaded = $receiver instanceof VSlim\Cli\App
                ? $receiver->hasCommand('ref:command')
                : $receiver->dispatch('GET', '/ref-spec')->body === 'reference spec';
            if (!$loaded || $GLOBALS['bootstrapReferenceCalls'] !== 1) {
                throw new RuntimeException('Bootstrap did not load the iterable returned by reference');
            }
        }
    }
} finally {
    unlink($referencePath);
    unset($GLOBALS['bootstrapReferenceCalls'], $GLOBALS['bootstrapReferenceSpec']);
}
?>
--EXPECT--
spec-fixture
spec-missing
/fixture/spec
spec-fixture
callable-fixture
