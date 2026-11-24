--TEST--
PHPT artifact prefixes preserve sibling PHP and shell fixtures on success and failure
--SKIPIF--
<?php
if (!function_exists('proc_open')) {
    die('skip proc_open required');
}
?>
--FILE--
<?php
$directory = sys_get_temp_dir() . '/vphp-phpt-' . bin2hex(random_bytes(8));
mkdir($directory);
try {
    $phpFixture = "<?php return 'original';\n";
    $shellFixture = "#!/bin/sh\nexit 0\n";
    $fixtures = [];
    foreach (['passes' => 'original', 'fails' => 'different'] as $name => $expected) {
        $fixtures["$directory/$name.php"] = $phpFixture;
        $fixtures["$directory/$name.sh"] = $shellFixture;
        file_put_contents("$directory/$name.php", $phpFixture);
        file_put_contents("$directory/$name.sh", $shellFixture);
        $source = '<?php echo require __DIR__ . ' . var_export("/$name.php", true) . '; ?>';
        file_put_contents("$directory/$name.phpt", "--TEST--\n$name\n--FILE--\n$source\n--EXPECT--\n$expected\n");
    }

    $environment = array_intersect_key(getenv(), array_flip([
        'PATH', 'SystemRoot', 'WINDIR', 'TMP', 'TEMP', 'TMPDIR', 'LD_LIBRARY_PATH', 'DYLD_LIBRARY_PATH',
    ]));
    $environment['TEST_PHP_LOG_FORMAT'] = 'DS';
    $environment['REPORT_EXIT_STATUS'] = '1';
    $prefix = '.isolated-' . getmypid() . '-';
    $runner = dirname(__DIR__) . '/run-tests.php';
    $process = proc_open(
        [PHP_BINARY, '-n', $runner, '-n', '-q', '--no-color', '-p', PHP_BINARY, '--artifact-prefix', $prefix,
            "$directory/passes.phpt", "$directory/fails.phpt"],
        [['pipe', 'r'], ['pipe', 'w'], ['redirect', 1]],
        $pipes,
        $directory,
        $environment,
    );
    if (!is_resource($process)) {
        throw new RuntimeException('Could not start the nested PHPT runner');
    }
    fclose($pipes[0]);
    $output = stream_get_contents($pipes[1]);
    fclose($pipes[1]);
    if (proc_close($process) !== 1 || !str_contains($output, 'PASS passes') || !str_contains($output, 'FAIL fails')) {
        throw new RuntimeException($output);
    }
    foreach ($fixtures as $path => $contents) {
        if (file_get_contents($path) !== $contents) {
            throw new RuntimeException("Overwritten fixture: $path");
        }
    }
    if (file_exists("$directory/{$prefix}passes.php")
        || !is_file("$directory/{$prefix}fails.php")
        || !is_file("$directory/{$prefix}fails.diff")
        || !is_file("$directory/{$prefix}fails.sh")) {
        throw new RuntimeException('Unexpected generated artifacts');
    }
    echo "fixtures preserved\n";
} finally {
    foreach (new FilesystemIterator($directory) as $file) {
        unlink($file->getPathname());
    }
    rmdir($directory);
}
?>
--EXPECT--
fixtures preserved
