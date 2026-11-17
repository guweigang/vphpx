--TEST--
VSlim Web and CLI validate bootstrap values and evaluate their callable once
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-bootstrap-results-' . bin2hex(random_bytes(8));
mkdir($root, 0700);
$file = $root . '/config.php';

try {
    foreach (['web' => VSlim\App::class, 'cli' => VSlim\Cli\App::class] as $surface => $class) {
        $setup = $surface === 'web'
            ? '$receiver->get("/probe", static fn () => "probe");'
            : '$receiver->command("probe", static fn () => 0);';
        $spec = $surface === 'web'
            ? '"routes" => static function ($receiver) { ' . $setup . ' }'
            : '"commands" => ["probe" => static fn () => 0]';
        $callback = 'return static function (\\' . $class . ' $receiver) { ++$GLOBALS["calls"]; ';
        $cases = [
            'array' => 'return [' . $spec . '];',
            'closure-array' => $callback . 'return [' . $spec . ', "boot" => true]; };',
            'closure-null' => $callback . $setup . ' return null; };',
            'closure-app' => $callback . $setup . ' return $receiver; };',
            'scalar' => 'return 42;',
            'closure-scalar' => $callback . 'return 42; };',
            'closure-closure' => $callback . 'return static function () { ++$GLOBALS["calls"]; }; };',
        ];
        foreach ($cases as $kind => $source) {
            file_put_contents($file, '<?php ' . $source);
            $GLOBALS['calls'] = 0;
            $app = new $class();
            try {
                $same = $app->bootstrapFile($file) === $app;
                $core = $surface === 'web' ? $app : $app->app();
                $booted = $core->booted();
                $registered = $surface === 'web'
                    ? $app->dispatch('GET', '/probe')->body === 'probe'
                    : $app->hasCommand('probe');
                echo "$surface|$kind|", implode('|', [(int) $same, (int) $registered, (int) $booted, $GLOBALS['calls']]), PHP_EOL;
            } catch (InvalidArgumentException $error) {
                echo "$surface|$kind|", $error->getMessage(), '|', $GLOBALS['calls'], PHP_EOL;
            }
        }
    }
} finally {
    unlink($file);
    rmdir($root);
}
?>
--EXPECT--
web|array|1|1|0|0
web|closure-array|1|1|1|1
web|closure-null|1|1|0|1
web|closure-app|1|1|0|1
web|scalar|bootstrap spec must be iterable|0
web|closure-scalar|bootstrap spec must be iterable|1
web|closure-closure|bootstrap spec must be iterable|1
cli|array|1|1|0|0
cli|closure-array|1|1|1|1
cli|closure-null|1|1|0|1
cli|closure-app|1|1|0|1
cli|scalar|bootstrap spec must be iterable|0
cli|closure-scalar|bootstrap spec must be iterable|1
cli|closure-closure|bootstrap spec must be iterable|1
