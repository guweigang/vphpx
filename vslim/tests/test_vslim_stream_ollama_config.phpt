--TEST--
VSlim Stream Ollama client can be created from app config
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
putenv('OLLAMA_CHAT_URL=');
putenv('OLLAMA_MODEL=');
putenv('OLLAMA_API_KEY=');
putenv('OLLAMA_STREAM_FIXTURE=');

$app = new VSlim\App();
$app->load_config_text(<<<'TOML'
[stream.ollama]
chat_url = "http://127.0.0.1:11434/api/chat"
model = "qwen-config"
api_key = "cfg-key"
fixture = "tests/fixtures/ollama_stream_fixture.ndjson"
TOML);

$client = VSlim\Stream\OllamaClient::from_app($app);
echo $client->chat_url() . PHP_EOL;
echo $client->default_model() . PHP_EOL;
echo $client->api_key() . PHP_EOL;
echo $client->fixture_path() . PHP_EOL;
?>
--EXPECT--
http://127.0.0.1:11434/api/chat
qwen-config
cfg-key
tests/fixtures/ollama_stream_fixture.ndjson
