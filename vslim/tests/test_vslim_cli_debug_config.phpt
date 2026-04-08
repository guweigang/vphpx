--TEST--
VSlim CLI bootstrap debug can be driven by config
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$sourceRoot = __DIR__ . '/../templates/app';
$root = sys_get_temp_dir() . '/vslim_cli_debug_config_' . getmypid();
$logFile = sys_get_temp_dir() . '/vslim_cli_debug_config_' . getmypid() . '.log';

function copy_dir(string $src, string $dst): void {
    if (!is_dir($dst)) {
        mkdir($dst, 0777, true);
    }
    $items = scandir($src);
    if ($items === false) {
        throw new RuntimeException('failed to read ' . $src);
    }
    foreach ($items as $item) {
        if ($item === '.' || $item === '..') {
            continue;
        }
        $from = $src . DIRECTORY_SEPARATOR . $item;
        $to = $dst . DIRECTORY_SEPARATOR . $item;
        if (is_dir($from)) {
            copy_dir($from, $to);
        } else {
            copy($from, $to);
        }
    }
}

if (is_dir($root)) {
    $it = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($root, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST
    );
    foreach ($it as $file) {
        $path = $file->getPathname();
        $file->isDir() ? rmdir($path) : unlink($path);
    }
    rmdir($root);
}
copy_dir($sourceRoot, $root);
@unlink($logFile);

putenv('VSLIM_CLI_DEBUG=');
putenv('VSLIM_CLI_DEBUG_FILE=');
file_put_contents($root . '/config/cli.toml', "[cli]\ndebug = true\ndebug_file = '" . addslashes($logFile) . "'\n");

$cli = new VSlim\Cli\App();
$cli->bootstrapDir($root);

clearstatcache();
$body = file_exists($logFile) ? (string) file_get_contents($logFile) : '';
echo (str_contains($body, '[vslim-cli-debug]') ? 'debug-on' : 'debug-off'), PHP_EOL;
echo (str_contains($body, 'commands_dir=') ? 'commands-logged' : 'commands-miss'), PHP_EOL;

@unlink($logFile);
if (is_dir($root)) {
    $it = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($root, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST
    );
    foreach ($it as $file) {
        $path = $file->getPathname();
        $file->isDir() ? rmdir($path) : unlink($path);
    }
    rmdir($root);
}
putenv('VSLIM_CLI_DEBUG=');
putenv('VSLIM_CLI_DEBUG_FILE=');
?>
--EXPECT--
debug-on
commands-logged
