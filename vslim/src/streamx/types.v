module streamx

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\Response')]
@[heap]
pub struct VSlimStreamResponse {
pub mut:
	stream_type  string @[vphp.PhpProperty; vphp.PhpProperty_name: 'streamType']
	status       int
	content_type string @[vphp.PhpProperty; vphp.PhpProperty_name: 'contentType']
mut:
	headers    map[string]string
	chunks_ref vphp.PhpValue = vphp.PhpValue.invalid() @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\NdjsonDecoder')]
@[heap]
pub struct VSlimStreamNdjsonDecoder {}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\SseEncoder')]
@[heap]
pub struct VSlimStreamSseEncoder {}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\OllamaClient')]
@[heap]
pub struct VSlimStreamOllamaClient {
pub mut:
	chat_url      string @[vphp.PhpProperty; vphp.PhpProperty_name: 'chatUrl']
	default_model string @[vphp.PhpProperty; vphp.PhpProperty_name: 'defaultModel']
	api_key       string @[vphp.PhpProperty; vphp.PhpProperty_name: 'apiKey']
	fixture_path  string @[vphp.PhpProperty; vphp.PhpProperty_name: 'fixturePath']
}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\Factory')]
@[heap]
pub struct VSlimStreamFactory {}
