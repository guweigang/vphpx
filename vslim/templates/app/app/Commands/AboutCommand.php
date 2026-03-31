<?php
declare(strict_types=1);

namespace App\Commands;

final class AboutCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Show template bootstrap status.',
            'examples' => [
                'vslim about',
                'vslim about services cache --format=json',
            ],
            'epilog' => 'This command runs against the same app container and config graph as HTTP bootstrap.',
            'arguments' => [
                [
                    'name' => 'topic',
                    'required' => false,
                    'default' => 'status',
                    'placeholder' => 'topic',
                    'value_hint' => 'status or subsystem name',
                    'description' => 'Bootstrap topic to inspect',
                ],
                [
                    'name' => 'details',
                    'multiple' => true,
                    'description' => 'Extra detail tokens',
                ],
            ],
            'options' => [
                [
                    'name' => 'format',
                    'short' => 'f',
                    'type' => 'string',
                    'default' => 'text',
                    'env' => 'VSLIM_TEMPLATE_FORMAT',
                    'placeholder' => 'kind',
                    'value_hint' => 'text or json',
                    'choices' => ['text', 'json'],
                    'description' => 'Output format',
                ],
                [
                    'name' => 'verbose',
                    'short' => 'v',
                    'type' => 'bool',
                    'description' => 'Print parsed topic and warning metadata',
                ],
            ],
        ];
    }

    public function description(): string
    {
        return 'Show template bootstrap status.';
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $app = $cli->app();
        $topic = (string) $cli->argument('topic', 'status');
        $details = $cli->argument('details', []);
        $format = (string) $cli->option('format', 'text');
        $verbose = (bool) $cli->option('verbose', false);
        $warnings = $cli->warnings();

        if ($format === 'json') {
            echo json_encode([
                'app' => $app->config()->get_string('app.name', ''),
                'message' => (string) $app->container()->get('template.message'),
                'topic' => $topic,
                'details' => is_array($details) ? array_values($details) : [],
                'verbose' => $verbose,
                'warnings' => is_array($warnings) ? array_values($warnings) : [],
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), PHP_EOL;

            return count($args);
        }

        echo implode("|", [
            $app->config()->get_string("app.name", ""),
            (string) $app->container()->get("template.message"),
            implode(",", $args),
        ]), PHP_EOL;

        if ($verbose) {
            echo implode('|', [
                'topic=' . $topic,
                'details=' . implode(',', is_array($details) ? $details : []),
                'warnings=' . implode(',', is_array($warnings) ? $warnings : []),
            ]), PHP_EOL;
        }

        return count($args);
    }
}
