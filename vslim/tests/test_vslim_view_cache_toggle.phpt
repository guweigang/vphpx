--TEST--
VSlim View cache toggle controls whether template source is reused
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$tmpDir = sys_get_temp_dir() . '/vslim_view_cache_' . uniqid('', true);
mkdir($tmpDir, 0777, true);
$tpl = $tmpDir . '/page.html';
file_put_contents($tpl, 'first');

$view = new VSlim\View($tmpDir, '/assets');
echo ($view->cacheEnabled() ? 'ctor-cache-on' : 'ctor-cache-off') . PHP_EOL;
$view->set_cache_enabled(false);
echo ($view->render('page.html', []) === 'first' ? 'nocache-first' : 'nocache-first-miss') . PHP_EOL;
file_put_contents($tpl, 'second');
echo ($view->render('page.html', []) === 'second' ? 'nocache-refresh' : 'nocache-stale') . PHP_EOL;

$app = new VSlim\App();
$app->setViewBasePath($tmpDir);
$app->setViewCache(true);
$cached = $app->makeView();
echo ($cached->cacheEnabled() ? 'app-cache-on' : 'app-cache-off') . PHP_EOL;
echo ($cached->render('page.html', []) === 'second' ? 'cache-first' : 'cache-first-miss') . PHP_EOL;
file_put_contents($tpl, 'third');
echo ($cached->render('page.html', []) === 'second' ? 'cache-hit' : 'cache-miss') . PHP_EOL;
$cached->clear_cache();
echo ($cached->render('page.html', []) === 'third' ? 'cache-cleared' : 'cache-clear-miss') . PHP_EOL;
?>
--EXPECT--
ctor-cache-off
nocache-first
nocache-refresh
app-cache-on
cache-first
cache-hit
cache-cleared
