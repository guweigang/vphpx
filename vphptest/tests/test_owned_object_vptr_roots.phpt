--TEST--
PHP-owned V object roots are released after returned objects are destroyed
--SKIPIF--
<?php if (!extension_loaded('vphptest')) echo 'skip vphptest extension missing'; ?>
--FILE--
<?php
$baseline = v_vptr_root_count();
for ($i = 0; $i < 200; $i++) {
    $article = Article::create('root-test');
    if (v_vptr_root_count() !== $baseline + 1) {
        throw new RuntimeException('Returned object did not have exactly one root');
    }
    unset($article);
}
gc_collect_cycles();
if (v_vptr_root_count() !== $baseline) {
    throw new RuntimeException('Destroyed returned objects retained V roots');
}
echo "roots released\n";
?>
--EXPECT--
roots released
