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
$app->loadConfigText(<<<'TOML'
[stream.ollama]
chat_url = "http://127.0.0.1:11434/api/chat"
model = "qwen-config"
api_key = "cfg-key"
fixture = "tests/fixtures/ollama_stream_fixture.ndjson"
TOML);

$client = VSlim\Stream\OllamaClient::fromApp($app);
echo $client->chatUrl() . PHP_EOL;
echo $client->defaultModel() . PHP_EOL;
echo $client->apiKey() . PHP_EOL;
echo $client->fixturePath() . PHP_EOL;
?>
--EXPECT--
http://127.0.0.1:11434/api/chat
qwen-config
cfg-key
tests/fixtures/ollama_stream_fixture.ndjson
