<?php
declare(strict_types=1);

namespace App\Commands;

final class QueueWorkCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Run queued VSlim jobs for this Knowledge Studio instance.',
            'examples' => [
                'vslim queue:work',
                'vslim queue:work --queue=default --max-jobs=10',
                'vslim queue:work --daemon=true --max-jobs=0',
            ],
            'options' => [
                [
                    'name' => 'queue',
                    'short' => 'q',
                    'type' => 'string',
                    'default' => 'default',
                    'description' => 'Queue name to consume.',
                ],
                [
                    'name' => 'max-jobs',
                    'type' => 'int',
                    'default' => 1,
                    'description' => 'Maximum jobs to process. Use 0 for an unbounded worker.',
                ],
                [
                    'name' => 'sleep-ms',
                    'type' => 'int',
                    'default' => 500,
                    'description' => 'Sleep duration when no job is available.',
                ],
                [
                    'name' => 'daemon',
                    'type' => 'bool',
                    'default' => false,
                    'description' => 'Keep polling when the queue is empty.',
                ],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $queue = trim((string) $cli->option('queue', 'default')) ?: 'default';
        $maxJobs = max(0, (int) $cli->option('max-jobs', 1));
        $sleepMs = max(0, (int) $cli->option('sleep-ms', 500));
        $daemon = (bool) $cli->option('daemon', false);
        $stopWhenEmpty = !$daemon;

        try {
            $processed = $cli->app()
                ->jobWorker()
                ->setWorkerId('knowledge-studio-' . getmypid())
                ->run($queue, $maxJobs, $sleepMs, $stopWhenEmpty);

            echo implode('|', [
                'queue-work',
                'queue=' . $queue,
                'processed=' . $processed,
            ]), PHP_EOL;

            return 0;
        } catch (\Throwable $e) {
            fwrite(STDERR, 'queue-work-failed|' . $e->getMessage() . PHP_EOL);
            return 1;
        }
    }
}
