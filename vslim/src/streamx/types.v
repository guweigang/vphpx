module streamx

import vphp

@[php_class: 'VSlim\\Stream\\Response']
@[heap]
pub struct VSlimStreamResponse {
pub mut:
	stream_type  string @[php_prop: streamType]
	status       int
	content_type string @[php_prop: contentType]
mut:
	headers    map[string]string
	chunks_ref vphp.PhpValue = vphp.PhpValue.invalid() @[php_ignore]
}

@[php_class: 'VSlim\\Stream\\NdjsonDecoder']
@[heap]
pub struct VSlimStreamNdjsonDecoder {}

@[php_class: 'VSlim\\Stream\\SseEncoder']
@[heap]
pub struct VSlimStreamSseEncoder {}

@[php_class: 'VSlim\\Stream\\OllamaClient']
@[heap]
pub struct VSlimStreamOllamaClient {
pub mut:
	chat_url      string @[php_prop: chatUrl]
	default_model string @[php_prop: defaultModel]
	api_key       string @[php_prop: apiKey]
	fixture_path  string @[php_prop: fixturePath]
}

@[php_class: 'VSlim\\Stream\\Factory']
@[heap]
pub struct VSlimStreamFactory {}
