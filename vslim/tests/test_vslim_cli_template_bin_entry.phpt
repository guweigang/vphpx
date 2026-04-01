--TEST--
VSlim CLI template bin entry can run commands from the project root convention
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$root = realpath(__DIR__ . '/../templates/app');
$php = escapeshellarg(PHP_BINARY);
$extensionPath = __DIR__ . '/../vslim.so';
if (DIRECTORY_SEPARATOR === '\\') {
    $extensionPath = __DIR__ . '/../php_vslim.dll';
}
$extension = escapeshellarg($extensionPath);
$script = escapeshellarg($root . '/bin/vslim');

$about = shell_exec($php . ' -d extension=' . $extension . ' ' . $script . ' about services cache');
echo trim((string) $about), PHP_EOL;

$help = shell_exec($php . ' -d extension=' . $extension . ' ' . $script . ' about --help');
echo (str_contains((string) $help, '--format <kind>') ? 'format_yes' : 'format_no'), '|',
    (str_contains((string) $help, 'VSLIM_TEMPLATE_FORMAT') ? 'env_yes' : 'env_no'), '|',
    (str_contains((string) $help, 'vslim about services cache --format=json') ? 'example_yes' : 'example_no'), PHP_EOL;
?>
--EXPECT--
vslim-template|provider-ready|services,cache
format_yes|env_yes|example_yes
