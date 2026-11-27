--TEST--
VSlim application builder creates a deterministic image and runtime manifest
--SKIPIF--
<?php if (!class_exists('ZipArchive')) print 'skip ZipArchive unavailable'; ?>
--FILE--
<?php
$root = realpath(__DIR__ . '/../templates/app');
$launcher = $root . '/bin/vslim';
$base = sys_get_temp_dir() . '/vslim-image-' . getmypid();
$first = $base . '-one.vslim-app';
$second = $base . '-two.vslim-app';

foreach ([$first, $second] as $output) {
    $command = escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg($launcher) . ' build'
        . ' --allow-missing-vendor --target=linux-amd64 --output=' . escapeshellarg($output);
    exec($command, $lines, $status);
    if ($status !== 0) {
        echo "build_failed\n";
        exit;
    }
}

$zip = new ZipArchive();
$zip->open($first);
$embedded = json_decode((string) $zip->getFromName('.vslim/manifest.json'), true);
$hasEntry = $zip->locateName('public/index.php') !== false;
$hasBuilder = $zip->locateName('bin/vslim-build') !== false;
$hasEnv = $zip->locateName('.env') !== false;
$zip->close();

echo $embedded['format'], '|', $embedded['target'], '|', implode(',', $embedded['php']['extensions']), PHP_EOL;
echo ($hasEntry ? 'entry_yes' : 'entry_no'), '|', ($hasBuilder ? 'builder_yes' : 'builder_no'), '|', ($hasEnv ? 'env_yes' : 'env_no'), PHP_EOL;
echo hash_file('sha256', $first) === hash_file('sha256', $second) ? "deterministic_yes\n" : "deterministic_no\n";

foreach ([$first, $second] as $output) {
    @unlink($output);
    @unlink(preg_replace('/\.vslim-app$/', '', $output) . '.manifest.json');
}
?>
--EXPECT--
vslim-app-image-v1|linux-amd64|json
entry_yes|builder_no|env_no
deterministic_yes
