--TEST--
VSlim EnvLoader bootstraps .env files without overriding existing environment values
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim_env_loader_' . getmypid();
@mkdir($root, 0777, true);
$path = $root . '/.env';
file_put_contents($path, implode(PHP_EOL, [
    '# comment',
    'VSLIM_ENV_ALPHA=alpha',
    'export VSLIM_ENV_BRAVO="bravo value"',
    "VSLIM_ENV_CHARLIE='charlie value'",
    'VSLIM_ENV_KEEP=from-file',
]));

putenv('VSLIM_ENV_ALPHA');
putenv('VSLIM_ENV_BRAVO');
putenv('VSLIM_ENV_CHARLIE');
putenv('VSLIM_ENV_KEEP=');

$loaded = VSlim\EnvLoader::bootstrap($root);
ksort($loaded);

echo count($loaded) . PHP_EOL;
echo $loaded['VSLIM_ENV_ALPHA'] . PHP_EOL;
echo $loaded['VSLIM_ENV_BRAVO'] . PHP_EOL;
echo $loaded['VSLIM_ENV_CHARLIE'] . PHP_EOL;
echo array_key_exists('VSLIM_ENV_KEEP', $loaded) ? "keep-loaded\n" : "keep-skipped\n";
echo getenv('VSLIM_ENV_ALPHA') . PHP_EOL;
echo getenv('VSLIM_ENV_BRAVO') . PHP_EOL;
echo getenv('VSLIM_ENV_CHARLIE') . PHP_EOL;
$keep = getenv('VSLIM_ENV_KEEP');
echo ($keep === '' ? 'keep-empty' : (string) $keep) . PHP_EOL;
echo $_ENV['VSLIM_ENV_ALPHA'] . PHP_EOL;
echo $_SERVER['VSLIM_ENV_BRAVO'] . PHP_EOL;
echo array_key_exists('VSLIM_ENV_KEEP', $_ENV) ? 'keep-env-present' : 'keep-env-missing';
echo PHP_EOL;

@unlink($path);
@rmdir($root);
?>
--EXPECT--
3
alpha
bravo value
charlie value
keep-skipped
alpha
bravo value
charlie value
keep-empty
alpha
bravo value
keep-env-missing
