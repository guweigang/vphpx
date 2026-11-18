--TEST--
VSlim CLI convention loading stops at the first command failure and preserves its exception
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim-cli-conventions-' . bin2hex(random_bytes(8));
try {
    foreach ([
        'Conflict' => 'public function aliases(): array { return ["partial-alias", "taken"]; }',
        'Callback' => 'public function aliases(): array { throw new \LogicException("aliases failed"); }',
        'Include' => null,
    ] as $case => $metadata) {
        $project = "$root/$case";
        $commands = "$project/app/Commands";
        mkdir($commands, 0700, true);
        mkdir("$project/bootstrap");
        $GLOBALS['events'] = [];
        foreach (['First', 'Middle', 'Suffix'] as $position) {
            $class = $case . $position . 'Command';
            $body = $position === 'Middle' ? $metadata : '';
            file_put_contents("$commands/$class.php", '<?php namespace App\Commands; '
                . '$GLOBALS["events"][] = ' . var_export($position, true) . '; '
                . ($body === null
                    ? 'throw new \LogicException("include failed");'
                    : "final class $class { public function handle(): int { return 11; } $body }"));
        }
        file_put_contents("$project/bootstrap/cli.php", '<?php $GLOBALS["events"][] = "cli.php"; return [];');

        $cli = new VSlim\Cli\App();
        $cli->command('taken', static fn (): int => 7);
        try {
            if ($case === 'Callback') {
                $cli->runArgv(['vslim', '--bootstrap-dir', $project, '--list']);
            } else {
                $cli->bootstrapDir($project);
            }
            echo "unexpected success\n";
        } catch (Throwable $error) {
            echo $case, '|', get_class($error), '|', $error->getMessage(), PHP_EOL;
        }
        echo implode(',', $cli->commandNames()), '|',
            (int) $cli->hasCommand('partial-alias'), '|', implode(',', $GLOBALS['events']), '|',
            $cli->run(strtolower($case) . '-first', []), '|', $cli->run('taken', []), PHP_EOL;
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
Conflict|InvalidArgumentException|CLI alias "taken" conflicts with registered command "taken"
taken,conflict-first|0|First,Middle|11|7
Callback|LogicException|aliases failed
taken,callback-first|0|First,Middle|11|7
Include|LogicException|include failed
taken,include-first|0|First,Middle|11|7
