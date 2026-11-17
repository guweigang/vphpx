--TEST--
VSlim restores container identity and view settings when a Web or CLI bootstrap callback fails
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function settingsPrefix(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'prefix';
    $app->setViewBasePath($GLOBALS['stable'])->setAssetsPrefix('/stable-assets')->setViewCache(false);
    $app->helper('label', static fn (): string => 'stable');
    $app->container()->set('service', 'stable');
    $app->getNamed('prefix', '/prefix', static fn (): string => 'prefix');
}

function settingsAttempt(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'attempt';
    $app->setContainer($GLOBALS['replacement']);
    $app->setViewBasePath($GLOBALS['pending'])->setAssetsPrefix('/attempt-assets')->setViewCache(true);
    $app->helper('label', static fn (): string => 'attempt');
    $app->helper('added', static fn (): string => 'added');
    $app->container()->set('service', 'attempt');
    $app->getNamed('attempt', '/attempt', static fn (): string => 'attempt');
    if (!$GLOBALS['retried']) {
        $GLOBALS['retried'] = true;
        throw new LogicException('failed');
    }
}

$root = sys_get_temp_dir() . '/vslim-settings-rollback-' . bin2hex(random_bytes(8));
mkdir("$root/stable", 0700, true);
mkdir("$root/pending");
$GLOBALS['stable'] = "$root/stable";
$GLOBALS['pending'] = "$root/pending";
try {
    foreach (['stable', 'pending'] as $directory) {
        file_put_contents("$root/$directory/probe.html", '{{ label() }}|{{ added() }}');
    }
    file_put_contents("$root/app.php", '<?php return ["routes" => ["settingsPrefix", "settingsAttempt"]];');
    foreach (['web', 'cli'] as $mode) {
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $original = $app->container();
        $replacement = $GLOBALS['replacement'] = new VSlim\Container();
        $replacement->set('service', 'replacement');
        $GLOBALS['retried'] = false;
        for ($i = 0; $i < 2; ++$i) {
            $GLOBALS['events'] = [];
            try {
                $target = $mode === 'web' ? $app : $cli;
                $target->bootstrapFile("$root/app.php");
                $status = 'ok';
            } catch (LogicException $error) {
                $status = $error->getMessage();
            }
            echo "$mode|$status|", implode(',', $GLOBALS['events']), '|',
                (int) ($app->container() === $original), '|', $app->container()->get('service'), '|',
                $replacement->get('service'), '|', basename($app->viewBasePath()), '|', $app->assetsPrefix(), '|',
                (int) $app->viewCacheEnabled(), '|', implode(',', $app->routeNames()), '|',
                $app->makeView()->render('probe.html', []), PHP_EOL;
        }
    }
} finally {
    unlink("$root/app.php");
    foreach (['stable', 'pending'] as $directory) {
        unlink("$root/$directory/probe.html");
        rmdir("$root/$directory");
    }
    rmdir($root);
}
?>
--EXPECT--
web|failed|prefix,attempt|1|stable|replacement|stable|/stable-assets|0|prefix|stable|
web|ok|attempt|0|attempt|attempt|pending|/attempt-assets|1|prefix,attempt|attempt|added
cli|failed|prefix,attempt|1|stable|replacement|stable|/stable-assets|0|prefix|stable|
cli|ok|attempt|0|attempt|attempt|pending|/attempt-assets|1|prefix,attempt|attempt|added
