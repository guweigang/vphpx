--TEST--
VSlim Web and CLI load shared startup once and preserve route, command and boot order
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
final class EntryProbeProvider
{
    public function boot(VSlim\App $app): void
    {
        ++$GLOBALS['entryBoots'];
        $GLOBALS['entryPhases'][] = 'boot';
    }
}

function writeEntry(string $file, string $name, bool $boot = false): void
{
    $entry = <<<'PHP'
<?php
$GLOBALS['entryLoads'][] = '{name}';
$GLOBALS['entryPhases'][] = 'load';
return [
    'providers' => [new EntryProbeProvider()],
    'routes' => static function (VSlim\App $app): void {
        $GLOBALS['entryPhases'][] = 'shared-routes';
        $app->get('/entry', static fn () => '{name}');
    },
    'boot' => {boot},
];
PHP;
    file_put_contents($file, strtr($entry, ['{name}' => $name, '{boot}' => $boot ? 'true' : 'false']));
}

function checkEntry(string $surface, string $directory): void
{
    $GLOBALS['entryLoads'] = [];
    $GLOBALS['entryBoots'] = 0;
    $GLOBALS['entryPhases'] = [];
    if ($surface === 'cli') {
        $cli = new VSlim\Cli\App();
        $cli->bootstrapDir($directory);
        $app = $cli->app();
    } else {
        $app = new VSlim\App();
        $app->bootstrapDir($directory);
    }
    $before = (int) $app->booted();
    $body = $app->dispatch('GET', '/entry')->body;
    $app->dispatch('GET', '/entry');
    echo implode('|', [$surface, implode(',', $GLOBALS['entryLoads']), $body,
        $before, (int) $app->booted(), $GLOBALS['entryBoots'],
        implode(',', $GLOBALS['entryPhases'])]) . PHP_EOL;
}

$root = sys_get_temp_dir() . '/vslim-entry-priority-' . bin2hex(random_bytes(8));
$bootstrap = $root . '/bootstrap';
mkdir($bootstrap, 0700, true);
mkdir($root . '/routes', 0700);
mkdir($root . '/app/Commands', 0700, true);
try {
    file_put_contents($root . '/routes/web.php', <<<'PHP'
<?php
return static function (VSlim\App $app): void {
    $GLOBALS['entryPhases'][] = 'web-routes:' . (int) $app->booted();
};
PHP);
    file_put_contents($root . '/app/Commands/ProbeCommand.php', <<<'PHP'
<?php
namespace App\Commands;
final class ProbeCommand {
    public function handle(): int { return 0; }
}
PHP);
    file_put_contents($bootstrap . '/cli.php', <<<'PHP'
<?php
return static function (VSlim\Cli\App $cli): void {
    $GLOBALS['entryPhases'][] = 'cli-config:' . (int) $cli->hasCommand('probe') . ':' . (int) $cli->app()->booted();
};
PHP);
    writeEntry($bootstrap . '/app.php', 'preferred');
    writeEntry($root . '/app.php', 'root');
    writeEntry($bootstrap . '/services.php', 'convention');
    foreach (['web', 'cli'] as $surface) {
        checkEntry($surface, $root);
        checkEntry($surface, $bootstrap);
        checkEntry($surface, $root . '/app.php');
    }

    writeEntry($bootstrap . '/app.php', 'boot-now', true);
    foreach (['web', 'cli'] as $surface) {
        checkEntry($surface, $root);
    }

    unlink($bootstrap . '/app.php');
    foreach (['web', 'cli'] as $surface) {
        checkEntry($surface, $bootstrap);
    }

    unlink($root . '/app.php');
    foreach (['web', 'cli'] as $surface) {
        checkEntry($surface, $bootstrap);
    }
} finally {
    $files = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($root, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST,
    );
    foreach ($files as $file) {
        $file->isDir() ? rmdir($file->getPathname()) : unlink($file->getPathname());
    }
    rmdir($root);
}
?>
--EXPECT--
web|preferred|preferred|0|1|1|load,shared-routes,boot
web|preferred|preferred|0|1|1|load,shared-routes,boot
web|root|root|0|1|1|load,shared-routes,boot
cli|preferred|preferred|1|1|1|load,shared-routes,boot,cli-config:1:1
cli|preferred|preferred|1|1|1|load,shared-routes,boot,cli-config:1:1
cli|root|root|0|1|1|load,shared-routes,boot
web|boot-now|boot-now|1|1|1|load,shared-routes,boot
cli|boot-now|boot-now|1|1|1|load,shared-routes,boot,cli-config:1:1
web|root|root|0|1|1|load,shared-routes,boot
cli|root|root|1|1|1|load,shared-routes,boot,cli-config:1:1
web|convention|convention|1|1|1|load,shared-routes,web-routes:0,boot
cli|convention|convention|1|1|1|load,shared-routes,boot,cli-config:1:1
