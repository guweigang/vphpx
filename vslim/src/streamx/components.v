module streamx

import httpx
import configx as cfgx
import os
import vphp

@[php_arg_name(chat_url: 'chatUrl', default_model: 'defaultModel', api_key: 'apiKey', fixture_path: 'fixturePath')]
@[php_method]
pub fn (mut c VSlimStreamOllamaClient) construct(chat_url string, default_model string, api_key string, fixture_path string) &VSlimStreamOllamaClient {
	c.chat_url = normalize_ollama_chat_url(chat_url)
	c.default_model = normalize_ollama_model(default_model)
	c.api_key = api_key.trim_space()
	c.fixture_path = fixture_path.trim_space()
	return &c
}

@[php_method: 'fromEnv']
pub fn VSlimStreamOllamaClient.from_env() &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(os.getenv('OLLAMA_CHAT_URL'), os.getenv('OLLAMA_MODEL'),
		os.getenv('OLLAMA_API_KEY'), os.getenv('OLLAMA_STREAM_FIXTURE'))
	return out
}

@[php_method: 'fromConfig']
pub fn VSlimStreamOllamaClient.from_config(config &cfgx.VSlimConfig) &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(config.get_string('stream.ollama.chat_url', os.getenv('OLLAMA_CHAT_URL')), config.get_string('stream.ollama.model',
		os.getenv('OLLAMA_MODEL')), config.get_string('stream.ollama.api_key',
		os.getenv('OLLAMA_API_KEY')), config.get_string('stream.ollama.fixture',
		os.getenv('OLLAMA_STREAM_FIXTURE')))
	return out
}

@[php_method: 'fromApp']
pub fn VSlimStreamOllamaClient.from_app(app vphp.PhpValue) &VSlimStreamOllamaClient {
	if obj := app.as_object() {
		if obj.method_exists('config') {
			mut config_value := obj.call_method('config')
			defer {
				config_value.release()
			}
			if config := config_value.to_v_object[cfgx.VSlimConfig]() {
				return VSlimStreamOllamaClient.from_config(config)
			}
		}
	}
	return VSlimStreamOllamaClient.from_env()
}

@[php_method: 'fromOptions']
pub fn VSlimStreamOllamaClient.from_options(options vphp.PhpArray) &VSlimStreamOllamaClient {
	base := VSlimStreamOllamaClient.from_env()
	mut out := &VSlimStreamOllamaClient{}
	out.construct(options.string_at('chat_url', base.chat_url_value()), options.string_at('model',
		base.default_model_value()), options.string_at('api_key', base.api_key_value()), options.string_at('fixture',
		base.fixture_path_value()))
	return out
}

@[php_method: 'chatUrl']
pub fn (c &VSlimStreamOllamaClient) chat_url() string {
	return c.chat_url_value()
}

@[php_method: 'defaultModel']
pub fn (c &VSlimStreamOllamaClient) default_model() string {
	return c.default_model_value()
}

@[php_method: 'apiKey']
pub fn (c &VSlimStreamOllamaClient) api_key() string {
	return c.api_key_value()
}

@[php_method: 'fixturePath']
pub fn (c &VSlimStreamOllamaClient) fixture_path() string {
	return c.fixture_path_value()
}

pub fn (c &VSlimStreamOllamaClient) chat_url_value() string {
	return normalize_ollama_chat_url(c.chat_url)
}

pub fn (c &VSlimStreamOllamaClient) default_model_value() string {
	return normalize_ollama_model(c.default_model)
}

pub fn (c &VSlimStreamOllamaClient) api_key_value() string {
	return c.api_key.trim_space()
}

pub fn (c &VSlimStreamOllamaClient) fixture_path_value() string {
	return c.fixture_path.trim_space()
}

fn normalize_ollama_chat_url(input string) string {
	clean := input.trim_space()
	if clean != '' {
		return clean
	}
	return 'http://127.0.0.1:11434/api/chat'
}

fn normalize_ollama_model(input string) string {
	clean := input.trim_space()
	if clean != '' {
		return clean
	}
	return 'qwen2.5:7b-instruct'
}

pub fn (c &VSlimStreamOllamaClient) free() {
	unsafe {
		c.chat_url.free()
		c.default_model.free()
		c.api_key.free()
		c.fixture_path.free()
	}
}
