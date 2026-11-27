--TEST--
VSlim template loops restore shadowed fields across rows, nested loops and include arguments
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-loop-scope-' . bin2hex(random_bytes(8));
mkdir($root, 0700);
try {
    file_put_contents("$root/partial.html", '{{label}}:{{index}}:{{item.name}}');
    file_put_contents("$root/main.html", <<<'HTML'
{{index}}:{{item.name}}|{{for:rows}}[{{index}}:{{item.name}}:{{item.other}};{{for:tags}}({{index}}:{{item}}:{{item.name}}){{/for}};{{include:partial.html|label=item.name}}]{{/for}}|{{index}}:{{item.name}}
HTML);
    $view = new VSlim\View($root, '/assets');
    echo $view->render('main.html', [
        'index' => 'outer',
        'item' => ['name' => 'baseline'],
        'rows' => [['name' => 'one'], ['other' => 'two'], ['name' => 'three']],
        'tags' => ['a', 'b'],
    ]), PHP_EOL;
} finally {
    unlink("$root/main.html");
    unlink("$root/partial.html");
    rmdir($root);
}
?>
--EXPECT--
outer:baseline|[0:one:;(0:a:one)(1:b:one);one:0:one][1:baseline:two;(0:a:baseline)(1:b:baseline);baseline:1:baseline][2:three:;(0:a:three)(1:b:three);three:2:three]|outer:baseline
