--TEST--
VSlim template generator commands can create provider and test files
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
function copy_tree(string $source, string $target): void
{
    if (is_dir($source)) {
        if (!is_dir($target)) {
            mkdir($target, 0777, true);
        }
        $items = scandir($source) ?: [];
        foreach ($items as $item) {
            if ($item === '.' || $item === '..') {
                continue;
            }
            copy_tree($source . DIRECTORY_SEPARATOR . $item, $target . DIRECTORY_SEPARATOR . $item);
        }
        return;
    }
    if (!is_dir(dirname($target))) {
        mkdir(dirname($target), 0777, true);
    }
    copy($source, $target);
}

$source = __DIR__ . '/../templates/app';
$target = sys_get_temp_dir() . '/vslim_template_' . bin2hex(random_bytes(4));
copy_tree($source, $target);

ob_start();
$providerCli = new VSlim\Cli\App();
$providerCode = $providerCli->runArgv(['bin/vslim', '--bootstrap-dir', $target, 'make:provider', 'Billing']);
$providerOutput = trim((string) ob_get_clean());
echo $providerCode, '|', (str_contains($providerOutput, 'BillingProvider.php') ? 'provider_created' : 'provider_missing'), PHP_EOL;

ob_start();
$testCli = new VSlim\Cli\App();
$testCode = $testCli->runArgv(['bin/vslim', '--bootstrap-dir', $target, 'make:test', 'billing-auth']);
$testOutput = trim((string) ob_get_clean());
echo $testCode, '|', (str_contains($testOutput, 'test_billing_auth.phpt') ? 'test_created' : 'test_missing'), PHP_EOL;

$providerPath = $target . '/app/Providers/BillingProvider.php';
$testPath = $target . '/tests/test_billing_auth.phpt';

echo (is_file($providerPath) ? 'provider_file_yes' : 'provider_file_no'), PHP_EOL;
echo (is_file($testPath) ? 'test_file_yes' : 'test_file_no'), PHP_EOL;
echo (str_contains((string) @file_get_contents($providerPath), 'extends \\VSlim\\Support\\ServiceProvider') ? 'provider_body_yes' : 'provider_body_no'), PHP_EOL;
echo (str_contains((string) @file_get_contents($testPath), '--EXPECT--') ? 'test_body_yes' : 'test_body_no'), PHP_EOL;
?>
--EXPECT--
0|provider_created
0|test_created
provider_file_yes
test_file_yes
provider_body_yes
test_body_yes
