<?php
declare(strict_types=1);

$autoload = __DIR__ . '/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = __DIR__ . '/../../../vhttpd/php/package/vendor/autoload.php';
}
if (is_file($autoload)) {
    require_once $autoload;
}

function vslim_stream_factory_demo_app(): VSlim\App
{
    static $app = null;
    if ($app instanceof VSlim\App) {
        return $app;
    }

    $app = new VSlim\App();
    $app->set_error_response_json(true);
    $app->set_view_base_path(__DIR__ . '/views');
    $app->set_assets_prefix('/assets');

    $app->get('/', function () use ($app) {
        return $app->view('stream_factory.html', [
            'title' => 'VSlim Stream Factory Demo',
            'default_prompt' => 'Explain VSlim stream factory in one paragraph.',
            'default_model' => (string) (getenv('OLLAMA_MODEL') ?: 'qwen2.5:7b-instruct'),
            'chat_url' => (string) (getenv('OLLAMA_CHAT_URL') ?: 'http://127.0.0.1:11434/api/chat'),
        ]);
    });

    $app->get('/health', fn () => 'OK');

    $app->get('/meta', function (VSlim\Request $req) {
        return [
            'status' => 200,
            'content_type' => 'application/json; charset=utf-8',
            'body' => json_encode([
                'name' => 'vslim-stream-factory-demo',
                'prompt' => $req->query('prompt') ?: '',
                'default_model' => (string) (getenv('OLLAMA_MODEL') ?: 'qwen2.5:7b-instruct'),
                'chat_url' => (string) (getenv('OLLAMA_CHAT_URL') ?: 'http://127.0.0.1:11434/api/chat'),
                'stream_fixture' => (string) (getenv('OLLAMA_STREAM_FIXTURE') ?: ''),
                'stream_routes' => [
                    'text' => '/stream/text',
                    'sse' => '/stream/sse',
                    'ollama_text' => '/ollama/text',
                    'ollama_sse' => '/ollama/sse',
                ],
            ], JSON_UNESCAPED_UNICODE),
        ];
    });

    $app->get('/stream/text', function (VSlim\Request $req) {
        $topic = trim((string) ($req->query('topic') ?: 'VSlim stream factory'));
        return VSlim\Stream\Factory::text((function () use ($topic): iterable {
            yield "demo: {$topic}\n";
            yield "mode: text\n";
            yield "status: ok\n";
        })());
    });

    $app->get('/stream/sse', function (VSlim\Request $req) {
        $topic = trim((string) ($req->query('topic') ?: 'VSlim stream factory'));
        return VSlim\Stream\Factory::sse((function () use ($topic): iterable {
            yield [
                'event' => 'token',
                'data' => json_encode(['token' => 'demo', 'topic' => $topic], JSON_UNESCAPED_UNICODE),
            ];
            yield [
                'event' => 'token',
                'data' => json_encode(['token' => 'stream', 'topic' => $topic], JSON_UNESCAPED_UNICODE),
            ];
            yield [
                'event' => 'done',
                'data' => json_encode(['done' => true, 'topic' => $topic], JSON_UNESCAPED_UNICODE),
            ];
        })());
    });

    $app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Request $req) {
        return VSlim\Stream\Factory::ollama_text($req);
    });

    $app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\Request $req) {
        return VSlim\Stream\Factory::ollama_sse($req);
    });

    return $app;
}

return vslim_stream_factory_demo_app();
