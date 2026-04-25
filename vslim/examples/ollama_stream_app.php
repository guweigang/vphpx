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
    $app->setErrorResponseJson(true);
    $app->setViewBasePath(__DIR__ . '/views');
    $app->setAssetsPrefix('/assets');
    $ollama = VSlim\Stream\OllamaClient::fromApp($app);

    $app->get('/', function () use ($app, $ollama) {
        return $app->view('ollama_stream.html', [
            'title' => 'VSlim Ollama Stream Demo',
            'default_prompt' => 'Explain VSlim streaming in one paragraph.',
            'default_model' => $ollama->defaultModel(),
            'chat_url' => $ollama->chatUrl(),
        ]);
    });

    $app->get('/health', fn () => 'OK');

    $app->get('/meta', function ($req) use ($ollama) {
        $query = $req->getQueryParams();
        return [
            'status' => 200,
            'content_type' => 'application/json; charset=utf-8',
            'body' => json_encode([
                'name' => 'vslim-ollama-stream-demo',
                'prompt' => $query['prompt'] ?? '',
                'default_model' => $ollama->defaultModel(),
                'chat_url' => $ollama->chatUrl(),
                'stream_fixture' => $ollama->fixturePath(),
                'stream_routes' => [
                    'text' => '/ollama/text',
                    'sse' => '/ollama/sse',
                ],
            ], JSON_UNESCAPED_UNICODE),
        ];
    });

    $app->map(['GET', 'POST'], '/ollama/text', function (VSlim\Vhttpd\Request $req) {
        return VSlim\Stream\Factory::ollama_text($req);
    });

    $app->map(['GET', 'POST'], '/ollama/sse', function (VSlim\Vhttpd\Request $req) {
        return VSlim\Stream\Factory::ollama_sse($req);
    });

    return $app;
}

return vslim_ollama_demo_app();
