module streamx

import vphp

@[vphp.PhpExportInterface(name: 'VSlim\\Stream\\ResponseFactory')]
pub interface VStreamResponseFactory {
	text(chunks vphp.PhpValue) &VSlimStreamResponse
	sse(events vphp.PhpValue) &VSlimStreamResponse
}

const stream_factory_methods = vphp.PhpInterfaceMethods[VStreamResponseFactory]{
	methods: [
		vphp.PhpInterfaceMethod{
			v_name:     'text'
			static_:    true
			attributes: [vphp.PhpAttributeSpec{ name: 'NoDiscard', args: 'message: "Use the stream response"' }]
		},
		vphp.PhpInterfaceMethod{
			v_name:  'sse'
			static_: true
		},
	]
}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\Response')]
@[vphp.PhpImplements(names: 'VSlim\\Stream\\ResponseFactory')]
@[heap]
pub struct VSlimStreamResponse {
pub mut:
	stream_type  string @[vphp.PhpProperty(name: 'streamType')]
	status       int
	content_type string @[vphp.PhpProperty(name: 'contentType')]
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
	chat_url      string @[vphp.PhpProperty(name: 'chatUrl')]
	default_model string @[vphp.PhpProperty(name: 'defaultModel')]
	api_key       string @[vphp.PhpProperty(name: 'apiKey')]
	fixture_path  string @[vphp.PhpProperty(name: 'fixturePath')]
}

@[vphp.PhpExportClass(name: 'VSlim\\Stream\\Factory')]
@[vphp.PhpImplements(names: 'VSlim\\Stream\\ResponseFactory')]
@[heap]
pub struct VSlimStreamFactory {}
