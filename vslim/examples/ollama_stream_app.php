<?php
declare(strict_types=1);

/**
 * VSlim Ollama stream demo entry.
 *
 * This file only does:
 * - bootstrap VSlim\App
 * - register page/meta/stream routes
 */

$autoload = __DIR__ . '/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = __DIR__ . '/../../../vhttpd/php/package/vendor/autoload.php';
}
if (is_file($autoload)) {
    require_once $autoload;
}

function vslim_ollama_demo_app(): VSlim\App
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
        return $app->view('ollama_stream.html', [
            'title' => 'VSlim Ollama Stream Demo',
            'default_prompt' => 'Explain VSlim streaming in one paragraph.',
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
                'name' => 'vslim-ollama-stream-demo',
                'prompt' => $req->query('prompt') ?: '',
                'default_model' => (string) (getenv('OLLAMA_MODEL') ?: 'qwen2.5:7b-instruct'),
                'chat_url' => (string) (getenv('OLLAMA_CHAT_URL') ?: 'http://127.0.0.1:11434/api/chat'),
                'stream_fixture' => (string) (getenv('OLLAMA_STREAM_FIXTURE') ?: ''),
                'stream_routes' => [
                    'text' => '/ollama/text',
                    'sse' => '/ollama/sse',
                ],
            ], JSON_UNESCAPED_UNICODE),
        ];
    });

    $app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Request $req) {
        return VSlim\Stream\Factory::ollama_text($req);
    });

    $app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\Request $req) {
        return VSlim\Stream\Factory::ollama_sse($req);
    });

    return $app;
}

return vslim_ollama_demo_app();
