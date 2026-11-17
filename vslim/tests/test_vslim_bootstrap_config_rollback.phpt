--TEST--
VSlim restores config identity, contents and config-derived settings after Web and CLI callback failures
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
function configText(string $value): string
{
    return "[probe]\nvalue = \"$value\"\n[auth]\nredirect_to = \"/$value\"";
}
function configPrefix(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'prefix';
    $app->loadConfig($GLOBALS['tomlFile']);
}
function configAttempt(VSlim\App $app): void
{
    $GLOBALS['events'][] = 'attempt';
    switch (++$GLOBALS['attempt']) {
        case 1:
            $app->config()->mergeText("[probe]\nextra = 1");
            $app->loadConfigText(configText('loaded'));
            throw new LogicException('load failed');
        case 2:
            $app->setConfig($GLOBALS['replacement']);
            $app->config()->mergeText(configText('replacement-changed'));
            throw new LogicException('swap failed');
        default:
            $app->mergeConfigText(configText('ready'));
    }
}

$root = sys_get_temp_dir() . '/vslim-config-rollback-' . bin2hex(random_bytes(8));
mkdir($root, 0700);
$GLOBALS['tomlFile'] = "$root/stable.toml";
try {
    file_put_contents($GLOBALS['tomlFile'], configText('stable'));
    file_put_contents("$root/app.php", '<?php return ["routes" => ["configPrefix", "configAttempt"]];');
    foreach (['web', 'cli'] as $mode) {
        $cli = new VSlim\Cli\App();
        $app = $mode === 'web' ? new VSlim\App() : $cli->app();
        $target = $mode === 'web' ? $app : $cli;
        $container = $app->container();
        $original = $app->config();
        $replacement = $GLOBALS['replacement'] = (new VSlim\Config())->loadText(configText('replacement'));
        $GLOBALS['attempt'] = 0;
        for ($i = 0; $i < 3; ++$i) {
            $GLOBALS['events'] = [];
            try {
                $target->bootstrapFile("$root/app.php");
                $status = 'ok';
            } catch (LogicException $error) {
                $status = $error->getMessage();
            }
            $config = $app->config();
            echo "$mode|$status|", implode(',', $GLOBALS['events']), '|', (int) ($config === $original),
                '|', (int) ($container->get('config') === $config), '|', $config->getString('probe.value'),
                '|', (int) $config->has('probe.extra'), '|', basename($config->path()), '|',
                $app->authRedirectTo(), '|', $replacement->getString('probe.value'), PHP_EOL;
        }
    }

    $app = new VSlim\App();
    try {
        $app->bootstrap(['routes' => static function (VSlim\App $app): void {
            $app->container();
            throw new LogicException('lazy');
        }]);
    } catch (LogicException $error) {
        echo $error->getMessage(), '|', (int) $app->hasContainer(), '|', (int) $app->hasConfig(), PHP_EOL;
    }
} finally {
    unlink("$root/app.php");
    unlink($GLOBALS['tomlFile']);
    rmdir($root);
}
?>
--EXPECT--
web|load failed|prefix,attempt|1|1|stable|0|stable.toml|/stable|replacement
web|swap failed|attempt|1|1|stable|0|stable.toml|/stable|replacement
web|ok|attempt|1|1|ready|0|stable.toml|/ready|replacement
cli|load failed|prefix,attempt|1|1|stable|0|stable.toml|/stable|replacement
cli|swap failed|attempt|1|1|stable|0|stable.toml|/stable|replacement
cli|ok|attempt|1|1|ready|0|stable.toml|/ready|replacement
lazy|0|0
